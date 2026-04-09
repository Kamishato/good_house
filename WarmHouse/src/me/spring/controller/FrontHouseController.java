package me.spring.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import me.spring.bean.Result;
import me.spring.dao.HouseInformationDAO;
import me.spring.dao.UserBehaviorDAO;
import me.spring.entity.HouseImgInfo;
import me.spring.entity.HouseInformation;
import me.spring.entity.HouseRange;
import me.spring.entity.HousePhoto;
import me.spring.entity.User;
import me.spring.service.HouseInformationService;
import me.spring.service.HousePhotoService;
import me.spring.service.RecommendService;
import me.spring.service.UserBehaviorService;

/**
 * 前台房源展示 Controller
 */
@Controller
@RequestMapping("/front")
public class FrontHouseController {

    @Autowired
    private HouseInformationService houseInformationService;

    @Autowired
    private HouseInformationDAO houseInformationDAO;

    @Autowired
    private HousePhotoService housePhotoService;

    @Autowired
    private UserBehaviorService userBehaviorService;

    @Autowired
    private UserBehaviorDAO userBehaviorDAO;

    @Autowired
    private RecommendService recommendService;

    /** 与列表查询 infotb 一致：先筛出候选 id 上限，再在其上做 CF + 热门 */
    private static final int RECOMMEND_CANDIDATE_CAP = 8000;

    /**
     * 猜你喜欢：最多 30 条混合池（Item-CF + 收藏热门去重补齐），排除已售与已收藏房源；内存分页每页 10 条、最多 3 页。
     * <p>
     * POST（父页查询栏在「猜你喜欢」Tab 下提交）：与 /searchInformation/infotb 相同参数，先按条件得到候选 id 集合，再仅在候选内推荐；
     * GET + flag=1：分页时从 session 恢复上次筛选条件（键 recommendHouseinfoFlag / recommendRangeInfoFlag）。
     * GET 无 flag：不按查询条件过滤（全站推荐逻辑）。
     * 已登录用户不展示本人发布的房源（{@code HouseInformation#salesman} 与当前用户 {@code username} 一致）。
     */
    @RequestMapping(value = "/recommendList", method = { RequestMethod.GET, RequestMethod.POST }, produces = "text/html;charset=utf-8")
    public String recommendList(HttpServletRequest request, HttpSession session, Model model,
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            HouseInformation houseinfo,
            HouseRange rangeInfo,
            @RequestParam(value = "flag", required = false) Integer flag) {

        boolean recommendFilterActive = false;
        boolean recommendNoCandidate = false;
        Set<Integer> candidate = null;

        if (RequestMethod.POST.name().equalsIgnoreCase(request.getMethod())) {
            if (houseinfo == null) {
                houseinfo = new HouseInformation();
            }
            if (rangeInfo == null) {
                rangeInfo = new HouseRange();
            }
            List<Integer> idList = houseInformationService.listHouseIdsByRange(houseinfo, rangeInfo, RECOMMEND_CANDIDATE_CAP);
            session.setAttribute("recommendHouseinfoFlag", houseinfo);
            session.setAttribute("recommendRangeInfoFlag", rangeInfo);
            recommendFilterActive = true;
            if (idList == null || idList.isEmpty()) {
                recommendNoCandidate = true;
            } else {
                candidate = new HashSet<Integer>(idList);
            }
        } else if (flag != null) {
            HouseInformation hi = (HouseInformation) session.getAttribute("recommendHouseinfoFlag");
            HouseRange ri = (HouseRange) session.getAttribute("recommendRangeInfoFlag");
            if (hi != null && ri != null) {
                List<Integer> idList = houseInformationService.listHouseIdsByRange(hi, ri, RECOMMEND_CANDIDATE_CAP);
                recommendFilterActive = true;
                if (idList == null || idList.isEmpty()) {
                    recommendNoCandidate = true;
                } else {
                    candidate = new HashSet<Integer>(idList);
                }
            }
        }

        model.addAttribute("recommendFilterActive", recommendFilterActive);
        model.addAttribute("recommendNoCandidate", recommendNoCandidate);

        if (recommendNoCandidate) {
            model.addAttribute("houseinfoList", new ArrayList<HouseInformation>());
            model.addAttribute("totalRecords", 0);
            model.addAttribute("totalPages", 0);
            model.addAttribute("pageNum", 1);
            return "mainPages/searchInformation/recommendTable";
        }

        User user = (User) session.getAttribute("user");
        List<HouseInformation> allRecommendPool = new ArrayList<HouseInformation>();

        // 用户已收藏房源 ID（behavior_type=2），用于后置过滤
        Set<Integer> favoritedHouseIds = new HashSet<Integer>();
        if (user != null) {
            List<HouseInformation> favList = houseInformationDAO.selectByBehavior(user.getId(), 2, 10000);
            if (favList != null) {
                for (HouseInformation h : favList) {
                    if (h != null) {
                        favoritedHouseIds.add(h.getId());
                    }
                }
            }
        }

        int hotFetch = candidate != null ? 200 : 50;

        // 1. 个性化推荐（多取候选以抵消过滤损耗，目标装入池 30 个）
        if (user != null) {
            try {
                List<Integer> ids = recommendService.recommendHouseIds(user.getId(), 50);
                if (ids != null && !ids.isEmpty()) {
                    for (Integer id : ids) {
                        if (id == null) {
                            continue;
                        }
                        if (candidate != null && !candidate.contains(id)) {
                            continue;
                        }
                        if (favoritedHouseIds.contains(id)) {
                            continue;
                        }
                        HouseInformation h = houseInformationService.getById(id);
                        if (h != null && !isSoldHouse(h) && !isOwnPublishedHouse(user, h)) {
                            allRecommendPool.add(h);
                            if (allRecommendPool.size() >= 30) {
                                break;
                            }
                        }
                    }
                }
            } catch (Exception e) {
                System.out.println("Item-CF 算法降级兜底: " + e.getMessage());
            }
        }

        // 2. 热度兜底：不足 30 条时补齐
        if (allRecommendPool.size() < 30) {
            List<HouseInformation> hotHouses = houseInformationService.getTopFavoritedHouses(hotFetch);
            if (hotHouses != null) {
                for (HouseInformation hot : hotHouses) {
                    if (allRecommendPool.size() >= 30) {
                        break;
                    }
                    if (hot == null) {
                        continue;
                    }
                    if (candidate != null && !candidate.contains(hot.getId())) {
                        continue;
                    }
                    if (isSoldHouse(hot)) {
                        continue;
                    }
                    if (isOwnPublishedHouse(user, hot)) {
                        continue;
                    }
                    if (favoritedHouseIds.contains(hot.getId())) {
                        continue;
                    }
                    boolean exists = false;
                    for (HouseInformation existHouse : allRecommendPool) {
                        if (Objects.equals(existHouse.getId(), hot.getId())) {
                            exists = true;
                            break;
                        }
                    }
                    if (!exists) {
                        allRecommendPool.add(hot);
                    }
                }
            }
        }

        // 3. 内存分页
        int totalRecords = allRecommendPool.size();
        int pageSize = 10;
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        if (totalRecords == 0) {
            model.addAttribute("houseinfoList", new ArrayList<HouseInformation>());
            model.addAttribute("totalRecords", 0);
            model.addAttribute("totalPages", 0);
            model.addAttribute("pageNum", 1);
            return "mainPages/searchInformation/recommendTable";
        }

        if (pageNum > totalPages) {
            pageNum = totalPages;
        }
        if (pageNum < 1) {
            pageNum = 1;
        }

        int fromIndex = (pageNum - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, totalRecords);
        List<HouseInformation> pageList = allRecommendPool.subList(fromIndex, toIndex);

        Map<String, List<HouseImgInfo>> hosueImgInfoMap = houseInformationService.getCoverImg(pageList);

        model.addAttribute("houseinfoList", pageList);
        model.addAttribute("hosueImgInfoMap", hosueImgInfoMap);
        model.addAttribute("totalRecords", totalRecords);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("pageNum", pageNum);

        return "mainPages/searchInformation/recommendTable";
    }

    /**
     * 房源详情页
     */
    @RequestMapping(value = "/houseDetails", produces = "text/html;charset=utf-8")
    public String houseDetails(Integer id, Model model, HttpSession session) {
        if (id == null) {
            return "errors/404page";
        }

        HouseInformation house = houseInformationService.getById(id);
        if (house == null) {
            return "errors/404page";
        }

        List<HousePhoto> photos = housePhotoService.getByCode(house.getCode());
        model.addAttribute("house", house);
        model.addAttribute("photos", photos);

        // 收藏状态回显：当前用户是否已收藏该房源（behavior_type = 2）
        boolean isFavorited = false;
        User currentUser = (User) session.getAttribute("user");
        if (currentUser != null) {
            int cnt = userBehaviorDAO.checkUserBehavior(currentUser.getId(), id, 2);
            if (cnt > 0) {
                isFavorited = true;
            }
        }
        model.addAttribute("isFavorited", isFavorited);

        // 无感浏览埋点：失败不影响页面展示
        try {
            User browseUser = (User) session.getAttribute("user");
            if (browseUser != null) {
                userBehaviorService.recordBehavior(browseUser.getId(), id, 1);
            }
        } catch (Exception e) {
            // ignore
        }

        return "mainPages/information/housedetails";
    }

    /**
     * 加入收藏（Ajax）：记录收藏行为（2 代表收藏）
     */
    @ResponseBody
    @RequestMapping(value = "/favorite", produces = "application/json;charset=utf-8")
    public Result favorite(Integer houseId, HttpSession session) {
        Result result = new Result();
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                result.setCode(-1);
                result.setMsg("请先登录");
                return result;
            }
            if (houseId == null) {
                result.setCode(-1);
                result.setMsg("参数错误");
                return result;
            }

            userBehaviorService.recordBehavior(user.getId(), houseId, 2);
            result.setCode(1);
            result.setMsg("已加入收藏");
            return result;
        } catch (Exception e) {
            result.setCode(-1);
            result.setMsg("收藏失败");
            return result;
        }
    }

    /** 房源状态为「已售」时不进入推荐池（housestatus 存中文字符串） */
    private static boolean isSoldHouse(HouseInformation h) {
        return h != null && "已售".equals(h.getHousestatus());
    }

    /** 发布者用户名与当前登录用户一致时不进入推荐池（与发布时 {@code setSalesman(username)} 一致） */
    private static boolean isOwnPublishedHouse(User user, HouseInformation h) {
        return user != null && h != null && user.getUsername() != null
                && user.getUsername().equals(h.getSalesman());
    }
}


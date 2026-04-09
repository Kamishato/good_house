package me.spring.imp;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.HashSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import me.spring.bean.Result;
import me.spring.dao.HouseInformationDAO;
import me.spring.dao.SystemTableDAO;
import me.spring.dao.UserRoleDAO;
import me.spring.entity.HouseImgInfo;
import me.spring.entity.HouseInformation;
import me.spring.entity.HouseRange;
import me.spring.entity.SystemTable;
import me.spring.entity.TotalTable;
import me.spring.service.HouseInformationService;
import me.spring.service.SystemTableService;
import me.spring.service.UserService;
import me.spring.utils.Parse;
import me.spring.utils.ReflectionUtils;
import me.spring.utils.RequestEntity;

@Service
public class HouseInformationImp implements HouseInformationService{
	@Autowired
    SystemTableDAO systemTableDAO;
	@Autowired
	HouseInformationDAO houseInformationDAO;
	@Autowired
    UserService userService;
	 
	@Override
	public PageInfo<HouseInformation> listHouseInfoTable(HouseInformation houseInfo, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<HouseInformation> houseInfoList = houseInformationDAO.getByFactors(houseInfo);
    	PageInfo<HouseInformation> houseInfoPageInfo = new PageInfo<>(houseInfoList, 5);

    	return houseInfoPageInfo;
	}

	@Override
	public List<TotalTable> listTotalTable() {
		return systemTableDAO.getTotalTable();
	}
	
	@Override
    @Transactional
	public Result delete(String code) {
		Result result = new Result();
		int resLine = houseInformationDAO.delete(code);
		
		if(resLine > 0) {
			result.setCode(1);
    		result.setMsg("删除成功");
		}else {
			result.setCode(-1);
    		result.setMsg("删除失败");
		}
	    return result;
	}

	@Override
	public HouseInformation getByCode(String code) {
		return houseInformationDAO.selectByCode(code);
	}

	@Override
	public HouseInformation getById(Integer id) {
		return houseInformationDAO.selectById(id);
	}
	
	@Override
	public int update(HouseInformation houseinfo) {
		return houseInformationDAO.update(houseinfo);
	}
	
	@Override
	public Result editSystemTable(SystemTable systemTable) {
		Result result = new Result();
		try{
			List<SystemTable> systableList = systemTableDAO.getByFactors(systemTable);
			result.setCode(1);
	    	result.setData(systableList.get(0));
		}catch  (Exception e){
			result.setCode(-1);
			result.setMsg("查找失败");
		}
    	return result;
	}

	@Override
	public Result add(HouseInformation houseinfo) {
		Result result = new Result();
		ReflectionUtils.stringBlankToNull(houseinfo);
		try {
			houseInformationDAO.insert(houseinfo);
		} catch (Exception e) {
			result.setCode(-1);
			result.setMsg("添加失败");
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public PageInfo<HouseInformation> RangeHouseInfoTable(HouseInformation houseinfo, HouseRange rangeInfo, int pageNum, int pageSize) {
		if (rangeInfo == null) {
			rangeInfo = new HouseRange();
		}
		applyRangeSearchNormalization(houseinfo, rangeInfo);
		System.out.println(houseinfo);
		System.out.println(rangeInfo);
		PageHelper.startPage(pageNum, pageSize);
		List<HouseInformation> houseInfoList = houseInformationDAO.selectByRange(houseinfo,rangeInfo);
    	PageInfo<HouseInformation> houseInfoPageInfo = new PageInfo<>(houseInfoList, 5);
    	
		return houseInfoPageInfo;
	}

	/**
	 * 与列表查询 {@link #RangeHouseInfoTable} 相同的面积区间、室数字段归一化（会修改入参对象）。
	 */
	private void applyRangeSearchNormalization(HouseInformation houseinfo, HouseRange rangeInfo) {
		if (houseinfo == null || rangeInfo == null) {
			return;
		}
		if (houseinfo.getArea() != null && !houseinfo.getArea().equals("")) {
			if (houseinfo.getArea().contains("以下")) {
				String temp = houseinfo.getArea();
				rangeInfo.setMinArea("0");
				rangeInfo.setMaxArea(temp.substring(0, temp.indexOf("㎡")));
			} else if (houseinfo.getArea().contains("以上")) {
				String temp = houseinfo.getArea();
				rangeInfo.setMinArea(temp.substring(0, temp.indexOf("㎡")));
				rangeInfo.setMaxArea("999");
			} else {
				String temp = houseinfo.getArea();
				rangeInfo.setMinArea(temp.substring(0, temp.indexOf("-")));
				rangeInfo.setMaxArea(temp.substring(temp.indexOf("-") + 1, temp.indexOf("㎡")));
			}
		} else {
			rangeInfo.setMinArea("0");
			rangeInfo.setMaxArea("999");
		}
		String tempSuiteRoom = houseinfo.getSuiteRoom();
		/* 仅当表单为「x室」中文时转换；session 回填已是数字时不可再 substring("室") */
		if (tempSuiteRoom != null && !tempSuiteRoom.equals("") && tempSuiteRoom.contains("室")) {
			String chineseNumStr = tempSuiteRoom.substring(0, tempSuiteRoom.indexOf("室"));
			Integer num = Parse.zh2arbaNum(chineseNumStr);
			houseinfo.setSuiteRoom(num.toString());
		}
	}

	@Override
	public List<Integer> listHouseIdsByRange(HouseInformation houseinfo, HouseRange rangeInfo, int maxIds) {
		if (houseinfo == null || maxIds <= 0) {
			return Collections.emptyList();
		}
		if (rangeInfo == null) {
			rangeInfo = new HouseRange();
		}
		applyRangeSearchNormalization(houseinfo, rangeInfo);
		return houseInformationDAO.selectIdsByRange(houseinfo, rangeInfo, maxIds);
	}

	@Override
	public Map<String, List<HouseImgInfo>> getImg(List<HouseInformation> houseinfoList) {
		Map<String, List<HouseImgInfo>> houseInfoMap = new HashMap<String, List<HouseImgInfo>>();
		for (HouseInformation item : houseinfoList) {
			String code = item.getCode();
			List<HouseImgInfo> HouseImgInfolist = houseInformationDAO.getHouseImg(code);
			for (HouseImgInfo info : HouseImgInfolist) {
				info.setDataBase64(RequestEntity.dataBase64(info.getSavingfilename()));
			}
			houseInfoMap.put(code, HouseImgInfolist);
		}
		return houseInfoMap;
	}

	@Override
	public Map<String, List<HouseImgInfo>> getCoverImg(List<HouseInformation> houseinfoList) {
		Map<String, List<HouseImgInfo>> houseInfoMap = new HashMap<String, List<HouseImgInfo>>();

		if (houseinfoList == null || houseinfoList.isEmpty()) {
			return houseInfoMap;
		}

		Set<String> codeSet = new HashSet<String>();
		for (HouseInformation item : houseinfoList) {
			if (item != null && item.getCode() != null) {
				codeSet.add(item.getCode());
			}
		}

		if (codeSet.isEmpty()) {
			return houseInfoMap;
		}

		List<String> codes = new ArrayList<String>(codeSet);
		List<HouseImgInfo> firstImgs = houseInformationDAO.getFirstHouseImgByCodes(codes);

		Map<String, HouseImgInfo> firstByCode = new HashMap<String, HouseImgInfo>();
		if (firstImgs != null) {
			for (HouseImgInfo info : firstImgs) {
				if (info == null || info.getCode() == null) {
					continue;
				}
				if (info.getSavingfilename() != null) {
					info.setDataBase64(RequestEntity.dataBase64(info.getSavingfilename()));
				}
				if (!firstByCode.containsKey(info.getCode())) {
					firstByCode.put(info.getCode(), info);
				}
			}
		}

		for (String code : codeSet) {
			HouseImgInfo first = firstByCode.get(code);
			if (first == null) {
				first = new HouseImgInfo();
				first.setCode(code);
			}
			List<HouseImgInfo> list = new ArrayList<HouseImgInfo>();
			list.add(first);
			houseInfoMap.put(code, list);
		}

		return houseInfoMap;
	}

	@Override
	public List<HouseInformation> getTopFavoritedHouses(int limit) {
		return houseInformationDAO.getTopFavoritedHouses(limit);
	}

}

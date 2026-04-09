package me.spring.service;

import java.util.List;
import java.util.Map;

import com.github.pagehelper.PageInfo;

import me.spring.bean.Result;
import me.spring.entity.HouseImgInfo;
import me.spring.entity.HouseInformation;
import me.spring.entity.HouseRange;
import me.spring.entity.SystemTable;
import me.spring.entity.TotalTable;

public interface HouseInformationService {
	public PageInfo<HouseInformation> listHouseInfoTable(HouseInformation houseinfo, int pageNum, int pageSize);
		
	public PageInfo<HouseInformation> RangeHouseInfoTable(HouseInformation houseinfo,HouseRange rangeInfo, int pageNum, int pageSize);

	/**
	 * 与 {@link #RangeHouseInfoTable} 使用同一套区间/户型归一化逻辑，仅返回符合条件的房源 id（上限 maxIds）。
	 * 用于猜你喜欢：在候选集合内做协同过滤与热门补齐。
	 */
	List<Integer> listHouseIdsByRange(HouseInformation houseinfo, HouseRange rangeInfo, int maxIds);

	public List<TotalTable> listTotalTable();

	public Result delete(String code);
	
	public HouseInformation getByCode(String code);

	/**
	 * 根据主键ID查询房源（前台详情页用）
	 *
	 * @param id 房源ID
	 * @return 房源信息
	 */
	public HouseInformation getById(Integer id);
	
	public Result editSystemTable(SystemTable systemTable);
	
	public int update(HouseInformation houseinfo);
	
	public Result add(HouseInformation houseinfo);
	
	public Map<String, List<HouseImgInfo>> getImg(List<HouseInformation> houseinfoList);

	/**
	 * 列表/足迹等仅需封面图：批量查首图，避免 N+1；不影响 {@link #getImg} 的全量多图语义。
	 */
	public Map<String, List<HouseImgInfo>> getCoverImg(List<HouseInformation> houseinfoList);

	/**
	 * 按全站收藏热度降序查询房源（用于推荐冷启动兜底）。
	 */
	List<HouseInformation> getTopFavoritedHouses(int limit);
}

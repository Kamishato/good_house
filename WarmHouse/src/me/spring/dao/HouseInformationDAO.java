package me.spring.dao;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import me.spring.entity.HouseImgInfo;
import me.spring.entity.HouseInformation;
import me.spring.entity.HouseRange;
import me.spring.entity.TotalTable;

public interface HouseInformationDAO {
	public List<HouseInformation> getByFactors(@Param("houseInfo") HouseInformation houseInfo);
	
	public List<HouseInformation> selectByRange(@Param("houseInfo") HouseInformation houseInfo,@Param("rangeInfo") HouseRange rangeInfo);

	/**
	 * 与 {@link #selectByRange} 相同筛选条件，仅返回 id（用于猜你喜欢：先筛选再在候选集内推荐）
	 */
	List<Integer> selectIdsByRange(@Param("houseInfo") HouseInformation houseInfo, @Param("rangeInfo") HouseRange rangeInfo,
			@Param("maxIds") int maxIds);
	
	public HouseInformation selectByCode(@Param("code") String code);

	public HouseInformation selectById(@Param("id") Integer id);

	public List<HouseInformation> selectByBehavior(@Param("userId") Integer userId, @Param("behaviorType") Integer behaviorType, @Param("limitNum") Integer limitNum);
	
	public int delete(@Param("code") String code);
	
	
	public List<TotalTable> getTotalTable();
	
	public int update(@Param("houseinfo") HouseInformation houseinfo);
	
	public int insert(@Param("houseinfo") HouseInformation houseinfo);
	
	public List<HouseImgInfo> getHouseImg(@Param("code") String code);

	/**
	 * 批量查询每个房源的“首图”（只返回每个 code 对应的一张图片）
	 *
	 * @param codes 房源编号集合（t_houseinformation.code）
	 * @return 返回列表中每个 code 一张图片的 HouseImgInfo
	 */
	public List<HouseImgInfo> getFirstHouseImgByCodes(@Param("codes") List<String> codes);

	/**
	 * 按全站收藏次数（behavior_type=2）降序取热门房源，用于推荐冷启动兜底。
	 */
	List<HouseInformation> getTopFavoritedHouses(@Param("limit") int limit);
}

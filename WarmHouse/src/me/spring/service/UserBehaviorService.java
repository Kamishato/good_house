package me.spring.service;

/**
 * 用户行为服务层
 */
public interface UserBehaviorService {

    /**
     * 记录用户行为（无感埋点）
     *
     * @param userId       用户ID
     * @param houseId      房源ID
     * @param behaviorType 行为类型：1代表浏览，2代表收藏
     */
    void recordBehavior(Integer userId, Integer houseId, Integer behaviorType);
}

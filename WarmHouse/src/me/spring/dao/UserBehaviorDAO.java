package me.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import me.spring.entity.UserBehavior;

/**
 * 用户行为数据访问层（原生 SSM + MyBatis）
 * 对应数据表：t_user_behavior
 */
public interface UserBehaviorDAO {

    /**
     * 记录用户行为（埋点用）
     *
     * @param behavior 用户行为
     * @return 影响行数
     */
    int insert(UserBehavior behavior);

    /**
     * 查某用户的历史记录（过滤已读用）
     *
     * @param userId 用户ID
     * @return 行为记录列表
     */
    List<UserBehavior> selectByUserId(Integer userId);

    /**
     * 查询所有用户的记录（协同过滤算法计算相似度矩阵用）
     *
     * @return 所有行为记录列表
     */
    List<UserBehavior> selectAll();

    /**
     * 查询某用户是否已对某房源产生指定类型行为（如收藏 behavior_type=2）
     *
     * @return 匹配记录条数，0 表示未发生
     */
    int checkUserBehavior(@Param("userId") Integer userId, @Param("houseId") Integer houseId,
            @Param("behaviorType") Integer behaviorType);
}

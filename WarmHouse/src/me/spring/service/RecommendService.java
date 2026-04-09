package me.spring.service;

import java.util.List;

/**
 * 基于物品的协同过滤（Item-CF）推荐服务。
 */
public interface RecommendService {

    /**
     * 为目标用户推荐房源主键 ID 列表（按预测得分降序取前 topK）。
     *
     * @param targetUserId 目标用户 ID
     * @param topK           推荐条数
     * @return 房源 id 列表；无历史行为时返回空列表（由上层做冷启动兜底）
     */
    List<Integer> recommendHouseIds(Integer targetUserId, int topK);
}

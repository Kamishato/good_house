package me.spring.imp;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import me.spring.dao.UserBehaviorDAO;
import me.spring.entity.UserBehavior;
import me.spring.service.RecommendService;

/**
 * 基于物品的协同过滤（Item-Based Collaborative Filtering）推荐引擎实现。
 * <p>
 * 毕设说明：在内存中用纯 Java 的 Map/List 完成「用户-物品评分矩阵 → 物品共现 → 余弦相似度 → 加权预测」全流程，
 * 便于论文中配图说明数据结构与公式对应关系。
 * </p>
 */
@Service
public class RecommendImp implements RecommendService {

    /** 浏览行为权重 */
    private static final double WEIGHT_BROWSE = 1.0;
    /** 收藏行为权重（更强偏好信号） */
    private static final double WEIGHT_FAVORITE = 3.0;

    @Autowired
    private UserBehaviorDAO userBehaviorDAO;

    /**
     * 将行为类型映射为隐式评分。
     */
    private static double implicitScore(Integer behaviorType) {
        if (behaviorType == null) {
            return 0.0;
        }
        // 1=浏览，2=收藏
        if (behaviorType == 2) {
            return WEIGHT_FAVORITE;
        }
        return WEIGHT_BROWSE;
    }

    /**
     * 向嵌套 Map 累加：matrix.get(i).get(j) += delta
     */
    private static void addMatrix(Map<Integer, Map<Integer, Double>> matrix, int i, int j, double delta) {
        matrix.computeIfAbsent(i, k -> new HashMap<>()).merge(j, delta, (a, b) -> a + b);
    }

    @Override
    public List<Integer> recommendHouseIds(Integer targetUserId, int topK) {
        if (targetUserId == null || topK <= 0) {
            return new ArrayList<>();
        }

        try {
            // 1. 获取所有行为数据
            List<UserBehavior> behaviors = userBehaviorDAO.selectAll();
            if (behaviors == null || behaviors.isEmpty()) {
                return new ArrayList<>();
            }

            // —— 步骤 1：清洗为「用户 -> (房源 -> 隐式评分)」矩阵；同一用户对同一房源取最高权重 ——
            Map<Integer, Map<Integer, Double>> userItemScoreMatrix = new HashMap<>();
            for (UserBehavior b : behaviors) {
                if (b == null || b.getUserId() == null || b.getHouseId() == null) {
                    continue;
                }
                double s = implicitScore(b.getBehaviorType());
                if (s <= 0 || !Double.isFinite(s)) {
                    continue;
                }
                Map<Integer, Double> row = userItemScoreMatrix.computeIfAbsent(b.getUserId(), u -> new HashMap<>());
                int hid = b.getHouseId();
                row.merge(hid, s, (oldV, newV) -> Math.max(oldV, newV));
            }

            Map<Integer, Double> targetRow = userItemScoreMatrix.get(targetUserId);
            if (targetRow == null || targetRow.isEmpty()) {
                // 新用户无记录，由 Controller 走热门兜底
                return new ArrayList<>();
            }

            // —— 步骤 2：构建物品共现矩阵 C 与物品「能量」N（此处 N[i]=C[i][i]，即 sum_u r_{u,i}^2） ——
            Map<Integer, Map<Integer, Double>> C = new HashMap<>();

            for (Map.Entry<Integer, Map<Integer, Double>> e : userItemScoreMatrix.entrySet()) {
                Map<Integer, Double> items = e.getValue();
                List<Integer> houseIds = new ArrayList<>(items.keySet());
                int n = houseIds.size();
                for (int a = 0; a < n; a++) {
                    int i = houseIds.get(a);
                    Double riObj = items.get(i);
                    double ri = riObj != null ? riObj : 0.0;
                    if (!Double.isFinite(ri)) {
                        continue;
                    }
                    for (int b = 0; b < n; b++) {
                        int j = houseIds.get(b);
                        Double rjObj = items.get(j);
                        double rj = rjObj != null ? rjObj : 0.0;
                        if (!Double.isFinite(rj)) {
                            continue;
                        }
                        addMatrix(C, i, j, ri * rj);
                    }
                }
            }

            // N[i] = C[i][i] = sum_u r_{u,i}^2
            Map<Integer, Double> N = new HashMap<>();
            for (Integer i : C.keySet()) {
                Map<Integer, Double> row = C.get(i);
                if (row != null && row.containsKey(i)) {
                    N.put(i, row.get(i));
                }
            }

            // —— 步骤 3：余弦相似度矩阵 W：W[i][j] = C[i][j] / sqrt(N[i]*N[j])，跳过 NaN/Inf ——
            Map<Integer, Map<Integer, Double>> W = new HashMap<>();
            for (Map.Entry<Integer, Map<Integer, Double>> rowEntry : C.entrySet()) {
                int i = rowEntry.getKey();
                Double ni = N.get(i);
                if (ni == null || ni <= 0 || !Double.isFinite(ni)) {
                    continue;
                }
                for (Map.Entry<Integer, Double> colEntry : rowEntry.getValue().entrySet()) {
                    int j = colEntry.getKey();
                    Double nj = N.get(j);
                    if (nj == null || nj <= 0 || !Double.isFinite(nj)) {
                        continue;
                    }
                    double cij = colEntry.getValue();
                    if (!Double.isFinite(cij)) {
                        continue;
                    }
                    double denom = Math.sqrt(ni * nj);
                    if (denom <= 0 || !Double.isFinite(denom)) {
                        continue;
                    }
                    double wij = cij / denom;
                    if (!Double.isFinite(wij)) {
                        continue;
                    }
                    addMatrix(W, i, j, wij);
                }
            }

            Set<Integer> allItems = new HashSet<>();
            for (Map<Integer, Double> row : userItemScoreMatrix.values()) {
                allItems.addAll(row.keySet());
            }

            Set<Integer> seenByTarget = new HashSet<>(targetRow.keySet());

            // —— 步骤 4：预测 —— sum_i W[i][j]*r_{u,i}，丢弃非有限值 ——
            Map<Integer, Double> predScore = new HashMap<>();
            for (Integer j : allItems) {
                if (seenByTarget.contains(j)) {
                    continue;
                }
                double sum = 0.0;
                for (Map.Entry<Integer, Double> ie : targetRow.entrySet()) {
                    int i = ie.getKey();
                    double rui = ie.getValue() != null ? ie.getValue() : 0.0;
                    if (!Double.isFinite(rui)) {
                        continue;
                    }
                    Double wij = getSimilarity(W, i, j);
                    if (wij != null && wij > 0 && Double.isFinite(wij)) {
                        double term = wij * rui;
                        if (Double.isFinite(term)) {
                            sum += term;
                        }
                    }
                }
                if (sum > 0 && Double.isFinite(sum)) {
                    predScore.put(j, sum);
                }
            }

            if (predScore.isEmpty()) {
                return new ArrayList<>();
            }

            // —— 步骤 5：按预测分降序，取前 topK 个 houseId ——
            List<Map.Entry<Integer, Double>> sorted = new ArrayList<>(predScore.entrySet());
            sorted.sort(Comparator.comparing(Map.Entry<Integer, Double>::getValue).reversed());

            List<Integer> out = new ArrayList<>();
            for (Map.Entry<Integer, Double> en : sorted) {
                if (en.getKey() != null && en.getValue() != null && Double.isFinite(en.getValue())) {
                    out.add(en.getKey());
                    if (out.size() >= topK) {
                        break;
                    }
                }
            }
            return out;
        } catch (Exception e) {
            System.out.println("Item-CF 算法计算出现异常，已降级处理: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    /**
     * 取 W[i][j]，若不存在则尝试对称位置 W[j][i]（数值应对称，实现上双保险）。
     */
    private static Double getSimilarity(Map<Integer, Map<Integer, Double>> W, int i, int j) {
        if (W.containsKey(i) && W.get(i).containsKey(j)) {
            return W.get(i).get(j);
        }
        if (W.containsKey(j) && W.get(j).containsKey(i)) {
            return W.get(j).get(i);
        }
        return null;
    }
}

package me.spring.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户行为实体类
 * 对应数据表：t_user_behavior
 */
public class UserBehavior implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private Integer id;

    /**
     * 用户ID，对应t_user表
     */
    private Integer userId;

    /**
     * 房源ID，对应t_houseinformation表
     */
    private Integer houseId;

    /**
     * 行为类型：1代表浏览，2代表收藏
     */
    private Integer behaviorType;

    /**
     * 行为发生的时间
     */
    private Date createTime;

    /**
     * 无参构造方法
     */
    public UserBehavior() {
    }

    /**
     * 全参构造方法
     *
     * @param id           主键ID
     * @param userId       用户ID
     * @param houseId      房源ID
     * @param behaviorType 行为类型：1代表浏览，2代表收藏
     * @param createTime   行为发生的时间
     */
    public UserBehavior(Integer id, Integer userId, Integer houseId, Integer behaviorType, Date createTime) {
        this.id = id;
        this.userId = userId;
        this.houseId = houseId;
        this.behaviorType = behaviorType;
        this.createTime = createTime;
    }

    /**
     * 获取主键ID
     *
     * @return 主键ID
     */
    public Integer getId() {
        return id;
    }

    /**
     * 设置主键ID
     *
     * @param id 主键ID
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * 获取用户ID
     *
     * @return 用户ID
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * 设置用户ID
     *
     * @param userId 用户ID
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * 获取房源ID
     *
     * @return 房源ID
     */
    public Integer getHouseId() {
        return houseId;
    }

    /**
     * 设置房源ID
     *
     * @param houseId 房源ID
     */
    public void setHouseId(Integer houseId) {
        this.houseId = houseId;
    }

    /**
     * 获取行为类型
     *
     * @return 行为类型：1代表浏览，2代表收藏
     */
    public Integer getBehaviorType() {
        return behaviorType;
    }

    /**
     * 设置行为类型
     *
     * @param behaviorType 行为类型：1代表浏览，2代表收藏
     */
    public void setBehaviorType(Integer behaviorType) {
        this.behaviorType = behaviorType;
    }

    /**
     * 获取行为发生的时间
     *
     * @return 行为发生的时间
     */
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 设置行为发生的时间
     *
     * @param createTime 行为发生的时间
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "UserBehavior{" +
                "id=" + id +
                ", userId=" + userId +
                ", houseId=" + houseId +
                ", behaviorType=" + behaviorType +
                ", createTime=" + createTime +
                '}';
    }
}
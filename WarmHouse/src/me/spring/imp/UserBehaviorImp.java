package me.spring.imp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import me.spring.dao.UserBehaviorDAO;
import me.spring.entity.UserBehavior;
import me.spring.service.UserBehaviorService;

/**
 * 用户行为服务实现类
 */
@Service
public class UserBehaviorImp implements UserBehaviorService {

    @Autowired
    private UserBehaviorDAO userBehaviorDAO;

    @Override
    public void recordBehavior(Integer userId, Integer houseId, Integer behaviorType) {
        UserBehavior behavior = new UserBehavior();
        behavior.setUserId(userId);
        behavior.setHouseId(houseId);
        behavior.setBehaviorType(behaviorType);
        userBehaviorDAO.insert(behavior);
    }
}

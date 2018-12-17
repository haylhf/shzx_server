package com.eservice.api.service.impl;

import com.eservice.api.dao.UserMapper;
import com.eservice.api.model.user.User;
import com.eservice.api.service.UserService;
import com.eservice.api.core.AbstractService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;


/**
* Class Description: xxx
* @author Wilson Hu
* @date 2018/12/17.
*/
@Service
@Transactional
public class UserServiceImpl extends AbstractService<User> implements UserService {
    @Resource
    private UserMapper userMapper;

}

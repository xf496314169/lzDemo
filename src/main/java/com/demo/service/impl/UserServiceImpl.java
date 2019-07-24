package com.demo.service.impl;

import com.demo.dao.UserDao;
import com.demo.service.UserService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    public  PageInfo<Map<String,Object>>   pagingQuery(Integer pageNum,Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<Map<String,Object>> users= userDao.pagingQuery();
        PageInfo<Map<String,Object>> pageInfo=new PageInfo<Map<String, Object>>(users);
        return pageInfo;
    }

    public int deleteUser(String id) {
        return userDao.deleteUser(id);
    }

    public int updateUser(Map<String, Object> user) {
        user.put("updateDate",new Date());
        return userDao.updateUser(user);
    }

    public int addUser(Map<String, Object> user) {
        user.put("id", String.valueOf(System.currentTimeMillis()));
        user.put("createDate",new Date());
        user.put("updateDate",new Date());
        return   userDao.addUser(user);
    }

    public Map<String, Object> login(Map<String, Object> user) {
        Map<String,Object> messageMap=new HashMap<String, Object>();
        String username=String.valueOf(user.get("username"));
        String password=String.valueOf(user.get("password"));
        Map<String,Object> loginUser=userDao.login(username);
         if(loginUser!=null){
              if(loginUser.get("password").equals(password)){
                  messageMap.put("message","登录成功");
                  messageMap.put("flag",true);
                  messageMap.put("user",loginUser);
              }else{
                  messageMap.put("message","密码错误");
                  messageMap.put("flag",false);
              }
         }else{
             messageMap.put("message","用户名错误");
             messageMap.put("flag",false);
         }
        return messageMap;
    }
}

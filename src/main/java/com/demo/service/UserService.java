package com.demo.service;

import com.demo.dao.UserDao;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


public interface UserService {


   PageInfo<Map<String,Object>> pagingQuery(Integer pageNum, Integer pageSize);

    int deleteUser(String id);

    int updateUser(Map<String,Object> user);

    int addUser(Map<String,Object> user);

    Map<String,Object> login(Map<String,Object> user);
}

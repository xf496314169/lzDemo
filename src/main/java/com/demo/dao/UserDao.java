package com.demo.dao;

import java.util.List;
import java.util.Map;

public interface UserDao {

    List<Map<String,Object>> pagingQuery();

    int deleteUser(String id);

    int updateUser(Map<String,Object> user);

    int addUser(Map<String,Object> user);

    Map<String,Object> login(String username);

}

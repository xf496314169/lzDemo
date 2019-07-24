package com.demo.controller;

import com.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class UserController {

      @Autowired
      private UserService userService;

    @RequestMapping("pagingQuery")
    @ResponseBody
    public Object pagingQuery(Integer pageNum,Integer pageSize){
      return   userService.pagingQuery(pageNum,pageSize);
    }
    @RequestMapping("addUser")
    @ResponseBody
    public Object addUser(@RequestBody Map<String,Object> user,HttpSession session){
      Map<String,Object> loginUser= (Map<String, Object>) session.getAttribute("user");
        if(loginUser.get("rid").equals("2")) {
            int num = userService.addUser(user);
            if (num > 0) {
                return "新增成功";
            } else {
                return "新增失败";
            }
        }else{
            return "您没有权限进行此操作";
        }
    }
    @RequestMapping("updateUser")
    @ResponseBody
    public Object updateUser(@RequestBody Map<String,Object> user,HttpSession session){
        Map<String,Object> loginUser= (Map<String, Object>) session.getAttribute("user");
        if(loginUser.get("rid").equals("2")) {
            int num = userService.updateUser(user);
            if (num > 0) {
                return "修改成功";
            } else {
                return "修改失败";
            }
        }else{
            return "您没有权限进行此操作";
        }
    }
    @RequestMapping("deleteUser")
    @ResponseBody
    public Object deleteUser(String id,HttpSession session){
        Map<String,Object> loginUser= (Map<String, Object>) session.getAttribute("user");
        if(loginUser.get("rid").equals("2")) {
            int num = userService.deleteUser(id);
            if (num > 0) {
                return "删除成功";
            } else {
                return "删除失败";
            }
        }else{
            return "您没有权限进行此操作";
        }
    }
    @RequestMapping("login")
    @ResponseBody
    public Object login(@RequestBody Map<String,Object> user, HttpSession session){

       Map<String,Object> messageMap= userService.login(user);
         if((Boolean)(messageMap.get("flag"))){
           session.setAttribute("user",messageMap.get("user"));
         }
       return messageMap;
    }
}

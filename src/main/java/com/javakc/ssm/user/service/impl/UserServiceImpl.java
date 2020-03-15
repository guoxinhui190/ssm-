package com.javakc.ssm.user.service.impl;

import com.javakc.ssm.user.dao.UserDao;
import com.javakc.ssm.user.entity.User;
import com.javakc.ssm.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.sql.Date;

@Service(value = "userService")
public class UserServiceImpl implements UserService, UserDetailsService {

    @Autowired
    private UserDao userDao;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public int insert(User entity) {
//        entity.getPass();
        entity.setPass(passwordEncoder.encode(entity.getPass()));
        return userDao.insert(entity);
    }

    @Override
    public int update(User entity) {
        return userDao.update(entity);
    }

    @Override
    public int delete(int id) {
        return userDao.delete(id);
    }

    @Override
    public int batch(int[] ids) {
        return userDao.batch(ids);
    }

    @Override
    public List<User> queryAll(User user,int start,int size,String notnickname) {
        user.setRealnamed(user.getRealnamed() + "%");
//        System.out.println(user.getRealnamed() + "----------------------------------");
//        if (user.getLdate() != null){
//            Date ldate = user.getLdate();
//            Calendar calendar2 =
//                    new GregorianCalendar();
//            calendar2.setTime(ldate); //你自己的数据进行类型转换
//            calendar2.add(calendar2.DATE,1);//把日期往后增加一天.整数往后推,负数往前移动
//            ldate= new java.sql.Date(calendar2.getTime().getTime());
//            user.setLdate(ldate);
//        }
        Map<String,Object> map = new HashMap<>();
        map.put("start",start);
        map.put("size",size);
        map.put("user",user);
        map.put("notnickname",notnickname);
        return userDao.queryAll(map);
    }

    @Override
    public List<User> toupdate(int id) {
        Map<String,Object> map = new HashMap<>();
        map.put("id",id);
        return userDao.toupdate(map);
    }

    @Override
    public User queryById(String id) {
        return userDao.queryById(id);
    }

    @Override
    public long queryByCount(User user) {
        Map<String , Object> map = new HashMap<>();
        return userDao.queryByCount(map);
    }

    @Override
    public Map<String, Object> unique(String nickname) {
        int result = userDao.unique(nickname);
        Map<String,Object> data = new HashMap<>();
        data.put("success",result == 0?true:false);
        data.put("message",result == 0?"可用":"no!");
        return data;
    }

    @Override
    public User getUser() {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        org.springframework.security.core.userdetails.User user = (org.springframework.security.core.userdetails.User)userDetails;
        return userDao.queryByName(user.getUsername());
    }

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        System.out.println("输入登录名称：" + s);
        User user = userDao.queryByName(s);
        if (!StringUtils.isEmpty(user))
        {
            return new org.springframework.security.core.userdetails.User(user.getName(),user.getPass(),getAuthority(user.getRoles()));
        }
        return null;
    }
    /**
     * @Date 17:17 2020/1/17
     * @Param []
     * @return 返回一个list集合, 集合中装的是用户权限描述
     **/
    private List<SimpleGrantedAuthority> getAuthority(String loginname) {
        List<SimpleGrantedAuthority> list = new ArrayList<>();
        list.add(new SimpleGrantedAuthority(loginname));
        return list;
    }
}

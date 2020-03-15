package com.javakc.ssm.user.entity;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class User {
    private Integer id;
    private String name;
    private String pass;
    private String nickname;
    private Integer age;
    //sex:0-man 1-woman
    private Integer gender;
    private String phone;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthday;
    private String address;
    private String realnamed;//搜索名称
    private java.sql.Date sdate;//开始日期
    private java.sql.Date ldate;//结束日期
    private String Roles;//角色

}

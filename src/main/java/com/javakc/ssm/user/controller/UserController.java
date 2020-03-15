package com.javakc.ssm.user.controller;

import com.javakc.ssm.component.Page;
import com.javakc.ssm.user.entity.User;
import com.javakc.ssm.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Map;

/**
 * 用户模块-表现层实现类
 */
@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("query/{nickname}")
    public String query(@PathVariable String nickname, User user, Page<User> userpage, ModelMap model) throws ParseException {
        userpage.setList(userService.queryAll(user,userpage.getStart(),userpage.getSize(),nickname));
        userpage.setCount(userService.queryByCount(user));
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        userpage.setSdate((user.getSdate() == null ? "" : simpleDateFormat.format(user.getSdate())));
        userpage.setLdate((user.getLdate() == null? "" : simpleDateFormat.format(user.getLdate())));
        System.out.println((user.getSdate() == null ? "" : simpleDateFormat.format(user.getSdate())));
        System.out.println((user.getLdate() == null ? "" : simpleDateFormat.format(user.getLdate())));
        userpage.setRealnamed2(user.getRealnamed().substring(0,user.getRealnamed().length() - 1));
        model.put("userpage",userpage);
        return "user/list";
    }
    @RequestMapping("toupdate/{id}")
    public String toupdate(@PathVariable int id, Page<User> userpage,ModelMap model)
    {
        userpage.setList(userService.toupdate(id));
        model.put("userpage",userpage);
        return "user/update";
    }
    @RequestMapping(value="insert/{nickname}",method= RequestMethod.POST)
    public String insert(@PathVariable String nickname , User entity)
    {
        userService.insert(entity);
        return "redirect:/user/query/" + nickname +  ".do";
    }
    @RequestMapping(value="update/{nickname}",method= RequestMethod.POST)
    public String update(@PathVariable String nickname , User entity)
    {
        userService.update(entity);
        return "redirect:/user/query/" + nickname +  ".do";
    }
    @RequestMapping(value = "delete/{id}/{nickname}")
    public String delete(@PathVariable  int id ,@PathVariable String nickname){
        userService.delete(id);
        return "redirect:/user/query/" + nickname +".do";
    }

    @RequestMapping(value = "batch/{nickname}",method = RequestMethod.POST)
    public String batch(int[] ides,@PathVariable String nickname){
        System.out.println(ides);
        userService.batch(ides);
//       return "attachment/query/null.do";
        String bathpath = "redirect:/user/query/" + nickname + ".do";
        return bathpath;
    }

    @RequestMapping(value = "unique",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> unique(String nickname)
    {
        return userService.unique(nickname);
    }

}

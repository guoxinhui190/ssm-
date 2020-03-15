package com.javakc.ssm.attachment.service.impl;

import com.javakc.ssm.attachment.dao.AttachmentDao;
import com.javakc.ssm.attachment.entity.Attachment;
import com.javakc.ssm.attachment.service.AttachmentService;
import com.javakc.ssm.user.entity.User;
import com.javakc.ssm.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @ClassName AttachmentServiceImpl
 * @Description TODO
 * @Author Administrator
 * @Date 2020/1/14 16:55
 * @Version 1.0
 **/
@Service
public class AttachmentServiceImpl implements AttachmentService {
    @Autowired
    private AttachmentDao attachmentDao;
    @Autowired
    private UserService userService;
    @Override
    public int insert(Attachment entity) {
        entity.setCreatetime(new Timestamp(System.currentTimeMillis()));
        //获取当前登录人信息
        User user = userService.getUser();
        entity.setUser(user);
        return attachmentDao.insert(entity);
    }

    @Override
    public int update(Attachment entity) {
        return attachmentDao.update(entity);
    }

    @Override
    public int delete(int id) {
        return attachmentDao.delete(id);
    }

    @Override
    public List<Attachment> queryByPage(Attachment attachment, int start, int size) {
        attachment.setRealnamed(attachment.getRealnamed() + "%");

//        if (attachment.getLdate() != null){
//            Date ldate = attachment.getLdate();
//            Calendar calendar2 =
//                    new GregorianCalendar();
//            calendar2.setTime(ldate); //你自己的数据进行类型转换
//            calendar2.add(calendar2.DATE,1);//把日期往后增加一天.整数往后推,负数往前移动
//            ldate= new java.sql.Date(calendar2.getTime().getTime());
//            attachment.setLdate(ldate);
//        }

        Map<String,Object> param = new HashMap<>();
        param.put("nickname",attachment.user.getNickname());
        param.put("start" ,start);
        param.put("size",size);
        param.put("sdate",attachment.getSdate());
        param.put("ldate",attachment.getLdate());
        param.put("realnamed",attachment.getRealnamed());
        param.put("sort",attachment.getSort());
        return attachmentDao.queryByPage(param);
    }

    @Override
    public long queryByCount(Attachment entity) {
        Map<String,Object> param = new HashMap<>();
        return attachmentDao.queryByCount(param);
    }

    @Override
    public Attachment queryById(int id) {
        return attachmentDao.queryById(id);
    }

    @Override
    public int updateDown(int id) {
        return attachmentDao.updateDown(id);
    }


    @Override
    public int batch(int[] ids) {
        return attachmentDao.batch(ids);
    }
}

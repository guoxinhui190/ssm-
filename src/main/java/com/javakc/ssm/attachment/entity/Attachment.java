package com.javakc.ssm.attachment.entity;

import com.javakc.ssm.user.entity.User;
import lombok.Data;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * @ClassName Attachment
 * @Description TODO
 * @Author Administrator
 * @Date 2020/1/14 16:43
 * @Version 1.0
 **/
@Data
public class Attachment {
    private int id;//主键
    private String name;//名称
    private String realname;//真实名称
    private String path;//保存路径
    private long filesize;//文件大小
    private String suffix;//文件后缀
    private int download;//下载次数
    private Timestamp createtime;//上传日期
    private Date sdate;//开始日期
    private Date ldate;//结束日期
    private String realnamed;//搜索名称
    private int state;//是否私有
    public User user;//上传人对象
    private String sort;//分类查询
}

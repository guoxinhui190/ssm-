package com.javakc.ssm.attachment.dao;

import com.javakc.ssm.attachment.entity.Attachment;

import java.util.List;
import java.util.Map;

/**
 * @InterfaceName AttachmentDao
 * @Description TODO
 * @Author Administrator
 * @Date 2020/1/14 16:48
 * @Version 1.0
 **/
public interface AttachmentDao {
    public int insert(Attachment entity);
    public int update(Attachment entity);
    public int delete(int id);
    public List<Attachment> queryByPage(Map<String,Object> param);
    public long queryByCount(Map<String,Object> param);
    public Attachment queryById(int id);
    public int updateDown(int id);
    public int batch(int[] ids);
}

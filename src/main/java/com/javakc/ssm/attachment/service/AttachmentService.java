package com.javakc.ssm.attachment.service;

import com.javakc.ssm.attachment.entity.Attachment;

import java.util.List;
import java.util.Map;

/**
 * @InterfaceName AttachmentService
 * @Description TODO
 * @Author Administrator
 * @Date 2020/1/14 16:54
 * @Version 1.0
 **/
public interface AttachmentService {
    public int insert(Attachment entity);
    public int update(Attachment entity);
    public int delete(int id);
    public List<Attachment> queryByPage(Attachment attachment,int start,int size);
    public long queryByCount(Attachment entity);
    public Attachment queryById(int id);
    public int updateDown(int id);
    public int batch(int[] ids);
}

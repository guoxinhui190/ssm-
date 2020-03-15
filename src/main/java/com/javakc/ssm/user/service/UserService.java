package com.javakc.ssm.user.service;

import com.javakc.ssm.user.entity.User;

import java.util.List;
import java.util.Map;

/**
 * 用户模块-逻辑层接口
 */
public interface UserService {

    /**
     * 用户注册
     * @param entity 实体类
     * @return 成功状态
     */
    public int insert(User entity);
    /**
     * 用户修改
     * @param entity 实体类
     * @return 成功状态
     */
    public int update(User entity);
    /**
     * 删除用户
     * @param id 主键ID
     * @return 状态
     */
    public int delete(int id);
    /**
     * 删除用户
     * @param ids 主键ID
     * @return 状态
     */
    public int batch(int[] ids);

    /**
     * 查询所有记录
     * @return 结果集
     */
    public List<User> queryAll(User user,int start,int size,String nickname);
    /**
     * 查询修改id
     * @return 结果集
     */
    public List<User> toupdate(int id);

    /**
     * 根据主键查询唯一对象
     * @param id 主键ID
     * @return 结果
     */
    public User queryById(String id);

    /**
     * 查询总条数
     * @return 条数
     */
    public long queryByCount(User userss);
//    public long queryByCount();
     /**
      * 登录名称唯一校验
      * @Date 17:46 2020/1/17
      * @Param [nickname]（登录名）
      * @return 校验结果
      **/
    public Map<String,Object> unique(String nickname);
     /**
      * 获取用户对象
      * @Date 17:48 2020/1/17
      * @Param []
      * @return org.springframework.security.core.userdetails.User
      **/
    public User getUser();

}

package com.javakc.ssm.user.dao;

import com.javakc.ssm.user.entity.User;

import java.util.List;
import java.util.Map;

/**
 * 用户模块-数据层接口
 */
public interface UserDao {
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
    public List<User> queryAll(Map<String,Object> map);
    /**
     * 查询所有记录
     * @return 结果集
     */
    public List<User> toupdate(Map<String,Object> map);

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
    public long queryByCount(Map<String,Object> map);
//    public long queryByCount();
    /**
     * 登录名称唯一校验
     * @Date 16:57 2020/1/17
     * @Param [nickname]（登录名称）
     * @return int
     **/
    public int unique(String nickname);
    /**
     * 根据登录名称查询对象
     * @Date 16:57 2020/1/17
     * @Param [nickname]（登录名称）
     * @return com.javakc.ssm.user.entity.User
     **/
    public User queryByName(String nickname);
}

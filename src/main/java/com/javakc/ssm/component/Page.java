package com.javakc.ssm.component;

import lombok.Setter;

import java.util.List;

/**
 * @ClassName Page
 * @Description TODO
 * @Author Administrator
 * @Date 2020/1/15 16:47
 * @Version 1.0
 **/
@Setter
public class Page<T> {
    private int thispage = 1;//当前页
    private int maxpage;//最大页
    private int start;//起始条数
    private int size = 10;//每页查询条数
    private long count;//总条数
    private List<T> list;//分页数据
    private String sort;//文件分类
    private String realnamed2;//文件分类
    private String sdate;//开始时间
    private String ldate;//结束时间

    public int getThispage() {
        return thispage;
    }

    public int getMaxpage() {
        return (int)Math.ceil(count*1.0/size);
    }

    public int getStart() {
        return (thispage - 1) * size;
    }

    public int getSize() {
        return size;
    }

    public long getCount() {
        return count;
    }

    public List<T> getList() {
        return list;
    }

    public String getSort() {
        return sort;
    }

    public String getRealnamed2() {
        return realnamed2;
    }

    public String getSdate() {
        return sdate;
    }

    public String getLdate() {
        return ldate;
    }
}

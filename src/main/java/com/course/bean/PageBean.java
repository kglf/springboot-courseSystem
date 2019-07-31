package com.course.bean;

import java.util.List;
import java.util.Map;

/**
 * @author 空谷丶临风
 * @date 2019-06-21 13:53
 */

public class PageBean {
    //传入参数
    int currentPage;
    int pageSize;

    private int startIndex; //每页开始记录的索引，计算出来的
    private int totalPage;  //一共多少页，计算出来的


    public int getStartIndex() {
        return startIndex;
    }
    //返回给easyui的数据
    private Integer total;//总记录条数，数据库查出来的			    *
    private List rows;//已经分好页的结果集

    public PageBean(Integer currentPage, Integer pageSize) {
        this.currentPage = (currentPage==null )? 1:currentPage;
        this.pageSize = (pageSize==null)? 3: pageSize;
        //计算查询记录的开始索引
        startIndex = (this.currentPage-1)*this.pageSize;

    }

    public PageBean(Integer currentPage, Integer pageSize, Integer num) {
        this.currentPage = (currentPage==null )? 1:currentPage;
        this.pageSize = (pageSize==null)? 5: pageSize;
        System.out.println(this.currentPage);

        //计算查询记录的开始索引
        startIndex = (this.currentPage-1)*this.pageSize;

    }

    public int getCurrentPage() {
        return currentPage;
    }
    public Integer getPageSize() {
        return pageSize;
    }
    public int getTotal() {
        return total;
    }
    public void setTotal(int total) {
        this.total = total;
    }
    public List getRows() {
        return rows;
    }
    public void setRows(List rows) {
        this.rows = rows;
    }


    //给params增加startIndex和pageSize，给mappper的分页查询sql使用
    public void addQueryParam(Map<String,Object> params) {
        totalPage = (int)Math.ceil(Double.valueOf(total)/Double.valueOf(pageSize));
        params.put("startIndex",this.startIndex);
        params.put("pageSize",this.pageSize);
        params.put("pageNum",this.currentPage);
        params.put("totalPage",totalPage);
    }
}

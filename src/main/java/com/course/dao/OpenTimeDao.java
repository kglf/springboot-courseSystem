package com.course.dao;

import com.course.entity.OpenTime;
import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * @author 空谷丶临风
 * @date 2019-06-25 19:32
 */

@Repository
public interface OpenTimeDao {

    public int addOpenTime(Map<String, Object> params);//添加选课开始、结束时间

    public OpenTime queryOpenTime();//查询选课时间段

    public int modifyOpenTime(Map<String, Object> params);//修改选课时间

    public int deleteOpenTime();//删除选课时间
}

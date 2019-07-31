package com.course.service;

import com.course.dao.OpenTimeDao;
import com.course.entity.OpenTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * @author 空谷丶临风
 * @date 2019-06-25 19:37
 */

@Service
@Transactional
public class OpenTimeService {

    @Autowired
    OpenTimeDao mapper;

    public boolean addOpenTime(Map<String,Object> params){
        return mapper.addOpenTime(params)>0;
    }

    public OpenTime queryOpenTime(){
        return mapper.queryOpenTime();
    }

    public boolean modifyOpenTime(Map<String,Object> params){
        return mapper.modifyOpenTime(params)>0;
    }

    public boolean deleteOpenTime(){
        return mapper.deleteOpenTime()>0;
    }
}

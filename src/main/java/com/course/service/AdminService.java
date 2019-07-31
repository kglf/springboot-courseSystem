package com.course.service;

import com.course.dao.AdminDao;
import com.course.entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author 空谷丶临风
 * @date 2019-06-17 22:29
 */

@Service
@Transactional
public class AdminService {

    @Autowired
    private AdminDao mapper;

    public Admin verify(String ano, String apassword){
        return mapper.verify(ano,apassword);
    }

    public Admin findById(String ano){
        return mapper.findById(ano);
    }

    public boolean updateById(Admin admin){
        return mapper.updateById(admin)>0;
    }


}

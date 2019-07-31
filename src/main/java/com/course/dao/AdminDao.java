package com.course.dao;

import com.course.entity.Admin;
import org.springframework.stereotype.Repository;

/**
 * @author 空谷丶临风
 * @date 2019-06-17 22:17
 */

@Repository
public interface AdminDao {

    Admin verify(String ano, String apassword);//按ano和apwd验证用户是否存在

    Admin findById(String ano);//按ano查用户

    public int updateById(Admin admin);//按ano更新用户



}

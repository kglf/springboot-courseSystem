package com.course.dao;

import com.course.entity.Student;
import org.springframework.stereotype.Repository;

/**
 * @author 空谷丶临风
 * @date 2019-06-22 19:51
 */

@Repository
public interface StudentDao {

    Student verify(String sno, String spassword);//按sno和spwd验证学生是否存在

    Student findById(String sno);//按sno查学生

    public int updateById(Student student);//按sno更新学生
}

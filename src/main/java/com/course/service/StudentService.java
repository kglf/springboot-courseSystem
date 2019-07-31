package com.course.service;

import com.course.dao.StudentDao;
import com.course.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author 空谷丶临风
 * @date 2019-06-22 19:55
 */

@Service
@Transactional
public class StudentService {

    @Autowired
    private StudentDao mapper;

    public Student verify(String sno, String spassword){
        return mapper.verify(sno,spassword);
    }

    public Student findById(String sno){
        return mapper.findById(sno);
    }

    public boolean updateById(Student student){
        return mapper.updateById(student)>0;
    }
}

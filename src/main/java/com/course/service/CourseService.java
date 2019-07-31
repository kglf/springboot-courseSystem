package com.course.service;

import com.course.bean.PageBean;
import com.course.dao.CourseDao;
import com.course.entity.Course;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * @author 空谷丶临风
 * @date 2019-06-18 22:52
 */

@Service
@Transactional
public class CourseService {

    @Autowired
    CourseDao mapper;

    public List<Course> queryAllCourse(){
        return mapper.queryAllCourse();
    }

    public Integer getTotalCount(){
        return mapper.getTotalCount();
    }

    public List<Course> queryListByPage(Integer pgNo, Integer pgSize, Map<String,Object> params){
        PageBean page = new PageBean(pgNo,pgSize);
        //-----查询记录条数
        Integer total= mapper.getTotalCount();
        page.setTotal(total);
        page.addQueryParam(params);
        return mapper.queryListByPage(params);
    }

    public boolean addCourse(Course course){
        return mapper.addCourse(course)>0;
    }

    public boolean updateById(Course course){
        return mapper.updateById(course)>0;
    }

    public boolean deleteById(String cno){
        return mapper.deleteById(cno)>0;
    }

    public List<Course> queryByCond(Course course){
        return mapper.queryByCond(course);
    }

    public List<Course> queryByCondAndPage(Integer pgNo, Integer pgSize, Map<String,Object> params){
        PageBean page = new PageBean(pgNo,pgSize);
        //-----查询记录条数
        Integer total= mapper.getTotalCountByCond(params);
        page.setTotal(total);
        page.addQueryParam(params);
        return mapper.queryByCondAndPage(params);
    }

    public List<Course> queryCourseFull(){
        return mapper.queryCourseFull();
    }

    public List<Course> queryCourseSelectedBySno(String sno){
        return mapper.queryCourseSelectedBySno(sno);
    }

    public boolean pickCourse(Map<String,Object> params){
        mapper.pickCourseBeforeSub1(params);//选课之前，课程剩余人数先减1
        return mapper.pickCourse(params)>0;
    }

    public boolean retiredCourse(Map<String,Object> params){
        return mapper.retiredCourse(params)>0;
    }

    public List<Course> queryPersonalCourseList(String sno){
        return mapper.queryPersonalCourseList(sno);
    }

    public List<Course> personalCourseListPage(Integer pgNo, Integer pgSize, Map<String,Object> params){
        PageBean page = new PageBean(pgNo,pgSize,1);
        //-----查询记录条数
        Integer total= mapper.getPersonalTotalCount(params);
        page.setTotal(total);
        page.addQueryParam(params);
        return mapper.queryPersonalCourseByPage(params);
    }

}

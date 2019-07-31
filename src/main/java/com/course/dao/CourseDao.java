package com.course.dao;

import com.course.entity.Course;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @author 空谷丶临风
 * @date 2019-06-18 22:50
 */

@Repository
public interface CourseDao {

    public List<Course> queryAllCourse();

    public Integer getTotalCount();//查询共有多少条记录

    public List<Course> queryListByPage(Map<String, Object> params);//分页查询

    public int addCourse(Course course);//添加课程

    public int updateById(Course course);//修改课程

    public int deleteById(String cno);//删除课程

    public List<Course> queryByCond(Course course);//按条件查询课程

    public Integer getTotalCountByCond(Map<String, Object> params);//按条件查询共有多少条记录

    public List<Course> queryByCondAndPage(Map<String, Object> params);//按条件分页查询课程

    public List<Course> queryCourseFull();//查找已满人的课程

    public List<Course> queryCourseSelectedBySno(String sno);//查找学生已选课程

    public int pickCourseBeforeSub1(Map<String, Object> params);//插入选课记录之前，先进行课程剩余人数减1

    public int pickCourse(Map<String, Object> params);//按学生sno和课程cno选课

    public int retiredCourse(Map<String, Object> params);//按学生sno和课程cno退课

    public List<Course> queryPersonalCourseList(String sno);//按学生sno查看个人已选的课程

    public Integer getPersonalTotalCount(Map<String, Object> params);//查询学生已选课程共有多少条记录

    public List<Course> queryPersonalCourseByPage(Map<String, Object> params);//分页查询学生已选课程

}

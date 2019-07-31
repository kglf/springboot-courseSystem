package com.course.controller;

import com.course.entity.Course;
import com.course.entity.OpenTime;
import com.course.entity.Student;
import com.course.service.CourseService;
import com.course.service.OpenTimeService;
import com.course.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * @author 空谷丶临风
 * @date 2019-06-22 19:49
 */

@Controller
@RequestMapping("/student")
public class StudentController {

    @Autowired
    StudentService service;

    @Autowired
    CourseService courseService;

    @Autowired
    OpenTimeService openTimeService;


    @RequestMapping("/login.do")
    public String login(String no, String password, HttpSession session, Map model){
        Student student = service.verify(no,password);
        if(student!=null) {
            session.setAttribute("student", student);
            return "redirect:/student/main.do";
        }else {
            model.put("errorInfo", "账号或密码错误！");
            return "/index";
        }
    }

    @RequestMapping("main.do")
    public String execute(HttpSession session,Map model){
        OpenTime openTime = openTimeService.queryOpenTime();
        if (openTime!=null){
            model.put("startTime",openTime.getStartTime());
            model.put("endTime",openTime.getEndTime());
        }else {
            model.put("startTime","");
            model.put("endTime","");
        }
        return "/student/main";
    }

    @RequestMapping("/update.do")
    public String modify(String sno,Map model){
        //查询开课时间，非核心代码
        OpenTime openTime = openTimeService.queryOpenTime();
        if (openTime!=null){
            model.put("startTime",openTime.getStartTime());
            model.put("endTime",openTime.getEndTime());
        }else {
            model.put("startTime","");
            model.put("endTime","");
        }
        return "/student/modifypwd";
    }

    @RequestMapping("modifypwd.do")
    public String modifyPassword(String oldSpwd,String newSpwd,HttpSession session,Map model){
        //查询开课时间，非核心代码
        OpenTime openTime = openTimeService.queryOpenTime();
        if (openTime!=null){
            model.put("startTime",openTime.getStartTime());
            model.put("endTime",openTime.getEndTime());
        }else {
            model.put("startTime","");
            model.put("endTime","");
        }
        Student studentSession = (Student) session.getAttribute("student");
        String snoSession = studentSession.getSno();
        Student student = service.findById(snoSession);
        if(oldSpwd.equals(student.getSpassword())){
            student.setSpassword(newSpwd);
            boolean flag = service.updateById(student);
            model.put("flag",flag);
            return "/student/main";
        }else{
            model.put("errorSpwd","原密码错误");
            return "/student/modifypwd";
        }
    }

    @RequestMapping("/person.do")
    public String queryPersonalInfo(HttpSession session,Map model){
        return "/student/person";
    }

    @RequestMapping("/queryCourseList.do")
    public String queryCourseByCondAndPage(String cno,String cname,String cteacher,String ccollege,String cgrade,Integer pageNum,Integer pageSize,HttpSession session,Map model,Map map){
        map.put("cno",cno);
        map.put("cname",cname);
        map.put("cteacher",cteacher);
        map.put("ccollege",ccollege);
        map.put("cgrade",cgrade);
        Student studentSession = (Student) session.getAttribute("student");
        String snoSession = studentSession.getSno();
        map.put("snoSession",snoSession);
        List<Course> courses = courseService.queryByCondAndPage(pageNum,pageSize,map);
        List<Course> coursesFull = courseService.queryCourseFull();
        List<Course> coursesSelected = courseService.queryCourseSelectedBySno(snoSession);
        for (Course course:courses){
            for (Course coursefull:coursesFull){
                if (course.getCno().equals(coursefull.getCno())){
                    course.setState(1);
                }
            }
            for (Course courseselected:coursesSelected){
                if (course.getCno().equals(courseselected.getCno())){
                    course.setState(2);
                }
            }
        }
        model.put("courses",courses) ;
        //查询开课时间，非核心代码
        OpenTime openTime = openTimeService.queryOpenTime();
        if (openTime!=null){
            model.put("startTime",openTime.getStartTime());
            model.put("endTime",openTime.getEndTime());
        }else {
            model.put("startTime","");
            model.put("endTime","");
        }
        return "/student/choosecourse";
    }

    @RequestMapping("/pickCourse.do")
    @ResponseBody
    public String pickCourse(String sno,String cno,Integer crestnum,Map map,Map model){
        boolean flag;
        String returnMsg;
        if (crestnum>0){
            map.put("sno",sno);
            map.put("cno",cno);
            crestnum = crestnum-1;
            map.put("crestnum",crestnum);
            flag = courseService.pickCourse(map);
            model.put("returnMsg","选课成功！");
            returnMsg = "选课成功！";
        }else {
            flag = false;
            model.put("returnMsg","课程人数已满，选课失败！");
            returnMsg = "课程人数已满，选课失败！";
        }
        model.put("flag",flag);
        return returnMsg;
    }

    @RequestMapping("retiredCourse.do")
    public String retiredCourse(String sno,String cno,Map map,Map model){
        map.put("sno",sno);
        map.put("cno",cno);
        boolean flag = courseService.retiredCourse(map);
        model.put("flag",flag);
        return "/student/choosecourse";
    }

    @RequestMapping("/personalCourseList.do")
    public String personalCourseList(HttpSession session,Map model){
        Student studentSession = (Student) session.getAttribute("student");
        String snoSession = studentSession.getSno();
        List<Course> courses = courseService.queryPersonalCourseList(snoSession);
        model.put("courses",courses);
        return "/student/personalcourses";
    }

    @RequestMapping("/personalCourseListPage.do")
    public String personalCourseListPage(Integer pageNum,Integer pageSize,HttpSession session,Map model,Map map){
        Student studentSession = (Student) session.getAttribute("student");
        String sno = studentSession.getSno();
        map.put("sno",sno);
        List<Course> courses = courseService.personalCourseListPage(pageNum,pageSize,map);
        model.put("courses",courses);
        //查询开课时间，非核心代码
        OpenTime openTime = openTimeService.queryOpenTime();
        if (openTime!=null){
            model.put("startTime",openTime.getStartTime());
            model.put("endTime",openTime.getEndTime());
        }else {
            model.put("startTime","");
            model.put("endTime","");
        }
        return "/student/personalcourses";
    }
}

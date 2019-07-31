package com.course.controller;

import com.course.entity.Admin;
import com.course.entity.Course;
import com.course.entity.OpenTime;
import com.course.service.AdminService;
import com.course.service.CourseService;
import com.course.service.OpenTimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * @author 空谷丶临风
 * @date 2019-06-17 21:09
 */

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    AdminService service;
    @Autowired
    CourseService courseService;
    @Autowired
    OpenTimeService openTimeService;


    @RequestMapping("/login.do")
    public String login(String no, String password, HttpSession session, Map model){
        System.out.println("ano=" + no + ",apwd=" + password);
        Admin admin = service.verify(no,password);
        //System.out.println(admin.getAname());
        //测试时应注意：若admin为null，则空指针异常，spring处理异常，并返回error页面，影响前端
        if(admin!=null) {
            session.setAttribute("admin", admin);
            return "redirect:/admin/main.do";
        }else {
            model.put("errorInfo", "账号或密码错误！");
            return "/index";
        }
    }

    @RequestMapping("main.do")
    public String execute(HttpSession session){
        return "/admin/main";
    }

    @RequestMapping("/update.do")
    public String modify(String ano){
        return "/admin/modifypwd";
    }

    @RequestMapping("modifypwd.do")
    public String modifyPassword(String oldApwd,String newApwd,HttpSession session,Map model){
        Admin adminSession = (Admin) session.getAttribute("admin");
        String anoSession = adminSession.getAno();
        Admin admin = service.findById(anoSession);
        if(oldApwd.equals(admin.getApassword())){
            admin.setApassword(newApwd);
            boolean flag = service.updateById(admin);
            model.put("flag",flag);
            return "/admin/main";
        }else{
            model.put("errorApwd","原密码错误");
            return "/admin/modifypwd";
        }
    }

    @RequestMapping("/course.do")
    public String course(Map model){
        List<Course> courses = courseService.queryAllCourse();
        model.put("courses",courses);
        return "/admin/course";
    }

    /**
     * 分页查询
     */
    //接收前台的分页数据请求,page为第几页，rows为每页多少行
    @RequestMapping("/courseList.do")
    public String courseList(Integer pageNum,Integer pageSize,Map model,Map map){
        model.put("courses",courseService.queryListByPage(pageNum,pageSize,map)) ;
        OpenTime openTime = openTimeService.queryOpenTime();
        if (openTime!=null){
            model.put("startTime",openTime.getStartTime());
            model.put("endTime",openTime.getEndTime());
        }else {
            model.put("startTime","");
            model.put("endTime","");
        }
        return "/admin/course";
    }

    @RequestMapping("/addCourse.do")
    public String addCourse(String cno, String cname, String cteacher, int ctotalnum, String ccollege, String cgrade, Map model){
        Course course = new Course();
        course.setCno(cno);
        course.setCname(cname);
        course.setCteacher(cteacher);
        course.setCtotalnum(ctotalnum);
        course.setCrestnum(ctotalnum);
        course.setCcollege(ccollege);
        course.setCgrade(cgrade);
        boolean flag = courseService.addCourse(course);
        model.put("flag",flag);
        return "redirect:/admin/courseList.do";
    }

    @RequestMapping("/person.do")
    public String queryPersonalInfo(HttpSession session,Map model){
        return "/admin/person";
    }

    @RequestMapping("/coursemodify.do")
    public String modifyCourseById(String scno, String scname, String scteacher, int sctotalnum,int screstnum , String sccollege, String scgrade,int oldtotalnum, Map model){//参数名要与前端传过来的参数名相同
        Course course = new Course();
        course.setCno(scno);
        course.setCname(scname);
        course.setCteacher(scteacher);
        course.setCtotalnum(sctotalnum);
        course.setCrestnum(screstnum+sctotalnum-oldtotalnum);
        course.setCcollege(sccollege);
        course.setCgrade(scgrade);
        boolean flag = courseService.updateById(course);
        model.put("flag",flag);
        return "redirect:/admin/courseList.do";
    }

    @RequestMapping("/deleteCourse.do")
    public String deleteCourseById(String cno,Map model){
        boolean flag = courseService.deleteById(cno);
        model.put("flag",flag);
        return "redirect:/admin/course.do";
    }

    @RequestMapping("/queryCourse.do")
    public String queryCourse(Map model){
        List<Course> courses = courseService.queryAllCourse();
        model.put("courses",courses);
        return "/admin/scourse";
    }

    @RequestMapping("/queryCourseList.do")
    public String queryCourseByCondAndPage(String cno,String cname,String cteacher,String ccollege,String cgrade,Integer pageNum,Integer pageSize,Map model,Map map){
        map.put("cno",cno);
        map.put("cname",cname);
        map.put("cteacher",cteacher);
        map.put("ccollege",ccollege);
        map.put("cgrade",cgrade);
        model.put("courses",courseService.queryByCondAndPage(pageNum,pageSize,map)) ;
        return "/admin/scourse";
    }

    @RequestMapping("/queryByCond.do")
    public String queryCourseByCondition(String cno,String cname,String cteacher,String ccollege,String cgrade,Map model){
        Course course = new Course();
        course.setCno(cno);
        course.setCname(cname);
        course.setCteacher(cteacher);
        course.setCcollege(ccollege);
        course.setCgrade(cgrade);
        List<Course> courses = courseService.queryByCond(course);
        model.put("courses",courses);
        return "/admin/scourse";
    }

    @RequestMapping("/addOpenTime.do")
    public String addOpenTime(String startTime,String endTime,Map map,Map model){
        map.put("startTime",startTime);
        map.put("endTime",endTime);
        boolean flag = openTimeService.addOpenTime(map);
        model.put("flag",flag);
        return "redirect:/admin/courseList.do";
    }

    @RequestMapping("/modifyOpenTime.do")
    public String modifyOpenTime(String startTimes,String endTimes,Map map,Map model){
        map.put("startTimes",startTimes);
        map.put("endTimes",endTimes);
        boolean flag = openTimeService.modifyOpenTime(map);
        model.put("flag",flag);
        return "redirect:/admin/courseList.do";
    }

    @RequestMapping("/deleteOpenTime.do")
    public String deleteOpenTime(Map model){
        boolean flag = openTimeService.deleteOpenTime();
        model.put("flag",flag);
        return "redirect:/admin/courseList.do";
    }
}

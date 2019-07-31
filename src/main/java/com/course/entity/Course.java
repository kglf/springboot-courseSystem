package com.course.entity;

/**
 * @author 空谷丶临风
 * @date 2019-06-18 20:10
 */

public class Course {
    private String cno;//课程编号
    private String cname;//课程名称
    private String cteacher;//老师
    private Integer ctotalnum;//总人数
    private Integer crestnum;//剩余人数
    private String ccollege;//学院
    private String cgrade;//年级
    private int state=0;//课程状态，默认0；满人1；已选2

    public String getCno() {
        return cno;
    }

    public void setCno(String cno) {
        this.cno = cno;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getCteacher() {
        return cteacher;
    }

    public void setCteacher(String cteacher) {
        this.cteacher = cteacher;
    }

    public Integer getCtotalnum() {
        return ctotalnum;
    }

    public void setCtotalnum(Integer ctotalnum) {
        this.ctotalnum = ctotalnum;
    }

    public Integer getCrestnum() {
        return crestnum;
    }

    public void setCrestnum(Integer crestnum) {
        this.crestnum = crestnum;
    }

    public String getCcollege() {
        return ccollege;
    }

    public void setCcollege(String ccollege) {
        this.ccollege = ccollege;
    }

    public String getCgrade() {
        return cgrade;
    }

    public void setCgrade(String cgrade) {
        this.cgrade = cgrade;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }
}

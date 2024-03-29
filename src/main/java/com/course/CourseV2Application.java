package com.course;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement //开启事务管理
@MapperScan(basePackages = "com.course.dao") //mapper接口类包扫描
public class CourseV2Application {

    public static void main(String[] args) {
        SpringApplication.run(CourseV2Application.class, args);
    }

}

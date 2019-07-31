package com.course.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author 空谷丶临风
 * @date 2019-06-24 20:41
 */

@Controller
@RequestMapping("/")
public class LoginController {

    @RequestMapping({"/","index.html"})
    public String index() {
        return "/index";
    }
}

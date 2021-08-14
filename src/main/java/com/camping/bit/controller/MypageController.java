package com.camping.bit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/mypage/*")
public class MypageController {

    @RequestMapping(value = "main.do", method = RequestMethod.GET)
    public String mypage() {

        System.out.println("test");

        return "mypagemain.tiles";
    }

}

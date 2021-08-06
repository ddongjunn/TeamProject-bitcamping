package com.camping.bit.controller;

import com.camping.bit.commons.Util;
import com.camping.bit.dto.MemberDto;
import com.camping.bit.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/regi/*")
public class RegiController {

    @Autowired
    private MemberService service;

    @ResponseBody
    @RequestMapping(value = "nicknameCheck.do", method = { RequestMethod.GET })
    public boolean nicknameCheck(String nickname) {

        return service.nicknameCheck(nickname);
    }

    @ResponseBody
    @RequestMapping(value = "emailCheck.do", method = { RequestMethod.GET })
    public boolean emailCheck(String email) {

        return service.emailCheck(email);
    }

    @ResponseBody
    @RequestMapping(value = "addMember.do", method = { RequestMethod.GET })
    public String addMember(MemberDto dto, @RequestParam String yy, @RequestParam String mm, @RequestParam String dd) {

        System.out.println("before mm " + mm + " before dd " + dd);
        String twomm = Util.two(mm);
        String twodd = Util.two(dd);
        System.out.println("yy = " + yy + " mm = " + twomm + " dd = " + twodd);
        System.out.println(dto.toString());

        return "성공";
    }
}

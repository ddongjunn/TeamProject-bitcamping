package com.camping.bit.controller;

import com.camping.bit.commons.Util;
import com.camping.bit.dto.MemberDto;
import com.camping.bit.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

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

    @PostMapping(value = "addMember.do")
    public String addMember(HttpSession session, MemberDto dto, @RequestParam String yy, @RequestParam String mm, @RequestParam String dd) {

        //생년월일 설정
        String twomm = Util.two(mm);
        String twodd = Util.two(dd);
        String birth = yy + "-" + twomm + "-" + twodd;
        dto.setBirth(birth);
        System.out.println(dto.toString());

        service.addMember(dto);
        session.setAttribute("login",dto);

        return "main.tiles";
    }
}

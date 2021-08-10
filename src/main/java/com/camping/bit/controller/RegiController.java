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

    @ResponseBody
    @RequestMapping(value = "idCheck.do", method = { RequestMethod.GET })
    public boolean idCheck(String id) {

        return service.idCheck(id);
    }

    @PostMapping(value = "addMember.do")
    public String addMember(HttpSession session, MemberDto dto) {

        System.out.println("addMember :  " + dto.toString());

        service.addMember(dto);
        if(!dto.getSns_Type().equals("none")) {
            session.setAttribute("login", dto);
        }

        return "main.tiles";
    }

    @RequestMapping(value = "normal.do", method = { RequestMethod.GET })
    public String regiMember() {

        return "normal.tiles";
    }
}

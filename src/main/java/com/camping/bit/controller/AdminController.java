package com.camping.bit.controller;

import com.camping.bit.dto.CampingDetailDto;
import com.camping.bit.dto.CampingImageDto;
import com.camping.bit.dto.CampingListDto;
import com.camping.bit.dto.MemberDto;
import com.camping.bit.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

    @Autowired
    AdminService service;

    @RequestMapping(value = "main.do", method = RequestMethod.GET)
    public String main(Model model) {

        //총회원수
        List<MemberDto> list = service.allMember();
        model.addAttribute("memberCount",service.memberCount());

        return "adminmain.tiles";
    }

    @RequestMapping(value = "calendar.do", method = RequestMethod.GET)
    public String calendar() {

        return "admin-calendar.tiles";
    }

    @RequestMapping(value = "memberInfo.do", method = RequestMethod.GET)
    public String memberInfo(Model model) {

        List<MemberDto> list = service.allMember();

        model.addAttribute("member",list);

        return "admin-memberInfo.tiles";
    }
}

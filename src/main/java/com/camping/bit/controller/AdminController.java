package com.camping.bit.controller;

import com.camping.bit.dto.*;
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

        model.addAttribute("memberCount",service.memberCount());

        return "adminmain.tiles";
    }

    @RequestMapping(value = "memberInfo.do", method = RequestMethod.GET)
    public String memberInfo(Model model, MypageParam param) {

        int sn = param.getPageNumber();
        int start = 1 + 10 * sn;
        int end = 10 + 10 * sn;

        param.setStart(start);
        param.setEnd(end);

        List<MemberDto> list = service.allMemberList(param);
        model.addAttribute("list",list);

        //갯수
        int totalCount = service.memberCountSearch(param);
        model.addAttribute("totalCount", totalCount);

        //현재페이지
        int nowPage = param.getPageNumber();
        model.addAttribute("nowPage", nowPage + 1);

        model.addAttribute("search", param.getSearch());
        model.addAttribute("choice", param.getChoice());

        return "admin-memberInfo.tiles";
    }

    @RequestMapping(value = "community.do", method = RequestMethod.GET)
    public String community(Model model, MypageParam param) {

        int sn = param.getPageNumber();
        int start = 1 + 15 * sn;
        int end = 15 + 15 * sn;
        param.setStart(start);
        param.setEnd(end);

        //글목록 list 가져오기
        List<CommunityDto> list = service.getCommunity(param);
        model.addAttribute("list",list);

        //총 글의 갯수
        int totalCount = service.getCommunityCount(param);
        model.addAttribute("totalCount",totalCount);

        //현재 페이지
        int nowPage = param.getPageNumber();
        model.addAttribute("nowPage", nowPage + 1);

        model.addAttribute("bbstype",param.getBbstype());

        model.addAttribute("search", param.getSearch());
        model.addAttribute("choice", param.getChoice());

        return "admin-community.tiles";
    }
}

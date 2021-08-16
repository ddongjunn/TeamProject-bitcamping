package com.camping.bit.controller;

import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.MemberDto;
import com.camping.bit.service.MypageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
@RequestMapping(value = "/account/*")
public class MypageController {

    @Autowired
    MypageService service;

    @RequestMapping(value = "main.do", method = RequestMethod.GET)
    public String mypage() {


        return "mypagemain.tiles";
    }

    @RequestMapping(value = "community.do", method = RequestMethod.GET)
    public String mypageCommunity(CommunityDto cdto, HttpSession session) {
        MemberDto dto = (MemberDto) session.getAttribute("login");

        cdto.setUser_id(dto.getId());

        //차후 삭제 예정
        cdto.setBbstype("hello");
        List<CommunityDto> list = service.getMyCommunity(cdto);

        System.out.println(list.toString());

        return "mypage-community.tiles";
    }


    @RequestMapping(value = "csite-review.do", method = RequestMethod.GET)
    public String mypageCampingReview() {


        return "mypage-csite-review.tiles";
    }

    @RequestMapping(value = "update.do", method = RequestMethod.GET)
    public String mypageUpdate() {


        return "mypage-update.tiles";
    }

    @RequestMapping(value = "password.do", method = RequestMethod.GET)
    public String mypagePassword() {


        return "mypage-password.tiles";
    }

    @RequestMapping(value = "withdrawal.do", method = RequestMethod.GET)
    public String mypageWithdrawal() {


        return "mypage-withdrawal.tiles";
    }

}

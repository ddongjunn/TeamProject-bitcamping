package com.camping.bit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
@RequestMapping(value = "/account/*")
public class MypageController {

    @RequestMapping(value = "main.do", method = RequestMethod.GET)
    public String mypage() {


        return "mypagemain.tiles";
    }

    @RequestMapping(value = "free.do", method = RequestMethod.GET)
    public String mypageFree() {


        return "mypage-free.tiles";
    }

    @RequestMapping(value = "deal.do", method = RequestMethod.GET)
    public String mypageDeal() {


        return "mypage-deal.tiles";
    }

    @RequestMapping(value = "review.do", method = RequestMethod.GET)
    public String mypageReview() {


        return "mypage-review.tiles";
    }

    @RequestMapping(value = "find.do", method = RequestMethod.GET)
    public String mypageFind() {


        return "mypage-find.tiles";
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

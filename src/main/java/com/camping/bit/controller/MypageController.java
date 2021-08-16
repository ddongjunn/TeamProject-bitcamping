package com.camping.bit.controller;

import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.MemberDto;
import com.camping.bit.dto.MypageParam;
import com.camping.bit.service.MypageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
@RequestMapping(value = "/account/*")
public class MypageController {

    @Autowired
    MypageService service;

    @RequestMapping(value = "main.do", method = RequestMethod.GET)
    public String main() {

        return "mypagemain.tiles";
    }

    @RequestMapping(value = "community.do", method = RequestMethod.GET)
    public String mypageCommunity(HttpSession session, Model model, MypageParam param) {

        int sn = param.getPageNumber();
        int start = 1 + 10 * sn;
        int end = 10 + 10 * sn;
        System.out.println("sn = " + sn + " " + "start = " + start + "end = " + end);

        param.setStart(start);
        param.setEnd(end);

        //세션에 있는 아이디로 param 셋팅
        MemberDto user = (MemberDto) session.getAttribute("login");
        param.setId(user.getId());

        //글목록 list 가져오기
        List<CommunityDto> list = service.getMyCommunity(param);
        model.addAttribute("list",list);

        //총 글의 갯수
        int totalCount = service.getMyCommunityCount(param);
        model.addAttribute("totalCount",totalCount);

        //현재 페이지
        int nowPage = param.getPageNumber();
        model.addAttribute("nowPage", nowPage + 1);

        model.addAttribute("bbstype", param.getBbstype());
       /* switch (param.getBbstype()) {
            case "free":
                model.addAttribute("bbstype", "자유게시판");
                break;
            case "deal":
                model.addAttribute("bbstype", "중고거래");
                break;
            case "review":
                model.addAttribute("bbstype", "캠핑&여행 후기");
                break;
            case "find":
                model.addAttribute("bbstype", "캠퍼 모집");
                break;
        }*/

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

package com.camping.bit.controller;

import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.MemberDto;
import com.camping.bit.dto.MypageParam;
import com.camping.bit.service.MemberService;
import com.camping.bit.service.MypageService;
import org.apache.ibatis.jdbc.Null;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
@RequestMapping(value = "/account/*")
public class MypageController {

    @Autowired
    MypageService service;

    @Autowired
    MemberService memberService;

    @RequestMapping(value = "main.do", method = RequestMethod.GET)
    public String main() {

        return "mypagemain.tiles";
    }

    @RequestMapping(value = "community.do", method = RequestMethod.GET)
    public String mypageCommunity(HttpSession session, Model model, MypageParam param) {

        int sn = param.getPageNumber();
        int start = 1 + 15 * sn;
        int end = 15 + 15 * sn;
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

    @RequestMapping(value = "update.do", method = { RequestMethod.GET,RequestMethod.POST} )
    public String mypageUpdate() {

        return "mypage-update.tiles";
    }

    @RequestMapping(value = "updateAf.do", method = { RequestMethod.POST} )
    public String mypageUpdateAf(MemberDto dto, HttpSession session) {

        service.modifyInfo(dto);
        MemberDto user = memberService.getMember(dto.getId());

        session.setAttribute("login", user);


        return "redirect:/account/update.do";
    }


    @RequestMapping(value = "password.do", method = RequestMethod.GET)
    public String mypagePassword() {


        return "mypage-password.tiles";
    }

    @ResponseBody
    @RequestMapping(value = "passwordCheck.do", method = RequestMethod.POST)
    public boolean passwordCheck(MemberDto dto) {

        //들어오는 id를 통해서 password 가져오기
        String password = service.getPassword(dto.getId());

        //입력한 비밀번호와 (암호화된)기존 비밀번호 비교
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        return encoder.matches(dto.getPwd(), password);

    }

    @ResponseBody
    @RequestMapping(value = "passwordAf.do", method = RequestMethod.POST)
    public boolean mypagePasswordAf(MemberDto dto) {

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        //새로운 비밀번호 암호화
        String securePw = encoder.encode(dto.getPwd());
        dto.setPwd(securePw);

        System.out.println("변경전 dto = " + dto);
        //비밀번호 변경
        System.out.println("비밀번호 변경");
        memberService.updatePw(dto);
        System.out.println("비밀번호 변경완료");

        return true;
    }

    @RequestMapping(value = "withdrawal.do", method = RequestMethod.GET)
    public String mypageWithdrawal() {


        return "mypage-withdrawal.tiles";
    }

}

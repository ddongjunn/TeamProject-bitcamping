package com.camping.bit.controller;

import com.camping.bit.dto.*;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


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
        model.addAttribute("search", param.getSearch());
        model.addAttribute("choice", param.getChoice());

        return "mypage-community.tiles";
    }

    @RequestMapping(value = "community-deal.do", method = RequestMethod.GET)
    public String communityDeal(HttpSession session, Model model, MypageParam param){

        int sn = param.getPageNumber();
        int start = 1 + 15 * sn;
        int end = 15 + 15 * sn;

        param.setStart(start);
        param.setEnd(end);

        //세션에 있는 아이디로 param 셋팅
        MemberDto user = (MemberDto) session.getAttribute("login");
        param.setId(user.getId());

        // DB 글목록 불러오기
        List<CommunityDto> list = service.dealList(param);

        // model 이용해 list룰 "dealList" 짐싸서 보냄
        model.addAttribute("dealList", list);

        // 게시글 총 수
        int totalCount = service.dealCount(param);
        model.addAttribute("totalCount", totalCount);

        // 현재 페이지
        int nowPage = param.getPageNumber();
        model.addAttribute("nowPage", nowPage + 1);

        model.addAttribute("search", param.getSearch());
        model.addAttribute("choice", param.getChoice());
        model.addAttribute("kind", param.getKind());

        return "mypage-community-deal.tiles";
    }

    @RequestMapping(value = "camping-review.do", method = RequestMethod.GET)
    public String campingReview(HttpSession session, Model model, CampingParam param){

        int sn = param.getPageNumber();
        int start = 1 + 15 * sn;
        int end = 15 + 15 * sn;

        //세션에 있는 아이디로 param 셋팅
        MemberDto user = (MemberDto) session.getAttribute("login");
        param.setId(user.getId());

        param.setStart(start);
        param.setEnd(end);

        // DB 글목록 불러오기
        List<CampingBbsDto> list = service.campingReviewList(param);
        System.out.println("campingreview : " + list);
        // model 이용해 list룰 "dealList" 짐싸서 보냄
        model.addAttribute("list", list);

        // 게시글 총 수
        int totalCount = service.campingReviewCount(param);
        model.addAttribute("totalCount", totalCount);

        // 현재 페이지
        int nowPage = param.getPageNumber();
        model.addAttribute("nowPage", nowPage + 1);

        model.addAttribute("search", param.getSearch());
        model.addAttribute("choice", param.getChoice());

        return "mypage-camping-review.tiles";
    }

    @RequestMapping(value = "update.do", method = { RequestMethod.GET,RequestMethod.POST} )
    public String mypageUpdate(MemberDto dto, Model model, HttpSession session) {


        if(dto.getId() != null) {
            MemberDto user = memberService.getMember(dto.getId());
            model.addAttribute("user", user);
            session.setAttribute("login",user);
            return "mypage-update.tiles";
        }
            MemberDto user = (MemberDto) session.getAttribute("login");
            model.addAttribute("user",memberService.getMember(user.getId()));
            session.setAttribute("login",memberService.getMember(user.getId()));

        return "mypage-update.tiles";
    }

    @RequestMapping(value = "updateAf.do", method = { RequestMethod.POST} )
    public String mypageUpdateAf(MemberDto dto, HttpSession session, RedirectAttributes redirect) {

        service.modifyInfo(dto);

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

        //비밀번호 변경
        memberService.updatePw(dto);


        return true;
    }

    @RequestMapping(value = "withdrawal.do", method = RequestMethod.GET)
    public String mypageWithdrawal() {


        return "mypage-withdrawal.tiles";
    }

    @RequestMapping(value = "withdrawalAf.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String mypageWithdrawalAf(HttpSession session, String id) {

        service.withdrawal(id);
        session.invalidate();

        return "redirect:/";
    }
	
	@RequestMapping(value = "myOrder.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String myOrder(HttpSession session, Model model, MypageParam param) {
		
		MemberDto user = (MemberDto)session.getAttribute("login");		
		param.setId(user.getId());
		
        int sn = param.getPageNumber();
        int start = 1 + 10 * sn;
        int end = 10 + 10 * sn;

        param.setStart(start);
        param.setEnd(end);

        //총 글의 갯수
        int totalCount = service.getMyOrderCount(param);
        model.addAttribute("totalCount",totalCount);

        //현재 페이지
        int nowPage = param.getPageNumber();
        model.addAttribute("nowPage", nowPage + 1);

		List<ProductOrderDto> order = service.getMyOrderList(param);
		model.addAttribute("order", order);
				
		return "mypage-myOrder.tiles";	
	}

}

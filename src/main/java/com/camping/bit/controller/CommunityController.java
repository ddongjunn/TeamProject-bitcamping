package com.camping.bit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.CommunityParam;
import com.camping.bit.service.CommunityService;

@Controller
@RequestMapping(value = "/community/*")
public class CommunityController {

	@Autowired
	CommunityService service;
	
	// 커뮤니티 누르면 첫화면
	@RequestMapping(value = "main.do", method = RequestMethod.GET)
	public String mainboard() {
	
		return "community.tiles";
	
	}
	
	// 가입인사게시판
	@RequestMapping(value = "hello.do", method = RequestMethod.GET)
	public String helloBoard(Model model, CommunityParam param){
		
		int start, end;
		start = 1 + 10 * param.getPageNumber();
		end = 10 + 10 * param.getPageNumber();
	
		// DB 글목록 불러오기
		List<CommunityDto> list = service.helloList(param);
		
		// model 이용해 list룰 "helloList" 짐싸서 보냄
		model.addAttribute("helloList", list); 
		
		// 게시글 총수
		int boardPage = service.helloListCount(param);
		model.addAttribute("boardPage", boardPage);
		
		// 현재 페이지
		model.addAttribute("pageNumber", param.getPageNumber());
		
		return "hello.tiles";
	
	}
	
	// 가입인사 글쓰기
	@RequestMapping(value = "helloWrite.do", method = RequestMethod.GET)
	public String helloWrite(Model model, String type) {
	
		model.addAttribute("type",type);
		System.out.println("type = " + type);
	
		return "hellowrite.tiles";
	}	
	
	// 가입인사글 작성 후
	@RequestMapping(value = "helloWriteAf.do", method = RequestMethod.POST)
	public String helloWriteAf(CommunityDto dto) {
		
		System.out.println(dto.toString());

		/*dto값을 service로 넘겨*/
		service.helloWriteAf(dto);
		
		return "redirect:/community/hello.do";
	
	}
	
	// 가입인사글 상세
	@RequestMapping(value = "helloDetail.do", method = RequestMethod.GET)
	public String helloDetail(Model model, int community_seq) {
		
		CommunityDto data = service.helloDetail(community_seq);
		model.addAttribute("data", data); 
		
		// 조회수
		service.readcount(community_seq);
		
		return "helloDetail.tiles";
	}
	
	
	// 게시글 삭제
	@RequestMapping(value = "delete.do", method = RequestMethod.GET) 
	public String boardDelete(CommunityDto dto) {	
		
		
		if(dto.getBbstype().equals("가입인사")) {
			return "redirect:/community/hello.do";
		}else if(dto.getBbstype().equals("자유게시판")) {
			return "redirect:/community/free.do";
		}else if(dto.getBbstype().equals("중고거래")) {
			return "redirect:/community/deal.do";
		}else if(dto.getBbstype().equals("캠퍼모집")) {
			return "redirect:/community/group.do";
		}else {
			return "redirect:/community/review.do";
		}
		
	}
	
	
	
	
	
	
	
	/* 가입인사 다 할때까지 딴 게시판 하지마~~~~ */
	
	// 자유게시판
	@RequestMapping(value = "free.do", method = RequestMethod.GET)
	public String freeboard() {

		return "free.tiles";
	}

	// 중고거래 게시판
	@RequestMapping(value = "deal.do", method = RequestMethod.GET)
	public String dealboard() {

		return "deal.tiles";
	}

	// 캠퍼모임 게시판
	@RequestMapping(value = "group.do", method = RequestMethod.GET)
	public String groupboard() {

		return "group.tiles";
	}

	// 캠핑후기 게시판
	@RequestMapping(value = "review.do", method = RequestMethod.GET)
	public String reviewboard() {

		return "review.tiles";
	}
	
	
}
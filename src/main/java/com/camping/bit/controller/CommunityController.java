package com.camping.bit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.camping.bit.dto.CommunityDto;
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
	
	// 게시판 글쓰기
	@RequestMapping(value = "boardwrite.do", method = RequestMethod.GET)
	public String boardwrite(Model model, String type) {
	
		model.addAttribute("type",type);
		System.out.println("type = " + type);
	
		return "boardwrite.tiles";
	}	
	
	// 게시판 상세화면
	@RequestMapping(value = "detail.do", method = RequestMethod.GET)
	public String boardDetail(Model model, int community_seq) {
		
		/*
		 * data = service.boardDetail(community_seq); model.addAttribute("data", data);
		 */
		
		return "boardDetail.tiles";
	}
	
	// 가입인사게시판
	@RequestMapping(value = "hello.do", method = RequestMethod.GET)
	public String helloboard(Model model) {
	
		// DB 글목록 불러오기
		List<CommunityDto> list = service.helloboardlist();
		// model 이용해 list룰 "helloboardlist" 짐싸서 보냄
		model.addAttribute("helloboardlist", list); 
		
	return "hello.tiles";
	
	}
	
	// 가입인사글 작성 후
	@RequestMapping(value = "boardwriteAf.do", method = RequestMethod.POST)
	public String boardwriteAf(CommunityDto dto) {
		
		System.out.println(dto.toString());

		/*dto값을 service로 넘겨*/
		service.boardwriteAf(dto);

		return "redirect:/community/hello.do";
	
	}
	
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
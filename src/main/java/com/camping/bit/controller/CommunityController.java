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
	
	// 가입인사게시판
	@RequestMapping(value = "hello.do", method = RequestMethod.GET)
	public String helloboard(Model model) {
	
		// DB 글목록 불러오기
		List<CommunityDto> list = service.helloboardlist();
		
		model.addAttribute("helloboardlist", list); // model 이용해 list룰 "helloboardlist" 짐싸서 보냄
		
	return "hello.tiles";
	
	}
	
	// 게시판 글쓰기
	@RequestMapping(value = "boardwrite.do", method = RequestMethod.GET)
	public String boardwrite(Model model, String type) {
	
		model.addAttribute("type",type);
		System.out.println("type = " + type);
	
		return "boardwrite.tiles";
	}
	
	// 가입인사글 작성 후
	@RequestMapping(value = "boardwriteAf.do", method = RequestMethod.POST)
	public String boardwriteAf(CommunityDto dto) {
		
		return "hello.tiles";
	}
	
	
	
	
}
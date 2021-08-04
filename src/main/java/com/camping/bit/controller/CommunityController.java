package com.camping.bit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/community/*")
public class CommunityController {

	// 커뮤니티 누르면 첫화면
	@RequestMapping(value = "main.do", method = RequestMethod.GET)
	public String mainboard() {
	
	return "community.tiles";
	
	}
	
	// 가입인사게시판
	@RequestMapping(value = "hello.do", method = RequestMethod.GET)
	public String helloboard() {
	
	return "hello.tiles";
	
	}
	
	// 게시판 글쓰기
	@RequestMapping(value = "boardwrite.do", method = RequestMethod.GET)
	public String boardwrite() {
	
	return "boardwrite.tiles";
	}
	
}
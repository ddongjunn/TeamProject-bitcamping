package com.camping.bit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.camping.bit.dto.MemberDto;
import com.camping.bit.service.MemberService;

@Controller
public class MainContorller {
	
	@Autowired
	private MemberService service;

	@RequestMapping(value = "main.do", method = RequestMethod.GET)
	public String main() {

		return "main.tiles";
	}
	
	
}

package com.camping.bit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CommunityController {

	@RequestMapping(value = "community.do", method = RequestMethod.GET)
	public String communityboard() {
	
	return "community.tiles";
	
	}
}

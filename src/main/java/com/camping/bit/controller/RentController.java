package com.camping.bit.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/rent/*")
public class RentController {

	
	@RequestMapping(value = "list.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String rentList() {
		
		return "rentList.tiles";
	}
	
	@RequestMapping(value = "regi.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String productRegi() {
		
		return "productRegi.tiles";
	}
	
}

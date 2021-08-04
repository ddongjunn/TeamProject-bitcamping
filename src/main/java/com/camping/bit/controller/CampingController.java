package com.camping.bit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.camping.bit.dto.CampingDetailDto;
import com.camping.bit.dto.CampingListDto;
import com.camping.bit.service.CampingService;

@Controller
@RequestMapping(value="/csite")
public class CampingController {

	@Autowired
	CampingService service;

	//전체 리스트 뿌리기
	@RequestMapping(value = "campinglist.do", method = RequestMethod.GET)
	public String campinglist(Model model, CampingListDto cdto) throws Exception {

		//db에서 글목록 불러오기 
		List<CampingListDto>list = service.getCampingList(cdto);
		model.addAttribute("campinglist",list);
		
		//System.out.println("controller 작동 확인");
		return "campinglist.tiles";
		
	}
	
	//디테일 화면
	@RequestMapping(value = "campingdetail.do", method = RequestMethod.GET)
	public String campingdetail(Model model, int contentid) throws Exception {
		
		CampingDetailDto dto = service.getCampingDetail(contentid);
		model.addAttribute("campingdetail", dto);
				
		return "campingdetail.tiles";		
	}
	
	//지도 화면 
	@RequestMapping(value = "campingmap.do", method = RequestMethod.GET)
	public String campingmap() throws Exception{
		
		return "campingmap.tiles";
	}

	
	
}

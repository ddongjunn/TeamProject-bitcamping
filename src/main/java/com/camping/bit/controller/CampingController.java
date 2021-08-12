package com.camping.bit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.camping.bit.dto.CampingDetailDto;
import com.camping.bit.dto.CampingImageDto;
import com.camping.bit.dto.CampingListDto;
import com.camping.bit.dto.CampingParam;
import com.camping.bit.service.CampingService;

@Controller
@RequestMapping(value="/csite/*")
public class CampingController{

	@Autowired
	CampingService service;

	//전체 리스트 뿌리기
	@RequestMapping(value = "campinglist.do", method = RequestMethod.GET)
	public String campinglist(Model model, CampingParam param) throws Exception {

		int start, end;
		start = 1 + 10 * param.getPageNumber();
		end = 10 + 10 * param.getPageNumber();
		param.setStart(start);
		param.setEnd(end);
		
		//db에서 글목록 불러오기 
		List<CampingListDto>list = service.getCampingList(param);
		model.addAttribute("campinglist",list);
		
		//총 글의 갯수
		int campingPage = service.getCampingCount(param);
		model.addAttribute("campingPage", campingPage);
		
		//현재 페이지
		int pageNumber = param.getPageNumber();
		model.addAttribute("pageNumber", pageNumber + 1);
	
		//System.out.println("controller 작동 확인");
		return "campinglist.tiles";
		
	}
	
	//디테일 화면
	@RequestMapping(value = "campingdetail.do", method = RequestMethod.GET)
	public String campingdetail(Model model, int contentid) throws Exception {
		
		CampingDetailDto detaildto = service.getCampingDetail(contentid);
		CampingListDto listdto = service.getCampingListForDetail(contentid);
		List<CampingImageDto> imagedto = service.getCampingImage(contentid);
		String intro = service.getCampingIntro(contentid);
		
		model.addAttribute("campingdetail", detaildto);
		model.addAttribute("campinglistfordetail", listdto);
		model.addAttribute("campingimage", imagedto);
		model.addAttribute("campingintro", intro);
		return "campingdetail.tiles";		
	}
	
	//지도 화면 
	@RequestMapping(value = "campingmap.do", method = RequestMethod.GET)
	public String campingmap() throws Exception{
		return "campingmap.tiles";
	}

	//조회수 증가
	@RequestMapping(value = "getCampingReadcount.do", method = RequestMethod.GET)
	public String getCampingReadcount(int contentid) throws Exception{
		service.getCampingReadcount(contentid);
		return "redirect:/campinglist.do";
	}
	
}
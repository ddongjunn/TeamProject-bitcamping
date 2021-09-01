package com.camping.bit.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.camping.bit.dto.CampingListDto;
import com.camping.bit.dto.CampingParam;
import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.MemberDto;
import com.camping.bit.service.AdminService;
import com.camping.bit.service.MemberService;

@Controller
public class MainController {
	
    @Autowired
    AdminService adminservice;

	@RequestMapping(value = "main.do", method = RequestMethod.GET)
	public String main(Model model) {
		
		// 추천캠핑장
		List<CampingListDto>list = adminservice.recommendCampingSite();
		model.addAttribute("campinglist",list);
		
        //커뮤니티 최신글 받아오기
        List<CommunityDto> recentCommunity = adminservice.recentCommunity();
        List<CommunityDto> dealList = new ArrayList<CommunityDto>();
        List<CommunityDto> freeList = new ArrayList<CommunityDto>();
        List<CommunityDto> findList = new ArrayList<CommunityDto>();
        List<CommunityDto> reviewList = new ArrayList<CommunityDto>();
        
        for(int i = 0; i < recentCommunity.size(); i++){

            if(recentCommunity.get(i).getBbstype().equals("review")){
                reviewList.add(recentCommunity.get(i));
            }else if(recentCommunity.get(i).getBbstype().equals("free")){
                freeList.add(recentCommunity.get(i));
            }else if(recentCommunity.get(i).getBbstype().equals("find")){
                findList.add(recentCommunity.get(i));
            }else{
                dealList.add(recentCommunity.get(i));
            }
        }

        HashMap<String, List<CommunityDto>> communityMap = new HashMap<>();
        communityMap.put("deal",dealList);
        communityMap.put("free",freeList);
        communityMap.put("find",findList);
        communityMap.put("review",reviewList);

        model.addAttribute("recentCommunity",communityMap);
   

		return "main.tiles";
	}

    @RequestMapping(value = "agreement.do", method = RequestMethod.GET)
    public String agreement(){

	    return "agreement.tiles";
    }

    @RequestMapping(value = "personalInfo.do", method = RequestMethod.GET)
    public String personalInfo(){

        return "personalInfo.tiles";
    }


}

package com.camping.bit.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.camping.bit.dto.ProductDetailDto;
import com.camping.bit.service.RentService;
import com.camping.bit.util.FileUploadUtil;

@Controller
@RequestMapping(value = "/rent/*")
public class RentController {
	
	@Autowired
	RentService service;
	
	@RequestMapping(value = "list.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String rentList() {
		
		return "rentList.tiles";
	}
	
	@RequestMapping(value = "regi.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String productRegi(HttpSession session) {
		
		/* 로그인 정보로 접근 권한 확인 */
		/* getAuth 오류 확인할 것 */
		/*
		String loginAuth = ((MemberDto)session.getAttribute("login")).getAuth();
		
		if(loginAuth != 3) {
			return "noPermission.tiles";
		}
		*/
		
		return "productRegi.tiles";
	}
	
	@RequestMapping(value = "RegiAf.do", method = RequestMethod.POST)
    public String RegiAf(ProductDetailDto dto, @RequestParam(value = "thumbnail", required = false) MultipartFile thumbnail, HttpServletRequest req) {
		
		String fileUpload = req.getServletContext().getRealPath("/images");
		
		System.out.println("썸네일 업로드 경로 : " + fileUpload);
		
		String newFileName = FileUploadUtil.getNewFileName(thumbnail.getOriginalFilename());
		
		dto.setThumbnailName(newFileName);
		
		File file = new File(fileUpload + "/" + newFileName);
		
		try {
			FileUtils.writeByteArrayToFile(file, thumbnail.getBytes());
			service.regiAf(dto);
		}catch(IOException e) {
			e.printStackTrace();			
		}		
		
		System.out.println("입력정보 : " + dto.toString());
		
		return "rentList.tiles";
	}
	
	
	
	
	@RequestMapping(value = "detail.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String productDetail() {
	
		
		return "productDetail.tiles";
	}
	
	@RequestMapping(value = "noPermission.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String noPermission() {
		
		return "noPermission.tiles";
	}
	
}

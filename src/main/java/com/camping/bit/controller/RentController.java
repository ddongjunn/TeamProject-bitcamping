package com.camping.bit.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.camping.bit.dto.ProductDetailDto;
import com.camping.bit.dto.ProductOptionDto;
import com.camping.bit.dto.ProductOrderDto;
import com.camping.bit.dto.ProductRentDto;
import com.camping.bit.service.RentService;
import com.camping.bit.commons.FileUploadUtil;

@Controller
@RequestMapping(value = "/rent/*")
public class RentController {
	
	@Autowired
	RentService service;
	
	@RequestMapping(value = "list.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String rentList(Model model) {
		
		List<ProductDetailDto> list = service.getProductList();
		
		model.addAttribute("list", list);
		
		return "rentList.tiles";
	}
	
	@RequestMapping(value = "regi.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String productRegi(HttpSession session) {
		
		return "productRegi.tiles";
	}
	
	@RequestMapping(value = "regiAf.do", method = RequestMethod.POST)
    public String regiAf(ProductDetailDto dto, @RequestParam(value = "thumbnail", required = false) MultipartFile thumbnail, HttpServletRequest req) {
		
		String fileUpload = req.getServletContext().getRealPath("/resources/upload");
		
		System.out.println("썸네일 업로드 경로 : " + fileUpload);
		
		String newFileName = FileUploadUtil.getNewFileName(thumbnail.getOriginalFilename());
		
		System.out.println("변환 파일명 : " + newFileName);
		
		dto.setThumbnail_Name(newFileName);
		
		File file = new File(fileUpload + "/" + newFileName);
		
		System.out.println("regiAf before : " + dto.toString());
		
		try {
			FileUtils.writeByteArrayToFile(file, thumbnail.getBytes());
			service.regiAf(dto);
		}catch(IOException e) {
			e.printStackTrace();			
		}		
		
		System.out.println("regiAf after : " + dto.toString());
		
		return "redirect:/rent/list.do";
	}
	
	@RequestMapping(value = "detail.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String productDetail(int product_Seq, Model model) {
		
		ProductDetailDto item = service.getProductDetail(product_Seq);
		model.addAttribute("item", item);
		
		List<ProductRentDto> rent = service.getRentList(product_Seq);
		model.addAttribute("rent", rent);
		
		List<ProductOptionDto> option = service.getOptionList();		
		model.addAttribute("option", option);
		
		return "productDetail.tiles";
	}
	
	@RequestMapping(value = "order.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String productOrder(ProductOrderDto dto, Model model) {
		
		// System.out.println(dto.toString());
		model.addAttribute("order", dto);
		
		ProductDetailDto item = service.getProductDetail(dto.getProduct_Seq());
		model.addAttribute("item", item);
		
		ProductRentDto rent = service.getRentDetail(dto.getRent_Seq());
		model.addAttribute("rent", rent);
		
		ProductOptionDto option1 = service.getOptionDetail(dto.getOption1_Seq());
		model.addAttribute("opt1", option1);
		
		ProductOptionDto option2 = service.getOptionDetail(dto.getOption2_Seq());
		model.addAttribute("opt2", option2);
		
		return "productOrder.tiles";
	}
	
}

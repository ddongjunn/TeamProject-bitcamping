package com.camping.bit.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.camping.bit.dto.*;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.camping.bit.dto.CommonsParam;
import com.camping.bit.dto.CsParam;
import com.camping.bit.dto.MemberDto;
import com.camping.bit.dto.ProductDetailDto;
import com.camping.bit.dto.ProductOptionDto;
import com.camping.bit.dto.ProductOrderDto;
import com.camping.bit.dto.ProductQnaDto;
import com.camping.bit.dto.ProductRentDto;
import com.camping.bit.dto.ProductReviewDto;
import com.camping.bit.service.RentService;
import com.camping.bit.commons.FileUploadUtil;

@Controller
@RequestMapping(value = "/rent/*")
public class RentController {
	
	@Autowired
	RentService service;
	
	@RequestMapping(value = "list.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String rentList(CommonsParam param, Model model) {
		
        int sn = param.getPageNumber();
        int start = 1 + 9 * sn;
        int end = 9 + 9 * sn;

        param.setStart(start);
        param.setEnd(end);

        //총 글의 갯수
        int totalCount = service.getProductCount(param);
        model.addAttribute("totalCount",totalCount);

        //현재 페이지
        int nowPage = param.getPageNumber();
        model.addAttribute("nowPage", nowPage + 1);
		
		List<ProductDetailDto> list = service.getProductList(param);		
		model.addAttribute("list", list);
		
		model.addAttribute("search", param.getSearch());
		model.addAttribute("sort", param.getSort());
		
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
		
		try {
			FileUtils.writeByteArrayToFile(file, thumbnail.getBytes());
			service.regiAf(dto);
		}catch(IOException e) {
			e.printStackTrace();			
		}		
		
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

	@ResponseBody
	@RequestMapping(value = "detail-review.do", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<String,Object> productDetailReivew(Model model, ProductParam param) {

		int sn = param.getPageNumber();
		int start = 1 + 5 * sn;
		int end = 5 + 5 * sn;

		param.setStart(start);
		param.setEnd(end);

		Map<String,Object> map = new HashMap<String,Object>();

		List<ProductReviewDto> review = service.getReviewList(param);
		map.put("reviewList",review);

		int totalCount = service.getReviewCount(param);
		map.put("totalCount",totalCount);

		//현재 페이지
		int nowPage = param.getPageNumber();
		map.put("nowPage",nowPage + 1);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "detail-qna.do", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<String,Object> productDetailQna(Model model, ProductParam param) {

		int sn = param.getPageNumber();
		int start = 1 + 5 * sn;
		int end = 5 + 5 * sn;

		param.setStart(start);
		param.setEnd(end);

		Map<String,Object> map = new HashMap<String,Object>();

		List<ProductQnaDto> qna = service.getQnaList(param);
		map.put("qna", qna);


		int qnaCount = service.getQnaCount(param);
		map.put("totalCount", qnaCount);

		//현재 페이지
		int nowPage = param.getPageNumber();
		map.put("nowPage",nowPage + 1);

		return map;
	}
	
	@RequestMapping(value = "order.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String productOrder(ProductOrderDto order, Model model) {

		model.addAttribute("order", order);
		
		ProductDetailDto item = service.getProductDetail(order.getProduct_Seq());
		model.addAttribute("item", item);
		
		ProductRentDto rent = service.getRentDetail(order.getRent_Seq());
		model.addAttribute("rent", rent);
		
		ProductOptionDto option1 = service.getOptionDetail(order.getOption1_Seq());
		model.addAttribute("opt1", option1);
		
		ProductOptionDto option2 = service.getOptionDetail(order.getOption2_Seq());
		model.addAttribute("opt2", option2);
		
		return "productOrder.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "paymentAf.do", method = { RequestMethod.GET, RequestMethod.POST })
    public int paymentAf(ProductOrderDto order) {

		System.out.println("paymentAf order = " + order);

		int result = service.paymentAf(order); // DB에 주문정보 저장
		
		service.reduceStock(order);

		return result;
	}
	
	@RequestMapping(value = "complete.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String complete(Model model, String merchant_Uid) {
		
		ProductOrderDto order = service.getOrderInfo(merchant_Uid);		
		model.addAttribute("order", order);
		
		ProductDetailDto item = service.getProductDetail(order.getProduct_Seq());
		model.addAttribute("item", item);
		
		ProductRentDto rent = service.getRentDetail(order.getRent_Seq());
		model.addAttribute("rent", rent);
		
		ProductOptionDto option1 = service.getOptionDetail(order.getOption1_Seq());
		model.addAttribute("opt1", option1);
		
		ProductOptionDto option2 = service.getOptionDetail(order.getOption2_Seq());
		model.addAttribute("opt2", option2);
		
		return "rentComplete.tiles";
	}
	
	@RequestMapping(value = "writeReview.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String writeReview(Model model, @RequestParam int order_Seq) {
		
		model.addAttribute("order_Seq", order_Seq);
		
		return "writeReview.tiles";
	}
	
	@RequestMapping(value = "writeReviewAf.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String writeReviewAf(ProductReviewDto review, @RequestParam(value = "reviewImage", required = false) MultipartFile reviewImage, HttpServletRequest req) {
		
		// System.out.println(reviewImage.isEmpty());
		System.out.println(review.getOrder_Seq());
		
		// if(!reviewImage.isEmpty() || reviewImage != null) 이경우 nullpointException 발생
		
		System.out.println(reviewImage.isEmpty());
		
		if(reviewImage != null) {
		
			String fileUpload = req.getServletContext().getRealPath("/resources/upload");
			
			System.out.println("리뷰 사진 업로드 경로 : " + fileUpload);
			
			String newFileName = FileUploadUtil.getNewFileName(reviewImage.getOriginalFilename());
			
			System.out.println("변환 파일명 : " + newFileName);
			
			review.setImage(newFileName);
			
			File file = new File(fileUpload + "/" + newFileName);
			
			try {
				FileUtils.writeByteArrayToFile(file, reviewImage.getBytes());
				service.writeReviewAf(review);
			}catch(IOException e) {
				e.printStackTrace();			
			}
		}else {
			service.writeReviewAf(review);
		}
		
		service.reviewStatus(review.getOrder_Seq()); // 리뷰 작성여부 0 -> 1 변경
				
		return "redirect:/";	
	}

	@RequestMapping(value = "writeQna.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String writeQna(Model model, @RequestParam int product_Seq) {
		
		model.addAttribute("product_Seq", product_Seq);
		
		return "writeQna.tiles";
	}

	@ResponseBody
	@RequestMapping(value = "writeQnaAf.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String writeQnaAf(ProductQnaDto qna) {

		service.writeQnaAf(qna);

		return "success";
	}

	@RequestMapping(value = "writeQnaComment.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String writeQnaComment(Model model, ProductQnaDto dto) {

		model.addAttribute("qna_Seq", dto.getQna_Seq());
		model.addAttribute("user_Id", dto.getUser_Id());

		return "writeQnaComment.tiles";
	}

	@ResponseBody
	@RequestMapping(value = "writeQnaCommentAf.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String writeQnaCommentAf(Model model, ProductQnaDto dto) {

		service.updateProductQnaStatus(dto);
		service.productQnaAnswer(dto);

		return dto.getQna_Seq() + "";
	}

	@RequestMapping(value = "writeCsQna.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String writeCsQna(Model model, CsQnaDto dto) {

		model.addAttribute("qna_Seq", dto.getQna_Seq());
		model.addAttribute("user_Id", dto.getUser_Id());

		return "writeCsQna-admin.tiles";
	}

	@ResponseBody
	@RequestMapping(value = "writeCsQnaAf.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String writeCsQnaAf(Model model, CsQnaDto dto) {

		System.out.println(dto);

		service.updateCsQnaStatus(dto);
		service.csQnaAnswer(dto);

		return dto.getQna_Seq() + "";
	}
	
}

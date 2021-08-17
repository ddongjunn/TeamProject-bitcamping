package com.camping.bit.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.camping.bit.dto.CommunityCommentDto;
import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.CommunityParam;
import com.camping.bit.dto.ProductDetailDto;
import com.camping.bit.service.CommunityService;
import com.camping.bit.commons.FileUploadUtil;

@Controller
@RequestMapping(value = "/community/*")
public class CommunityController {

	@Autowired
	CommunityService service;
	
	// 커뮤니티 누르면 첫화면
	@RequestMapping(value = "main.do", method = RequestMethod.GET)
	public String mainboard() {
	
		return "community.tiles";
	
	}
	
	// 가입인사게시판
	@RequestMapping(value = "hello.do", method = RequestMethod.GET)
	public String helloBoard(Model model, CommunityParam param){
	
		// DB 글목록 불러오기
		List<CommunityDto> list = service.helloList(param);
		
		// model 이용해 list룰 "helloList" 짐싸서 보냄
		model.addAttribute("helloList", list); 
		
		// 게시글 총 수
		int boardPage = service.helloBoardCount(param);
		model.addAttribute("boardPage", boardPage);
		System.out.println(boardPage);
		
		// 현재 페이지
		model.addAttribute("pageNumber", param.getPageNumber() + 1);
		
		int sn = param.getPageNumber();
		int start = 1 + sn * 10;
		int end = (sn + 1) * 10;
		
		param.setStart(start);
		param.setEnd(end);
		
		model.addAttribute("search", param.getSearch());
		model.addAttribute("choice", param.getChoice());
		
		return "hello.tiles"; 
	}
	
	// 가입인사 글쓰기
	@RequestMapping(value = "helloWrite.do", method = RequestMethod.GET)
	public String helloWrite(Model model) {
		
		return "hellowrite.tiles";
	}	
	
	// 가입인사글 작성 후
	@RequestMapping(value = "helloWriteAf.do", method = RequestMethod.POST)
	public String helloWriteAf(CommunityDto dto, HttpServletRequest req) {
		
		String fileUpload = req.getServletContext().getRealPath("/resources/upload");
		
		System.out.println(dto.toString());

		/*dto값을 service로 넘겨*/
		service.helloWrite(dto); 
		
		return "redirect:/community/hello.do";
	
	}
	
	// 가입인사글 상세
	@RequestMapping(value = "helloDetail.do", method = RequestMethod.GET)
	public String helloDetail(Model model, int community_seq, String id) {
		
		CommunityDto data = service.helloDetail(community_seq);
		model.addAttribute("data", data); 
		
		// 조회수
		service.readCount(community_seq);
		
		// 댓글
		List<CommunityCommentDto> commentList = service.commentList(community_seq);
		model.addAttribute("commentList", commentList);
		
		return "helloDetail.tiles";
	}
	
	
	// 게시글 삭제
	@RequestMapping(value = "delete.do", method = RequestMethod.GET) 
	public String boardDelete(Model model, CommunityDto dto) {	
	
		service.boardDelete(dto);
		
		if(dto.getBbstype().equals("hello")) {
			return "redirect:/community/hello.do";
		}else if(dto.getBbstype().equals("free")) {
			return "redirect:/community/free.do";
		}else if(dto.getBbstype().equals("deal")) {
			return "redirect:/community/deal.do";
		}else if(dto.getBbstype().equals("group")) {
			return "redirect:/community/group.do";
		}else {
			return "redirect:/community/review.do";
		}
		
	}
	
	// 인사게시글 수정
	@RequestMapping(value = "helloupdate.do", method = RequestMethod.GET) 
	public String helloUPdate(Model model, int community_seq) {
		
		CommunityDto data = service.helloDetail(community_seq);
		model.addAttribute("data", data);
		
		return "helloUpdate.tiles";
	}
	
	// 인사게시글 수정 후
	@RequestMapping(value = "helloUpdateAf.do", method = RequestMethod.POST) 
		public String helloUpdateAf(CommunityDto dto, HttpServletRequest req) {	
		
		String fileUpload = req.getServletContext().getRealPath("/resources/upload");
		
		System.out.println(dto.toString());
		
		service.helloUpdate(dto);
		
		return "redirect:/community/hello.do";
	}

	// 댓글 입력(아직안함)
	@RequestMapping("write.do")
		public void commentWrite(CommunityCommentDto dto) {
		
		System.out.println(dto.toString());

		/*dto값을 service로 넘겨*/
		service.commentWrite(dto); 
		
	}

	/* 가입인사 다 할때까지 딴 게시판 하지마~~~~ */
	
	// 자유게시판
	@RequestMapping(value = "free.do", method = RequestMethod.GET)
	public String freeboard() {

		return "free.tiles";
	}

	// 중고거래 게시판
	@RequestMapping(value = "deal.do", method = RequestMethod.GET)
	public String dealboard() {

		return "deal.tiles";
	}

	// 캠퍼모임 게시판
	@RequestMapping(value = "find.do", method = RequestMethod.GET)
	public String groupboard() {

		return "find.tiles";
	}

	// 캠핑후기 게시판
	@RequestMapping(value = "review.do", method = RequestMethod.GET)
	public String reviewboard() {

		return "review.tiles";
	}
	
	
}
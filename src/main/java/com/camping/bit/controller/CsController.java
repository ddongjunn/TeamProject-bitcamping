package com.camping.bit.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.camping.bit.commons.FileUploadUtil;
import com.camping.bit.dto.CsCommentParam;
import com.camping.bit.dto.CsNoticeCommentDto;
import com.camping.bit.dto.CsNoticeDto;
import com.camping.bit.dto.CsParam;
import com.camping.bit.dto.CsQnaDto;
import com.camping.bit.service.CsService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
@RequestMapping(value = "/cs/*")
public class CsController {
		
	
	@Autowired 
	CsService service;
	
	@RequestMapping(value = "csMain.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String main() {		
		
		return "csMain.tiles";
	}
	
	@RequestMapping(value = "notice.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String noticeList(Model model, CsParam param) {

		int currentPage = param.getPageNumber();
		
		int start = 1 + currentPage * 15;
		param.setStart(start);
		
		int end = (currentPage + 1) * 15;
		param.setEnd(end);
		
		List<CsNoticeDto> notice = service.getNoticeList(param);		
		model.addAttribute("notice", notice);
		
		int totalCount = service.getNoticeCount(param);
		model.addAttribute("totalCount", totalCount);
		
		model.addAttribute("pageNumber", param.getPageNumber() + 1);		
		model.addAttribute("search", param.getSearch());
		model.addAttribute("choice", param.getChoice());
		
		return "noticeList.tiles";
	}
	
	@RequestMapping(value = "noticeDetail.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String noticeDetail(int notice_Seq, Model model) {
		
		service.noticeReadcount(notice_Seq);
		
		CsNoticeDto notice = service.getNoticeDetail(notice_Seq);		
		model.addAttribute("notice", notice);
		
		return "noticeDetail.tiles";
	}
	
	@RequestMapping(value = "noticeWrite.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String noticeWrite() {		
		
		return "noticeWrite.tiles";
	}
	
	@RequestMapping(value = "noticeWriteAf.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String noticeWriteAf(CsNoticeDto notice, @RequestParam(value = "attachedfile", required = false) MultipartFile fileload, HttpServletRequest req) {		
		
		String filename = fileload.getOriginalFilename();
		notice.setFilename(filename);
		
		String fileupload = req.getServletContext().getRealPath("/resources/upload");
		System.out.println("공지사항 첨부파일 경로 : " + fileupload);

		String newfilename = FileUploadUtil.getNewFileName(notice.getFilename());
		
		notice.setNewfilename(newfilename);
		
		File file = new File(fileupload + "/" + newfilename);
		
		try {
			// 실제로 업로드
			FileUtils.writeByteArrayToFile(file, fileload.getBytes());
			
			// DB에 저장
			service.noticeWriteAf(notice); 
			
		} catch (IOException e) {
			
			e.printStackTrace();
			
		}
		
		return "redirect:/cs/notice.do";
	}
	
	@RequestMapping(value = "fileDownload.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String fileDownload(String newfilename, String filename, int seq, HttpServletRequest req, Model model) {

		String fupload = req.getServletContext().getRealPath("/resources/upload");
		
		File downloadFile = new File(fupload + "/" + newfilename);
		
		model.addAttribute("downloadFile", downloadFile);
		model.addAttribute("originalFile", filename);
		model.addAttribute("seq", seq);
				
		return "downloadView";
	}
	
	@RequestMapping(value = "noticeUpdate.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String noticeUpdate(int notice_Seq, Model model) {

		CsNoticeDto notice = service.getNoticeDetail(notice_Seq);
		
		model.addAttribute("notice", notice);
		
		return "noticeUpdate.tiles";
	}
	
	@RequestMapping(value = "noticeUpdateAf.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String noticeUpdateAf(CsNoticeDto dto, @RequestParam(value = "attachedfile", required = false) MultipartFile fileload, HttpServletRequest req, Model model) {		
		
		System.out.println("dto 넘어오는지 확인 : " + dto);
		
		if(fileload != null) {
			String filename = fileload.getOriginalFilename();
			dto.setFilename(filename);
			
			String fileupload = req.getServletContext().getRealPath("/resources/upload");
			System.out.println("공지사항 첨부파일 경로 : " + fileupload);
	
			String newfilename = FileUploadUtil.getNewFileName(dto.getFilename());
			
			dto.setNewfilename(newfilename);
			
			File file = new File(fileupload + "/" + newfilename);
			
			try {
				// 실제로 업로드
				FileUtils.writeByteArrayToFile(file, fileload.getBytes());
				
				// DB에 저장
				service.noticeUpdateAf(dto);
				
			} catch (IOException e) {
				
				e.printStackTrace();
				
			}
		} else {
			service.noticeUpdateAf(dto);
		}
		
		CsNoticeDto notice = service.getNoticeDetail(dto.getNotice_Seq());		
		model.addAttribute("notice", notice);
		
		return "noticeDetail.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "writeComment.do", method = RequestMethod.POST)
	public int writeComment(CsNoticeCommentDto comment) {
		
		int result = 0;
		
	    try {
	    	result = service.writeComment(comment);
	    } catch (Exception e) {
	    	e.printStackTrace();
	        result = -1;
	    }
	    return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "answerComment.do", method = RequestMethod.POST)
	public int answerComment(CsNoticeCommentDto comment) {
		
		System.out.println("answerComment dto : " + comment);
		
		int result = 0;
		
	    try {
	    	result = service.answerComment(comment);
	    } catch (Exception e) {
	    	e.printStackTrace();
	        result = -1;
	    }
	    return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "updateComment.do", method = RequestMethod.POST)
	public int updateComment(CsNoticeCommentDto comment) {
		
		int result = 0;
		
	    try {
	    	result = service.updateComment(comment);
	    } catch (Exception e) {
	    	e.printStackTrace();
	        result = -1;
	    }
	    return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "deleteComment.do", method = RequestMethod.POST)
	public int deleteComment(int comment_Seq) {
		
		int result = 0;
		
	    try {
	    	result = service.deleteComment(comment_Seq);
	    } catch (Exception e) {
	    	e.printStackTrace();
	        result = -1;
	    }
	    return result;
	}

	// 댓글 목록 조회
	// JSON : 자바스크립트 객체 모양의 String
	// ajax에서는 filter에서 문자열을 잡아주지 못함
	// produces : 조건에 지정한 미디어 타입과 관련된 응답을 생성하는데 사용한 실제 컨텐츠 타입을 보장한다
	// --> 응답 데이터의 Content-Type 지정가능
	// text/html; charset=utf-8
	@ResponseBody
	@RequestMapping(value="commentList.do", produces="application/json; charset=utf-8")
	public HashMap<String, Object> commentList(CsCommentParam param){
		
		int currentPage = param.getPageNumber();
		
		int start = 1 + currentPage * 10;
		param.setStart(start);
		
		int end = (currentPage + 1) * 10;
		param.setEnd(end);
		
		System.out.println(param);
		
		HashMap<String, Object> result = new HashMap<>();
		
	    List<CsNoticeCommentDto> comment = service.getCommentList(param);	    
	    result.put("comment", comment);
	    
	    int totalCount = service.getCommentCount(param);
	    result.put("totalCount", totalCount);
	    
	    result.put("param", param);
	    
	    // JSON으로 담아도 되지만 편한 방법인 GSON으로 사용	    
	    // yyyy-MM-dd hh:mm:ss
	    Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd hh:mm:ss").create();
	    
	    return result;
	}
	
	@RequestMapping(value = "noticeDelete.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String noticeDelete(int notice_Seq) {

		service.noticeDelete(notice_Seq);
		
		return "redirect:/cs/notice.do";
	}

	@RequestMapping(value = "qna.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String qnaList(Model model, CsParam param) {

		int currentPage = param.getPageNumber();
		
		int start = 1 + currentPage * 15;
		param.setStart(start);
		
		int end = (currentPage + 1) * 15;
		param.setEnd(end);
		
		List<CsQnaDto> qna = service.getQnaList(param);		
		model.addAttribute("qna", qna);
		
		int totalCount = service.getQnaCount(param);
		model.addAttribute("totalCount", totalCount);
		
		model.addAttribute("pageNumber", param.getPageNumber() + 1);		
		model.addAttribute("search", param.getSearch());
		model.addAttribute("choice", param.getChoice());
		
		return "qnaList.tiles";
	}
	
	@RequestMapping(value = "qnaWrite.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String qnaWrite() {
		
		return "qnaWrite.tiles";
	}
	
	@RequestMapping(value = "qnaWriteAf.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String qnaWriteAf(CsQnaDto qna) {		
		
		service.qnaWriteAf(qna); 
		
		return "redirect:/cs/qna.do";
	}
	
	@RequestMapping(value = "qnaDetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String qnaDetail(int qna_Seq, Model model) {
		
		service.qnaReadcount(qna_Seq);
		
		CsQnaDto qna = service.getQnaDetail(qna_Seq);
		model.addAttribute("qna", qna);
		
		CsQnaDto answer = service.getAnswerDetail(qna_Seq);
		model.addAttribute("answer", answer);
		
		return "qnaDetail.tiles";
	}
	
	@RequestMapping(value = "qnaAnswer.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String qnaAnswer(int qna_Seq, Model model) {
		
		CsQnaDto qna = service.getQnaDetail(qna_Seq);
		model.addAttribute("qna", qna);
		
		return "qnaAnswer.tiles";
	}
	
	@RequestMapping(value = "qnaAnswerAf.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String qnaAnswerAf(CsQnaDto answer, Model model) {
		
		service.qnaAnswerAf(answer);
		
		service.answerStatus(answer.getRef());
		
		/*
		 * CsQnaDto qna = service.getQnaDetail(qna_Seq); 
		 * model.addAttribute("qna", qna);
		 */
		
		return "redirect:/cs/qna.do";
	}
	
	@RequestMapping(value = "qnaUpdate.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String qnaUpdate(int qna_Seq, Model model) {
		
		CsQnaDto qna = service.getQnaDetail(qna_Seq);
		model.addAttribute("qna", qna);
		
		return "qnaUpdate.tiles";
	}
	
	@RequestMapping(value = "qnaUpdateAf.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String qnaUpdateAf(CsQnaDto qna) {
		
		service.qnaUpdateAf(qna);
		
		return "redirect:/cs/qna.do";
	}
	
	@RequestMapping(value = "qnaAnswerUpdate.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String qnaAnswerUpdate(int qna_Seq, Model model) {
		
		CsQnaDto qna = service.getQnaDetail(qna_Seq);
		model.addAttribute("qna", qna);
		
		CsQnaDto answer = service.getAnswerDetail(qna_Seq);
		model.addAttribute("answer", answer);
		
		return "qnaAnswerUpdate.tiles";
	}
	
	@RequestMapping(value = "qnaDelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String qnaDelete(int qna_Seq) {
		
		service.qnaDelete(qna_Seq);
		
		return "redirect:/cs/qna.do";
	}
	
	@RequestMapping(value = "qnaAnswerDelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String qnaAnswerDelete(int qna_Seq) {
		
		service.answerStatusWait(qna_Seq);
		service.qnaAnswerDelete(qna_Seq);

		return "redirect:/cs/qna.do";
	}
}

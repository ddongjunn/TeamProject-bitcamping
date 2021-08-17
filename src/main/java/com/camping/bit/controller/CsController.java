package com.camping.bit.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.camping.bit.commons.FileUploadUtil;
import com.camping.bit.dto.CsNoticeDto;
import com.camping.bit.service.CsService;

@Controller
@RequestMapping(value = "/cs/*")
public class CsController {
		
	
	@Autowired 
	CsService service;
	
	@RequestMapping(value = "notice.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String noticeList(Model model) {
		
		List<CsNoticeDto> notice = service.getNoticeList();
		
		model.addAttribute("notice", notice);
		
		return "noticeList.tiles";
	}
	
	@RequestMapping(value = "noticeDetail.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String noticeDetail(int notice_Seq, Model model) {
		
		CsNoticeDto notice = service.getNoticeDetail(notice_Seq);
		
		model.addAttribute("notice", notice);
		
		return "noticeDetail.tiles";
	}
	
	@RequestMapping(value = "noticeWrite.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String noticeWrite() {		
		
		return "noticeWirte.tiles";
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
}

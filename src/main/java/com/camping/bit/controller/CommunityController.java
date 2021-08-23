package com.camping.bit.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.request;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import com.camping.bit.dto.CommunityCommentDto;
import com.camping.bit.dto.CommunityDto;
import com.camping.bit.dto.CommunityLikeDto;
import com.camping.bit.dto.CommunityParam;
import com.camping.bit.dto.MemberDto;
import com.camping.bit.dto.ProductDetailDto;
import com.camping.bit.service.CommunityService;
import com.camping.bit.commons.FileUploadUtil;

@Controller
@RequestMapping(value = "/community/*")
public class CommunityController {

   private static final int community_seq = 0;
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
   
      int sn = param.getPageNumber();
      int start = 1 + 15 * sn;
      int end = 15 + 15 * sn;
      System.out.println("sn = " + sn + " " + "start = " + start + "end = " + end);
      
      param.setStart(start);
        param.setEnd(end);


      // DB 글목록 불러오기
      List<CommunityDto> list = service.helloList(param);
      
      // model 이용해 list룰 "helloList" 짐싸서 보냄
      model.addAttribute("helloList", list); 
      
      // 게시글 총 수
      int totalCount = service.helloBoardCount(param);
      model.addAttribute("totalCount", totalCount);
      System.out.println("게시글 총 글수 = " + totalCount);
      
	  // 현재 페이지
	  int nowPage = param.getPageNumber();
	  model.addAttribute("nowPage", nowPage + 1);
      
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
   public String helloDetail(HttpSession session, Model model, CommunityDto dto) {

      // 조회수
      service.readCount(dto.getCommunity_seq());

      CommunityDto data = null;

      if(session.getAttribute("login") != null) {
         MemberDto user = (MemberDto) session.getAttribute("login");
         dto.setUser_id(user.getId());
         data = service.helloDetail(dto);
      }else {
         dto.setUser_id("0");
         data = service.helloDetail(dto);
      }
      
      /* CommunityDto data = service.helloDetail(dto); */
      model.addAttribute("data", data);
      
      int likecount = service.likeCount(dto.getCommunity_seq());
      model.addAttribute("likecount", likecount);
      
      return "helloDetail.tiles";
   }
   
   
   // 게시글 삭제
   @RequestMapping(value = "delete.do", method = RequestMethod.GET) 
   public String boardDelete(CommunityDto dto) {   
   
      service.boardDelete(dto);
      
      if(dto.getBbstype().equals("hello")) {
         return "redirect:/community/hello.do";
      }else if(dto.getBbstype().equals("free")) {
         return "redirect:/community/free.do";
      }else if(dto.getBbstype().equals("deal")) {
         return "redirect:/community/deal.do";
      }else if(dto.getBbstype().equals("find")) {
         return "redirect:/community/find.do";
      }else {
         return "redirect:/community/review.do";
      }
      
   }
   
   // 인사게시글 수정
   @RequestMapping(value = "helloupdate.do", method =  { RequestMethod.GET, RequestMethod.POST })
   public String helloUpdate(Model model, CommunityDto dto) {

      CommunityDto data = service.helloDetail(dto);
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
   
   // 좋아요 저장
   @ResponseBody
   @RequestMapping(value = "likeClick.do", method = RequestMethod.GET)
   public HashMap<String,Object> likeClick(CommunityLikeDto dto) {

      boolean check = service.likeCheck(dto);

      HashMap<String,Object> map = new HashMap<String, Object>();

      System.out.println("check = " + check);
      if(check){
         service.likeDown(dto);
         map.put("result",false);
         map.put("likeCount",service.likeCount(dto.getCommunity_seq()));
         return map;
      }
      service.likeUp(dto);
      map.put("result",true);
      map.put("likeCount",service.likeCount(dto.getCommunity_seq()));
      return map;
   }
   
   // 댓글 입력(아직안함)
   @RequestMapping("write.do")
      public void commentWrite(CommunityCommentDto dto) {
      
      System.out.println(dto.toString());

      /*dto값을 service로 넘겨*/
      service.commentWrite(dto); 
      
   }
   
   // 자유게시판
   @RequestMapping(value = "free.do", method = RequestMethod.GET)
   public String freeBoard(Model model, CommunityParam param) {

      int sn = param.getPageNumber();
      int start = 1 + 15 * sn;
      int end = 15 + 15 * sn;
      System.out.println("sn = " + sn + " " + "start = " + start + "end = " + end);

      param.setStart(start);
      param.setEnd(end);

      // DB 글목록 불러오기
      List<CommunityDto> list = service.freeList(param);

      // model 이용해 list룰 "freeList" 짐싸서 보냄
      model.addAttribute("freeList", list);

      // 게시글 총 수
      int totalCount = service.freeBoardCount(param);
      model.addAttribute("totalCount", totalCount);
      System.out.println("게시글 총 글수 = " + totalCount);

      // 현재 페이지
      int nowPage = param.getPageNumber();
      model.addAttribute("nowPage", nowPage + 1);
      
      model.addAttribute("search", param.getSearch());
      model.addAttribute("choice", param.getChoice());

      return "free.tiles";
   }

   // 자유게시판 글쓰기
   @RequestMapping(value = "freeWrite.do", method = RequestMethod.GET)
   public String freeWrite(Model model) {

      return "freewrite.tiles";
   }

   // 자유게시판 작성 후
   @RequestMapping(value = "freeWriteAf.do", method = RequestMethod.POST)
   public String freeWriteAf(CommunityDto dto, HttpServletRequest req) {

      String fileUpload = req.getServletContext().getRealPath("/resources/upload");

      System.out.println(dto.toString());

      /*dto값을 service로 넘겨*/
      service.freeWrite(dto);

      return "redirect:/community/free.do";

   }

   // 자유게시판 상세
   @RequestMapping(value = "freeDetail.do", method = RequestMethod.GET)
   public String freeDetail(HttpSession session, Model model, CommunityDto dto) {
	   
      // 조회수
      service.readCount(dto.getCommunity_seq());
	      
      CommunityDto data = null;

      System.out.println("들어오는 dto = " + dto);

      if(session.getAttribute("login") != null) {
         MemberDto user = (MemberDto) session.getAttribute("login");
         dto.setUser_id(user.getId());
         data = service.freeDetail(dto);
      }else {
         dto.setUser_id("0");
         data = service.freeDetail(dto);
      }

      /* CommunityDto data = service.helloDetail(dto); */
      model.addAttribute("data", data);

      int likecount = service.likeCount(dto.getCommunity_seq());
      model.addAttribute("likecount", likecount);

      return "freeDetail.tiles";
   }

   // 자유게시판 글 수정
   @RequestMapping(value = "freeUpdate.do", method = { RequestMethod.GET, RequestMethod.POST })
   public String freeUpdate(Model model, CommunityDto dto) {

      CommunityDto data = service.freeDetail(dto);
      model.addAttribute("data", data);

      return "freeUpdate.tiles";
   }

   // 자유게시판 글 수정 후
   @RequestMapping(value = "freeUpdateAf.do", method = RequestMethod.POST)
   public String freeUpdateAf(CommunityDto dto, HttpServletRequest req) {

      String fileUpload = req.getServletContext().getRealPath("/resources/upload");

      System.out.println(dto.toString());

      service.freeUpdate(dto);

      return "redirect:/community/free.do";
   }

   
   
   
   // 중고거래 게시판
   @RequestMapping(value = "deal.do", method = RequestMethod.GET)
   public String dealboard() {

      return "deal.tiles";
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   // 캠퍼모임
   @RequestMapping(value = "find.do", method = RequestMethod.GET)
   public String findBoard(Model model, CommunityParam param) {

      int sn = param.getPageNumber();
      int start = 1 + 15 * sn;
      int end = 15 + 15 * sn;
      System.out.println("sn = " + sn + " " + "start = " + start + "end = " + end);

      param.setStart(start);
      param.setEnd(end);

      // DB 글목록 불러오기
      List<CommunityDto> list = service.findList(param);

      // model 이용해 list룰 "findList" 짐싸서 보냄
      model.addAttribute("findList", list);

      // 게시글 총 수
      int totalCount = service.findBoardCount(param);
      model.addAttribute("totalCount", totalCount);
      System.out.println("게시글 총 글수 = " + totalCount);

      // 현재 페이지
      int nowPage = param.getPageNumber();
      model.addAttribute("nowPage", nowPage + 1);
      
      model.addAttribute("search", param.getSearch());
      model.addAttribute("choice", param.getChoice());

      return "find.tiles";
   }

   // 캠퍼모집 글쓰기
   @RequestMapping(value = "findWrite.do", method = RequestMethod.GET)
   public String findWrite(Model model) {

      return "findWrite.tiles";
   }

   // 캠퍼모집 작성 후
   @RequestMapping(value = "findWriteAf.do", method = RequestMethod.POST)
   public String findWriteAf(CommunityDto dto, HttpServletRequest req) {

      String fileUpload = req.getServletContext().getRealPath("/resources/upload");

      System.out.println(dto.toString());

      /*dto값을 service로 넘겨*/
      service.findWrite(dto);

      return "redirect:/community/find.do";

   }

   // 캠퍼모집 상세
   @RequestMapping(value = "findDetail.do", method = RequestMethod.GET)
   public String findDetail(HttpSession session, Model model, CommunityDto dto) {
	   
      // 조회수
      service.readCount(dto.getCommunity_seq());
	      
      CommunityDto data = null;

      System.out.println("들어오는 dto = " + dto);

      if(session.getAttribute("login") != null) {
         MemberDto user = (MemberDto) session.getAttribute("login");
         dto.setUser_id(user.getId());
         data = service.findDetail(dto);
      }else {
         dto.setUser_id("0");
         data = service.findDetail(dto);
      }

      /* CommunityDto data = service.helloDetail(dto); */
      model.addAttribute("data", data);

      int likecount = service.likeCount(dto.getCommunity_seq());
      model.addAttribute("likecount", likecount);

      return "findDetail.tiles";
   }

   // 캠퍼모집 글 수정
   @RequestMapping(value = "findUpdate.do", method = { RequestMethod.GET, RequestMethod.POST })
   public String findUpdate(Model model, CommunityDto dto) {

      CommunityDto data = service.findDetail(dto);
      model.addAttribute("data", data);

      return "findUpdate.tiles";
   }

   // 캠퍼모집 글 수정 후
   @RequestMapping(value = "findUpdateAf.do", method = RequestMethod.POST)
   public String findUpdateAf(CommunityDto dto, HttpServletRequest req) {

      String fileUpload = req.getServletContext().getRealPath("/resources/upload");

      System.out.println(dto.toString());

      service.findUpdate(dto);

      return "redirect:/community/find.do";
   }
   
   
   
   
   
   
   
   

   // 캠핑후기 게시판
   @RequestMapping(value = "review.do", method = RequestMethod.GET)
   public String reviewboard() {

      return "review.tiles";
   }

}
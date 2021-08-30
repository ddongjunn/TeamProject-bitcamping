package com.camping.bit.controller;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.camping.bit.dto.CampingBbsDto;
import com.camping.bit.dto.CampingCommentDto;
import com.camping.bit.dto.CampingDetailDto;
import com.camping.bit.dto.CampingImageDto;
import com.camping.bit.dto.CampingLikeDto;
import com.camping.bit.dto.CampingListDto;
import com.camping.bit.dto.CampingParam;
import com.camping.bit.dto.MemberDto;
import com.camping.bit.service.CampingService;
import com.fasterxml.jackson.databind.ObjectMapper;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/csite/*")
public class CampingController{

	@Autowired
	CampingService service;
	HttpSession session;

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
		
		//검색된 글의 갯수
		int campingSearchPage = service.getCampingSearchCount(param);
		model.addAttribute("campingSearchPage", campingSearchPage);
		
		//현재 페이지
		int pageNumber = param.getPageNumber();
		model.addAttribute("pageNumber", pageNumber + 1);
		
		return "campinglist.tiles";
		
	}
	
	//디테일 화면
	@RequestMapping(value = "campingdetail.do", method = RequestMethod.GET)
	public String campingdetail(Model model, HttpServletRequest request, int contentid, HttpSession session, CampingParam param) throws Exception {
		CampingDetailDto detaildto = service.getCampingDetail(contentid);
		CampingListDto listdto = service.getCampingListForDetail(contentid);
		List<CampingImageDto> imagedto = service.getCampingImage(contentid);
		String intro = service.getCampingIntro(contentid);
		//List<CampingLikeDto> likedto = service.getCampingLike(clike);
		
		Map<String, Object> resultMap = null;
		Map<String, Object> contentidMap = new HashMap<>();
		int campingidx = contentid; //캠핑장 고유번호
		String useridx;  //사용자 아이디 받아올 변수
	
		try {
			if(session.getAttribute("login") != null) { //로그인을 한 경우에
				
			//@SuppressWarnings("unchecked")
			MemberDto userInfo = (MemberDto)session.getAttribute("login");
			//System.out.println(userInfo);
			useridx = userInfo.getId();
			
			resultMap = service.getCampingLikeInfo(campingidx); //CAMPING_LIST에서 해당 CONTENTID를 가진 캠핑장의 CONTENTID와 LIKECOUNT를 가져옴
			
			//System.out.println("resultMap : " + resultMap);
			contentidMap.put("campingidx", campingidx); //CAMPING_LIKE테이블에서 검사할 CONTENTID
			contentidMap.put("useridx", useridx);//CAMPING_LIKE테이블에서 검사할 USERID
			//System.out.println("contentidMap :" + contentidMap);
			Map<String, Object> likecheckMap = service.getCampingLike(contentidMap); //위에서 만든 MAP으로 검사를 돌림
			
			//System.out.println("likecheckmap: " + likecheckMap);
			if(likecheckMap == null) {//지금 로그인하고 있는 사용자가 한번도 하트를 누르지 않았으므로 null값이 나옴
				model.addAttribute("likecheck", 0); //likecheck를 0으로 넘김
			}else {//지금 로그인 한 사용자가 하트를 눌렀으므로 null값이 아닌 값이 넘어감
				model.addAttribute("likecheck", likecheckMap.get("LIKE_AUTO_SEQ"));
				//System.out.println("확인 : " + likecheckMap.get("LIKE_AUTO_SEQ"));
			} //지금 로그인한 사용자가 좋아요를 이미 눌렀다면
			model.addAttribute("likecount", resultMap.get("likecount"));
			model.addAttribute("campingidx", campingidx);
			model.addAttribute("useridx", useridx);
			//System.out.println("useridx : " + useridx);			
			}else { //login하지 않은 상태에서 
				resultMap = service.getCampingLikeInfo(contentid);
				model.addAttribute("useridx", "");
				model.addAttribute("likecheck", 0);
				//System.out.println("로그인상태가 아님");
				model.addAttribute("likecount", resultMap.get("likecount"));
				model.addAttribute("campingidx", campingidx);
			}
		} catch (Exception e) {
			// 에러났을때
			System.out.println(e);
		}
		
		//총 글의 갯수
		int reviewPage = service.getCampingReviewCount(contentid);
		model.addAttribute("ReviewPage", reviewPage);
		
		//현재 페이지
		int pageNumber = param.getPageNumber();
		model.addAttribute("pageNumber", pageNumber + 1);
		
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

	//조회수 증가(캠핑장 상세화면)
	@RequestMapping(value = "getCampingReadcount.do", method = RequestMethod.GET)
	public String getCampingReadcount(int contentid) throws Exception{
		service.getCampingReadcount(contentid);
		return "redirect:/campinglist.do";
	}
	
    //자동 검색어 추천
	@RequestMapping(value = "autoSearch.do", method = RequestMethod.GET, produces = "application/text;charset=utf8")
	public @ResponseBody String autoSearch(@RequestParam("searchWord") String searchWord,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		if (searchWord == null || searchWord.equals("")) {
			return null;
		}

		searchWord = searchWord.toUpperCase();
		List searchWordList = service.autoSearch(searchWord);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("searchWord", searchWordList);
		String jsonInfo = jsonObject.toString();
		return jsonInfo;

	}
	
	//전체 리스트 뿌리기
	@RequestMapping(value = "campingreview.do", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<CampingBbsDto> campingreview(Model model, CampingParam param, @RequestParam int contentid) throws Exception {
		
		int start, end;
		start = 1 + 10 * param.getPageNumber();
		end = 10 + 10 * param.getPageNumber();
		//System.out.println("requestparam contentid : " + contentid);
		param.setStart(start);
		param.setEnd(end);
		param.setContentid(contentid);
		
		//db에서 글목록 불러오기 
		List<CampingBbsDto>list = service.getcampingreview(param);
		//System.out.println("list : " + list.toString());
		return list;
			
		}
	
	//캠핑디테일 리뷰 상세화면 
	@RequestMapping(value = "campingdetailreview.do", method = RequestMethod.GET)
	public String campingdetailreview(Model model, CampingBbsDto cbsdto, int contentid, HttpSession session, CampingParam param, @RequestParam int review_seq) throws Exception{
		CampingBbsDto campingbbs = service.campingdetailreview(cbsdto);
		CampingDetailDto detaildto = service.getCampingDetail(contentid);
		CampingListDto listdto = service.getCampingListForDetail(contentid);
		String useridx;  //사용자 아이디 받아올 변수
		try {
			if(session.getAttribute("login") != null) { //로그인을 한 경우에
				
			//@SuppressWarnings("unchecked")
			MemberDto userInfo = (MemberDto)session.getAttribute("login");
			//System.out.println(userInfo);
			useridx = userInfo.getId();
			model.addAttribute("useridx", useridx);
			//System.out.println("useridx : " + useridx);			
			}else { //login하지 않은 상태에서 
				model.addAttribute("useridx", "");
			}
		} catch (Exception e) {
			// 에러났을때
			System.out.println(e);
		}
		
		//도움이 됐어요
		Map<String, Object> resultMap = null;
		Map<String, Object> reviewseqMap = new HashMap<>();
		int reviewidx = review_seq; //캠핑장 고유번호
		String useridx1 = "";  //사용자 아이디 받아올 변수
	
		try {
			if(session.getAttribute("login") != null) { //로그인을 한 경우에
				
			//@SuppressWarnings("unchecked")
			MemberDto userInfo = (MemberDto)session.getAttribute("login");
			//System.out.println(userInfo);
			useridx = userInfo.getId();
			
			resultMap = service.getCampingHelpInfo(reviewidx); //CAMPING_LIST에서 해당 CONTENTID를 가진 캠핑장의 CONTENTID와 LIKECOUNT를 가져옴
			
			//System.out.println("resultMap : " + resultMap);
			reviewseqMap.put("reviewidx", reviewidx); //CAMPING_LIKE테이블에서 검사할 CONTENTID
			reviewseqMap.put("useridx1", useridx1);//CAMPING_LIKE테이블에서 검사할 USERID
			//System.out.println("contentidMap :" + contentidMap);
			Map<String, Object> helpcheckMap = service.getCampingHelp(reviewseqMap); //위에서 만든 MAP으로 검사를 돌림
			
			//System.out.println("likecheckmap: " + likecheckMap);
			if(helpcheckMap == null) {//지금 로그인하고 있는 사용자가 한번도 하트를 누르지 않았으므로 null값이 나옴
				model.addAttribute("helpcheck", 0); //likecheck를 0으로 넘김
			}else {//지금 로그인 한 사용자가 하트를 눌렀으므로 null값이 아닌 값이 넘어감
				model.addAttribute("helpcheck",helpcheckMap.get("LIKE_AUTO_SEQ"));
				//System.out.println("확인 : " + likecheckMap.get("LIKE_AUTO_SEQ"));
			} //지금 로그인한 사용자가 좋아요를 이미 눌렀다면
			model.addAttribute("likecount", resultMap.get("likecount"));
			model.addAttribute("reviewidx", reviewidx);
			model.addAttribute("useridx1", useridx1);
			//System.out.println("useridx : " + useridx);			
			}else { //login하지 않은 상태에서 
				resultMap = service.getCampingLikeInfo(contentid);
				model.addAttribute("useridx", "");
				model.addAttribute("likecheck", 0);
				//System.out.println("로그인상태가 아님");
				model.addAttribute("likecount", resultMap.get("likecount"));
				model.addAttribute("reviewidx", reviewidx);
			}
		} catch (Exception e) {
			// 에러났을때
			System.out.println(e);
		}
		
		//총 댓글의 갯수		
		int commentPage = service.getCampingReviewCommentCount(review_seq);
		model.addAttribute("commentPage", commentPage);
		//System.out.println("requestParam review_seq : " + commentPage);
		//현재 페이지
		int pageNumber = param.getPageNumber();
		model.addAttribute("pageNumber", pageNumber + 1);
		
		model.addAttribute("campingdetail", detaildto);
		model.addAttribute("campinglistfordetail", listdto);
		model.addAttribute("campingdetailreview", campingbbs);
		return "campingdetailreview.tiles";
	}
	
	//캠핑디테일 리뷰 상세화면(윗부분)
	@RequestMapping(value = "campingdetailtop.do", method = RequestMethod.GET)
	public String campingdetailtop(Model model, CampingBbsDto cbsdto, int contentid) throws Exception{
		CampingBbsDto campingbbs = service.campingdetailreview(cbsdto);
		CampingDetailDto detaildto = service.getCampingDetail(contentid);
		CampingListDto listdto = service.getCampingListForDetail(contentid);
		
		model.addAttribute("campingdetail", detaildto);
		model.addAttribute("campinglistfordetail", listdto);
		model.addAttribute("campingdetailreview", campingbbs);
		
		return "campingdetailtop.tiles";
	}

	//캠핑장 리뷰 작성하기
	@RequestMapping(value = "campingwritereview.do", method = RequestMethod.GET)
	public String campingwritereview(Model model, int contentid) throws Exception{
		CampingListDto listdto = service.getCampingListForDetail(contentid);
		model.addAttribute("campinglistfordetail", listdto);
		return "campingwritereview.tiles";
	}
	
	//캠핑장 리뷰 작성하기 af
	@RequestMapping(value = "campingwritereviewAf.do", method = RequestMethod.POST)
	public String campingwritereviewAf(CampingBbsDto cbsdto, Model model, RedirectAttributes redirect) throws Exception{
		if(cbsdto.getContent().equals("") || cbsdto.getTitle().equals("")){
			return "campingwritereview.tiles";
		}
	CampingBbsDto campingbbs = service.campingdetailreview(cbsdto);
	model.addAttribute("campingdetailreview", campingbbs);
	service.campingwritereviewAf(cbsdto);
	redirect.addAttribute("contentid", cbsdto.getContentid());
		return "redirect:/csite/campingdetail.do";
	}
	
	//조회수 증가(캠핑장 리뷰 상세화면)
	@RequestMapping(value = "getCampingReviewReadcount.do", method = RequestMethod.GET)
	public String getCampingReviewReadcount(int review_seq, int contentid, RedirectAttributes redirect) throws Exception{
		service.getCampingReviewReadcount(review_seq);
		redirect.addAttribute("review_seq", review_seq);
		redirect.addAttribute("contentid", contentid);
		return "redirect:/csite/campingdetailtop.do";
	}
	
	//캠핑장 리뷰 수정하기
	@RequestMapping(value = "campingupdatereview.do", method = RequestMethod.GET)
	public String campingupdatereview(Model model, CampingBbsDto cbsdto) throws Exception{
		CampingBbsDto campingbbs = service.campingdetailreview(cbsdto);
		CampingListDto listdto = service.getCampingListForDetail(cbsdto.getContentid());
		CampingDetailDto detaildto = service.getCampingDetail(cbsdto.getContentid());
		
		model.addAttribute("campingdetailreview", campingbbs);
		model.addAttribute("campinglistfordetail", listdto);
		model.addAttribute("campingdetail", detaildto);
		
		return "campingupdatereview.tiles";
	}
	
	//캠핑장 리뷰 수정하기 af
	@RequestMapping(value = "campingupdatereviewAf.do", method = RequestMethod.POST)
	public String campingupdatereviewAf(CampingBbsDto cbsdto, Model model, RedirectAttributes redirect) throws Exception{
		if(cbsdto.getContent().equals("") || cbsdto.getTitle().equals("")){
			return "campingwritereview.tiles";
		}
	CampingBbsDto campingbbs = service.campingdetailreview(cbsdto);
	model.addAttribute("campingdetailreview", campingbbs);
	service.campingupdatereviewAf(cbsdto);
	redirect.addAttribute("review_seq", cbsdto.getReview_seq());
	redirect.addAttribute("contentid", cbsdto.getContentid());
		return "redirect:/csite/campingdetailreview.do";
	}
	
	//캠핑장 리뷰 삭제하기
	@RequestMapping(value = "campingdeletereview.do", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public String campingdeletereview(int review_seq) throws Exception{
		String result = "";
		if(service.campingdeletereview(review_seq)) {
			result = "success";
		}else {
			result = "failed";
		}
		return result;
	}
	
	//캠핑장 리뷰 검색하기
	@RequestMapping(value = "campingSearchReview.do", method = {RequestMethod.GET, RequestMethod.POST}, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<CampingBbsDto>campingSearchReview(CampingParam param, @RequestParam int contentid) throws Exception{
		
		int start, end;
		start = 1 + 10 * param.getPageNumber();
		end = 10 + 10 * param.getPageNumber();
		//System.out.println("requestparam contentid : " + contentid);
		param.setStart(start);
		param.setEnd(end);
		param.setContentid(contentid);
		
		List<CampingBbsDto> searchList = service.campingSearchReview(param);
		return searchList;
	
	}
	
	/*
	//캠핑장 좋아요 있는지 없는지 유무 확인
	@RequestMapping(value = "getCampingLike.do", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public String getCampingLike(CampingLikeDto clike) throws Exception{
		String result;
		CampingLikeDto response = service.getCampingLike(clike);
		if(response!=null) {
			result = "success";
		}else {
			result = "fail";
		}
		return result;
	}

	*/	
	
	//캠핑장 좋아요 증가시키기
	@RequestMapping(value = "plusCampingHeart.do", method = {RequestMethod.GET, RequestMethod.POST}, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public int plusCampingHeart(CampingLikeDto clike) throws Exception{
		int result = 0;
		if(service.plusCampingHeart(clike)) {
			result = service.getCampingLikecount(clike.getContentid());
		}else {
			result = -1;
		}
		return result;
	}
	
	//캠핑장 좋아요 감소시키기
	@RequestMapping(value = "minusCampingHeart.do", method = {RequestMethod.GET, RequestMethod.POST}, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public int minusCampingHeart(CampingLikeDto clike) throws Exception{
		int result = 0;
		if(service.minusCampingHeart(clike)) {
			result = service.getCampingLikecount(clike.getContentid());
		}else {
			result = -1;
		}
		return result;
	}

	//캠핑장 likecount 갯수 가져오기
		@RequestMapping(value = "getCampingLikecount.do", method = {RequestMethod.GET, RequestMethod.POST}, produces = MediaType.APPLICATION_JSON_VALUE)
		@ResponseBody
		public int getCampingLikecount(int contentid) throws Exception{
		int likecount = service.getCampingLikecount(contentid);
			return likecount;
	}

		
	//캠핑장 리뷰에 달린 댓글 뿌리기
		
	//전체 리스트 뿌리기
	@RequestMapping(value = "campingReviewComment.do",  method = {RequestMethod.GET, RequestMethod.POST}, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<CampingCommentDto>campingReviewComment(Model model, CampingParam param, int review_seq) throws Exception {
		
		int start, end;
		start = 1 + 10 * param.getPageNumber();
		end = 10 + 10 * param.getPageNumber();
		//System.out.println("requestparam review_seq : " + review_seq);
		param.setStart(start);
		param.setEnd(end);
		param.setReview_seq(review_seq);
		
		//db에서 글목록 불러오기 
		List<CampingCommentDto>list = service.getCampingReviewComment(param);
		//System.out.println("list : " + list.toString());
		// get login id
		
		// return type :  newDto
		/**
		 * new dto
		 *   list : List<CampingCommentDto>
		 *   loginId: string? long?
		 */
		
		// new NewDto(list, loginId)
		return list;
			
		}
		
	//캠핑장 리뷰에 댓글 달기 
	@RequestMapping(value = "campingWriteComment.do", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public String getCampingWriteComment(CampingCommentDto cbs) throws Exception{
		String result;
		if(service.campingWriteComment(cbs)) {
			result = "success";
		}else {
			result = "failed";
		}
		return result;
	}	
	
	//캠핑장 리뷰에 댓글 삭제하기
	@RequestMapping(value = "campingDeleteComment.do", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public String getCampingDeleteComment(int comment_seq) throws Exception{
		String result = "";
		if(service.campingDeleteComment(comment_seq)) {
			result = "success";
		}else {
			result = "failed";
		}
		return result;
	}	
	
	//캠핑장 리뷰에 댓글 수정하기
		@RequestMapping(value = "campingUpdateComment.do", method = {RequestMethod.GET, RequestMethod.POST})
		@ResponseBody
		public String getCampingUpdateComment(@RequestParam int comment_seq, @RequestParam String content) throws Exception{
			
			CampingCommentDto comment = new CampingCommentDto();
			
			comment.setComment_seq(comment_seq);
			comment.setContent(content);
			
			String result;
			if(service.campingUpdateComment(comment)) {
				result = "success";
			}else {
				result = "failed";
			}
			return result;
		}	
		
	//메인 검색창 캠핑장 검색하기
		@RequestMapping(value = "campingMainSearch.do", method = {RequestMethod.GET, RequestMethod.POST}, produces = MediaType.APPLICATION_JSON_VALUE)
		@ResponseBody
		public List<CampingListDto>campingMainSearch(CampingParam param) throws Exception{
			
			int start, end;
			start = 1 + 10 * param.getPageNumber();
			end = 10 + 10 * param.getPageNumber();
			//System.out.println("requestparam contentid : " + contentid);
			param.setStart(start);
			param.setEnd(end);
			System.out.println(param);
			List<CampingListDto> searchList = service.campingMainSearch(param);
			return searchList;
		
		}
		
	//캠핑장 도움이 됐어요 증가시키기
		@RequestMapping(value = "plusCampingHelp.do", method = {RequestMethod.GET, RequestMethod.POST}, produces = MediaType.APPLICATION_JSON_VALUE)
		@ResponseBody
		public int plusCampingHelp(CampingLikeDto clike) throws Exception{
			int result = 0;
			if(service.plusCampingHelp(clike)) {
				result = service.getCampingLikecount(clike.getContentid());
			}else {
				result = -1;
			}
			return result;
		}	
}
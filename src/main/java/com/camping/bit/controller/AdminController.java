package com.camping.bit.controller;

import com.camping.bit.commons.FileUploadUtil;
import com.camping.bit.dto.*;
import com.camping.bit.service.AdminService;
import com.camping.bit.service.CommunityService;
import com.camping.bit.service.CsService;
import com.camping.bit.service.RentService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Member;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

    @Autowired
    AdminService service;

    @Autowired
    CsService csService;

    @Autowired
    RentService rentService;

    @Autowired
    CommunityService communityService;

    @RequestMapping(value = "main.do", method = RequestMethod.GET)
    public String main(Model model) {

        //회원가입 경로 통계
        Map<String,Object> regiPathCount = service.regiPathCount();
        int total = (Integer.parseInt(String.valueOf(regiPathCount.get("TOTAL"))));
        int bitcamping = (int) Math.round((Double.parseDouble(String.valueOf(regiPathCount.get("BITCAMPING"))) / total) * 100);
        int naver = (int) Math.round((Double.parseDouble(String.valueOf(regiPathCount.get("NAVER"))) / total) * 100);
        int kakao = (int) Math.round((Double.parseDouble(String.valueOf(regiPathCount.get("KAKAO"))) / total) * 100);

        regiPathCount.put("bitcampingPer",bitcamping );
        regiPathCount.put("naverPer",naver );
        regiPathCount.put("kakaoPer",kakao );
        model.addAttribute("regiPath",regiPathCount);
        model.addAttribute("todaySales",service.getTodaySales());

        //커뮤니티 최신글 받아오기
        List<CommunityDto> recentCommunity = service.recentCommunity();
        List<CommunityDto> dealList = new ArrayList<CommunityDto>();
        List<CommunityDto> freeList = new ArrayList<CommunityDto>();
        List<CommunityDto> findList = new ArrayList<CommunityDto>();
        List<CommunityDto> reviewList = new ArrayList<CommunityDto>();
        for(int i = 0; i < recentCommunity.size(); i++){
            if(recentCommunity.get(i).getTitle().length() >= 42 ){
                String str = recentCommunity.get(i).getTitle().substring(0,40);
                recentCommunity.get(i).setTitle(str + "...");
            }

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

        model.addAttribute("memberCount",service.memberCount());
        model.addAttribute("qnaCount",service.getQnaWaitTotalCount());
        model.addAttribute("communityCount",service.getCommunityTotalCount());

        //일주일 날짜 계산
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();

        String[] days7 = new String[7];
        days7[0] = format.format(cal.getTime());

        for( int i = 1; i <= 6; i++ ){
            cal.add(Calendar.DAY_OF_MONTH, - 1);
            days7[i] = format.format(cal.getTime());
        }

        model.addAttribute("days",days7);

        //일주일 매출 얻기
        Map<String,Object> sales = service.weeklySales();
        model.addAttribute("sales",sales);

        return "adminmain.tiles";
    }

    @RequestMapping(value = "memberInfo.do", method = RequestMethod.GET)
    public String memberInfo(Model model, MypageParam param) {

        int sn = param.getPageNumber();
        int start = 1 + 10 * sn;
        int end = 10 + 10 * sn;

        param.setStart(start);
        param.setEnd(end);

        List<MemberDto> list = service.allMemberList(param);
        model.addAttribute("list",list);

        //갯수
        int totalCount = service.memberCountSearch(param);
        model.addAttribute("totalCount", totalCount);

        //현재페이지
        int nowPage = param.getPageNumber();
        model.addAttribute("nowPage", nowPage + 1);

        model.addAttribute("search", param.getSearch());
        model.addAttribute("choice", param.getChoice());

        return "admin-memberInfo.tiles";
    }

    @RequestMapping(value = "community.do", method = RequestMethod.GET)
    public String community(Model model, MypageParam param) {

        int sn = param.getPageNumber();
        int start = 1 + 15 * sn;
        int end = 15 + 15 * sn;
        param.setStart(start);
        param.setEnd(end);

        //글목록 list 가져오기
        List<CommunityDto> list = service.getCommunity(param);
        model.addAttribute("list",list);

        //총 글의 갯수
        int totalCount = service.getCommunityCount(param);
        model.addAttribute("totalCount",totalCount);

        //현재 페이지
        int nowPage = param.getPageNumber();
        model.addAttribute("nowPage", nowPage + 1);

        model.addAttribute("bbstype",param.getBbstype());

        model.addAttribute("search", param.getSearch());
        model.addAttribute("choice", param.getChoice());

        return "admin-community.tiles";
    }

    @RequestMapping(value = "qna.do", method = RequestMethod.GET)
    public String qnaList(Model model, CsParam param) {

        int sn = param.getPageNumber();
        int start = 1 + 10 * sn;
        int end = (sn + 1) * 10;

        param.setStart(start);
        param.setEnd(end);

        List<CsQnaDto> qna = service.csQnaList(param);
        model.addAttribute("qna", qna);

        int totalCount = service.csQnaListCount(param);
        model.addAttribute("totalCount", totalCount);

        model.addAttribute("pageNumber", param.getPageNumber() + 1);
        model.addAttribute("search", param.getSearch());
        model.addAttribute("choice", param.getChoice());
        model.addAttribute("kind",param.getKind());

        return "admin-qna.tiles";
    }


    @RequestMapping(value = "product.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String product(CommonsParam param, Model model) {
    	
    	int sn = param.getPageNumber();
        int start = 1 + 9 * sn;
        int end = 9 + 9 * sn;

        param.setStart(start);
        param.setEnd(end);

        //총 글의 갯수
        int totalCount = rentService.getProductCount(param);
        model.addAttribute("totalCount",totalCount);

        //현재 페이지
        int nowPage = param.getPageNumber();
        model.addAttribute("nowPage", nowPage + 1);

        List<ProductDetailDto> list = rentService.getProductList(param);
        model.addAttribute("list", list);

        return "admin-rentList.tiles";
    }

    @RequestMapping(value = "product-regi.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String productRegi() {

        return "admin-productRegi.tiles";
    }

    @RequestMapping(value = "product-regiAf.do", method = RequestMethod.POST)
    public String productRegiAf(ProductDetailDto dto, @RequestParam(value = "thumbnail", required = false) MultipartFile thumbnail, HttpServletRequest req) {

        String fileUpload = req.getServletContext().getRealPath("/resources/upload");

        String newFileName = FileUploadUtil.getNewFileName(thumbnail.getOriginalFilename());

        dto.setThumbnail_Name(newFileName);

        File file = new File(fileUpload + "/" + newFileName);

        try {
            FileUtils.writeByteArrayToFile(file, thumbnail.getBytes());
            rentService.regiAf(dto);
        }catch(IOException e) {
            e.printStackTrace();
        }

        return "redirect:/admin/product.do";
    }
    
	/* 영신 */
    @RequestMapping(value = "product-update.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String productUpdate(int product_Seq, Model model) {
    	
    	ProductDetailDto item = rentService.getProductDetail(product_Seq);
    	model.addAttribute("item", item);    	
    	
        return "admin-productUpdate.tiles";
    }
    
    @RequestMapping(value = "product-updateAf.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String productUpdateAf(ProductDetailDto dto, @RequestParam(value = "thumbnail", required = false) MultipartFile thumbnail, HttpServletRequest req) {

    	// 썸네일 사진 새로 등록한 경우
    	if(!thumbnail.isEmpty()) {
	        String fileUpload = req.getServletContext().getRealPath("/resources/upload");
	
	        String newFileName = FileUploadUtil.getNewFileName(thumbnail.getOriginalFilename());
	
	        dto.setThumbnail_Name(newFileName);
	
	        File file = new File(fileUpload + "/" + newFileName);
	
	        try {
	            FileUtils.writeByteArrayToFile(file, thumbnail.getBytes());
	            rentService.productUpdateAf(dto);
	        }catch(IOException e) {
	            e.printStackTrace();
	        }
	    // 썸네일 사진 새로 등록하지 않은 경우
    	}else {
    		ProductDetailDto original = rentService.getProductDetail(dto.getProduct_Seq()); // 기존 썸네일명 가져오기
    		// System.out.println(original.getThumbnail_Name());
    		dto.setThumbnail_Name(original.getThumbnail_Name()); // 수정된 dto에 넣어주기
    		rentService.productUpdateAf(dto);
    	}

        return "redirect:/admin/product.do";
    }
    
    @RequestMapping(value = "product-delete.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String productDelete(int product_Seq) {
    	
    	System.out.println(product_Seq);
    	
    	rentService.productDelete(product_Seq);
    	
        return "redirect:/admin/product.do";
    }

    @RequestMapping(value = "community-deal.do", method = RequestMethod.GET)
    public String communityDeal(HttpSession session, Model model, MypageParam param){

        int sn = param.getPageNumber();
        int start = 1 + 15 * sn;
        int end = 15 + 15 * sn;

        param.setStart(start);
        param.setEnd(end);

        // DB 글목록 불러오기
        List<CommunityDto> list = service.dealList(param);

        // model 이용해 list룰 "dealList" 짐싸서 보냄
        model.addAttribute("dealList", list);

        // 게시글 총 수
        int totalCount = service.dealCount(param);
        model.addAttribute("totalCount", totalCount);

        // 현재 페이지
        int nowPage = param.getPageNumber();
        model.addAttribute("nowPage", nowPage + 1);

        model.addAttribute("search", param.getSearch());
        model.addAttribute("choice", param.getChoice());
        model.addAttribute("kind", param.getKind());

        return "admin-community-deal.tiles";
    }

    @RequestMapping(value = "camping-review.do", method = RequestMethod.GET)
    public String campingReview(HttpSession session, Model model, CampingParam param){

        int sn = param.getPageNumber();
        int start = 1 + 15 * sn;
        int end = 15 + 15 * sn;

        param.setStart(start);
        param.setEnd(end);

        // DB 글목록 불러오기
        List<CampingBbsDto> list = service.campingReviewList(param);
        System.out.println("campingreview : " + list);
        // model 이용해 list룰 "dealList" 짐싸서 보냄
        model.addAttribute("list", list);

        // 게시글 총 수
        int totalCount = service.campingReviewCount(param);
        model.addAttribute("totalCount", totalCount);

        // 현재 페이지
        int nowPage = param.getPageNumber();
        model.addAttribute("nowPage", nowPage + 1);

        model.addAttribute("search", param.getSearch());
        model.addAttribute("choice", param.getChoice());

        return "admin-camping-review.tiles";
    }

    @RequestMapping(value = "product-qna.do", method = RequestMethod.GET)
    public String productQna(Model model, CsParam param){

        int sn = param.getPageNumber();
        int start = 1 + 10 * sn;
        int end = (sn + 1) * 10;

        param.setStart(start);
        param.setEnd(end);

        List<ProductQnaDto> qna = service.productQnaList(param);
        model.addAttribute("qna", qna);

        System.out.println("qna=" + qna);

        int totalCount = service.productQnaListCount(param);
        model.addAttribute("totalCount", totalCount);

        model.addAttribute("pageNumber", param.getPageNumber() + 1);
        model.addAttribute("search", param.getSearch());
        model.addAttribute("choice", param.getChoice());
        model.addAttribute("kind",param.getKind());

        return "admin-product-qna.tiles";
    }

    @RequestMapping(value = "order-list.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String orderList(HttpSession session, Model model, MypageParam param) {

        int sn = param.getPageNumber();
        int start = 1 + 10 * sn;
        int end = 10 + 10 * sn;

        param.setStart(start);
        param.setEnd(end);

        //총 글의 갯수
        int totalCount = service.orderListCount(param);
        model.addAttribute("totalCount",totalCount);

        //현재 페이지
        int nowPage = param.getPageNumber();
        model.addAttribute("nowPage", nowPage + 1);

        List<ProductOrderDto> order = service.orderList(param);
        model.addAttribute("order", order);

        return "admin-orderlist.tiles";
    }

   @RequestMapping(value = "order-detail.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String orderDetail(Model model, String merchant_Uid) {

        System.out.println(merchant_Uid);

        ProductOrderDto order = service.getOrderInfo(merchant_Uid);
        model.addAttribute("order", order);

        System.out.println(order);

        return "admin-orderdetail.tiles";
    }

    @RequestMapping(value = "community-detail.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String communityDetail(Model model, int community_seq) {

        CommunityDto dto = service.getCommunityDetail(community_seq);
        model.addAttribute("community",dto);

        return "admin-communityDetail.tiles";
    }

    @RequestMapping(value = "community-delete.do", method = RequestMethod.GET)
    public String boardDelete(HttpServletRequest request, CommunityDto dto) {

        String type = service.getCommunityType(dto.getCommunity_seq());

        communityService.boardDelete(dto);

        if(type.equals("deal") || type.equals("buy") || type.equals("soldout") || type.equals("sell")){
            return "redirect:community-deal.do";
        }else{
            return "redirect:community.do?bbstype=" + type;
        }

    }

    @ResponseBody
    @RequestMapping(value = "community-writeComment.do", method = RequestMethod.POST)
    public int writeComment(HttpSession session, CommunityCommentDto comment) {

        MemberDto dto = (MemberDto) session.getAttribute("login");
        comment.setUser_id(dto.getId());

        int result = 0;

        try {
            result = communityService.writeComment(comment);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

    @ResponseBody
    @RequestMapping(value="community-commentList.do", produces="application/json; charset=utf-8")
    public HashMap<String, Object> commentList(HttpSession session, CommunityCommentParam param){

        int currentPage = param.getPageNumber();

        int start = 1 + currentPage * 10;
        param.setStart(start);

        int end = (currentPage + 1) * 10;
        param.setEnd(end);

        System.out.println(param);

        HashMap<String, Object> result = new HashMap<>();

        List<CommunityCommentDto> comment = communityService.getCommentList(param);
        result.put("comment", comment);

        int totalCount = communityService.getCommentCount(param);
        result.put("totalCount", totalCount);

        result.put("param", param);

        return result;
    }

    @ResponseBody
    @RequestMapping(value = "community-answerComment.do", method = RequestMethod.POST)
    public int answerComment(HttpSession session, CommunityCommentDto comment) {

        MemberDto dto = (MemberDto) session.getAttribute("login");
        comment.setUser_id(dto.getId());

        int result = 0;

        try {
            result = communityService.answerComment(comment);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

    @ResponseBody
    @RequestMapping(value = "community-updateComment.do", method = RequestMethod.POST)
    public int updateComment(HttpSession session, CommunityCommentDto comment) {

        MemberDto dto = (MemberDto) session.getAttribute("login");
        comment.setUser_id(dto.getId());

        int result = 0;

        try {
            result = communityService.updateComment(comment);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

    @ResponseBody
    @RequestMapping(value = "community-deleteComment.do", method = RequestMethod.POST)
    public int deleteComment(int comment_seq) {

        int result = 0;

        try {
            result = communityService.deleteComment(comment_seq);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

}

package com.camping.bit.controller;

import com.camping.bit.commons.FileUploadUtil;
import com.camping.bit.dto.*;
import com.camping.bit.service.AdminService;
import com.camping.bit.service.MemberService;
import com.camping.bit.service.MypageService;
import org.apache.commons.io.FileUtils;
import org.apache.ibatis.jdbc.Null;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping(value = "/account/*")
public class MypageController {

    @Autowired
    MypageService service;

    @Autowired
    MemberService memberService;
    
    @Autowired
    AdminService adminService;

    @RequestMapping(value = "main.do", method = RequestMethod.GET)
    public String main(HttpSession session, Model model) {
    	
    	MemberDto user = (MemberDto) session.getAttribute("login");
    	
    	MypageParam param = new MypageParam();
    	param.setId(user.getId());    	
    	
    	int myPostCount = service.getMyPostCount(param);
    	model.addAttribute("myPostCount", myPostCount);
    	
    	int myCommentCount = service.getMyCommentCount(param);
    	model.addAttribute("myCommentCount", myCommentCount);
    	
    	int myQuestionCount = service.csQnaCount(param);
    	model.addAttribute("myQuestionCount", myQuestionCount);
    	
    	int myOrderCount = service.getMyOrderCount(param);
    	model.addAttribute("myOrderCount", myOrderCount);
    	
    	param.setStatus(1);
    	int orderStatus1 = service.getMyorderStatus(param);
    	model.addAttribute("orderStatus1", orderStatus1);
    	
    	param.setStatus(2);
    	int orderStatus2 = service.getMyorderStatus(param);
    	model.addAttribute("orderStatus2", orderStatus2);
    	
    	param.setStatus(3);
    	int orderStatus3 = service.getMyorderStatus(param);
    	model.addAttribute("orderStatus3", orderStatus3);
    	
    	param.setStatus(4);
    	int orderStatus4 = service.getMyorderStatus(param);
    	model.addAttribute("orderStatus4", orderStatus4);
    	
    	List<CommunityDto> myCommunity = service.getMyAllCommunity(param);
    	model.addAttribute("myCommunity", myCommunity);
    	
    	List<CsQnaDto> myQna = service.getMyAllQna(param);
    	model.addAttribute("myQna", myQna);

        return "mypagemain.tiles";
    }

    @RequestMapping(value = "community.do", method = RequestMethod.GET)
    public String mypageCommunity(HttpSession session, Model model, MypageParam param) {

        int sn = param.getPageNumber();
        int start = 1 + 15 * sn;
        int end = 15 + 15 * sn;

        param.setStart(start);
        param.setEnd(end);

        //세션에 있는 아이디로 param 셋팅
        MemberDto user = (MemberDto) session.getAttribute("login");
        param.setId(user.getId());

        //글목록 list 가져오기
        List<CommunityDto> list = service.getMyCommunity(param);
        model.addAttribute("list",list);
        
        //총 글의 갯수
        int totalCount = service.getMyCommunityCount(param);
        model.addAttribute("totalCount",totalCount);

        //현재 페이지
        int nowPage = param.getPageNumber();
        model.addAttribute("nowPage", nowPage + 1);

        model.addAttribute("bbstype", param.getBbstype());
        model.addAttribute("search", param.getSearch());
        model.addAttribute("choice", param.getChoice());

        return "mypage-community.tiles";
    }

    @RequestMapping(value = "community-deal.do", method = RequestMethod.GET)
    public String communityDeal(HttpSession session, Model model, MypageParam param){

        int sn = param.getPageNumber();
        int start = 1 + 15 * sn;
        int end = 15 + 15 * sn;

        param.setStart(start);
        param.setEnd(end);

        //세션에 있는 아이디로 param 셋팅
        MemberDto user = (MemberDto) session.getAttribute("login");
        param.setId(user.getId());

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

        return "mypage-community-deal.tiles";
    }

    @RequestMapping(value = "camping-review.do", method = RequestMethod.GET)
    public String campingReview(HttpSession session, Model model, CampingParam param){

        int sn = param.getPageNumber();
        int start = 1 + 15 * sn;
        int end = 15 + 15 * sn;

        //세션에 있는 아이디로 param 셋팅
        MemberDto user = (MemberDto) session.getAttribute("login");
        param.setId(user.getId());

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

        return "mypage-camping-review.tiles";
    }

    @RequestMapping(value = "update.do", method = { RequestMethod.GET,RequestMethod.POST} )
    public String mypageUpdate(MemberDto dto, Model model, HttpSession session) {


        if(dto.getId() != null) {
            MemberDto user = memberService.getMember(dto.getId());
            model.addAttribute("user", user);
            session.setAttribute("login",user);
            return "mypage-update.tiles";
        }
            MemberDto user = (MemberDto) session.getAttribute("login");
            model.addAttribute("user",memberService.getMember(user.getId()));
            session.setAttribute("login",memberService.getMember(user.getId()));

        return "mypage-update.tiles";
    }

    @RequestMapping(value = "updateAf.do", method = { RequestMethod.POST} )
    public String mypageUpdateAf(MemberDto dto, HttpSession session, RedirectAttributes redirect) {

        service.modifyInfo(dto);

        return "redirect:/account/update.do";
    }


    @RequestMapping(value = "password.do", method = RequestMethod.GET)
    public String mypagePassword() {


        return "mypage-password.tiles";
    }

    @ResponseBody
    @RequestMapping(value = "passwordCheck.do", method = RequestMethod.POST)
    public boolean passwordCheck(MemberDto dto) {

        //들어오는 id를 통해서 password 가져오기
        String password = service.getPassword(dto.getId());

        //입력한 비밀번호와 (암호화된)기존 비밀번호 비교
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        return encoder.matches(dto.getPwd(), password);

    }

    @ResponseBody
    @RequestMapping(value = "passwordAf.do", method = RequestMethod.POST)
    public boolean mypagePasswordAf(MemberDto dto) {

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        //새로운 비밀번호 암호화
        String securePw = encoder.encode(dto.getPwd());
        dto.setPwd(securePw);

        //비밀번호 변경
        memberService.updatePw(dto);


        return true;
    }

    @RequestMapping(value = "withdrawal.do", method = RequestMethod.GET)
    public String mypageWithdrawal() {


        return "mypage-withdrawal.tiles";
    }

    @RequestMapping(value = "withdrawalAf.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String mypageWithdrawalAf(HttpSession session, String id) {

        service.withdrawal(id);
        session.invalidate();

        return "redirect:/";
    }
	
	@RequestMapping(value = "myOrder.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String myOrder(HttpSession session, Model model, MypageParam param) {
		
		MemberDto user = (MemberDto)session.getAttribute("login");		
		param.setId(user.getId());
		
        int sn = param.getPageNumber();
        int start = 1 + 10 * sn;
        int end = 10 + 10 * sn;

        param.setStart(start);
        param.setEnd(end);

        //총 글의 갯수
        int totalCount = service.getMyOrderCount(param);
        model.addAttribute("totalCount",totalCount);

        //현재 페이지
        int nowPage = param.getPageNumber();
        model.addAttribute("nowPage", nowPage + 1);

		List<ProductOrderDto> order = service.getMyOrderList(param);
		model.addAttribute("order", order);
				
		return "mypage-myOrder.tiles";	
	}

    @RequestMapping(value = "product-review.do", method = RequestMethod.GET)
    public String productReview(HttpSession session ,Model model, MypageParam param){

        MemberDto user = (MemberDto)session.getAttribute("login");
        param.setId(user.getId());

        int sn = param.getPageNumber();
        int start = 1 + 10 * sn;
        int end = (sn + 1) * 10;

        param.setStart(start);
        param.setEnd(end);

        List<ProductReviewDto> review = service.productReview(param);
        model.addAttribute("review", review);
        System.out.println("review = " + review);

       int totalCount = service.productReviewCount(param);
        model.addAttribute("totalCount", totalCount);

        model.addAttribute("pageNumber", param.getPageNumber() + 1);

        return "mypage-product-review.tiles";
    }

    @RequestMapping(value = "product-qna.do", method = RequestMethod.GET)
    public String productQna(HttpSession session, Model model, MypageParam param){

        MemberDto user = (MemberDto)session.getAttribute("login");
        param.setId(user.getId());

        int sn = param.getPageNumber();
        int start = 1 + 10 * sn;
        int end = (sn + 1) * 10;

        param.setStart(start);
        param.setEnd(end);

        List<ProductQnaDto> qna = service.productQna(param);
        model.addAttribute("qna", qna);

        int totalCount = service.productQnaCount(param);
        model.addAttribute("totalCount", totalCount);

        model.addAttribute("pageNumber", param.getPageNumber() + 1);

        model.addAttribute("kind",param.getKind());

        return "mypage-productQna.tiles";
    }

    @RequestMapping(value = "qna.do", method = RequestMethod.GET)
    public String qnaList(HttpSession session, Model model, MypageParam param) {

        MemberDto user = (MemberDto)session.getAttribute("login");
        param.setId(user.getId());

        int sn = param.getPageNumber();
        int start = 1 + 10 * sn;
        int end = (sn + 1) * 10;

        param.setStart(start);
        param.setEnd(end);

        List<CsQnaDto> qna = service.csQna(param);
        model.addAttribute("qna", qna);

        int totalCount = service.csQnaCount(param);
        model.addAttribute("totalCount", totalCount);

        model.addAttribute("pageNumber", param.getPageNumber() + 1);

        model.addAttribute("kind",param.getKind());

        return "mypage-csQna.tiles";
    }
    
    @RequestMapping(value = "order-detail.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String orderDetail(Model model, String merchant_Uid) {

        System.out.println(merchant_Uid);

        ProductOrderDto order = adminService.getOrderInfo(merchant_Uid);
        model.addAttribute("order", order);

        System.out.println(order);

        return "mypage-myOrder-detail.tiles";
    }

    @RequestMapping(value = "update-review.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String updateReview(Model model, int review_Seq) {

        ProductReviewDto dto = service.getProductReview(review_Seq);
        System.out.println("업데이트 전 : " + dto);
        model.addAttribute("review",dto);

        return "updateReview.tiles";
    }

    @ResponseBody
    @RequestMapping(value = "update-reviewAf.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String updateReviewAf(ProductReviewDto review, @RequestParam(value = "reviewImage", required = false) MultipartFile reviewImage, HttpServletRequest req) {

        System.out.println("updateReview : " + review);
        System.out.println("reviewImage : " + reviewImage);
        if(reviewImage != null) {

            String fileUpload = req.getServletContext().getRealPath("/resources/upload");

            System.out.println("리뷰 사진 업로드 경로 : " + fileUpload);

            String newFileName = FileUploadUtil.getNewFileName(reviewImage.getOriginalFilename());

            System.out.println("변환 파일명 : " + newFileName);

            review.setImage(newFileName);

            File file = new File(fileUpload + "/" + newFileName);

            try {
                FileUtils.writeByteArrayToFile(file, reviewImage.getBytes());
                service.updateProductReview(review);
            }catch(IOException e) {
                e.printStackTrace();
            }
        }else {
            service.updateProductReview(review);
        }


        return "true";
    }

    @ResponseBody
    @RequestMapping(value = "delete-review.do", method = { RequestMethod.GET })
    public String deleteReview(int review_Seq) {

        service.deleteProductReview(review_Seq);

        return "true";
    }

}

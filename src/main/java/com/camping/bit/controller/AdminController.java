package com.camping.bit.controller;

import com.camping.bit.commons.FileUploadUtil;
import com.camping.bit.dto.*;
import com.camping.bit.service.AdminService;
import com.camping.bit.service.CsService;
import com.camping.bit.service.RentService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

    @Autowired
    AdminService service;

    @Autowired
    CsService csService;

    @Autowired
    RentService rentService;

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

                if(recentCommunity.get(i).getBbstype().equals("deal")){
                    dealList.add(recentCommunity.get(i));
                }else if(recentCommunity.get(i).getBbstype().equals("free")){
                    freeList.add(recentCommunity.get(i));
                }else if(recentCommunity.get(i).getBbstype().equals("find")){
                    findList.add(recentCommunity.get(i));
                }else{
                    reviewList.add(recentCommunity.get(i));
                }
        }

        HashMap<String, List<CommunityDto>> communityMap = new HashMap<>();
        communityMap.put("deal",dealList);
        communityMap.put("free",freeList);
        communityMap.put("find",findList);
        communityMap.put("review",reviewList);
        model.addAttribute("recentCommunity",communityMap);

        System.out.println(communityMap);

        model.addAttribute("memberCount",service.memberCount());
        model.addAttribute("qnaCount",service.getQnaWaitTotalCount());
        model.addAttribute("communityCount",service.getCommunityTotalCount());

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
        int start = 1 + 15 * sn;
        int end = (sn + 1) * 15;

        param.setStart(start);
        param.setEnd(end);

        List<CsQnaDto> qna = csService.getQnaList(param);
        model.addAttribute("qna", qna);

        System.out.println("qna=" + qna);

        int totalCount = csService.getQnaCount(param);
        model.addAttribute("totalCount", totalCount);

        model.addAttribute("pageNumber", param.getPageNumber() + 1);
        model.addAttribute("search", param.getSearch());
        model.addAttribute("choice", param.getChoice());
        model.addAttribute("kind",param.getKind());

        return "admin-qna.tiles";
    }


    @RequestMapping(value = "product.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String product(Model model) {

        List<ProductDetailDto> list = rentService.getProductList();
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

}

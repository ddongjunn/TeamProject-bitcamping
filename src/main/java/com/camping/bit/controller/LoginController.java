package com.camping.bit.controller;

import java.io.IOException;
import java.util.HashMap;


import javax.servlet.http.HttpSession;

import com.camping.bit.dto.MemberDto;
import com.camping.bit.oauth.bo.KakaoLoginBO;
import com.camping.bit.service.MemberService;
import com.fasterxml.jackson.databind.JsonNode;
import org.json.simple.parser.JSONParser;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.github.scribejava.core.model.OAuth2AccessToken;

import com.camping.bit.oauth.bo.NaverLoginBO;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/login/*")
public class LoginController {

    @Autowired
    private MemberService service;

    /* NaverLoginBO */
    private NaverLoginBO naverLoginBO;
    private KakaoLoginBO kakaoLoginBO;
    private String apiResult = null;

    @Autowired
    private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
        this.naverLoginBO = naverLoginBO;
    }

    @Autowired
    private void setKakaoLoginBO(KakaoLoginBO kakaoLoginBO) { this.kakaoLoginBO = kakaoLoginBO; }


    @RequestMapping(value = "login.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String login(Model model, HttpSession session) {
        /* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
        // 네이버
        model.addAttribute("naverUrl", naverAuthUrl);

        //카카오 URL
        String kakaoAuthUrl = kakaoLoginBO.getUrl();

        //카카오
        model.addAttribute("kakaoUrl", kakaoAuthUrl);

        return "login.tiles";
    }

    @RequestMapping(value = "callback-naver.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String naverCallback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws Exception {

        OAuth2AccessToken oauthToken;
        // 1. 로그인 사용자 정보를 읽어온다.
        oauthToken = naverLoginBO.getAccessToken(session, code, state);

        apiResult = naverLoginBO.getUserProfile(oauthToken); // String형식의 json데이터
        /**
         * apiResult json 구조 {"resultcode":"00", "message":"success",
         * "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
         **/

        // 2. String형식인 apiResult를 json형태로 바꿈
        JSONParser parser = new JSONParser();
        Object obj = parser.parse(apiResult);
        JSONObject jsonObj = (JSONObject) obj;


        // 3. 데이터 파싱
        // Top레벨 단계 _response 파싱
        JSONObject response_obj = (JSONObject)jsonObj.get("response");
        // response의 id값 파싱
        String id = (String)response_obj.get("id");

        //신규회원인지 기존회원인지 검사
        boolean result = service.idCheck(id);

        if(result){
            MemberDto dto = service.getMember(id);
            System.out.println("로그인 = " + dto.toString());
            session.setAttribute("login",dto);
            return "main.tiles";
        }

        model.addAttribute("sns_type","naver");
        model.addAttribute("info", response_obj);
        return "snsRegi.tiles";

    }

    @RequestMapping(value = "callback-kakao.do")
    public String kakaoCallback( @RequestParam(value = "code") String code, Model model, HttpSession session) throws Exception {

        String access_Token = kakaoLoginBO.getAccessToken(code);
        HashMap<String, String> info = kakaoLoginBO.getUserInfo(access_Token);

        String id = info.get("id");

        info.put("nickname2","test");

        //신규회원인지 기존회원인지 검사
        boolean result = service.idCheck(id);

        if(result){
            MemberDto dto = service.getMember(id);
            System.out.println("로그인 = " + dto.toString());
            session.setAttribute("access_Token", access_Token);
            session.setAttribute("login",dto);
            return "main.tiles";
        }


        model.addAttribute("sns_type","kakao");
        model.addAttribute("info",info);
        return "snsRegi.tiles"; //본인 원하는 경로 설정
    }

    @RequestMapping(value = "logout.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String logout(HttpSession session) {
        MemberDto dto = (MemberDto) session.getAttribute("login");
        String sns_Type = dto.getSns_Type();

        if(sns_Type.equals("kakao")){
            kakaoLoginBO.kakaoLogout((String)session.getAttribute("access_Token"));
            session.removeAttribute("access_Token");
        }

        session.removeAttribute("login");
        session.invalidate();

        return "main.tiles";
    }

}
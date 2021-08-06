package com.camping.bit.controller;

import java.io.IOException;


import javax.servlet.http.HttpSession;

import com.camping.bit.service.MemberService;
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
    private String apiResult = null;

    @Autowired
    private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
        this.naverLoginBO = naverLoginBO;
    }

//	@RequestMapping(value = "login.do")
//	public String login() {
//
//		return "/member/login";
//	}

    @RequestMapping(value = "login.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String login(Model model, HttpSession session) {
        /* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

        // 네이버
        model.addAttribute("url", naverAuthUrl);

        return "login.tiles";
    }

    @RequestMapping(value = "callback-naver.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws Exception {

        System.out.println("여기는 callback");
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
        System.out.println("result = " + result);

        if(result){
            return "main.tiles";
        }

        model.addAttribute("sns_type","naver");
        model.addAttribute("info", response_obj);
        return "snsRegi.tiles";

        /*
        // 4.파싱 닉네임 세션으로 저장
        //session.setAttribute("sessionId", nickname); // 세션 생성
        model.addAttribute("result", apiResult);
        return "main.tiles";
        */
    }

    @RequestMapping(value = "logout.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String logout(HttpSession session) {

        session.invalidate();

        return "/member/login";
    }

}
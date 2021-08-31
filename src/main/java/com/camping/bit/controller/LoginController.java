package com.camping.bit.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.UUID;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.camping.bit.commons.Mail;
import com.camping.bit.dto.MemberDto;
import com.camping.bit.oauth.bo.KakaoLoginBO;
import com.camping.bit.service.MemberService;
import org.json.simple.parser.JSONParser;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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


    @RequestMapping(value = "naver.do", method = { RequestMethod.POST })
    public String naverLogin(Model model, HttpSession session) {
        //* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 *//*
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
        // 네이버
        model.addAttribute("naverUrl", naverAuthUrl);

        return "redirect:" + naverAuthUrl;
    }

    @RequestMapping(value = "kakao.do", method = { RequestMethod.POST })
    public String kakaoLogin(Model model, HttpSession session) {
        //카카오 URL
        String kakaoAuthUrl = kakaoLoginBO.getUrl();

        //카카오
        model.addAttribute("kakaoUrl", kakaoAuthUrl);

        return "redirect:" + kakaoAuthUrl;
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
            session.setMaxInactiveInterval(1800); // 1800 = 60s*30 (30분)
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

        //신규회원인지 기존회원인지 검사
        boolean result = service.idCheck(id);

        if(result){
            MemberDto dto = service.getMember(id);

            session.setMaxInactiveInterval(1800); // 1800 = 60s*30 (30분)
            session.setAttribute("access_Token", access_Token);
            session.setAttribute("login",dto);
            return "redirect:/";
        }


        model.addAttribute("sns_type","kakao");
        model.addAttribute("info",info);
        return "snsRegi.tiles"; //본인 원하는 경로 설정
    }

    @RequestMapping(value = "logout.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String logout(HttpSession session) {
        MemberDto dto = (MemberDto) session.getAttribute("login");

        if(session.getAttribute("login") == null){
            return "redirect:/";
        }

        if(dto.getSns_Type().equals("null")){

            session.removeAttribute("login");
        }
        else if(dto.getSns_Type().equals("kakao")){

            kakaoLoginBO.kakaoLogout((String)session.getAttribute("access_Token"));
            session.removeAttribute("access_Token");
        }

        session.invalidate();

        return "redirect:/";

    }

    @ResponseBody
    @RequestMapping(value="normal.do", method = {RequestMethod.POST})
    public boolean login(Model model, HttpSession session, MemberDto dto) throws IOException {

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        MemberDto member = service.getMember(dto.getId());
        if(member == null){
            return false;
        }else if(member.getAuth() == -1){
            return false;
        }

        if(encoder.matches(dto.getPwd(), member.getPwd())){
            session.setMaxInactiveInterval(1800);
            session.setAttribute("login",member);
            return true;
        }

        return false;
    }

    @ResponseBody
    @RequestMapping(value="findId.do", method = {RequestMethod.POST})
    public String findId(MemberDto dto){

        String id = service.findId(dto);
        if(id == null){
            return "null";
        }

        int length = id.length() / 2;

        StringBuilder str = new StringBuilder();
        for(int i = 0; i < id.length(); i++){
            if( i < length){
                char c = id.charAt(i);
                str.append(c);
            }else{
                str.append("*");
            }
        }
        return str.toString();
    }

    @ResponseBody
    @RequestMapping(value="findPw.do", method = {RequestMethod.POST})
    public String findPw(MemberDto dto){

        String id = service.findPw(dto);

        if(id == null){
            return "null";
        }

        MemberDto member = new MemberDto();
        member.setId(id);
        member.setEmail(dto.getEmail());
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String result = null;

        //임시 비밀번호 생성
        String tempPw = UUID.randomUUID().toString().replace("-","");
        tempPw = tempPw.substring(0,10);


        //임시 비밀번호로 변경
        member.setPwd(tempPw);


        //메일 전송
        try{
            Mail mail = new Mail();
            mail.sendEmail(member);

        }catch(Exception e){
            e.printStackTrace();
        }

        //회원 비밀번호를 암호화
        String securePw = encoder.encode(member.getPwd());
        member.setPwd(securePw);

        //암호화된 비밀번호로 업데이트
        service.updatePw(member);

        return "success";
    }
}
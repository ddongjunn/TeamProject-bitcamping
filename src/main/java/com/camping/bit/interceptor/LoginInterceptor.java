package com.camping.bit.interceptor;

import com.camping.bit.dto.MemberDto;
import org.springframework.ui.Model;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

public class LoginInterceptor implements HandlerInterceptor{

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session;
        MemberDto dto = (MemberDto) request.getSession().getAttribute("login");

        StringBuffer url = (StringBuffer) request.getRequestURL();
        System.out.println("요청 온 주소 : " + url);

        String query = request.getQueryString();
        System.out.println("쿼리스트링 : " + query);

        if (query == null || query.equals("null")) {

            query = "";

        } else {

            query = "?" + query;

        }

        if(dto != null){
            return true;
        }

        response.setContentType("<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\"\n" +
                "    pageEncoding=\"UTF-8\"%>");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<title>로그인 요청</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<script>");
        out.println("alert('로그인이 필요한 서비스입니다.');");
        out.println("location.href='http://localhost:8090/main.do?move=" + url + query + "';");
        out.println("</script>");
        out.println("</body>");
        out.println("</html>");
        out.flush();

        return false;
    }


    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }

}

package com.camping.bit.interceptor;

import com.camping.bit.dto.MemberDto;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

public class AdminInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session;
        MemberDto dto = (MemberDto) request.getSession().getAttribute("login");

        if(dto == null){
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
            out.println("location.href='http://localhost:8090/main.do';");
            out.println("</script>");
            out.println("</body>");
            out.println("</html>");
            out.flush();

            return false;
        }

        if(dto != null){
            if(dto.getAuth() == 1){
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
            out.println("alert('관리자 권한이 없습니다.');");
            out.println("location.href='http://localhost:8090/main.do'");
            out.println("</script>");
            out.println("</body>");
            out.println("</html>");
            out.flush();

            return false;
        }

        return false;
    }
}

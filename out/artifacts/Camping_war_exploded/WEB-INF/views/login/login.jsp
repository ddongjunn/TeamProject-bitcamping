<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <!-- 카카오 로그인 -->
    <script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <style>
        .btn-social-login {
            transition: all .2s;
            outline: 0;
            border: 1px solid transparent;
            padding: .5rem !important;
            border-radius: 50%;
            color: #fff;
        }
        .btn-social-login:focus {
            box-shadow: 0 0 0 .2rem rgba(0,123,255,.25);
        }
        .text-dark { color: #343a40!important; }
    </style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="wrap">
    <div class="login">
        <h2>비트캠핑</h2>
        <div class="login_sns">
            <a href="${naverUrl}"><button class='btn-social-login' style='background:#1FC700'><i class="xi-3x xi-naver"></i></button></a>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="${kakaoUrl}"><button class='btn-social-login' style='background:#FFEB00'><i class="xi-3x xi-kakaotalk text-dark"></i></button></a>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="#none"><button class='btn-social-login' style='background:#D93025'><i class="xi-3x xi-google"></i></button></a>
        </div>
        <div class="login_id">
            <h4>아이디</h4>
            <input type="email" name="" id="" placeholder="Email">
        </div>
        <div class="login_pw">
            <h4>비밀번호</h4>
            <input type="password" name="" id="" placeholder="Password">
        </div>
        <div class="login_etc">
            <div class="checkbox">
                <input type="checkbox" name="" id=""> 아이디 저장
            </div>
            <div class="forgot_pw">
                <a href="">비밀번호 찾기</a>
            </div>
        </div>
        <div class="submit">
            <input type="submit" value="로그인" style="margin-bottom: 15px">
            <input type="button" value="회원가입">
        </div>
    </div>
</div>




<%--<table border="1">
    <tr>
        <th colspan="2">로그인</th>
    </tr>
    <tr>
        <th>아이디</th>
        <td><input type="text" size="20" id="id"></td>
    </tr>
    <tr>
        <th>비밀번호</th>
        <td><input type="text" size="20" id="pwd"></td>
    </tr>
    <tr>
        <td colspan="2" align="center">
            <input type="button" value="로그인" id="loginBtn">
            <input type="button" value="회원가입" id="regiBtn">
        </td>
    </tr>
    <tr>
        <th colspan="2"><!-- 네이버 로그인 창으로 이동 -->
            <div id="naver_id_login" style="text-align:center">
                <a href="${naverUrl}">
                    <img src="/resources/images/kakao_login.png" width="300">
                </a>
            </div>
        </th>
    </tr>
    <tr>
        <th colspan="2">
            <div id="kakao_id_login">
                <a href="${kakaoUrl}">
                    <img src="/resources/images/naver_login.png" width="300">
                </a>
            </div>
        </th>
    </tr>
</table>--%>

</body>
</html>
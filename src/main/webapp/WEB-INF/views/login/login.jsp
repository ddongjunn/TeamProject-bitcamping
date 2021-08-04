<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<table border="1">
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
            <div id="naver_id_login" style="text-align:center"><a href="${url}">
                <img width="223" src="${pageContext.request.contextPath}/resources/images/naver_login_btn.png"></a></div>
        </th>
    </tr>
</table>

</body>
</html>
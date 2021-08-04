<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div>
	<a href="/login/login.do">로그인</a> <a href="regi.do">회원가입</a> <a href="/login/logout.do">로그아웃</a>
</div>
<div>

	<a href="/csite/campinglist.do">캠핑장검색</a> <a href="/community/main.do">커뮤니티</a> <a href="rent.do">물품대여</a> <a href="cs.do">고객센터</a>
</div>

<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery.twbsPagination.min.js"></script>

</body>
</html>
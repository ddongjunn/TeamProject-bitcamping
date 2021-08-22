<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: djlee
  Date: 2021-08-13
  Time: 오후 7:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
    <title>관리자 메뉴</title>
</head>
<body>

<div class="leftmenu">
    <div class="customer-name">
        <span class="ns-profile icon-user"></span>
        <span>${login.id}</span>
    </div>

    <div class="lnb">
        <h3 class="title">회원관리</h3>
        <a href="/admin/memberInfo.do">회원정보</a>
    </div>

    <div class="lnb">
        <h3 class="title">커뮤니티관리</h3>
        <a href="/admin/community.do?bbstype=hello">가입인사</a>
        <a href="/admin/community.do?bbstype=free">자유게시판</a>
        <a href="/admin/community.do?bbstype=deal">중고거래</a>
        <a href="/admin/community.do?bbstype=review">캠핑&여행후기</a>
        <a href="/admin/community.do?bbstype=find">캠퍼모집</a>
        <a href="/admin/csite-review.do">캠핑장리뷰</a>
    </div>

    <div class="lnb">
        <h3 class="title">상품관리</h3>
        <a>상품등륵</a>
        <a>재고관리</a>
        <a>대여관리</a>
        <a>주문관리</a>
        <a>상품Q&A</a>
    </div>

    <div class="lnb">
        <h3 class="title">고객센터관리</h3>
        <a >Q&A답변</a>
    </div>

</div>



</body>
</html>

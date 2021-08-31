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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <title>마이페이지</title>
</head>
<body>

<div class="leftmenu">
    <div class="customer-name">
        <span class="ns-profile icon-user"></span>
        <span>${login.nickname}</span>
    </div>

    <div class="lnb">
        <h3 class="title">활동정보</h3>
        <a href="/account/community.do?bbstype=hello">가입인사</a>
        <a href="/account/community.do?bbstype=free">자유게시판</a>
        <a href="/account/community-deal.do?">중고거래</a>
        <a href="/account/community.do?bbstype=review">캠핑&여행 후기</a>
        <a href="/account/community.do?bbstype=find">캠퍼 모집</a>
        <a href="/account/camping-review.do">캠핑장 리뷰</a>
    </div>

    <div class="lnb">
        <h3 class="title">나의정보</h3>
        <form name="updateFrm" action="/account/update.do" method="post">
            <input type="hidden" name="id" value="${login.id}">
            <a href="#" onclick="javascript:document.updateFrm.submit();">회원정보 관리 </a>
        </form>

        <c:if test="${login.sns_Type == 'none'}">
            <a href="/account/password.do">비밀번호 변경 </a>
            <a href="/account/withdrawal.do">회원탈퇴 </a>
        </c:if>
    </div>

    <div class="lnb">
        <h3 class="title">상품대여관리</h3>
        <a href="/account/myOrder.do">내 주문내역</a>
        <a>대여/반납 내역</a>
        <a>상품반납</a>
        <a>상품리뷰</a>
        <a>상품Q&A</a>
    </div>

    <div class="lnb">
        <h3 class="title">고객센터</h3>
        <a href="/cs/qnaWrite.do">1:1 게시글 문의</a>
        <a href="http://pf.kakao.com/_sDxgUs/chat" target="_blank">1:1 채팅 문의</a>
        <a href="mailto:ddongjunn@gmail.com">Email 문의하기</a>
    </div>
    <div class="lnb">
        <h3 class="title">비트캠핑 고객센터</h3>
        <p class="phone"><a href="tel:080-022-0182">080-022-0182</a></p>
        <p class="txt">월~일: 오전 9시 ~ 오후 8시</p>
    </div>
</div>



</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypageRent.css">
</head>
<body>

<div class="mypage_board">
	<div class="myorder-title">
	    주문 상세
	</div>
	
	<div class="table-responsive">
	    <table class="table align-items-center">
	        <tr>
	            <th>주문번호</th> <td>${order.merchant_Uid}</td>
	        </tr>
	        <tr>
	            <th>상품명</th>
	            <td>
	                ${order.product_Name} &nbsp;/&nbsp; 옵션 : (${order.rent_Name})
	                <c:if test="${order.option1_Seq != 0}">
	                   + ${order.option1_Name}
	                </c:if>
	                <c:if test="${order.option2_Seq ne 0}">
	                   + ${order.option2_Name}
	                </c:if>
	            </td>
	        </tr>
	        <tr>
	            <th>상품대여기간</th>
	            <td>
	                ${order.rent_Sdate} ~ ${order.rent_Edate}
	            </td>
	        </tr>
	        <tr>
	            <th>결제일시</th>
	            <td>
	                <fmt:parseDate value="${order.order_Date}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
	                <fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd HH:mm"/>
	            </td>
	        </tr>
	        <tr>
	            <th>결제수단</th>
	            <td>
	                <c:choose>
	                    <c:when test="${order.payment eq 'card'}">신용카드</c:when>
	                    <c:when test="${order.payment eq 'trans'}">실시간계좌이체</c:when>
	                    <c:when test="${order.payment eq 'vbank'}">가상계좌</c:when>
	                    <c:when test="${order.payment eq 'phone'}">휴대폰소액결제</c:when>
	                    <c:when test="${order.payment eq 'kakaopay'}">카카오페이</c:when>
	                    <c:when test="${order.payment eq 'payco'}">페이코</c:when>
	                    <c:when test="${order.payment eq 'point'}">간편결제</c:when>
	                </c:choose>
	            </td>
	        </tr>
	        <tr>
	            <th>결제금액</th>
	            <td>
	                <fmt:formatNumber value="${order.total_Price}" type="number"/>원
	            </td>
	        </tr>
	        <tr>
	            <th>배송지 정보</th>
	            <td>
	                ${order.receiver}<br>
	                ${order.address}<br>
	                ${order.receiver_Phone}<br>
	            </td>
	        </tr>
	        <tr>
	            <th>배송메세지</th>
	            <td>${order.memo}</td>
	        </tr>
	    </table>
	    <div style="width: 100%; text-align: center;">
	        <button type="button" class="btn btn-outline-primary btn-sm" onclick="window.history.back()">뒤로가기</button>
	    </div>
	</div>
</div>

</body>
</html>
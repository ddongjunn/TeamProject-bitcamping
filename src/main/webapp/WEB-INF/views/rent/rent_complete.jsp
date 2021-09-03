<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="/resources/css/rentComplete.css" />

</head>
<body>

<div class="cmplt-box">

	<div class="cmplt-title">
		<p class="cmplt-check"><i class="fas fa-check"></i></p>
		<p>주문이 완료되었습니다! 감사합니다</p>
	</div>
	
	<div class="cmplt-subtitle">
		결제정보
	</div>
	
	<table class="cmplt-table">
		<colgroup>
			<col width="30%">
			<col width="70%">
		</colgroup>
		
		<tr>
			<th>주문번호</th> <td>${order.merchant_Uid}</td>
		</tr>
		<tr>
			<th>상품명</th> 
			<td>
				${item.product_Name} &nbsp;/&nbsp; 옵션 : ${rent.rent_Name}
				<c:if test="${order.option1_Seq ne 0}">
					+ ${opt1.option_Name}
				</c:if>
				<c:if test="${order.option2_Seq ne 0}">
					+ ${opt2.option_Name}
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
	</table>
	
	<div class="cmplt-subtitle" style="margin-top: 40px;">
		주문정보
	</div>
	
	<table class="cmplt-table">
		<colgroup>
			<col width="30%">
			<col width="70%">
		</colgroup>
		<tr>
			<th>배송지 정보</th>
			<td>
				${order.receiver}<br>
				${order.address}<br>
				${order.receiver_Phone}<br>
			</td>
		</tr>
		<tr>
			<th>배송 메세지</th>
			<td>${order.memo}</td>
		</tr>
	</table>
	
	<div class="cmplt-btn-box">
		<button type="button" class="cmplt-btn" onclick="location.href='/account/myOrder.do'">주문내역 확인하기</button>
	</div>
</div>
</body>
</html>
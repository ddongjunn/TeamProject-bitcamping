<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
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
	<div>
		<div class="myorder-title">
			내 주문내역
		</div>
	</div>
	<c:forEach items="${order}" var="order">
		<div class="myorder-box">
			<div class="myorder-date">
				<span class="myorder-date-icon"><i class="fas fa-shopping-cart"></i></span>
				<fmt:parseDate value="${order.order_Date}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd HH:mm"/>
			</div>
			<div class="myorder-case">
				<div class="myorder-item">
					<a href="/rent/detail.do?product_Seq=${order.product_Seq}">
							${order.product_Name}
					</a>
				</div>
				<div class="myorder-detail">
					<hr>
					<div class="myorder-img">
						<img src="/resources/upload/${order.thumbnail_Name}" alt="상품 썸네일 이미지">
					</div>
					<div class="myorder-info">
						<table class="myorder-info-table">
							<tr>
								<th>주문번호</th>
								<td>
									<a href="/account/order-detail.do?merchant_Uid=${order.merchant_Uid}">
											${order.merchant_Uid}
									</a>
								</td>
							</tr>
							<tr>
								<th>결제금액</th> <td><fmt:formatNumber value="${order.total_Price}" type="number"/>원</td>
							</tr>
							<tr>
								<th>대여기간</th>
								<td>
										${order.rent_Sdate} ~ ${order.rent_Edate}
								</td>
							</tr>
							<tr>
								<th>주문상태</th>
								<td>
									<c:choose>
										<c:when test="${order.order_Status eq 1}">결제완료</c:when>
										<c:when test="${order.order_Status eq 2}">
											배송중 [우체국 : ${order.invoiceNumber}]
										</c:when>
										<c:when test="${order.order_Status eq 3}">배송완료</c:when>
										<c:when test="${order.order_Status eq 4}">반납완료</c:when>
									</c:choose>
								</td>
							</tr>
						</table>
					</div>
					<div class="myorder-btn">
						<c:if test="${order.review_Status eq 0}">
							<button class="myorder-review-btn" onclick="writereview(${order.order_Seq})">리뷰 작성</button><br>
						</c:if>
						<button class="myorder-qna-btn" onclick="writeqna(${order.product_Seq})">상품 문의</button>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>

	<!-- pagination -->
	<div class="container">
		<nav aria-label="Page navigation">
			<ul class="pagination" id="pagination" style="justify-content: center;"></ul>
		</nav>
	</div>
</div>
<script type="text/javascript">
	/* 리뷰작성 popup open */
	function writereview(order_Seq){

		let popupWidth = 480;
		let popupHeight = 520;

		let popupX = (window.screen.width / 2) - (popupWidth / 2);
		// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

		let popupY= (window.screen.height / 2) - (popupHeight / 2);
		// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음

		window.open("/rent/writeReview.do?order_Seq=" + order_Seq , "_blank", "location=no, status=no, resizable=no, height=" + popupHeight  + ", width=" + popupWidth  + ", left=" + popupX + ", top=" + popupY);
	}

	/* QnA 작성 popup open */
	function writeqna(product_Seq){

		let popupWidth = 480;
		let popupHeight = 520;

		let popupX = (window.screen.width / 2) - (popupWidth / 2);
		// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

		let popupY= (window.screen.height / 2) - (popupHeight / 2);
		// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음

		window.open("/rent/writeQna.do?product_Seq=" + product_Seq, "_blank", "location=no, status=no, resizable=no, height=" + popupHeight  + ", width=" + popupWidth  + ", left=" + popupX + ", top=" + popupY);
	}

	function writeQnaAf(){

	}

	let totalCount = ${totalCount};
	if(totalCount === 0){
		totalCount = 1;
	}

	let nowPage = ${nowPage};
	let pageSize = 10;

	let _totalPages = totalCount / pageSize;
	if(totalCount % pageSize > 0){
		_totalPages++;
	}

	$("#pagination").twbsPagination({
		startPage: nowPage,
		totalPages: _totalPages,
		visiblePages: 10,
		first:'<span sria-hidden="true">«</span>',
		prev:"이전",
		next:"다음",
		last:'<span sria-hidden="true">»</span>',
		initiateStartPageClick:false,      // onPageClick 자동 실행되지 않도록 한다
		onPageClick:function(event, page){
			location.href = "/account/myOrder.do?pageNumber=" + (page - 1);
		}
	});

</script>

</body>
</html>
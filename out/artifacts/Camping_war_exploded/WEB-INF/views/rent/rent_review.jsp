<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 쓰기</title>

 <!-- sweetalert2 -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style type="text/css">

.reviewtitle:hover {
   text-decoration: underline;
}

</style>

</head>
<body>

<!-- 
	리뷰 -> 마이페이지에 추가시
	order_Seq 넘겨줘야함
 -->

<nav id="review">
	<ul>
		<li><a href="#">상품 선택</a></li>
		<li><a href="#content">상품 상세</a></li>
		<li><a href="#review">상품 리뷰</a></li>
		<li><a href="#qna">Q&A</a></li>
	</ul>
</nav>
<div id="reviewbox" style="height: auto; margin: auto; width: 80%; padding: 20px; background-color: tomato;">

	<span>리뷰 <fmt:formatNumber value="${reviewCount}" type="number"/> 개</span> <span style="float:right;"><a href="javascript:write();">리뷰쓰기</a></span>
	 <c:forEach items="${review}" var="review">
	<div class="reviewrow" style="display: flex; background-color: #F7BBBB; ">		
		<div id="ratebox" class="rate" style="flex: 1 1 15%; padding: 10px; ">
			<c:choose>
				<c:when test="${review.rate eq 5}">⭐⭐⭐⭐⭐</c:when>
				<c:when test="${review.rate eq 4}">⭐⭐⭐⭐</c:when>
				<c:when test="${review.rate eq 3}">⭐⭐⭐</c:when>
				<c:when test="${review.rate eq 2}">⭐⭐</c:when>
				<c:when test="${review.rate eq 1}">⭐</c:when>
			</c:choose>
		</div>
		<div id="reviewtitle" class="reviewtitle" style="flex: 1 1 65%; overflow: hidden; text-overflow: ellipsis; padding: 10px;" >
			${review.title}
		</div>
		<div class="info" style="flex: 1 1 25%; padding: 10px;" >
			<span>작성자 : ${review.nickname}</span><br>
			<span>작성일 : ${review.wdate}</span>
		</div>
	</div>
	<hr>
	<div id="reviewcontent" onclick="showHide(this)" class="reviewcontent" style="height: auto; background-color: #CDE8FD; padding: 10px; display: none;" >
		<div>
			${review.content}
		</div>
		<c:if test="${review.image ne null}">
			<div>
				<img src="/resources/upload/${review.image}" alt="상품평 이미지" height="250px" >
			</div>
		</c:if>
		<hr>
	</div>
	</c:forEach> 
</div>

<script type="text/javascript">

/* 	$(document).ready(function(){
			
		 $("div").click(function(){
			
			if($("#reviewcontent").css("display") == "none"){
				$("#reviewcontent").show();
			}else{
				$("#reviewcontent").hide();
			}
		}); 
	}); */
	
	
	function showHide(e){
		
		if($(e).css("display") == "none"){
			$(e).show();
		}else{
			$(e).hide();
		}
	}
	
	/* 리뷰작성 popup open */
	function write(){
		
		var order_Seq = 1; // 이부분 나중에 order_Seq 넣어주기
		var popupWidth = 480;
		var popupHeight = 520;

		var popupX = (window.screen.width / 2) - (popupWidth / 2);
		// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

		var popupY= (window.screen.height / 2) - (popupHeight / 2);
		// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음
		
		window.open("/rent/writeReview.do?order_Seq=" + order_Seq , "_blank", "location=no, status=no, resizable=no, height=" + popupHeight  + ", width=" + popupWidth  + ", left=" + popupX + ", top=" + popupY);
	} 
	
</script>

</body>
</html>
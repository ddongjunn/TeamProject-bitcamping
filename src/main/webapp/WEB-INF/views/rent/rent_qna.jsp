<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

.qnatitle:hover {
   text-decoration: underline;
}

</style>

</head>
<body>

<nav id="qna">
	<ul>
		<li><a href="#">상품 선택</a></li>
		<li><a href="#content">상품 상세</a></li>
		<li><a href="#review">상품 리뷰</a></li>
		<li><a href="#qna">Q&A</a></li>
	</ul>
</nav>

<div id="qnacontent" style="height: auto; margin: auto; width: 80%; background-color: gray;">
	<span>문의 <fmt:formatNumber value="${qnaCount}" type="number"/> 개</span> <span style="float:right;"><a href="javascript:writeqna();">문의하기</a></span>
	 <c:forEach items="${qna}" var="qna">
	<div class="qnarow" style="display: flex; background-color: #F7BBBB; ">
		<div id="statusbox" class="status" style="flex: 1 1 15%; padding: 10px; ">
			<c:choose>
				<c:when test="${qna.status eq 0}">답변대기중</c:when>
				<c:when test="${qna.status eq 1}">답변완료</c:when>
			</c:choose>
		</div>
		<c:choose>
			<c:when test="${qna.secret eq 0}">
				<div id="qnatitle" onclick="showHide(${qna.qna_Seq})" class="qnatitle" style="flex: 1 1 65%; overflow: hidden; padding: 10px;" >
					${qna.title}
				</div>
			</c:when>
			<c:otherwise>
				<div id="qnatitle" onclick="noPermission('${qna.user_Id}', '${qna.qna_Seq}')" class="qnatitle" style="flex: 1 1 65%; overflow: hidden; padding: 10px;" >
					🔒 ${qna.title}
				</div>
			</c:otherwise>
		</c:choose>
		<div class="info" style="flex: 1 1 25%; padding: 10px;" >
			<span>작성자 : ${qna.nickname}</span><br>
			<span>작성일 : 
				<fmt:parseDate value="${qna.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss" />
				<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd" />
			</span>
		</div>
	</div>
	<hr>	
	
	<div id="qnacontent${qna.qna_Seq}" class="qnacontent" style="height: auto; padding: 10px; display: none;" >
		<!-- 문의 내용 -->
		<div style="background-color: #CDE8FD;">
			${qna.content}
		</div>
		<hr>
		<!-- 답변 내용 -->
		<c:if test="${qna.status eq 1}">
			<div style="background-color: #CDE8FD;">
				나중에 답변 들어갈 자리
			</div>
			<hr>
		</c:if>
	</div>
	</c:forEach> 
</div>

<script type="text/javascript">

function showHide(seq){
	
	if($("#qnacontent"+seq).css("display") == "none"){
		$("#qnacontent"+seq).show();
	}else{
		$("#qnacontent"+seq).hide();
	}
}

function noPermission(id, seq){	
	
	if("${login.id}" == id || "${login.auth}" == 1){
		showHide(seq);
	} else {
		Swal.fire({
			  icon: 'error',
			  title: '접근 권한이 없습니다',
			  text: '비밀글은 작성자와 관리자만 조회할 수 있습니다',
		});
	}
}

/* 리뷰작성 popup open */
function writeqna(){
	
	var product_Seq = ${item.product_Seq}; // 이부분 나중에 order_Seq 넣어주기
	var popupWidth = 480;
	var popupHeight = 520;

	var popupX = (window.screen.width / 2) - (popupWidth / 2);
	// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

	var popupY= (window.screen.height / 2) - (popupHeight / 2);
	// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음
	
	window.open("/rent/writeQna.do?product_Seq=" + product_Seq, "_blank", "location=no, status=no, resizable=no, height=" + popupHeight  + ", width=" + popupWidth  + ", left=" + popupX + ", top=" + popupY);
}

</script>

</body>
</html>
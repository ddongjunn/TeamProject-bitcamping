<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- JQuery -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<!-- sweetalert2 -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/popup.css">

</head>
<body>
<form id="qnaForm" action="/rent/writeQnaAf.do" method="post" autocomplete="off">
	<div class="pop-title">상품 문의 작성</div>
	
	<div class="pop-subtitle">제목</div> 
	<label for="secret"><span style="float: right"><input type="checkbox" id="secret" name="secret" value="1">비밀글 설정</span></label>
	<div id="contentbox" style="width: 100%; margin: auto;">
		<input type="text" id="title" name="title" placeholder="제목을 입력해 주세요">
	</div>
	<div class="pop-subtitle">문의 내용</div>
	<div id="contentbox" style="width: 100%; margin: auto;">
		<textarea id="content" rows="8" name="content" placeholder="문의 내용을 입력해 주세요"></textarea>
	</div>
	
	<input type="hidden" name="product_Seq" value="${product_Seq}">
	<input type="hidden" name="user_Id" value="${login.id}">
	
	<div class="pop-notice-short">
		문의하신 내용에 대한 답변은 해당 상품의 상세페이지 또는 '쇼핑MY > 상품Q&A'에서 확인하실 수 있습니다.	
	</div>	
	
	<div class="submit-box">
		<input type="button" id="sendqna" value="제출하기">
	</div>
</form>

<div class="pop-notice-long">
	<div class="pop-notice-title">상품 Q&A 작성 유의사항</div>
	상품 Q&A는 상품 및 상품 구매 과정(배송, 반품/취소, 교환/변경)에 대해 판매자에게 문의하는 게시판입니다.
	상품 및 상품 구매 과정과 관련 없는 비방/욕설/명예훼손성 게시글 및 상품과 관련 없는 광고글 등 부적절한 게시글 등록 시 글쓰기 제한 및 게시글이 삭제 조치 될 수 있습니다.
	전화번호, 이메일 등 개인 정보가 포함된 글 작성이 필요한 경우 판매자만 볼 수 있도록 비밀글로 문의해 주시기 바랍니다.
</div>

<script type="text/javascript">
	
	$("#sendqna").click(function() {		
		
		if(${login == null}) {
			
    		Swal.fire({
    			  icon: 'warning',
    			  title: '로그인 후 이용해 주세요',
    			  confirmButtonText: '닫기',
    			  showCancelButton: true,
    			  cancelButtonText: '뒤로',
    		}).then((result) => {
    			if (result.isConfirmed) {
    				window.close();
    			}
    		});
    		
		} else if($("#title").val() == ""){
			
			Swal.fire({
	  			  icon: 'warning',
	  			  title: '제목을 입력해 주세요!'
	  		});
			$("#title").focus();
			
		} else if($("#content").val() == ""){
			
			Swal.fire({
	  			  icon: 'warning',
	  			  title: '문의 내용을 입력해 주세요!'
	  		});
			$("#content").focus();
			
		} else {
			
	 		var params = $("#qnaForm").serialize();
	 		
			$.ajax({
				url : '<c:url value='/rent/writeQnaAf.do' />',
				data : params,
				success : function(data){
					opener.writeQnaAf();
					window.close();
				}
			});
        }
	});
	
</script>

</body>
</html>
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

</head>
<body>
<form id="qnaCommentForm" action="/rent/writeQnaCommentAf.do" method="post" autocomplete="off">
	<h3>답변 달기</h3>
	<span>제목</span> 
	<div id="contentbox" style="width: 100%; margin: auto;">
		<input type="text" id="title" name="title" placeholder="제목을 입력해 주세요" style="width: 100%">
	</div>
	<div>문의 내용</div>
	<div id="contentbox" style="width: 100%; margin: auto;">
		<textarea id="content" rows="8" name="content" placeholder="문의 내용을 입력해 주세요" style="width: 100%"></textarea>
	</div>
	
	<input type="hidden" name="qna_Seq" value="">
	<input type="hidden" name="user_Id" value="${login.id}">
	
	<div>
		<input type="button" id="sendQnaComment" value="제출하기">
	</div>
</form>

<script type="text/javascript">
	
	$("#sendQnaComment").click(function() {
		
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
	  			  title: '답변 내용을 입력해 주세요!'
	  		});
			$("#content").focus();
			
		} else {
			
	 		var params = $("#qnaCommentForm").serialize();
	 		
			$.ajax({
				url : '<c:url value='/rent/writeQnaCommentAf.do' />',
				data : params,
				success : function(xh){	
							opener.parent.location.reload();
							window.close();
				}
			});
        }
	});
	
</script>

</body>
</html>
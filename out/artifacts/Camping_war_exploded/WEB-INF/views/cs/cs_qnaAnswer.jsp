<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- summernote -->
<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">

<style type="text/css">
.qnaWrite{
	width: 85%;
}
.qnaWrite td{
	padding: 10px 0px;
	border-bottom: 1px solid gray;
}
.title{
	width: 100%;
	font-size: 18px;
}
.submitbox{
	width: 85%;
	margin: 10px;
	text-align: right;
}
.qnadetail{
	width: 85%;
}
.qnadetail > tr, td{
	padding: 10px 0px;
	border: 1px solid;
}
</style>
</head>
<body>

<h4>Question</h4>
<table class="qnadetail">
	<tbody>
		<tr>
			<td>
				<span>${qna.title}</span>
			</td>
		</tr>
		<tr>
			<td>
				<span>${qna.nickname}</span>
			</td>
		</tr>
		<tr>
			<td>
				<span>조회수 ${qna.readcount}</span>
			</td>
		</tr>
		<tr>
			<td>
			 	<fmt:parseDate value="${qna.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd HH:mm"/>
			</td>
		</tr>
		<tr>
			<td>
				<span>${qna.content}</span>
			</td>
		</tr>
	</tbody>
</table>

<h4>ㄴAnswer</h4>
<form id="qnaWriteForm" action="/cs/qnaAnswerAf.do" method="post">
<table class="qnaWrite">
	<tbody>
		<tr>
			<td>
				<input type="text" class="title" name="title" placeholder="제목을 입력해 주세요" value="RE: ${qna.title}"required>
			</td>
		</tr>
		<tr>
			<td>
				<c:choose>
					<c:when test="${qna.secret eq 1}">
						<label for="secret">
							<input type="checkbox" name="secret" id="secret" value="1" checked disabled> 비밀글 설정 (원글과 동일하게 설정됩니다)
						</label>
					</c:when>
					<c:otherwise>
						<label for="secret">
							<input type="checkbox" name="secret" id="secret" value="0" disabled> 비밀글 설정 (원글과 동일하게 설정됩니다)
						</label>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td>
				<textarea id="summernote" name="content" required></textarea>
			</td>
		</tr>
	</tbody>
</table>
<div class="submitbox">
	<input type="submit" value="등록">
</div>

<input type="hidden" name="user_Id" value="${login.id}">
<input type="hidden" name="ref" value="${qna.ref}">
</form>

<script type="text/javascript">

	$(document).ready(function() {
		
		/* summernote 설정 */
		$('#summernote').summernote({
			height: 500,
			dialogsInBody: true,
			lang: "ko-KR",
			toolbar: [
			    ['style', ['style']],
			    ['font', ['bold', 'italic', 'underline', 'clear']],
			    ['fontname', ['fontname']],
			    ['color', ['color']],
			    ['height', ['height']],
			    ['table', ['table']],
			    ['insert', ['link', 'picture', 'hr']],
			    ['view', ['fullscreen', 'codeview']],
			    ['help', ['help']]
			  ],
			fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
			fontNamesIgnoreCheck : [ '맑은고딕' ],
			focus: false,
			placeholder: '내용을 입력해 주세요',
			
			callbacks: {
		         onImageUpload: function(files, editor, welEditable) {
		               for (var i = files.length - 1; i >= 0; i--) {
		                  sendFile(files[i], this);
		               }
		           }
		      }
		});
	});
	
	/* summernote 파일 저장 */
	function sendFile(file, el) {
		var form_data = new FormData();
	  	form_data.append('file', file);
	  	$.ajax({
	    	data: form_data,
	    	type: 'POST',
	    	url: '/summernote/upload.do',
	    	cache: false,
	    	contentType: false,
	    	enctype: 'multipart/form-data',
	    	processData: false,
	    	success: function(img_name) {
	      		$(el).summernote('editor.insertImage', img_name);
	    	}
	  	});     	
	}

</script>

</body>
</html>
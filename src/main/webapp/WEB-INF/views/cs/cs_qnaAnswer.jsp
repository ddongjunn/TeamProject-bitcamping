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

</head>
<body>

<div class="detailtitle">Question</div>
<div class="postarea">
	<table class="tabledetail">
		<tbody>
			<tr>
				<td class="detailtitle">
					<span>${qna.title}</span>
				</td>
			</tr>
			<tr>
				<td class="detailinfo">
					<span><i class="fas fa-user-circle fa-sm"></i> ${qna.nickname}</span>
					<span>
						<i class="far fa-calendar-alt fa-sm"></i>
						 <fmt:parseDate value="${qna.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd HH:mm"/>
					</span>
					<span>조회수 ${qna.readcount}</span>
					<hr>
				</td>
			</tr>
			<tr>
				<td class="detailcontent">
					<span>${qna.content}</span>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="detailtitle">Answer</div>
<div class="writearea">	
	<form id="qnaWriteForm" action="/cs/qnaAnswerAf.do" method="post">
		<table class="writetable">
			<tbody>
				<tr>
					<td>
						<input type="text" class="writetitle" name="title" placeholder="제목을 입력해 주세요" maxlength="110" value="RE: ${qna.title}"required>
					</td>
				</tr>
				<tr>
					<td class="writesecret">
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
						<textarea id="summernote" class="summernoteleft" name="content" required></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		
		<div class="submitbox">
			<input type="submit" class="btnSimple" value="등록">
		</div>
		
		<input type="hidden" name="user_Id" value="${login.id}">
		<input type="hidden" name="ref" value="${qna.ref}">
		
	</form>
</div>


<script type="text/javascript">

	$(document).ready(function() {
		
		/* summernote 설정 */
		$('#summernote').summernote({
			height: 500,
			dialogsInBody: true,
			lang: "ko-KR",
			toolbar: [
			    ['font', ['bold', 'italic', 'underline', 'clear']],
			    ['color', ['color']],
			    ['para', ['paragraph']],
			    ['height', ['height']],
			    ['table', ['table']],
			    ['insert', ['link', 'picture', 'hr']],
			    ['view', ['codeview']],
			    ['help', ['help']]
			  ],
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
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

<div class="boardtitle">
	<span>글쓰기</span>
</div>
<div class="writearea">
	<form id="qnaWriteForm" action="/cs/qnaWriteAf.do" method="post">
		<table class="writetable">
			<tbody>
				<tr>
					<td>
						<input type="text" class="writetitle" name="title" placeholder="제목을 입력해 주세요" required>
					</td>
				</tr>
				<tr>
					<td class="writesecret">
						<label for="secret">
							<input type="checkbox" name="secret" id="secret" value="1"> 비밀글 설정
						</label>
					<%-- <c:if test="${login.auth eq 3}">
							<label for="notice">
								<input type="checkbox" name="notice" id="notice" value="1"> 공지글 설정
							</label>
						</c:if> --%>
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
			    ['style', ['style']],
			    ['font', ['bold', 'italic', 'underline', 'clear']],
			    ['fontname', ['fontname']],
			    ['color', ['color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['table', ['table']],
			    ['insert', ['link', 'picture', 'hr']],
			    ['view', ['fullscreen', 'codeview']],
			    ['help', ['help']]
			  ],
			fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
			fontNamesIgnoreCheck : [ '맑은고딕' ],
			focus: false,
			disableResizeEditor: true,
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
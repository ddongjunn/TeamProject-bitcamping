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
	<span>글 수정</span>
</div>

<div class="writearea">
	<form id="qnaUpdateForm" action="/cs/qnaUpdateAf.do" method="post">
		<input type="hidden" name="qna_Seq" value="${qna.qna_Seq}">
		
		<table class="writetable">
			<tbody>
				<tr>
					<td>
						<input type="text" class="writetitle" name="title" value="${qna.title}" placeholder="제목을 입력해 주세요" maxlength="100" required>
					</td>
				</tr>
				<tr>
					<td class="writesecret">
						<label for="secret">
							<input type="checkbox" name="secret" id="secret" value="1"> 비밀글 설정
						</label>
					</td>
				</tr>	
				<tr>
					<td>
						<textarea id="summernote" class="summernoteleft" name="content" required>${qna.content}</textarea>
					</td>
				</tr>
			</tbody>
		</table>
		
		<div class="submitbox">
			<input type="submit" class="btnSimple" value="등록">
		</div>	
		
	</form>
</div>


<script type="text/javascript">

	$(document).ready(function() {
		
		/* 비밀글 여부 가져오기 */
		if(${qna.secret eq 1}){
			$("#secret").prop("checked", true);
		}
		
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
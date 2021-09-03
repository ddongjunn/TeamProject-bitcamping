<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- summernote -->
<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">


<style>
.note-editable{
	font-family: initial !important;
}
</style>
</head>
<body>

<div class="writearea">
	<form id="noticeWriteForm" action="/cs/noticeWriteAf.do" method="post" enctype="multipart/form-data" >
		<table class="writetable">
			<tbody>
				<tr>
					<td>
						<input type="text" class="writetitle" name="title" placeholder="제목을 입력해 주세요" required>
					</td>
				</tr>
				<tr>
					<td>
						<input type="file" class="writefile" name="attachedfile">
					</td>
				</tr>	
				<tr>
					<td>
						<textarea id="summernote" class="summernoteleft" name="content" style="text-align: center;"required></textarea>
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
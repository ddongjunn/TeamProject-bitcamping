<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>  -->

<!-- 써머노트 -->
<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>

<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(document).ready(function() {


	$('#summernote').summernote({
		height: 400,
		dialogsInBody: true,
		disableResizeEditor: true,	// 크기 조절 기능 삭제
		toolbar: [
		// [groupName, [list of button]]
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
		lang: "ko-KR",
	
		callbacks: {	// 이미지 여러개  for 문
			onImageUpload: function(files, editor, welEditable) {
	            for (var i = files.length - 1; i >= 0; i--) {
	            	sendFile(files[i], this);
	            }
	        }
		} 
	
	});
	
	/* $("#summernote").summernote('code', '${data.content}'); */


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
});
</script>

</head>
<body>

<h1>게시글 수정화면</h1>

<form action="/community/helloUpdateAf.do" method="post">

<!-- boardUpdateAf.do 로 id값 넘겨주는 곳 -->
<input type="hidden" name="id" value="${data.user_id }">
<input type="hidden" name="bbstype" value="hello">
<input type="hidden" name="community_seq" value="${data.community_seq }">

<table border="1">
<col width="200"><col width="800">

<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" size="50px" required value="${data.title }">
	</td>
</tr>
<tr>
	<th>작성일</th>
	<td>
		${data.wdate }
	</td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea id="summernote" name="content">${data.content} </textarea>
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" id="submit" value="수정하기">
	</td>
</tr>
</table>
</form>



</body>
</html>
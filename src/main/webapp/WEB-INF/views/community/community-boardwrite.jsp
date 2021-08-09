<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<!-- 써머노트 -->
<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1> ${type} 글쓰기</h1>

<form action="boardwriteAf.do" method="post">

<!-- boardwriteAf.do 로 id값 넘겨주는 곳 -->
<input type="hidden" name="id" value="">
<input type="hidden" name="bbstype" value="${type}">

<table border="1">
<col width="200"><col width="800">

<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" size="50px" required oninvalid="this.setCustomValidity('제목을 입력하세요')">
	</td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea id="summernote" name="content">  </textarea>
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" id="submit" value="글쓰기">
	</td>
</tr>
</table>
</form>


<script type="text/javascript">
$(document).ready(function() {

	$('#summernote').summernote({
		height: 400,
		disableResizeEditor: true,	// 크기 조절 기능 삭제
		placeholder: '내용을 입력해 봅시당',
		toolbar: [
		// [groupName, [list of button]]
		['fontname', ['fontname']],
		['fontsize', ['fontsize']],
		['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		['color', ['forecolor','color']],
		['table', ['table']],
		['para', ['paragraph']],
		['height', ['height']],
		['insert',['picture','link','video']],
		['view', ['help']]
		],
		fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
		fontNamesIgnoreCheck : [ '맑은고딕' ],
		focus: false,
		lang: "ko-KR",
		
		callbacks: {	// 이미지 여러개  for 문
			onImageUpload: function(files, editor, welEditable) {
	            for (var i = files.length - 1; i >= 0; i--) {
	            	uploadFile(files[i], this);
	            }
	        }
		}
	});

});
</script>


</body>
</html>
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

<table border="1">
<col width="200"><col width="800">

<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" size="50px">
	</td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea id="summernote" name="content" rows="20" cols="50px"> </textarea>
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="글쓰기">
	</td>
</tr>
</table>
</form>

<script type="text/javascript">
$(document).ready(function() {

	$('#summernote').summernote({
			height: 400,
			lang: "ko-KR"
	});
});
</script>


</body>
</html>
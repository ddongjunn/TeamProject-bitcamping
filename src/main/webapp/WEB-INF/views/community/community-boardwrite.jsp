<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>게시판 글쓰기</h1>
<!-- 써머노트해야함 -->
<form action="bbswriteAf.do" method="post">

<table border="1">
<col width="200"><col width="400">

<tr>
	<th>아이디</th>
	<td>
		<input type="text" name="id" size="50px" value="">
	</td>
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" size="50px">
	</td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea rows="20" cols="50px" name="content"></textarea>
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="글쓰기">
	</td>
</tr>
</table>
</form>

</body>
</html>
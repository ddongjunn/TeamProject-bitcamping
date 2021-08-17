<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="get" action="campingwritereviewAf.do">
<table border = "1">
<col width = "70"><col width = "auto">

<tr>
	<th>id</th><td><input name="id" type = "text" value = '#{id}'readonly ></td>
</tr>
<tr>
	<th>제목</th><td><input name="title" type = "text" placeholder = "제목을 입력해주세요"></td>
</tr>
<tr>
	<th>내용</th><td><textarea name="content" placeholder="내용을 입력해주세요" style="width:300px;height:500px;overflow-y:hidden"></textarea></td>
</tr>
</table>
<br><br>
<tr>
	<td colspan = "2">
<button type = "submit" value = "글쓰기" id = "campingwritereview">글쓰기</button>
	</td>
</tr>
</form>
</body>
</html>
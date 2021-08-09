<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>${type} 게시글 상세화면</h1>

<form action="hello.do" method="GET">

<!-- boardwriteAf.do 로 id값 넘겨주는 곳 -->
<%-- <input type="hidden" name="id" value="">
<input type="hidden" name="bbstype" value="${type}"> --%>

<table border="1">
<col width="200"><col width="800">

<tr>
	<th>작성자</th>
	<td>
		${data.user_id } 
	</td>
</tr>
<tr>
	<th>작성날짜</th>
	<td>
		${data.wdate } 
	</td>
</tr>
<tr>
	<th>제목</th>
	<td>
		${data.title } 
	</td>
</tr>
<tr>
	<th>내용</th>
	<td>
		${data.content }
	</td>
</tr>
<tr>
	<td>
		<input type="submit" value="좋아요">
	</td>	
</tr>
<tr>
	<td colspan="2">
		<input type="submit" id="submit" value="목록">
	</td>
</tr>

</table>
</form>

</body>
</html>
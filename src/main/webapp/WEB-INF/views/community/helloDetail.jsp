<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>게시글 상세화면</h1>

<form action="hello.do" method="GET" id="board">

<table border="1" style="width: 700px">
<colgroup>
	<col style="width:30%;" />
	<col style="width:70%;" />
</colgroup>
<thead>
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
	<th>좋아요</th>
	<td>
		<%-- ${data.commend } ??왜 안됨--%>
	</td>
</tr>
<tr>
	<td>
		<input type="submit" value="좋아요">
	</td>	
</tr>
<tr>

	<td>
		<a href="/community/modify.do?community_seq=${data.community_seq }">수정</a>
		<button type="submit" id="del">삭제</button>
	</td>
	<td>
		<input type="submit" id="submit" value="목록">
	</td>
</tr>

</thead>
</table>
</form>

<script type="text/javascript">
$("#del").click(function() {			
	$("#board").attr({ "target":"_self", "action":"delete.do" }).submit();
});

/* $("#modify").click(function() {			
	$("#board").attr({ "action":"modify.do?community_seq=${data.community_seq }" }).submit();
}); */
</script>

</body>
</html>
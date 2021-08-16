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
	<th>조회수</th>
	<td>
		${data.readcount }
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

</thead>
</table>
	
<button type="button" onclick="update(${data.community_seq})">수정</button>	
<button type="button" onclick="del(${data.community_seq})">삭제</button>
<button type="button" onclick="location='/community/hello.do'">목록</button>

<hr>



<script type="text/javascript">
function del(community_seq) {
	var check = confirm("정말 삭제하시겠습니까?");
	if (check) {
		location='/community/delete.do?community_seq=' + ${data.community_seq} + '&bbstype=hello';
	}
}

function update(community_seq) {
	var check = confirm("수정하시겠습니까?");
	if (check) {
		location='/community/helloupdate.do?community_seq=' + ${data.community_seq} + '&bbstype=hello';
	}
}
</script>

</body>
</html>



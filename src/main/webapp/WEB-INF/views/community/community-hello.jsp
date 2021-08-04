<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<h1>가입인사게시판</h1>

<!-- 글 작성 리스트 틀-->
<table>
<colgroup>
	<col style="width:5%;" />
	<col style="width:auto;" />
	<col style="width:15%;" />
	<col style="width:10%;" />
	<col style="width:10%;" />
</colgroup>
<thead>
<tr>
	<th>번호</th><th>제목</th><th>작성자</th><th>조회수</th><th>작성일</th>
	
</tr>
</thead>
</table>



<!-- 글검색 -->
<select id="searchType">
	<option value="title">제목</option>
	<option value="content">내용</option>
	<option value="two">제목+내용</option>
	<option value="writer">작성자</option>
</select>
<input type="text" id="search">
<button onclick="searchBtn()">검색</button>

<!-- 글쓰기 버튼 -->
<div align="right">
<a href="boardwrite.do">글쓰기</a>
</div>




<script type="text/javascript">
function searchBtn() {
	alert("검색버튼 실행");
}
</script>


</body>
</html>
<%@page import="com.camping.bit.dto.CommunityDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입인사게시판</title>
</head>
<body>

<h1>가입인사게시판</h1>



<!-- 글 작성 리스트 틀-->
<table border="1">
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
 	<c:if test="${empty helloboardlist}">
		<tr>
			<td colspan="3">작성된 글이 없습니다</td>
		</tr>
	</c:if>
	<c:if test="${!empty helloboardlist}">
		<c:forEach var="list" items="${helloboardlist}">
			<tr>
				<td>${list.community_seq }</td>
				<td><a href="/community/detail.do?community_seq=${list.community_seq }">${list.title }</a></td>
				<td>${list.user_id }</td>
				<td>${list.readcount }</td>
				<td> <%-- ${list.wdate } --%></td>
				
				<!-- 작성일 들어갈곳 -->
				<%-- 	 <fmt:setLocale value="en_US" scope="session"/> 
					 <fmt:formatDate value="${list.wdate }" pattern="yyyy/MM/dd"/>    --%>
			</tr>
		</c:forEach>
	</c:if>

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
 <a href="boardwrite.do?type=가입인사">글쓰기</a> 
</div>


<script type="text/javascript">
function searchBtn() {
	alert("검색버튼 실행");
}

</script>


</body>
</html>
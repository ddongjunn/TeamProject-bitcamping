<%@page import="java.util.Date"%>
<%@page import="com.camping.bit.dto.CommunityDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
//총 페이지의 수
int len = (Integer)request.getAttribute("boardPage");
int boardPage = len / 10;
if((len%10) > 0) {
	boardPage = boardPage + 1;
}

//현재 페이지
Object obj = request.getAttribute("pageNumber");
int pageNumber = 0;
if(obj != null){
	pageNumber = (Integer)obj; 
}
%>

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
	<col style="width:15%;" />
</colgroup>
<thead>

<tr>
	<th>번호</th><th>제목</th><th>작성자</th><th>조회수</th><th>작성일</th>
</tr>
	<c:if test="${empty helloList}">
	<tr>
		<td colspan="3">작성된 글이 없습니다</td>
	</tr>			
	</c:if>
		<c:forEach var="list" items="${helloList}">
			<tr>
				<td>${list.community_seq }</td>
				<td><a href="/community/helloDetail.do?community_seq=${list.community_seq }">${list.title }</a></td>
				<td>${list.user_id }</td>
				<td>${list.readcount }</td>
				<td> 
					<c:set var="date" value="${list.wdate}"/>
					${fn:substring(date,2,16)}
				</td>
				</tr>
		</c:forEach>
</thead>
</table>

<div align="center">
<%
for(int i = 0;i < boardPage; i++){
	if(pageNumber == i){
		%>
		<span style="font-size: 15pt; color: #0000ff; font-weight: bold;">
			<%=i+1 %>
		</span>&nbsp;		
		<%		
	}else{
		%>
		<a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
			style="font-size: 15pt; color: #000; font-weight: bold; text-decoration: none;">
			[<%=i+1 %>]
		</a>&nbsp;
		<%
	}	
}
%>

</div>

<!-- 글검색 -->
<div align="center">
<select id="_choice" name="choice">
	<option value="" selected="selected">선택</option>
	<option value="title">제목</option>
	<option value="content">내용</option>
	<option value="user_id">작성자</option>
</select>
<input type="text" id="_search" name="search" placeholder="검색내용입력.">
<button type="button" id="btnSearch">검색</button>
</div>


<!-- 글쓰기 버튼 -->
<div align="right">
 <a href="helloWrite.do">글쓰기</a> 
</div>

<script type="text/javascript">

$("#btnSearch").click(function () {
	location.href = "hello.do?search=" + $("#_search").val() + "&choice=" + $("#_choice").val();	
}); 
 
function goPage( pageNumber ) {
	
	location.href = "hello.do?search=" + $("#_search").val() + "&choice=" + $("#_choice").val()+ "&pageNumber=" + pageNumber;
} 
</script>


</body>
</html>
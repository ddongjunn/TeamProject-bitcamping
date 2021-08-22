<%@page import="java.util.Date"%>
<%@page import="com.camping.bit.dto.CommunityDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- bootstrap 추가 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입인사게시판</title>
</head>
<body>

<h1>가입인사게시판</h1>


<!-- 글 작성 리스트 틀-->
<div align="center">
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
	<th>번호</th><th>제목</th><th>닉네임</th><th>조회수</th><th>작성일</th>
</tr>
	<c:if test="${empty helloList}">
		<td colspan="3">작성된 글이 없습니다</td>			
	</c:if>
		<c:forEach var="data" items="${helloList}">
			<tr>
				<td>${data.community_seq }</td>
				<td><a href="/community/helloDetail.do?community_seq=${data.community_seq }">${data.title }</a></td>
				<td>${data.nickname }</td>
				<td>${data.readcount }</td>
				<td> 
					<c:set var="date" value="${data.wdate}"/>
					${fn:substring(date,2,16)}
				</td>
				</tr>
		</c:forEach>
</thead>
</table>
</div>
<br>

<!-- 글검색 -->
<div align="center">
<select id="_choice" name="choice">
	<option value="" selected="selected">선택</option>
	<option value="title">제목</option>
	<option value="content">내용</option>
	<option value="nickname">닉네임</option>
</select>
<input type="text" id="_search" name="search" placeholder="검색내용입력.">
<button type="button" id="btnSearch">검색</button>
</div>

<br>

<!-- 페이지네이션 -->
<div class="container" style="text-align: center" >
     <div style = "display : inline-block">  
	    <nav aria-label="Page navigation">
	        <ul class="pagination" id="pagination"></ul>
	    </nav>
    </div>

<!-- 글쓰기 버튼 -->
<div align="right">
 <a href="/community/helloWrite.do">글쓰기</a> 
</div>

<script type="text/javascript">
$(document).ready(function () {
	// 페이지네이션
	let totalCount = ${totalCount}; 	// 글의 총수
	let pageSize = 15;	// 페이지의 크기 1 ~ 10 [1] ~ [10]
	let nowPage = ${nowPage}; // 현재 페이지
	let totalPages = totalCount / pageSize;
	
	if(totalCount % pageSize > 0) {
		totalPages++;
	}
	
    /*페이지 갱신 : 페이징을 갱신해 줘야 번호가 재설정된다.*/
    if($('#pagination').data("twbs-pagination")){
         $('#pagination').twbsPagination('destroy');
     }
	
	$("#pagination").twbsPagination({
		startPage: nowPage,
		totalPages: totalPages,
		visiblePages: 10, // 보여지는 페이지 갯수
		first: '<span sria-hidden="true">«</span>',
		prev: "이전",
		next: "다음",
		last: '<span sria-hidden="true">»</span>',
		initiateStartPageClick:false,
		onPageClick:function(event, page){
			location.href = "/community/hello.do?choice=" + $("#_choice").val() + "&search=" + $("#_search").val() + "&pageNumber=" + (page - 1);
		}
	});
 	// 검색
	$("#btnSearch").click(function () {
		location.href = "/community/hello.do?choice=" + $("#_choice").val() + "&search=" + $("#_search").val();	
	});  
});
</script>


</body>
</html>
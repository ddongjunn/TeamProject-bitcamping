<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/resources/css/cs.css" />
</head>
<body>

<!-- <div class="cs_board"> -->
	<div class="boardtitle">
		<span style="font-size: 28px">공지사항</span>
	</div>
	
	<table class="tablelist">
	
		<colgroup>
			<col width="10%">
			<col width="45%">
			<col width="10%">
			<col width="10%">
			<col width="15%">	
			<col width="10%">	
		</colgroup>
		
		<thead>
			<tr>
				<th>글번호</th> <th>제목</th> <th>첨부파일</th> <th>작성자</th> <th>작성일</th> <th>조회수</th>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach items="${notice}" var="notice">
				<tr>
					<td>${notice.notice_Seq}</td>
					<td class="textoverflow" style="text-align: left;">
						<a href="/cs/noticeDetail.do?notice_Seq=${notice.notice_Seq}">
							${notice.title}
							<c:if test="${notice.commentcount ne 0}">
								<span style="font-size: 13px; color: tomato;">[${notice.commentcount}]</span>
							</c:if>
						</a>
					</td>
					<td>
						<c:if test="${not empty notice.filename}"> 💾 </c:if>
					</td>
					<c:choose>
						<c:when test="${notice.nickname ne '관리자'}">
							<td> ${notice.nickname} </td>
						</c:when>
						<c:otherwise>
							<td><span class="badge-md badge-pill badge-success">관리자</span></td>
						</c:otherwise>
					</c:choose>
					<td>
	 					<fmt:parseDate value="${notice.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd"/>
					</td>
					<td>${notice.readcount}</td>
				</tr>		
			</c:forEach>
		</tbody>
	</table>
	
	<c:if test="${login.auth eq 1}">
		<div class="buttonbox">
			<button id="btnWrite" onclick="location.href='/cs/noticeWrite.do'">글쓰기</button>
		</div>
	</c:if>
	
	<!-- pagination -->
	<div class="pgcontainer">
	    <nav aria-label="Page navigation">
	        <ul class="pagination" id="pagination" style="justify-content:center;"></ul>
	    </nav>
	</div>
	
	<!-- 검색 -->
	<div class="searchbox" style="margin: 5px auto 10px auto">
		<table style="margin: auto;">
		<tr>
			<td style="padding-left: 5px">
				<select id="_choice" name="choice">
					<option value="" selected="selected">선택</option>
					<option value="title">제목</option>
					<option value="content">내용</option>
					<!-- <option value="writer">작성자</option> -->
				</select>	
			</td>
			<td style="padding-left: 5px">
				<input type="text" id="_search" name="search"  placeholder="검색내용입력">
			</td>
			<td style="padding-left: 5px">
					<button type="button" id="btnSearch">검색</button>
			</td>
		</tr>
		</table>
	</div>
<!-- </div> -->

<script type="text/javascript">

	var search = "${search}";
	var choice = "${choice}";
	
	$(document).ready(function () {
		if(search != ""){
			$("#_choice").val( choice );
			
			document.getElementById("_search").value = search;
		}	
	});

	let totalCount = ${totalCount};
	if(totalCount === 0){
		totalCount = 1;
	}
	
	let nowPage = ${pageNumber};
	let pageSize = 15;
	
	let _totalPages = totalCount / pageSize;	
	if(totalCount % pageSize > 0){
		_totalPages++;
	}
	
	
	$("#pagination").twbsPagination({
		startPage: nowPage,
		totalPages: _totalPages,
		visiblePages: 10,
		first:'<span sria-hidden="true">«</span>',
		prev:"이전",
		next:"다음",
		last:'<span sria-hidden="true">»</span>',
		initiateStartPageClick:false,		// onPageClick 자동 실행되지 않도록 한다
		onPageClick:function(event, page){
			location.href = "/cs/notice.do?search=" + $("#_search").val() + "&choice=" + $("#_choice").val() + "&pageNumber=" + (page - 1);	
		}
	});
	
	
	$("#btnSearch").click(function () {
		location.href = "/cs/notice.do?search=" + $("#_search").val() + "&choice=" + $("#_choice").val();	
	});
</script>

</body>
</html>
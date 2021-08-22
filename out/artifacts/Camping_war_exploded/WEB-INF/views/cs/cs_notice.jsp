<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- pagination -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

<style type="text/css">
.noticeList > th, td{
	padding: 5px;
	border-bottom: solid 1px gray;
	border-collapse: collapse;
	text-align: center;
}
.buttonbox{
	width: 85%;
	margin-top: 20px;
	text-align: right;
}
.searchbox{
	width: 85%;
}
</style>
</head>
<body>

<table class="noticeList">

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
				<td style="text-align: left;">
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
				<td>${notice.nickname}</td>
				<td>
 					<fmt:parseDate value="${notice.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd"/>
				</td>
				<td>${notice.readcount}</td>
			</tr>		
		</c:forEach>
	</tbody>
</table>

<div class="buttonbox">
	<button onclick="location.href='/cs/noticeWrite.do'">글쓰기</button>
</div>

<!-- pagination -->
<div class="container">
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination" style="justify-content:center;"></ul>
    </nav>
</div>

<br>

<!-- 검색 -->
<div class="searchbox" style="margin: 5px auto 10px auto">
	<table style="margin: auto;">
	<tr>
		<td>검색</td>
		<td style="padding-left: 5px">
			<select id="_choice" name="choice">
				<option value="" selected="selected">선택</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
				<!-- <option value="writer">작성자</option> -->
			</select>	
		</td>
		<td style="padding-left: 5px">
			<input type="text" id="_search" name="search">
		</td>
		<td style="padding-left: 5px">
				<button type="button" id="btnSearch">검색</button>
		</td>
	</tr>
	</table>
</div>


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
	let nowPage = ${pageNumber};
	let pageSize = 10;
	let _totalPages = totalCount / pageSize;
	
	if(totalCount % pageSize > 0){
		_totalPages++;
	}
	
	//$("#pagination").twbsPagination('destroy');	// 페이지 갱신 : 페이징을 갱신해 줘야 번호가 재설정된다.
	
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
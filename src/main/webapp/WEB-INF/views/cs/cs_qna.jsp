<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.qnaList{
	width: 85%;
}
.qnaList > th, td{
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

<table class="qnaList">

	<colgroup>
		<col width="10%">
		<col width="10%">
		<col width="45%">
		<col width="10%">
		<col width="15%">	
		<col width="10%">	
	</colgroup>
	
	<thead>
		<tr>
			<th>글번호</th> <th>답변상태</th> <th>제목</th> <th>작성자</th> <th>작성일</th> <th>조회수</th>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach items="${qna}" var="qna" varStatus="i">
			<tr>
				<td>${qna.qna_Seq}</td>
				<td>
					<c:choose>
						<c:when test="${qna.status eq 0}">
							[답변대기중]
						</c:when>
						<c:otherwise>
							[답변완료]
						</c:otherwise>
					</c:choose>				
				</td>
				<td style="text-align: left;">
					<c:choose>
						<c:when test="${qna.secret eq 0}">
							<a href="/cs/qnaDetail.do?qna_Seq=${qna.qna_Seq}">						
								${qna.title}
							</a>
						</c:when>
						<c:otherwise>
						
							<c:choose>						
								<c:when test="${login.id eq qna.user_Id || login.auth eq 1}">
									<a href="/cs/qnaDetail.do?qna_Seq=${qna.qna_Seq}">							
										${qna.title}
									</a> 🔒 
								</c:when>
								<c:otherwise>
									<a href="javascript:noPermission();">						
										${qna.title}
									</a> 🔒 
								</c:otherwise>
							</c:choose>
							
						</c:otherwise>
					</c:choose>			
				</td>
				<td>${qna.nickname}</td>
				<td>
 					<fmt:parseDate value="${qna.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd"/>
				</td>
				<td>${qna.readcount}</td>
			</tr>		
		</c:forEach>
	</tbody>
</table>

<div class="buttonbox">
	<button onclick="location.href='/cs/qnaWrite.do'">글쓰기</button>
</div>

<!-- pagination -->
<div class="container">
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination" style="justify-content: center;"></ul>
    </nav>
</div>

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
				<option value="writer">작성자</option>
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

	function noPermission(){
		Swal.fire({
			  icon: 'error',
			  title: '접근 권한이 없습니다',
			  text: '비밀글은 작성자와 관리자만 조회할 수 있습니다',
		});
	}

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
			location.href = "/cs/qna.do?search=" + $("#_search").val() + "&choice=" + $("#_choice").val() + "&pageNumber=" + (page - 1);	
		}
	});
	
	
	$("#btnSearch").click(function () {
		location.href = "/cs/qna.do?search=" + $("#_search").val() + "&choice=" + $("#_choice").val();	
	});
</script>

</body>
</html>
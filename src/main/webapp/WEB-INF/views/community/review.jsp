<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>캠핑여행&후기 게시판</h1>

<!-- 글 작성 리스트 틀-->
<div class="container">
	<table class="table table-sm">
		<colgroup>
			<col style="width:5%;" />
			<col style="width:auto;" />
			<col style="width:15%;" />
			<col style="width:10%;" />
			<col style="width:15%;" />
		</colgroup>
	<thead>
		<tr class="table-success">
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
					<c:if test="${empty reviewList}">
				<td colspan="3">작성된 글이 없습니다</td>			
			</c:if>
			<c:forEach var="data" items="${reviewList}">
				<tr>
					<td>${data.community_seq }</td>
					<td>
						<a href="/community/reviewDetail.do?community_seq=${data.community_seq }">
							${data.title}
							<c:if test="${data.commentcount ne 0}">
								<span style="font-size: 13px; color: tomato;">[${data.commentcount}]</span>
							</c:if>
						</a>
					</td>
					<td>${data.nickname }</td>
					<td>
						<fmt:parseDate value="${data.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd"/>
					</td>
					<td>${data.readcount }</td>
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
</div>

<!-- 글쓰기 버튼 -->
<div align="right">
	<a href="/community/reviewWrite.do">글쓰기</a> 
</div>

<script type="text/javascript">

$(document).ready(function () {

	let choice = '${choice}';
	let search = '${search}';

	// 페이지네이션
	let totalCount = ${totalCount}; 	// 글의 총수
	let pageSize = 15;	// 페이지의 크기 1 ~ 10 [1] ~ [10]
	let nowPage = ${nowPage}; // 현재 페이지
	if(totalCount === 0){
        totalCount = 1;
    }
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
			location.href = "/community/review.do?choice=" + choice + "&search=" + search + "&pageNumber=" + (page - 1);
		}
	});
 	// 검색
	$("#btnSearch").click(function () {

		if($('#_choice').val() === ""){
			let Toast = Swal.mixin({
				toast: true,
				position: 'bottom-end',
				showConfirmButton: false,
				timer: 2000,
				timerProgressBar: true,
				didOpen: (toast) => {
					toast.addEventListener('mouseenter', Swal.stopTimer)
					toast.addEventListener('mouseleave', Swal.resumeTimer)
				}
			})

			Toast.fire({
				icon: 'error',
				title: '검색옵션을 선택해주세요!'
			})
			return;

		}else if($('#_search').val() ===""){
			let Toast = Swal.mixin({
				toast: true,
				position: 'bottom-end',
				showConfirmButton: false,
				timer: 2000,
				timerProgressBar: true,
				didOpen: (toast) => {
					toast.addEventListener('mouseenter', Swal.stopTimer)
					toast.addEventListener('mouseleave', Swal.resumeTimer)
				}
			})

			Toast.fire({
				icon: 'error',
				title: '검색어를 입력해주세요!'
			})

			return;
		}

		location.href = "/community/review.do?choice=" + $("#_choice").val() + "&search=" + $("#_search").val();
	});  
});
</script>

 
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <style type="text/css"> -->
<link rel="stylesheet" type="text/css" href="/resources/css/community.css" />

</head>
<body>

<main class="board">
<div class="maintitle">
<h2>가입인사</h2>
</div>


<div class="communitybox">
    <div class="freebox_top">
    	<img id="hello" src="../resources/images/hello.png" width="550px" >
        <div class="freebox_title" style="margin-bottom: 3px">"안녕하세요 반갑습니다! 여러분들을 환영합니다"</div>
    </div>
    <div class="freetext">
        <ul class="bu">
            <li style="margin-bottom: 5px">새로운 사람들을 맞이해보세요.</li>
            <li>먼저 인사를 건네보는건 어떨까요?</li>
        </ul>
    </div>
</div>

<!-- 글검색 -->
<div id="searchbox" style="background-color: #f1f3f5; padding-top: 14px; padding-bottom: 14px;" align="center">
	<select id="_choice" name="choice">
		<option value="" selected="selected">선택</option>
		<option value="title">제목</option>
		<option value="content">내용</option>
		<option value="nickname">작성자</option>
	</select> 
	<input type="text" id="_search" name="search" placeholder="검색내용입력">
	<button type="button" id="btnSearch">검색</button>
</div>
<br>

<div class="bbs_total">
	<i class="fas fa-layer-group"></i><span>전체게시물<strong> ${totalCount}</strong></span>
</div> 
<!-- 글 작성 리스트 틀-->
	<table class="table bbstable">
			<colgroup>
				<col style="width: 10%;" />
				<col style="width: auto;" />
				<col style="width: 15%;" />
				<col style="width: 20%;" />
				<col style="width: 10%;" />
			</colgroup>
		<thead>
			<tr class="table_top">
				<td>글번호</td>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>조회수</td>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty helloList}">
				<tr>
					<td colspan="5">작성된 글이 없습니다</td>
				</tr>		
			</c:if>
			<c:forEach var="data" items="${helloList}">
				<tr>
					<td>${data.community_seq }</td>
					<td style="text-align: left">
						<a href="/community/helloDetail.do?community_seq=${data.community_seq }">
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
		</tbody>
	</table>

<!-- 글쓰기 버튼 -->
<div class="buttonbox" style="width: 100%;">
	<button id="btnWrite" onclick="location.href='/community/helloWrite.do'">글쓰기</button>
</div>

<!-- 페이지네이션 -->
<div class="container" style="text-align: center" >
	<div style = "display : inline-block">  
		<nav aria-label="Page navigation">
			<ul class="pagination" id="pagination"></ul>
		</nav>
	</div>
</div>

</main>

<script type="text/javascript">

$(document).ready(function () {

	let choice = '${choice}';
	let search = '${search}';
	
	$(document).ready(function () {
		if(search != ""){
			$("#_choice").val( choice );
			
			document.getElementById("_search").value = search;
		}	
	});

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
			location.href = "/community/hello.do?choice=" + choice + "&search=" + search + "&pageNumber=" + (page - 1);
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

		location.href = "/community/hello.do?choice=" + $("#_choice").val() + "&search=" + $("#_search").val();
	});  
});
</script>

 
</body>
</html>
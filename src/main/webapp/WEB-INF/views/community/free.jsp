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
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
</head>
<body>

<main class="board">
<div class="maintitle">
<h2>자유게시판</h2>
</div>

<div class="communitybox">
    <div class="freebox_top">
    	<img src="../resources/images/book.png" height="65px" width="75px">
        <div class="freebox_title">자유게시판은 캠퍼분들이 나누고 싶은 글을 게시하는 공간입니다.</div>
    </div>
    <hr id="dotline">
    <div class="freetext">
        <ul class="bu">
            <li style="margin-bottom: 5px">불건전성, 상업성 광고, 유언비어, 저속한 표현, 특정인 또는 단체에 대한 비방(명예훼손), 정치적 목적이나 성향, 반복적 게시물, 저작권 침해, 기타 불법
                정보 등의 <span class="em_orange">유해게시물은 관리자에 의해 통보없이 삭제</span>될 수 있습니다.</li>
            <li style="margin-bottom: 5px">주민등록번호, 핸드폰번호, 이메일, 계좌번호, 신용카드번호 등 <span class="em_orange">개인정보(본인 또는 타인)가 누출되지 않도록 주의</span>하시기 바랍니다.
                <p class="point"><img src="../resources/images/point.png" height="30px" width="30px">개인정보가 포함되어 있는 글은 일차적으로 글쓰기시 차단되오니, 이점 유념하여 작성하여 주시기 바랍니다.</p>
            </li>
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
			<c:if test="${empty freeList}">
				<td colspan="5">작성된 글이 없습니다</td>			
			</c:if>
			<c:forEach var="data" items="${freeList}">
				<tr>
					<td>${data.community_seq }</td>
					<td style="text-align: left">
						<a href="/community/freeDetail.do?community_seq=${data.community_seq }">
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

<!-- 글쓰기 버튼 -->
<div class="buttonbox" style="width: 100%;">
	<button id="btnWrite" onclick="location.href='/community/freeWrite.do'">글쓰기</button>
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
			location.href = "/community/free.do?choice=" + choice + "&search=" + search + "&pageNumber=" + (page - 1);
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

		location.href = "/community/free.do?choice=" + $("#_choice").val() + "&search=" + $("#_search").val();
	});  
});
</script>

</body>
</html>
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
<!-- <style type="text/css"> -->
<link rel="stylesheet" type="text/css" href="/resources/css/community.css" />
</head>
<body>

<main class="board">
<div class="maintitle">
	<h2>캠핑여행&후기 게시판</h2>
</div>

<div class="communitybox">
    <div class="freebox_top">
    	<img src="../resources/images/communityreview.png" height="65px" width="75px">
        <div class="freebox_title">캠핑 여행&후기 게시판은 여러분들의 소중한 추억을 게시하는 공간입니다.</div>
    </div>
    <hr id="dotline">
    <div class="freetext">
        <ul class="bu">
            <li>불건전성, 상업성 광고, 유언비어, 저속한 표현, 특정인 또는 단체에 대한 비방(명예훼손), 정치적 목적이나 성향, 반복적 게시물, 저작권 침해, 기타 불법
                정보 등의 <span class="em_orange">유해게시물은 관리자에 의해 통보없이 삭제</span>될 수 있습니다.</li>
            <li>주민등록번호, 핸드폰번호, 이메일, 계좌번호, 신용카드번호 등 <span class="em_orange">개인정보(본인 또는 타인)가 누출되지 않도록 주의</span>하시기 바랍니다.
                <p class="point"><img src="../resources/images/point.png" height="30px" width="30px">타인의 저작물(신문기사, 사진, 동영상 등)을 관리자의 허락 없이 무단으로 복제하여 올리는 것은 저작권 침해에 해당합니다.</p>
            </li>
        </ul>
    </div>
</div>

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

<div>&nbsp; 총 ${totalCount}건</div> 
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
</main>

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
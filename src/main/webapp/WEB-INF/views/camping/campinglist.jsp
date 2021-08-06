<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- bootstrap 추가 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!--DB에 컬럼 추가 
ALTER TABLE CAMPING_LIST ADD READCOUNT NUMBER(8) DEFAULT '0' NOT NULL; 
ALTER TABLE CAMPING_LIST ADD LIKECOUNT NUMBER(8) DEFAULT '0' NOT NULL;
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href = "campingmap.do">지도로 가기</a>

<!-- 캠핑장 검색창 -->
<div class = "search_box" style = "margin-top : 5px; margin-bottom : 10px">
	<!-- <label for = "selectListOrder" class = "skip">정렬하귀</label> -->
	<table style = "margin-left : left; margin-right : left; margin-top : 3px; margin-bottom : 3px">
		<tr>
			<td style = "padding-left:5px">
				<select class = "sorting_select" id = "sorting" title = "정렬">
					<option value = "image" selected = "selected">--정렬--</option>
					<option value = "create">최신등록순</option>
					<option value = "update">업데이트순</option>
					<option value = "read">조회순</option>
					<option value = "like">추천순</option>
				</select>
			</td>
		</tr>
	</table>
</div>

<script type="text/javascript">
var sorting = "${sorting}";

$(document).ready(function(){
		$("#sorting").val(sorting);
	}
$("#sorting").change(function(){
	$("").val($("#sorting" option:selected").val());
	location.href = "campinglist.do?sorting=" + $("#sorting").val();
});
});
</script>

<!-- 실제 캠핑장 리스트 뿌려지는 부분 -->
<%-- <table class = "list_table" style = "width : 100%" id = "_list_table">
<colgroup>
	<col style = "width : 10px">
	<col style = "width : 10px">
	<col style = "width : 20px">
	<col style = "width : 100px">
	<col style = "width : 60px">
</colgroup>

	<tr>
		<th>번호</th><th>사진</th><th>캠핑장 이름</th><th>주소</th><th>한 줄 소개</th>
	</tr>
	<c:if test = "${empty campinglist}">
	<tr>
		<td colspan = "3">작성된 글이 없습니다</td>
	</tr>
	</c:if>

	<c:forEach items = "${campinglist}" var = "camping" varStatus = "i">
		<tr>
			
			<td>${i.count}</td>
			<td style = "width : 50px"><img src = ${camping.firstimageurl} onerror="this.src='<%=request.getContextPath()%>/resources/image/csite_alt_image.png'"
				width = "300" height = "200"></td>
			<td><a href = "campingdetail.do?contentid=${camping.contentid}">${camping.facltnm}</a></td>
			<td>${camping.addr1}</td>
			<td>${camping.lineintro}</td>
		</tr>
	</c:forEach>
</table> --%>
<c:forEach items = "${campinglist}" var = "camping" varStatus = "i">
<div class = "camping_search_list">
	<ul>
		<li style = "list-style : none;">
			<div class = "image" style = "float : left ; margin-right : 10px" >
				<a href = "campingdetail.do?contentid=${camping.contentid}">	
				<img src = "${camping.firstimageurl}" onerror="this.src='<%=request.getContextPath()%>/resources/image/csite_alt_image.png'"
				width = "300" height = "200"></a>
			</div>
			<div class = "camping_information" style = "float : left">
				<div class = "camping_site name">
					<h2 class = "camping_site_name">
						<a href = "campingdetail.do?contentid=${camping.contentid}">	
							${camping.facltnm}
						</a>
						<span class = "readcount" style = "font-size : 15px">조회수 : ${camping.readcount}</span>
						<span class = "readcount" style = "font-size : 15px">추천수 : ${camping.likecount}</span>
					</h2>
					
				</div>
				<c:set var="TextValue" value="${camping.addr1}"/>
				<c:choose>
					<c:when test = "${fn:length(camping.addr1)>40}">
						<c:set var = "string1" value = "${fn:substring(TextValue, 0,30)}"/>
						<h2>주소 :${string1}...</h2>
					</c:when>
					<c:otherwise>
						<h2>주소 :${camping.addr1}</h2>
					</c:otherwise>
				</c:choose>
				<c:if test="${camping.lineintro!='none'}">
					<h5>${camping.lineintro}</h5>
				</c:if>
				<c:if test="${camping.tel!='none'}">
					<h5>${camping.tel}</h5>
				</c:if>
				<c:choose>
					<c:when test="${camping.homepage eq 'none'}">
						홈페이지 준비중 
					</c:when>
					<c:otherwise>
						<button type = button onclick = "location.href ='${url}'">홈페이지</button>
					</c:otherwise>
				</c:choose>
				
			</div>
			<div style="clear:both"></div>
		</li>
	</ul>
</div>
</c:forEach>

<div class="container" style = "width : 100%; text-align : center">
    <div style = "display : inline-block">
	    <nav aria-label="Page navigation">
	        <ul class="pagination" id="pagination"></ul>
	    </nav>
    </div>
</div>
<br>
<script type="text/javascript">
$(document).ready(function () {
	
//페이지네이션
let totalCount = ${campingPage};	// 서버로부터 총글의 수를 취득
//alert(totalCount);
let nowPage = ${pageNumber};	// 서버로부터 현재 페이지를 취득
//alert(nowPage);

let pageSize = 10;//페이지의 크기(1~10) [1] ~ [10]


/* if(typeof jQuery == 'undefined'){
	console.log("not ready");
}else{
	console.log("ready");
} */

let _totalPages = totalCount / pageSize;

if(totalCount % pageSize > 0){
	_totalPages++;
}
if($('#pagination').data("twbs-pagination")){
	  $('#pagination').twbsPagination('destroy');}// 페이지 갱신 : 페이징을 갱신해 줘야 번호가 재설정된다.

	$("#pagination").twbsPagination({
		startPage : nowPage,
		totalPages : (_totalPages==0)?1:_totalPages, //전체 페이지
		visiblePages: 10, //최대로 보여줄 페이지
		first: '<span sria-hidden="true">«</span>',
		prev: "이전",
		next: "다음",
		last: '<span sria-hidden="true">»</span>',
		initiateStartPageClick:false,
		onPageClick: function(event,page){
			//alert(page);
			location.href = "campinglist.do?pageNumber=" + (page - 1);
		}

	});
});
</script>
</body>
</html>
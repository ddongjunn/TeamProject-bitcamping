<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href = "campingmap.do">지도로 가기</a>
<table class = "list_table" style = "width : 85%" id = "_list_table">
<colgroup>
	<col style = "width : 70px">
	<col style = "width : 80px">
	<col style = "width : 50px">
	<col style = "width : 100px">
</colgroup>

	<tr>
		<th>번호</th><th>사진</th><th>캠핑장 이름</th><th>주소</th>
	</tr>
	<c:if test = "${empty campinglist}">
	<tr>
		<td colspan = "3">작성된 글이 없습니다</td>
	</tr>
	</c:if>

	<c:forEach items = "${campinglist}" var = "camping" varStatus = "i">
		<tr>
			
			<td>${i.count}</td>
			<td><img src = ${camping.firstimageurl} onerror="this.src='<%=request.getContextPath()%>/resources/image/csite_alt_image.png'"
				width = "300" height = "200"></td>
			<td><a href = "campingdetail.do?contentid=${camping.contentid}">${camping.facltnm}</a></td>
			<td> ${camping.addr1}</td>
		</tr>
	</c:forEach>
</table>

<div class="container" style = "float : left; width : 100%; text-align : center">
    <div style = "display : inline-block">
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination"></ul>
    </nav>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function () {
//jQuery(document).ready(function($){
let totalCount = ${campingPage};	// 서버로부터 총글의 수를 취득
//alert(totalCount);
let nowPage = ${pageNumber};	// 서버로부터 현재 페이지를 취득
//alert(nowPage);

let pageSize = 10;//페이지의 크기(1~10) [1] ~ [10]

let _totalPages = totalCount / pageSize;
if(totalCount % pageSize > 0){
	_totalPages++;
}
if($('#pagination').data("twbs-pagination")){
	  $('#pagination').twbsPagination('destroy');}// 페이지 갱신 : 페이징을 갱신해 줘야 번호가 재설정된다.
(function($){
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
	})(jQuery);
	});
});
</script>
</body>
</html>
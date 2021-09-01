<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--
  Created by IntelliJ IDEA.
  User: djlee
  Date: 2021-08-15
  Time: 오후 8:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <title>Title</title>
</head>
<body>
<div class="mypage_board">
	    <h2 class="title">
	        캠핑장 리뷰
	    </h2>
	
	<div class="table-responsive">
	    <div>
	        <table class="table align-items-center">
	            <thead class="">
	            <tr class="table_top">
	                <td>번호</td>
	                <td>캠핑장</td>
	                <td>제목</td>
	                <td>작성자</td>
	                <td>조회수</td>
	                <td>좋아요</td>
	                <td>작성일</td>
	            </tr>
	            </thead>
	            <tbody class="list">
	            <c:if test="${empty list}">
	                <tr>
	                    <td colspan="5" style="text-align: center">
	                        작성된 게시글이 없습니다.
	                    </td>
	                </tr>
	            </c:if>
	            <c:forEach var="data" items="${list}">
	                <tr>
	                    <td>${data.review_seq}</td>
	                    <td>${data.campingName}</td>
	                    <td>
	                        <a href='${pageContext.request.contextPath}/csite/campingdetailreview.do?review_seq=${data.review_seq}&contentid=${data.contentid}'>
	                                ${data.title}
	                        </a>
	                        <span style="font-size: 13px; color: tomato;">[${data.commentCount}]</span>
	                    </td>
	
	                    <td>${data.nickname}</td>
	                    <td>${data.readcount}</td>
	                    <td>${data.like_count}</td>
	                    <td>
	                        <fmt:formatDate value="${data.wdate}" pattern="yyyy/MM/dd"/>
	                    </td>
	                </tr>
	            </c:forEach>
	            </tbody>
	        </table>
	    </div>
	</div>
	
	<div class="container"> <!-- style = "width : 100%; text-align : center" -->
	    <!--  <div style = "display : inline-block"> -->
	    <nav aria-label="Page navigation">
	        <ul class="pagination justify-content-center" id="pagination"></ul>
	    </nav>
	</div>
	
	
	<div class="row" style="justify-content: space-between; width: 350px; margin: auto">
	    <select id="_choice" name="choice" class="form-control form-control-sm" style="width: 90px">
	        <option value="" selected="selected">선택</option>
	        <option value="title">제목</option>
	        <option value="content">내용</option>
	        <option value="name">캠핑장</option>
	    </select>
	    <input type="text" id="_search" name="search" placeholder="검색" class="form-control form-control-sm" style="width: 200px">
	    <button type="button" id="btnSearch" class="btn btn-outline-primary btn-sm">검색</button>
	</div>
</div>
<script type="text/javascript">

    $(document).ready(function () {

        let choice = '${choice}';
        let search = '${search}';

        //페이지네이션
        let totalCount = ${totalCount};	// 서버로부터 총글의 수를 취득
        //alert(totalCount);

        let nowPage = ${nowPage};	// 서버로부터 현재 페이지를 취득
        //alert(nowPage);

        let pageSize = 15;//페이지의 크기(1~10) [1] ~ [10]

        if(totalCount === 0){
            totalCount = 1;
        }
        let totalPages = totalCount / pageSize;

        if(totalCount % pageSize > 0){
            totalPages++;
        }

        /*페이지 갱신 : 페이징을 갱신해 줘야 번호가 재설정된다.*/
        if($('#pagination').data("twbs-pagination")){
            $('#pagination').twbsPagination('destroy');
        }

        $("#pagination").twbsPagination({
            startPage : nowPage,
            totalPages : totalPages, //전체 페이지
            visiblePages: 10, //최대로 보여줄 페이지
            first: '<span sria-hidden="true">«</span>',
            prev: "이전",
            next: "다음",
            last: '<span sria-hidden="true">»</span>',
            initiateStartPageClick:false,
            onPageClick: function(event,page){
                location.href = "/account/camping-review.do?" + "pageNumber=" + (page - 1) + "&choice=" + choice + "&search=" + search;
            }
        });

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

            location.href = "/account/camping-review.do?" + "choice=" + $("#_choice").val() + "&search=" + $("#_search").val();
        });
    });
</script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>

<div class="container-fluid" >
    <h2>중고거래</h2>
</div>

<div class="container-fluid">
    <a href="/admin/community-deal.do" class="badge badge-pill badge-default">전체글</a>
    <a href="/admin/community-deal.do?kind=sell"
       class="badge badge-pill badge-danger">팝니다</a> <a
        href="/admin/community-deal.do?kind=buy"
        class="badge badge-pill badge-success">삽니다</a>
</div>
<br>

<!-- 글 작성 리스트 틀-->
<div align="table-responsive">
    <table class="table align-items-center">
        <thead class="thead-light">
        <tr>
            <th>번호</th>
            <th>상태</th>
            <th>제목</th>
            <th>작성자</th>
            <th>조회수</th>
            <th>작성일</th>
        </tr>
        <c:if test="${empty dealList}">
            <td colspan="3">작성된 글이 없습니다</td>
        </c:if>
        <c:forEach var="data" items="${dealList}">
            <tr>
                <td>${data.community_seq }</td>
                <td>
                    <c:choose>
                        <c:when test="${data.bbstype eq 'buy'}">
                            <span style="font-size: 13px; color: red;">[삽니다]</span>
                        </c:when>
                        <c:when test="${data.bbstype eq 'sell'}">
                            <span style="font-size: 13px; color: orange;">[팝니다]</span>
                        </c:when>
                        <c:otherwise>
                            <span style="font-size: 13px; color: blue;">[거래완료]</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <a href="/community/dealDetail.do?community_seq=${data.community_seq }">
                            ${data.title}
                        <span style="font-size: 13px; color: tomato;">[${data.commentcount}]</span>
                    </a>
                </td>
                <td>${data.nickname}</td>
                <td>${data.readcount}</td>
                <td>
                    <fmt:parseDate value="${data.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
                    <fmt:formatDate value="${formatedDate}" pattern="yyyy.MM.dd HH:mm"/>
                </td>
            </tr>
        </c:forEach>
        </thead>
    </table>
</div>

<div class="container"> <!-- style = "width : 100%; text-align : center" -->
    <!--  <div style = "display : inline-block"> -->
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center" id="pagination"></ul>
    </nav>
</div>

<!-- 글검색 -->
<div class="row" style="justify-content: space-between; width: 350px; margin: auto">
    <select id="_choice" name="choice" class="form-control form-control-sm" style="width: 90px">
        <option value="" selected="selected">선택</option>
        <option value="title">제목</option>
        <option value="content">내용</option>
        <option value="writer">작성자</option>
    </select>
    <input type="text" id="_search" name="search" placeholder="검색" class="form-control form-control-sm" style="width: 200px">
    <button type="button" id="btnSearch" class="btn btn-outline-primary btn-sm">검색</button>
</div>

<script type="text/javascript">
    $(document).ready(function () {

        let choice = '${choice}';
        let search = '${search}';
        let kind = '${kind}';

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
                location.href = "/admin/community-deal.do?kind=" + kind + "&choice=" + choice + "&search=" + search + "&pageNumber=" + (page - 1);
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

            location.href = "/admin/community-deal.do?kind=" + kind  + "&choice=" + $("#_choice").val() + "&search=" + $("#_search").val();
        });
    });
</script>

</body>
</html>
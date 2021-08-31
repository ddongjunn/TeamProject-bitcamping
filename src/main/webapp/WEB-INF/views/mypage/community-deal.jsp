<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>

<h1>중고거래 게시판</h1>

<div class="container-fluid">
    <a href="/account/community-deal.do" class="badge badge-pill badge-default">전체글</a>
    <a href="/account/community-deal.do?kind=sell"
       class="badge badge-pill badge-danger">팝니다</a> <a
        href="/account/community-deal.do?kind=buy"
        class="badge badge-pill badge-success">삽니다</a>
</div>
<br>

<!-- 글 작성 리스트 틀-->
<div align="center">
    <table>
        <colgroup>
            <col style="width: 5%;" />
            <col style="width: 15%;" />
            <col style="width: auto;" />
            <col style="width: 15%;" />
            <col style="width: 10%;" />
            <col style="width: 15%;" />
        </colgroup>
        <thead>
        <tr>
            <td>번호</td>
            <td>상태</td>
            <td>제목</td>
            <td>조회수</td>
            <td>작성일</td>
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
                        <c:if test="${data.commentcount ne 0}">
                            <span style="font-size: 13px; color: tomato;">[${data.commentcount}]</span>
                        </c:if>
                    </a>
                </td>
                <td>${data.readcount }</td>
                <td>
                    <fmt:parseDate value="${data.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
                    <fmt:formatDate value="${formatedDate}" pattern="yyyy.MM.dd HH:mm"/>
                </td>
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
    </select>
    <input type="text" id="_search" name="search" placeholder="검색내용입력">
    <button type="button" id="btnSearch">검색</button>
</div>
<br>

<!-- 페이지네이션 -->
<div class="container" style="text-align: center">
    <div style="display: inline-block">
        <nav aria-label="Page navigation">
            <ul class="pagination" id="pagination"></ul>
        </nav>
    </div>
</div>

<!-- 글쓰기 버튼 -->
<div align="right">
    <a href="/community/dealWrite.do">글쓰기</a>
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
                location.href = "/account/community-deal.do?kind=" + kind + "&choice=" + choice + "&search=" + search + "&pageNumber=" + (page - 1);
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

            location.href = "/account/community-deal.do?kind=" + kind  + "&choice=" + $("#_choice").val() + "&search=" + $("#_search").val();
        });
    });
</script>

</body>
</html>
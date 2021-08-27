<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
    <title>Title</title>
</head>
<body>
<c:choose>
    <c:when test="${bbstype eq 'hello'}">
        <h2>가입인사</h2>
    </c:when>
    <c:when test="${bbstype eq 'free'}">
        <h2>자유게시판</h2>
    </c:when>
    <c:when test="${bbstype eq 'deal'}">
        <h2>중고거래</h2>
    </c:when>
    <c:when test="${bbstype eq 'review'}">
        <h2>캠핑&여행후기</h2>
    </c:when>
    <c:otherwise>
        <h2>캠핑장리뷰</h2>
    </c:otherwise>
</c:choose>
<div>
    <c:choose>
    <c:when test="${empty list}">
        <h1>작성하신 글이 없습니다.</h1>
    </c:when>
    <c:otherwise>
        <table border="1" style="width: 70%">
            <colgroup>
                <col style="width:10%;" />
                <col style="width:auto;" />
                <col style="width:15%;" />
                <col style="width:20%;" />
            </colgroup>

            <thead>
            <tr>
                <th>번호</th><th>제목</th><th>조회수</th><th>작성일</th>
            </tr>
            </thead>

            <tbody>
                <c:forEach var="data" items="${list}">
                    <c:if test="${data.del != '1'}">
                        <tr>
                            <td>${data.community_seq }</td>

                            <!-- bbstype에 따라서 if문으로 걸러줘야함 -->
                            <c:if test="${bbstype eq 'free'}">
                                <td><a href="/community/freeDetail.do?community_seq=${data.community_seq}">${data.title}</a></td>
                            </c:if>
                            <c:if test="${bbstype eq 'find'}">
                                <td><a href="/community/findDetail.do?community_seq=${data.community_seq}">${data.title}</a></td>
                            </c:if>
                            <c:if test="${bbstype eq 'deal'}">
                                <td><a href="/community/dealDetail.do?community_seq=${data.community_seq}">${data.title}</a></td>
                            </c:if>
                            <c:if test="${bbstype eq 'review'}">
                                <td><a href="/community/reviewDetail.do?community_seq=${data.community_seq}">${data.title}</a></td>
                            </c:if>
                            <c:if test="${bbstype eq 'hello'}">
                                <td><a href="/community/helloDetail.do?community_seq=${data.community_seq}">${data.title}</a></td>
                            </c:if>

                            <td>${data.readcount}</td>
                            <td>
                                <c:set var="date" value="${data.wdate}"/>
                                    ${fn:substring(date,2,16)}
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
    </c:otherwise>
    </c:choose>
</div>

<div class="container"> <!-- style = "width : 100%; text-align : center" -->
    <!--  <div style = "display : inline-block"> -->
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination"></ul>
    </nav>
</div>


<div align="center">
    <select id="_choice" name="choice">
        <option value="" selected="selected">선택</option>
        <option value="title">제목</option>
        <option value="content">내용</option>
    </select>
    <input type="text" id="_search" name="search" placeholder="검색">
    <button type="button" id="btnSearch">검색</button>
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
        if(totalCount === 0){
            totalCount = 1;
        }

        let pageSize = 15;//페이지의 크기(1~10) [1] ~ [10]

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
                location.href = "/account/community.do?bbstype=" + '${bbstype}' + "&pageNumber=" + (page - 1) + "&choice=" + choice + "&search=" + search;
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

            location.href = "/account/community.do?bbstype=" + '${bbstype}' + "&choice=" + $("#_choice").val() + "&search=" + $("#_search").val();
        });
    });
</script>
</body>
</html>

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
    <title>Title</title>
</head>
<body>
<c:choose>
    <c:when test="${bbstype eq 'hello'}">
        <div class="container-fluid" >
            <h2>가입인사</h2>
        </div>
    </c:when>
    <c:when test="${bbstype eq 'free'}">
        <div class="container-fluid" >
            <h2>자유게시판</h2>
        </div>
    </c:when>
    <c:when test="${bbstype eq 'review'}">
        <div class="container-fluid" >
            <h2>캠핑&여행후기</h2>
        </div>
    </c:when>
    <c:otherwise>
        <div class="container-fluid" >
            <h2>캠퍼모집</h2>
        </div>
    </c:otherwise>
</c:choose>
<div class="table-responsive">
    <div>
        <table class="table align-items-center">
            <thead class="thead-light">
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
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
                    <c:if test="${data.del != '1'}">
                        <tr>
                            <td>${data.community_seq }</td>

                            <!-- bbstype에 따라서 if문으로 걸러줘야함 -->
                            <c:if test="${bbstype eq 'free'}">
                                <td><a href="/community/freeDetail.do?community_seq=${data.community_seq}">${data.title}</a>
                            </c:if>
                            <c:if test="${bbstype eq 'find'}">
                                <td><a href="/community/findDetail.do?community_seq=${data.community_seq}">${data.title}</a>
                            </c:if>
                            <c:if test="${bbstype eq 'deal'}">
                                <td><a href="/community/dealDetail.do?community_seq=${data.community_seq}">${data.title}</a>
                            </c:if>
                            <c:if test="${bbstype eq 'review'}">
                                <td><a href="/community/reviewDetail.do?community_seq=${data.community_seq}">${data.title}</a>
                            </c:if>
                            <c:if test="${bbstype eq 'hello'}">
                                <td><a href="/community/helloDetail.do?community_seq=${data.community_seq}">${data.title}</a>
                            </c:if>

                            <span style="font-size: 13px; color: tomato;">[${data.commentcount}]</span>
                            </td>

                            <td>${data.nickname}</td>
                            <td>${data.readcount}</td>
                            <td>
                                <fmt:parseDate value="${data.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
                                <fmt:formatDate value="${formatedDate}" pattern="yyyy.MM.dd HH:mm"/>
                            </td>
                        </tr>
                    </c:if>
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
        <option value="writer">작성자</option>
    </select>
    <input type="text" id="_search" name="search" placeholder="검색" class="form-control form-control-sm" style="width: 200px">
    <button type="button" id="btnSearch" class="btn btn-outline-primary btn-sm">검색</button>
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
                location.href = "/admin/community.do?bbstype=" + '${bbstype}' + "&pageNumber=" + (page - 1) + "&choice=" + choice + "&search=" + search;
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

            location.href = "/admin/community.do?bbstype=" + '${bbstype}' + "&choice=" + $("#_choice").val() + "&search=" + $("#_search").val();
        });
    });
</script>
</body>
</html>

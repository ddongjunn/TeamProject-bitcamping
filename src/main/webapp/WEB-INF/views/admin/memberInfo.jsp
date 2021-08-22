<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: 이동준
  Date: 2021-08-19
  Time: 오후 11:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

</head>
<body>
<div>
    <h2>회원정보</h2>
    <c:choose>
        <c:when test="${empty list}">
            <h1>회원이 없습니다.</h1>
        </c:when>
        <c:otherwise>
            <table border="1" style="width: 100%">
                <colgroup>
                    <col style="width:10%;" />
                    <col style="width:auto;" />
                    <col style="width:8%;" />
                    <col style="width:10%;" />
                    <col style="width:11%;" />
                    <col style="width:16%;" />
                    <col style="width:9%;" />
                </colgroup>

                <thead>
                <tr>
                    <th>가입경로</th><th>아이디</th><th>이름</th><th>닉네임</th><th>핸드폰</th><th>이메일</th><th>가입일</th><th>상태</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="list" items="${list}">
                    <tr>
                        <td>
                            <c:if test="${list.sns_Type eq 'naver'}">
                                네이버
                            </c:if>
                            <c:if test="${list.sns_Type eq 'kakao'}">
                                카카오
                            </c:if>
                            <c:if test="${list.sns_Type eq 'none'}">
                                자사
                            </c:if>
                        </td>
                        <td>${list.id}</td>
                        <td>${list.username}</td>
                        <td>${list.nickname}</td>
                        <td>${list.phone}</td>
                        <td>${list.email}</td>
                        <td>
                            <c:set var="date" value="${list.create_Date}"/>
                                ${fn:substring(date,0,11)}
                        </td>
                        <td>
                            <c:if test="${list.auth == '0'}">
                                활동
                            </c:if>
                            <c:if test="${list.auth == '1'}">
                                탈퇴
                            </c:if>
                        </td>

                    </tr>
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
        <option value="id">아이디</option>
        <option value="username">이름</option>
        <option value="nickname">닉네임</option>
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
                location.href = "/admin/memberInfo.do?&pageNumber=" + (page - 1) + "&choice=" + choice + "&search=" + search;
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

            location.href = "/admin/memberInfo.do?choice=" + $("#_choice").val() + "&search=" + $("#_search").val();
        });
    });
</script>
</body>
</html>

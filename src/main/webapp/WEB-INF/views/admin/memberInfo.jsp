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
    <style>
        .swal-wide{
            width: 700px !important;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <h2>회원정보</h2>
</div>

<div class="table-responsive">
    <div>
        <table class="table align-items-center">
            <thead class="thead-light">
            <tr>
                <th scope="col">가입경로</th>
                <th scope="col" width="360px">아이디</th>
                <th scope="col">이름</th>
                <th scope="col">닉네임</th>
                <th scope="col">핸드폰</th>
                <th scope="col">이메일</th>
                <th scope="col">가입일</th>
                <th scope="col">상태</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody class="list">
            <c:if test="${empty list}">
                <tr>
                    <td colspan="7" style="text-align: center">
                        해당 조건의 회원이 없습니다.
                    </td>
                </tr>
            </c:if>
            <c:forEach var="list" items="${list}">
                <tr>
                    <th scope="row">
                        <c:if test="${list.sns_Type eq 'naver'}">
                            네이버
                        </c:if>
                        <c:if test="${list.sns_Type eq 'kakao'}">
                            카카오
                        </c:if>
                        <c:if test="${list.sns_Type eq 'none'}">
                            자사
                        </c:if>
                    </th>

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
                        <c:if test="${list.auth eq 0}">
                            <span class="badge badge-dot mr-4">
                                <i class="bg-success"></i>
                                <span class="status">활동</span>
                            </span>
                        </c:if>
                        <c:if test="${list.auth eq -1}">
                            <span class="badge badge-dot mr-4">
                                <i class="bg-warning"></i>
                                <span class="status">탈퇴</span>
                            </span>
                        </c:if>
                        <c:if test="${list.auth eq 1}">
                            <span class="badge badge-dot mr-4">
                                <i class="bg-primary"></i>
                                <span class="status">관리자</span>
                            </span>
                        </c:if>
                        <c:if test="${list.auth eq -2}">
                            <span class="badge badge-dot mr-4">
                                <i class="bg-dark"></i>
                                <span class="status">블랙</span>
                            </span>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${list.auth eq -2}">
                            <button type="button" class="btn btn-outline-danger btn-sm" onclick="restoreMember('${list.id}','${list.username}','${list.nickname}')">복구</button>
                        </c:if>
                        <c:if test="${list.auth eq 0}">
                            <button type="button" class="btn btn-danger btn-sm" onclick="stopMember('${list.id}','${list.username}','${list.nickname}')">블랙</button>
                        </c:if>
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


<div class="row" style="justify-content: space-between; width: 350px; margin:auto">
    <select id="_choice" name="choice" class="form-control form-control-sm" style="width: 90px">
        <option value="" selected="selected">선택</option>
        <option value="id">아이디</option>
        <option value="username">이름</option>
        <option value="nickname">닉네임</option>
    </select>
    <input type="text" id="_search" name="search" placeholder="검색" class="form-control form-control-sm"
           style="width: 200px">
    <button type="button" id="btnSearch" class="btn btn-outline-primary btn-sm ">검색</button>
</div>

<script type="text/javascript">

    $(document).ready(function () {

        let choice = '${choice}';
        let search = '${search}';

        //페이지네이션
        let totalCount = ${totalCount};	// 서버로부터 총글의 수를 취득
        //alert(totalCount);
        if(totalCount === 0){
            totalCount = 1;
        }

        let nowPage = ${nowPage};	// 서버로부터 현재 페이지를 취득
        //alert(nowPage);

        let pageSize = 15;//페이지의 크기(1~10) [1] ~ [10]

        let totalPages = totalCount / pageSize;

        if (totalCount % pageSize > 0) {
            totalPages++;
        }

        /*페이지 갱신 : 페이징을 갱신해 줘야 번호가 재설정된다.*/
        if ($('#pagination').data("twbs-pagination")) {
            $('#pagination').twbsPagination('destroy');
        }

        $("#pagination").twbsPagination({
            startPage: nowPage,
            totalPages: totalPages, //전체 페이지
            visiblePages: 10, //최대로 보여줄 페이지
            first: '<span sria-hidden="true">«</span>',
            prev: "이전",
            next: "다음",
            last: '<span sria-hidden="true">»</span>',
            initiateStartPageClick: false,
            onPageClick: function (event, page) {
                location.href = "/admin/memberInfo.do?&pageNumber=" + (page - 1) + "&choice=" + choice + "&search=" + search;
            }
        });

        $("#btnSearch").click(function () {

            if ($('#_choice').val() === "") {
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

            } else if ($('#_search').val() === "") {
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

    function stopMember(id,username,nickname){

        Swal.fire({
            title:'블랙리스트 등록',
            html: '<div style="text-align: center"> 아이디 : ' + id  + '<br>이름 : ' + username  +'<br>닉네임 : ' + nickname + '</div>',
            customClass: 'swal-wide',
            showCancelButton: true,
            confirmButtonText: `등록`,
            cancelButtonText: '취소',
        }).then((result) => {
            if (result.isConfirmed) {

                $.ajax({
                    url : '/admin/stop-member.do',
                    data : { 'id' : id } ,
                    success : function(xh){
                        history.go(0);
                    },

                });
            }
        })
    }
    function restoreMember(id,username,nickname){
        Swal.fire({
            title:'블랙리스트 복구',
            html: '<div style="text-align: center"> 아이디 : ' + id  + '<br>이름 : ' + username  +'<br>닉네임 : ' + nickname + '</div>',
            customClass: 'swal-wide',
            showCancelButton: true,
            confirmButtonText: `복구`,
            cancelButtonText: '취소',
        }).then((result) => {
            if (result.isConfirmed) {

                $.ajax({
                    url : '/admin/restore-member.do',
                    data : { 'id' : id } ,
                    success : function(xh){
                        history.go(0);
                    },

                });
            }
        })
    }
</script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

</head>
<body>

<div class="container-fluid">
    <a href="/admin/qna.do" class="badge badge-pill badge-default">전체글</a>
    <a href="/admin/qna.do?kind=wait" class="badge badge-pill badge-danger">답변대기중</a>
    <a href="/admin/qna.do?kind=complete" class="badge badge-pill badge-success">답변완료</a>
</div>
<br>

<div class="table-responsive">
    <div>
<table class="table align-items-center">

    <colgroup> 
        <col width="10%">
        <col width="10%">
        <col width="45%">
        <col width="10%">
        <col width="15%">
        <col width="10%">
    </colgroup>

    <thead>
    <tr>
        <th>글번호</th> <th>답변상태</th> <th>제목</th> <th>작성자</th> <th>작성일</th> <th>조회수</th>
    </tr>
    </thead>


    <tbody class="list">
    <c:if test="${empty qna}">
        <tr>
            <td colspan="6" style="text-align: center">
            작성된 게시글이 없습니다.
            </td>
        </tr>
    </c:if>
    <c:forEach items="${qna}" var="qna" varStatus="i">
        <tr>
            <td>${qna.qna_Seq}</td>
            <td>
                <c:choose>
                    <c:when test="${qna.status eq 0}">
                        [답변대기중]
                    </c:when>
                    <c:otherwise>
                        [답변완료]
                    </c:otherwise>
                </c:choose>
            </td>
            <td style="text-align: left;">
                <c:choose>
                    <c:when test="${qna.secret eq 0}">
                        <a href="/cs/qnaDetail.do?qna_Seq=${qna.qna_Seq}">
                                ${qna.title}
                        </a>
                    </c:when>
                    <c:otherwise>

                        <c:choose>
                            <c:when test="${login.id eq qna.user_Id || login.auth eq 1}">
                                <a href="/cs/qnaDetail.do?qna_Seq=${qna.qna_Seq}">
                                        ${qna.title}
                                </a> 🔒
                            </c:when>
                            <c:otherwise>
                                <a href="javascript:noPermission();">
                                        ${qna.title}
                                </a> 🔒
                            </c:otherwise>
                        </c:choose>

                    </c:otherwise>
                </c:choose>
            </td>
            <td>${qna.nickname}</td>
            <td>
                <fmt:parseDate value="${qna.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
                <fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd"/>
            </td>
            <td>${qna.readcount}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
    </div>
</div>


<!-- pagination -->
<div class="container">
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination" style="justify-content: center;"></ul>
    </nav>
</div>

<!-- 검색 -->
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

        let search = "${search}";
        let choice = "${choice}";
        let kind = "${kind}";

        let totalCount = ${totalCount};	// 서버로부터 총글의 수를 취득
        //alert(count);
        if(totalCount === 0){
            totalCount = 1;
        }

        let nowPage = ${pageNumber};	// 서버로부터 현재 페이지를 취득
        //alert(pageNum);

        let pageSize = 15;

        let _totalPages = totalCount / pageSize;
        if (totalCount % pageSize > 0) {
            _totalPages++;
        }

        //$("#pagination").twbsPagination('destroy');	// 페이지 갱신 : 페이징을 갱신해 줘야 번호가 재설정된다.

        $("#pagination").twbsPagination({
            startPage: nowPage,
            totalPages: _totalPages,
            visiblePages: 10,
            first: '<span sria-hidden="true">«</span>',
            prev: "이전",
            next: "다음",
            last: '<span sria-hidden="true">»</span>',
            initiateStartPageClick: false,		// onPageClick 자동 실행되지 않도록 한다
            onPageClick: function (event, page) {
                location.href = "/admin/qna.do?kind=" + kind + "&search=" + $("#_search").val() + "&choice=" + $("#_choice").val() + "&pageNumber=" + (page - 1);
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

            location.href = "/admin/qna.do?kind=" + kind + "&search=" + $("#_search").val() + "&choice=" + $("#_choice").val();

        });
    });

</script>

</body>
</html>
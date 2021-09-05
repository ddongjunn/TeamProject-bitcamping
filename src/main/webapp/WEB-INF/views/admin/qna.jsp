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

<div class="container-fluid" >
    <h2>고객센터 Q&A</h2>
</div>

<div class="container-fluid">
    <a href="/admin/qna.do" class="badge badge-pill badge-default">전체글</a>
    <a href="/admin/qna.do?kind=wait" class="badge badge-pill badge-danger">답변대기중</a>
    <a href="/admin/qna.do?kind=complete" class="badge badge-pill badge-success">답변완료</a>
</div>
<br>

<div class="table-responsive">
    <div>
        <table class="table align-items-center">

            <thead>
            <tr>
                <th width="70px">글번호</th> <th width="120px">답변상태</th> <th width="400px" >문의내용</th>
                <th>작성자</th> <th>작성일</th> <th></th>
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
                <tr id="tr${qna.qna_Seq}">
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
                    <td style="max-width: 400px">
                        <c:choose>
                            <c:when test="${qna.secret eq 0}">
                                <span id="qnatitle${qna.qna_Seq}" onclick="showHideQna('${qna.qna_Seq}')" style=""> ${qna.title}</span>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${login.id eq qna.user_Id || login.auth eq 1}">
                                        <span id="qnatitle${qna.qna_Seq}" onclick="showHideQna('${qna.qna_Seq}')">${qna.title}</span> 🔒
                                    </c:when>
                                    <c:otherwise>
                                        <span id="qnatitle'${qna.qna_Seq}'" onclick="showHideQna('${qna.qna_Seq}')">${qna.title}</span> 🔒
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${qna.nickname}</td>
                    <td>
                        <fmt:parseDate value="${qna.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
                        <fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd HH:mm"/>
                    </td>
                    <c:if test="${qna.status == 0}">
                        <td>
                            <button type="button" class="btn btn-primary btn-sm" onclick="writeqna('${qna.qna_Seq}')">답변</button>
                        </td>
                    </c:if>
                    <c:if test="${qna.status == 1}">
                        <td>
                            <button type="button" class="btn btn-secondary btn-sm" disabled)>답변완료</button>
                        </td>
                    </c:if>
                </tr>

                <tr id="qnacontent${qna.qna_Seq}" class="qnacontent" style="display:none;">
                    <td>
                    </td>
                    <td>
                    </td>
                    <td colspan="3">
                        &nbsp;&nbsp;&nbsp; ${qna.content}
                        <c:if test="${qna.status == 1}">
                            <hr>
                            <span class="badge badge-secondary">답변</span> ${qna.answercontent}
                        </c:if>
                    </td>
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

    function showHideQna(seq){

        if($("#qnacontent"+seq).css("display") == "none"){
            $("#qnacontent"+seq).show();
        }else{
            $("#qnacontent"+seq).hide();
        }
    }

    function writeqna(qna_Seq){

    	let popupWidth = 500;
		let popupHeight = 580;

        let popupX = (window.screen.width / 2) - (popupWidth / 2);
        // 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

        let popupY= (window.screen.height / 2) - (popupHeight / 2);
        // 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음

        window.open("/rent/writeCsQna.do?qna_Seq=" + qna_Seq + "&user_Id=" + '${login.id}', " _blank", "location=no, status=no, resizable=no, height=" + popupHeight  + ", width=" + popupWidth  + ", left=" + popupX + ", top=" + popupY);
    }

    function writeQnaAf(qna_Seq){
        $("#tr"+qna_Seq).hide();
        $('#qnacontent'+qna_Seq).hide();
    }


</script>

</body>
</html>
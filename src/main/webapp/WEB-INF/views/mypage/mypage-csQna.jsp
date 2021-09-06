<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <title>Insert title here</title>

</head>
<body>
<div class="mypage_board">
	    <h2 class="title">
	        Q&A
	    </h2>
	<div class="container-fluid">
	    <a href="/account/qna.do" class="badge badge-pill badge-default">전체글</a>
	    <a href="/account/qna.do?kind=wait" class="badge badge-pill badge-danger">답변대기중</a>
	    <a href="/account/qna.do?kind=complete" class="badge badge-pill badge-success">답변완료</a>
	</div>
	<br>
	
	<div class="table-responsive">
	    <div>
	        <table class="table align-items-center" style="text-align: center;">
	        
	        	<col width="10%">
	        	<col width="10%">
	        	<col width="60%">
	        	<col width="20%">
	
	            <thead>
	            <tr class="table_top" style="color: white;">
	                <td>글번호</td> <td>답변상태</td> <td>문의내용</td> <td>작성일</td>
	            </tr>
	            </thead>
	
	            <tbody class="list">
	            <c:if test="${empty qna}">
	                <tr>
	                    <td colspan="4" style="text-align: center">
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
	                                <span class="badge badge-pill badge-danger">답변대기중</span>
	                            </c:when>
	                            <c:otherwise>
	                                <span class="badge badge-pill badge-success">답변완료</span>
	                            </c:otherwise>
	                        </c:choose>
	                    </td>
	                    <td style="text-align: left;">
	                        <c:choose>
	                            <c:when test="${qna.secret eq 0}">
	                                <span id="qnatitle${qna.qna_Seq}" onclick="showHideQna('${qna.qna_Seq}')" style=""> ${qna.title}</span>
	                            </c:when>
	                            <c:otherwise>
	                                <span id="qnatitle'${qna.qna_Seq}'" onclick="showHideQna('${qna.qna_Seq}')">${qna.title}</span> 🔒
	                            </c:otherwise>
	                        </c:choose>
	                    </td>
	                    <td>
	                        <fmt:parseDate value="${qna.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
	                        <fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd HH:mm"/>
	                    </td>
	                </tr>
	
	                <tr id="qnacontent${qna.qna_Seq}" class="qnacontent" style="display:none; background-color: #f0f0f0;">
	                    <td></td>
	                    <td></td>
	                    <td colspan="2" style="text-align: left; line-height: 24px;">
	                        ${qna.content}
	                        <c:if test="${qna.status == 1}">
	                             <br>
	                            ㄴ<span class="badge badge-secondary">비트캠핑 </span> ${qna.answercontent}
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
</div>
<script type="text/javascript">

    $(document).ready(function () {

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
                location.href = "/account/qna.do?kind=" + kind + "&pageNumber=" + (page - 1);
            }
        });


    });

    function showHideQna(seq){

        if($("#qnacontent"+seq).css("display") == "none"){
            $("#qnacontent"+seq).show();
        }else{
            $("#qnacontent"+seq).hide();
        }
    }

</script>

</body>
</html>
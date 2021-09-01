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
	        상품정보 Q&A
	    </h2>
	<div class="container-fluid">
	    <a href="/account/product-qna.do" class="badge badge-pill badge-default">전체글</a>
	    <a href="/account/product-qna.do?kind=wait" class="badge badge-pill badge-danger">답변대기중</a>
	    <a href="/account/product-qna.do?kind=complete" class="badge badge-pill badge-success">답변완료</a>
	</div>
	<br>
	
	<div class="table-responsive">
	    <div>
	        <table class="table align-items-center">
	
	            <thead>
	            <tr class="table_top">
	                <td width="90px">글번호</td> <td width="120px">답변상태</td> <td width="400px" >문의내용</td>
	                <td>작성일</td>
	            </thead>
	
	            <tbody class="">
	            <c:if test="${empty qna}">
	                <tr>
	                    <td colspan="5" style="text-align: center">
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
	                    <td style="max-width: 400px">
	                        <c:choose>
	                            <c:when test="${qna.secret eq 0}">
	                                <span id="qnatitle${qna.qna_Seq}" onclick="showHideQna('${qna.qna_Seq}')"> ${qna.title}</span>
	                            </c:when>
	                            <c:otherwise>
	                                <span id="qnatitle${qna.qna_Seq}" onclick="showHideQna('${qna.qna_Seq}')">${qna.title}</span> 🔒
	                            </c:otherwise>
	                        </c:choose>
	                    </td>
	                    <td>
	                        <fmt:parseDate value="${qna.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
	                        <fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd HH:mm"/>
	                    </td>
	                </tr>
	
	                <tr id="qnacontent${qna.qna_Seq}" class="qnacontent" style="display:none;">
	                    <td></td>
	                    <td>&nbsp;&nbsp;</td>
	                    <td colspan="" style="text-align: center">
	                        &nbsp;&nbsp;&nbsp;ㄴ ${qna.content}
	                        <c:if test="${qna.status == 1}">
	                            <br><br>
	                            <span class="badge badge-secondary">비트캠핑 </span> ${qna.answercontent}
	                        </c:if>
	                    </td>
	                    <td></td>
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

        let pageSize = 10;

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
                location.href = "/account/product-qna.do?kind=" + kind + "&pageNumber=" + (page - 1);
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
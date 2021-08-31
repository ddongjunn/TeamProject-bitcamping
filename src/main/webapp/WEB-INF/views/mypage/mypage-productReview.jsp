<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: djlee
  Date: 2021-08-31
  Time: 오후 4:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div class="table-responsive">
    <div>
        <table class="table align-items-center">
            <thead>
            <tr>
                <td>상품명</td>
                <td>리뷰제목</td>
                <td>작성일</td>
                <td>별점</td>
            </tr>
            </thead>
            <tbody class="list">
            <c:if test="${empty review}">
                <tr>
                    <td colspan="4" style="text-align: center">
                        작성한 리뷰가 없습니다.
                    </td>
                </tr>
            </c:if>

            <c:forEach items="${review}" var="review" varStatus="i">
                <tr id="tr${review.review_Seq}">

                    <td>
                        <a href="/rent/detail.do?product_Seq=${review.product_Seq}">${review.productname}</a>
                    </td>
                    <td style="max-width: 400px">
                        <span id="qnatitle${review.review_Seq}" onclick="showHideQna('${review.review_Seq}')" style="">${review.title}</span>
                    </td>
                    <td>
                        <fmt:parseDate value="${review.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
                        <fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd HH:mm"/>
                    </td>
                    <td>
                        <c:forEach begin="1" end="${review.rate}">
                            ⭐
                        </c:forEach>
                    </td>
                </tr>

                <tr id="reviewcontent${review.review_Seq}" class="qnacontent" style="display:none;">
                    <td></td>
                    <td colspan="1">
                        &nbsp; &nbsp; &nbsp;ㄴ ${review.content}
                    </td>
                    <td></td>
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
                location.href = "/account/product-review.do?pageNumber=" + (page - 1);
            }
        });


    });

    function showHideQna(seq){

        if($("#reviewcontent"+seq).css("display") == "none"){
            $("#reviewcontent"+seq).show();
        }else{
            $("#reviewcontent"+seq).hide();
        }
    }


</script>
</body>
</html>

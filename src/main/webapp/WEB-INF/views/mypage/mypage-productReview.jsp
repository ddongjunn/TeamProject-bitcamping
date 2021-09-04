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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <title>Title</title>
</head>
<body>
<div class="mypage_board">
	    <h2 class="title">
	        상품리뷰
	    </h2>
	<div class="table-responsive">
	    <div>
	        <table class="table">
	            <thead>
	            <tr class="table_top" style="text-align: left">
	                <th>상품명</th>
	                <th>리뷰제목</th>
	                <th>작성일</th>
	                <th>별점</th>
					<th></th>
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
						<td>
							<button type="button" class="btn btn-primary btn-sm" onclick="updateReview(${review.review_Seq})">수정</button>
							<button type="button" class="btn btn-primary btn-sm" onclick="deleteReview(${review.review_Seq})">삭제</button>
						</td>
	                </tr>
	
	                <tr id="reviewcontent${review.review_Seq}" class="qnacontent" style="display:none;">
	                    <td></td>
	                    <td colspan="1">
	                        &nbsp; &nbsp; &nbsp;ㄴ ${review.content}<br>
							<c:if test="${review.image ne null}">
								<img src = "/resources/upload/${review.image}" alt = "상품평 이미지" height = "250px">
							</c:if>
	                    </td>
	                    <td></td>
	                    <td></td>
						<td></td>
	                </tr>
	            </c:forEach>
	            </tbody>
	        </table>
	    </div>
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

	function updateReview(review_Seq){

		let popupWidth = 480;
		let popupHeight = 520;

		let popupX = (window.screen.width / 2) - (popupWidth / 2);
		// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

		let popupY= (window.screen.height / 2) - (popupHeight / 2);
		// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음

		window.open("/account/update-review.do?review_Seq=" + review_Seq, "_blank", "location=no, status=no, resizable=no, height=" + popupHeight  + ", width=" + popupWidth  + ", left=" + popupX + ", top=" + popupY);
	}

	function deleteReview(review_Seq) {
		Swal.fire({
			title: '리뷰를 정말 삭제하시겠어요?',
			showCancelButton: true,
			confirmButtonText: `삭제하기`,
			cancelButtonText: '취소',
		}).then((result) => {
			/* Read more about isConfirmed, isDenied below */
			if (result.isConfirmed) {

				$.ajax({
					url : '/account/delete-review.do',
					data : { 'review_Seq' : review_Seq } ,
					success : function(xh){

						let tr = document.getElementById('tr'+review_Seq);
						let tr2 = document.getElementById('reviewcontent'+review_Seq);
						tr.remove();
						tr2.remove();

					},

				});
			}
		})
	}


</script>
</body>
</html>

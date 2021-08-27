<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" type="text/css" href="/resources/css/rentList-admin.css" />

</head>
<body>

<div class="container mydiv">
    <div class="row">
        <c:forEach items="${list}" var="list">
            <div class="col-md-4">
                <!-- bbb_deals -->
                <div class="bbb_deals" style="margin-bottom: 50px;">
                    <!-- <div class="ribbon ribbon-top-right"><span><small class="cross">x </small>4</span></div> -->
                    <!-- <div class="bbb_deals_title">Today's Combo Offer</div> -->
                    <div style="float: right; z-index: 1;">
                    	<a href="/admin/product-update.do?product_Seq=${list.product_Seq}">수정</a>
                    	<a href="javascript:confirm(${list.product_Seq});">삭제</a>
                    	</div>
                    <div class="bbb_deals_slider_container">
                        <div class=" bbb_deals_item">
                            <div class="bbb_deals_image"><a href="/rent/detail.do?product_Seq=${list.product_Seq}"><img src="/resources/upload/${list.thumbnail_Name}" alt="" height="250px"></a></div>
                            <div class="bbb_deals_content">
                                <div class="bbb_deals_info_line d-flex flex-row justify-content-start">
                                    <div class="bbb_deals_item_name" style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden;"><a href="/rent/detail.do?product_Seq=${list.product_Seq}">${list.product_Name}</a></div>
                                </div>
                                <div class="bbb_deals_info_line d-flex flex-row justify-content-start">
                                    <div class="bbb_deals_item_category" style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">${list.product_Desc}</div>
                                </div>
                                <br>
                                <div class="bbb_deals_info_line d-flex flex-row justify-content-start">
                                    <div class="bbb_deals_item_price_a ml-auto">2박 3일 기준</div>
                                </div>
                                <div class="bbb_deals_info_line d-flex flex-row justify-content-start">
                                    <div class="bbb_deals_item_price ml-auto"><fmt:formatNumber value="${list.product_Price}" type="number"/>원</div>
                                </div>

                                <div class="available">
                                    <div class="available_line d-flex flex-row justify-content-start">
                                        <div class="available_title">현재 상품 재고 <span>${list.product_Stock}</span>개</div>
                                        <div class="sold_stars ml-auto"> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> </div>
                                    </div>
                                    <div class="available_bar"><span style="width:17%"></span></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script type="text/javascript">

	function confirm(product_Seq){
		Swal.fire({
		  title: '삭제하시겠습니까?',
		  showCancelButton: true,
		  confirmButtonText: '삭제하기',
		  denyButtonText: '취소',
		}).then((result) => {
			  if (result.isConfirmed) {
				  location.href="/admin/product-delete.do?product_Seq=" + product_Seq;
			  } else if (result.isDenied) {
			    	return;
			  }
		})
	}

</script>

</body>
</html>
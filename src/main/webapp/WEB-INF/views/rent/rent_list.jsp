<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/resources/css/rentList.css" />
<link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

<style type="text/css">
.star {
  position: relative;
  display: inline-block;
  font-size: 20px;
}

.star-under {
  color: #ddd;
}

.star-over {
  color: #f80;
  overflow: hidden;
  position: absolute;
  top: 0;
  left: 0;
  display: none;
}

.star-visible {
  display: inline-block;
}
</style>

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
	                <div class="bbb_deals_slider_container">
	                    <div class=" bbb_deals_item">
	                        <div class="bbb_deals_image" style="width: 300px; height: 250px;">
	                        	<a href="/rent/detail.do?product_Seq=${list.product_Seq}">
	                        		<img src="/resources/upload/${list.thumbnail_Name}" alt="상품 이미지" style="height: 250px !important;">
	                        	</a>
	                        </div>
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
	                                    <div class="available_title">상품 재고 <span>${list.product_Stock}</span>개</div>
	                                    <div class="sold_stars ml-auto"> 
	                                    	<div id="rating${list.product_Seq}">
										        <i class="star star-under fa fa-star">
												  <i class="star star-over fa fa-star"></i>
												</i>
												<i class="star star-under fa fa-star">
												  <i class="star star-over fa fa-star"></i>
												</i>
												<i class="star star-under fa fa-star">
												  <i class="star star-over fa fa-star"></i>
												</i>
												<i class="star star-under fa fa-star">
												  <i class="star star-over fa fa-star"></i>
												</i>
												<i class="star star-under fa fa-star">
												  <i class="star star-over fa fa-star"></i>
												</i>
										      </div>                                    	
	                                    </div>
	                                    <span>(${list.rate})</span>
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


	
</script>

</body>
</html>
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
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

</head>
<body>

<div class="container mydiv">
	<div class="title">상품 목록</div>
	<div class="total-item">
		총 <span class="c_point f_bold">${totalCount}</span>개의 상품이 있습니다
		<span class="sort-item"> <a href="#none">신상품</a> / <a>상품명</a> / <a>낮은가격</a> / <a>높은가격</a></span>
	</div> 
	
	<hr>
    <div class="item-row">
    	<c:forEach items="${list}" var="list">
	        <div class="col-md-4">       	
	            <!-- bbb_deals -->
	            <div class="bbb_deals" style="margin-bottom: 50px;">
	                <!-- <div class="ribbon ribbon-top-right"><span><small class="cross">x </small>4</span></div> -->
	                <!-- <div class="bbb_deals_title">Today's Combo Offer</div> -->
	                <div class="bbb_deals_slider_container">
	                
	                	<!-- 상품 영역 시작 -->
	                    <div class="bbb_deals_item">
	                    	
	                    	<!-- 상품 이미지 -->
	                        <div class="bbb_deals_image">
	                        	<a href="/rent/detail.do?product_Seq=${list.product_Seq}">
	                        		<img src="/resources/upload/${list.thumbnail_Name}" alt="상품 이미지">
	                        	</a>
	                        </div>
	                        
	                        <!-- 텍스트 영역 -->
	                        <div class="bbb_deals_content">
	                        	<!-- 상품명 -->
	                            <div class="bbb_deals_info_line d-flex flex-row justify-content-start">
	                                <div class="bbb_deals_item_name"><!-- style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden;" -->
	                                	<span class="item-name">
	                                		<a href="/rent/detail.do?product_Seq=${list.product_Seq}">
	                                			${list.product_Name}
	                                		</a>
	                                	</span>	                                	
	                                </div>
	                            </div>
	                            <!-- 상품 설명 -->
	                            <div class="bbb_deals_info_line d-flex flex-row justify-content-start">
	                                <div class="bbb_deals_item_category">
	                                	<span class="item-desc">
	                                		${list.product_Desc}
	                                	</span>
	                                </div>
	                            </div>
	                            
	                            <br>
	                            
	                            <div class="bbb_deals_info_line d-flex flex-row justify-content-start">
	                                <div class="bbb_deals_item_price_a ml-auto">2박 3일 기준</div>
	                            </div>
	                            <!-- 상품 가격 -->
	                            <div class="bbb_deals_info_line d-flex flex-row justify-content-start">
	                                <div class="bbb_deals_item_price ml-auto">
	                              	  <span class="c_tomato f_bold"><fmt:formatNumber value="${list.product_Price}" type="number"/></span>
	                              	  <span class="item-won"> 원</span>
	                                </div>
	                            </div>
								
								<!-- 상품 재고, 평점 -->
	                            <div class="available">
	                                <div class="available_line d-flex flex-row justify-content-start">
	                                	<c:if test="${list.product_Stock ne 0}">
	                                    	<div class="available_title">재고 <span class="c_point">${list.product_Stock}</span>개</div>
	                                    </c:if>
	                                    <c:if test="${list.product_Stock eq 0}">
	                                    	<div class="available_title"><span class="c_point">일시품절</span></div>
	                                    </c:if>
										<div class="sold_stars ml-auto"> 
	                                    	<div id="rating${list.product_Seq}">

										    </div>                                    	
	                                    </div>
	                                    <span class="item-rate">리뷰 ${list.rate}점</span>
	                                </div>
	                                
	                                <div class="available_bar">
	                                	<span style="width:17%"></span>
	                                </div>
	                            </div>
	                            
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>        
        </c:forEach>        
    </div>
</div>

<!-- pagination -->
<div class="container" style="margin: -50px auto 60px auto;">
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination" style="justify-content: center;"></ul>
    </nav>
</div>

<script type="text/javascript">

	let totalCount = ${totalCount};
	if(totalCount === 0){
		totalCount = 1;
	}
	
	let nowPage = ${nowPage};
	let pageSize = 10;
	
	let _totalPages = totalCount / pageSize;	
	if(totalCount % pageSize > 0){
		_totalPages++;
	}
	
	/* let sortMethod = ${param.sortMethod}; */
	
	$("#pagination").twbsPagination({
		startPage: nowPage,
		totalPages: _totalPages,
		visiblePages: 10,
		first:'<span sria-hidden="true">«</span>',
		prev:"이전",
		next:"다음",
		last:'<span sria-hidden="true">»</span>',
		initiateStartPageClick:false,		// onPageClick 자동 실행되지 않도록 한다
		onPageClick:function(event, page){
			location.href = "/rent/list.do?pageNumber=" + (page - 1);	
		}
	});
	
</script>

</body>
</html>
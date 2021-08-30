<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="/resources/css/rentDetail.css" />
	<!-- datepicker -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<!-- sweetAlert2 -->
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.1.2/handlebars.min.js"></script>
</head>
<body>

<form id="orderForm" action="/rent/order.do" method="post">
	<section class="product" id="productinfo">
		<div class="product__photo">
			<div class="photo-container">
				<div class="photo-main">
					<img src="/resources/upload/${item.thumbnail_Name}" style="max-width: 100%; max-height: 100%;" alt="상품 썸네일 이미지">
					<input type="hidden" name="product_Seq" value="${item.product_Seq}">
				</div>
			</div>
		</div>
		<div class="product__info">
			<div class="title">
				<h1>${item.product_Name}</h1>
				<span>${item.product_Desc}</span>
			</div>
			<hr class="hr">
			<div class="description">
				<h4>기본 포함 상품</h4>
				<span>${item.base_Item}</span>
			</div>
			<hr class="hr">
			<div class="price">
				2박3일 기준<br>
				<span><fmt:formatNumber value="${item.product_Price}" type="number"/>원~</span>
				<input id="product_Price" type="hidden" value="${item.product_Price}">
			</div>
			<hr class="hr">
			<div class="variant">
				<h4>대여 기간</h4>
				<select id="rent_Seq" name="rent_Seq" onchange="totalcount()" style="width: 60%;">
					<c:forEach items="${rent}" var="rent">
						<c:if test="${rent.rent_Price eq 0}">
							<option value="${rent.rent_Seq}" data-rentDays="${rent.rent_Days}" data-rentPrice="${rent.rent_Price}" selected>${rent.rent_Name}</option>
						</c:if>
						<c:if test="${rent.rent_Price ne 0}">
							<option value="${rent.rent_Seq}" data-rentDays="${rent.rent_Days}" data-rentPrice="${rent.rent_Price}">${rent.rent_Name}</option>
						</c:if>
					</c:forEach>
				</select>
				<h4>대여 일자</h4>
				<input id="rent_Sdate" name="rent_Sdate" type="text" placeholder="시작 날짜 선택" autocomplete="off" readonly required> ~ <input id="rent_Edate" name="rent_Edate" type="text" placeholder="반납일 자동 지정" autocomplete="off" readonly required>
				<span style="font-size: 12px">
					<!-- <br>대여시작일은 배송 기간을 고려하여 일주일 뒤부터 지정 가능합니다 -->
					<br>
				</span>
			</div>
			<c:if test="${item.include_Light eq 1 or item.include_Grill eq 1}">
				<hr class="hr">
				<div class="variant">
					<h4>추가 옵션 선택</h4>
					<c:if test="${item.include_Light eq 1}">
						<h3>조명 추가</h3>
						<select id="option1_Seq" name="option1_Seq" style="width: 60%;">
							<option value="0" selected>선택안함</option>
							<c:forEach items="${option}" var="option">
								<c:if test="${option.option_Type eq 1}">
									<option value="${option.option_Seq}" data-optionPrice="${option.option_Price}">${option.option_Name}</option>
								</c:if>
							</c:forEach>
						</select><br>
					</c:if>
					<c:if test="${item.include_Grill eq 1}">
						<h3>화로 추가</h3>
						<select id="option2_Seq" name="option2_Seq" style="width: 60%;">
							<option value="0" selected>선택안함</option>
							<c:forEach items="${option}" var="option">
								<c:if test="${option.option_Type eq 2}">
									<option value="${option.option_Seq}" data-optionPrice="${option.option_Price}">${option.option_Name}</option>
								</c:if>
							</c:forEach>
						</select>
					</c:if>
				</div>
			</c:if>
			<hr class="hr">
			<div class="total">
				<span style="font-weight: bold;">
					총 주문 금액 : <span id="totalprice" style="font-size: 18px"><fmt:formatNumber value="${item.product_Price}" type="number"/></span> 원
					<input type="hidden" id="total_Price" name="product_Price" value="">
				</span>
				<div class="quantity-picker is-small">
					<button type="button" id="button-minus" class="button-minus">-</button>
					<input type="number" id="quantity" name="quantity" min="1" max="10" value="1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" readonly />
					<button type="button" id="button-plus" class="button-plus"><div id="plusbox" style="display:inline;">+</div></button>
				</div>
				
			</div>
			<hr class="hr">
			<button type="submit" id="buybutton" class="buy--btn">이 제품 대여하기</button>
		</div>
	</section>
</form>

<nav id="content">
	<ul>
		<li><a href="#">상품 선택</a></li>
		<li><a href="#content">상품 상세</a></li>
		<li><a href="#review">상품 리뷰</a></li>
		<li><a href="#qna">Q&A</a></li>
	</ul>
</nav>

<div style="height: auto; width: 80%; background-color: #dddddd; margin:auto; padding: 20px;">
	${item.content}
</div>

<script type="text/javascript">

/* 대여 버튼 클릭시 유효성 검사 */
$("#buybutton").click(function(){
	if(${login eq null}){
		Swal.fire({
			icon : 'warning',
			text : '로그인 후 이용해주세요'
		});
		return;
	}else if($("#rent_Sdate").val() == ""){
		Swal.fire({
			icon : 'warning',
			text : '대여일을 입력해주세요',
			didClose: () => {
				$("#rent_Sdate").focus();
			}
		});
		return;
	}else{
		$("#orderForm").submit();
	}
});
	
$(document).ready(function () {
	
	if(${item.product_Stock} == 0){
		$("#buybutton").attr("disabled", true);
		$("#buybutton").html('품절된 상품입니다');
		$("#buybutton").css('background-color', '#4c4c4c');
	}
	
	$("#total_Price").attr("value", ${item.product_Price});
	
	/* datepicker 기본 설정 */
	$.datepicker.setDefaults({
		  dateFormat: 'yy/mm/dd',
		  prevText: '이전 달',
		  nextText: '다음 달',
		  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		  showMonthAfterYear: true,
		  yearSuffix: '년'		  
	});

	/* 시작일 - 종료일 설정 */
    $("#rent_Sdate").datepicker({ 
    	minDate: '+0',
    	maxDate: '+1Y',
    	onSelect: function (dateString) {

			var rentdays = parseInt($("#rent_Seq option:selected").attr("data-rentDays"));
			var sdate = new Date($("#rent_Sdate").datepicker({dateFormat:"yy/mm/dd"}).val());
			var edate = new Date(sdate.setDate(sdate.getDate() + rentdays));
			
			var e1 = edate.getFullYear();
			
			var e2 = edate.getMonth() + 1;
			/* month 2자리 변환 */
			e2 = e2 + "";
			if(e2.length == 1){
				e2 = '0' + e2;
			}

			var e3 = edate.getDate();
			/* date 2자리 변환 */
			e3 = e3 +"";
			if(e3.length == 1){
				e3 = '0' + e3;
			}
			
			var eedate = e1 + "/" + e2 + "/" + e3;
			$('#rent_Edate').attr('value', eedate);
          }
    });
	
	/* 대여기간 변경시 종료일에 반영 */
	$("#rent_Seq").change(function() {
		
		if($("#rent_Sdate").datepicker("getDate") != null){
			
			var sdate = $("#rent_Sdate").datepicker("getDate");
			var rentdays = parseInt($("#rent_Seq option:selected").attr("data-rentDays"));
	
			var edate = new Date(sdate.setDate(sdate.getDate() + rentdays));
			
			var e1 = edate.getFullYear();
			
			var e2 = edate.getMonth() + 1;
			/* month 2자리 변환 */
			e2 = e2 + "";
			if(e2.length == 1){
				e2 = '0' + e2;
			}
	
			var e3 = edate.getDate();
			/* date 2자리 변환 */
			e3 = e3 +"";
			if(e3.length == 1){
				e3 = '0' + e3;
			}
			
			var eedate = e1 + "/" + e2 + "/" + e3;
			$('#rent_Edate').attr('value', eedate);
		}          
    });

	/* quantity picker 동작 설정 */
    $(".quantity-picker").each(function() {
    	
    	  // 재고에 따라 최대 구매 가능 수량 제한
    	  // 재고 10개 이상일 경우 - 최대 10개 구매 가능
    	  // 재고 10개 미만일 경우 - 최대 남은 재고만큼 구매 가능
    	  let stock = ${item.product_Stock};
    	  let maxbuy = 10;
    	  if(stock < 10){
    		  maxbuy = ${item.product_Stock};
    	  }
    	
    	  var input = $(this).find("input");
    	  var plus = $(this).find(".button-plus");
    	  var minus = $(this).find(".button-minus");
    	  var min = parseInt($(input).attr("min"), 10);
    	  var max = parseInt($(input).attr("max"), 10);

    	  $(plus).click(function() {
    	    $(input).val(Math.min(parseInt($(input).val(), 10) + 1, max));
    	    updateState();
    	  });

    	  $(minus).click(function() {
    	    $(input).val(Math.max(parseInt($(input).val(), 10) - 1, min));
    	    updateState();
    	  });

    	  function updateState() {
    	    var val = $(input).val();

    	    // Set disabled state when max / min qty reached
    	    $(minus).prop("disabled", val <= min);
    	    $(plus).prop("disabled", val >= maxbuy);
    	  };
    	  
    	  updateState();
    });
    
	
	/*총 주문금액 계산 */
	function totalcount(){
		
		var baseprice = parseInt($("#product_Price").val());
		// alert(baseprice);
		var rentprice = parseInt($("#rent_Seq option:selected").attr("data-rentPrice"));
		// alert(rentprice);
		var opt1price = $("#option1_Seq option:selected").attr("data-optionPrice") != null ? parseInt($("#option1_Seq option:selected").attr("data-optionPrice")) : 0;
		// alert(opt1price);
		var opt2price = $("#option2_Seq option:selected").attr("data-optionPrice") != null ? parseInt($("#option2_Seq option:selected").attr("data-optionPrice")) : 0;
		// alert(opt2price);
		var quantity = parseInt($("#quantity").val());
		// alert(quantity);
		
		var totalprice = (baseprice + rentprice + opt1price + opt2price) * quantity;
		// alert(totalprice);
		
		/* 총 금액 화면에 출력 */
		$("#totalprice").text(totalprice.toLocaleString('ko-KR'));
		$("#total_Price").attr("value", totalprice);
	}
	
	/* select option 부분의 값 변경 감지 */
	$("#rent_Seq, #option1_Seq, #option2_Seq").change(function(){
		totalcount();		
    });
	/* input(quantity) 부분의 값 변경 감지 */
	$("#quantity").on("propertychange change keyup paste input", function() {
	    totalcount();
	});
	/* button으로 수량 변경시 감지 */
	$("#button-minus, #button-plus").click(function(){
		totalcount();
	});
	
});

	function reload(){
		$("#reviewcontent").load("/rent/regi.do");
	}

</script>

</body>
</html>
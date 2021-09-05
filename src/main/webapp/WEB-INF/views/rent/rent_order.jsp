<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>결제하기</title>
<meta charset="utf-8">

<!-- order form css -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/resources/css/rentOrder.css" />
<!-- kakao address api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- iamport payment api -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<!-- sweetAlert2 -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>
	<main class="page payment-page">
		<section class="payment-form dark">
			<div class="container" style="width: 85%; background-color: f6f6f6; padding: 0; border-radius: 5px; border: 1px solid #dbdbdb; margin: 40px auto auto">
				<div class="block-heading">
					<h2>결제하기</h2>
					<!-- <p>결제화면입니다</p> -->
				</div>

				<!-- <form id="paymentform" action="/rent/paymentAf.do" method="post"> -->
					<!-- 배송 정보 -->
					<div class="card-details">
						<h3 class="title">배송 정보 입력</h3>
						<div class="row">
							<div class="form-group col-sm-4">
								<label id="">받는분</label> 
								<input id="receiver" type="text" name="receiver" class="form-control" placeholder="이름" aria-label="이름" aria-describedby="basic-addon1">
							</div>
							<div class="form-group col-sm-8">
								<label id="">전화번호</label>
								<div style="display: flex; vertical-align: center;">
									<input id="phone1" type="text" class="form-control" placeholder="" aria-label="" aria-describedby="basic-addon1" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="flex: 1;"> 
									<span class="date-separator">-</span>
									<input id="phone2" type="text" class="form-control" placeholder="" aria-label="" aria-describedby="basic-addon1" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="flex: 1;"> 
									<span class="date-separator">-</span>
									<input id="phone3" type="text" class="form-control" placeholder="" aria-label="" aria-describedby="basic-addon1" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="flex: 1;">
									<input type="hidden" id="receiver_Phone" name="receiver_Phone" value="">
								</div>
							</div>
							<div class="form-group col-sm-4">
								<label for="delivery_post">우편번호</label> 
								<input id="delivery_post" type="text" class="form-control" placeholder="우편번호검색" aria-label="우편번호" aria-describedby="basic-addon1" onclick="findAddr()" readonly>
							</div>
							<div class="form-group col-sm-8">
								<label for="delivery_addr1">주소</label>
								<input id="delivery_addr1" type="text" class="form-control" placeholder="주소" aria-label="주소" aria-describedby="basic-addon1" onclick="findAddr()" readonly>
							</div>
							<div class="form-group col-sm-12">
								<label for="delivery_addr2">상세주소</label> 
								<input id="delivery_addr2" type="text" class="form-control" placeholder="상세 주소 입력" aria-label="Card Holder" aria-describedby="basic-addon1">
							</div>
							<div class="form-group col-sm-12">
								<label for="memoselect">배송요청사항</label> 
								<select id="memoselect" class="form-control" aria-label="Card Holder" aria-describedby="basic-addon1">
									<option>배송 요청 사항을 선택해주세요</option>
									<option>부재시 경비실에 맡겨주세요</option>
									<option>부재시 문앞에 놓아주세요</option>
									<option>배송 전에 연락주세요</option>
									<option value="direct">직접 입력</option>
								</select> 
								<input id="memodirect" name="memodirect" type="text" class="form-control" placeholder="요청 사항 직접 입력" maxlength="100" aria-label="Card Holder" aria-describedby="basic-addon1" style="margin-top: 10px">
								<input type="hidden" id="memo" name="memo" value="">
							</div>
						</div>
					</div>

					<!-- 상품 정보 -->
					<div class="products">
						<h3 class="title">주문 상세</h3>
						<div style="max-width: 110px; overflow: hidden; text-align: center; float: left; margin-right: 20px;">
							<img src="/resources/upload/${item.thumbnail_Name}" style="height: 110px; position: relative; left: 100%; margin-left: -200%;" alt="상품 썸네일 이미지">
						</div>
						<div class="item">
							<span class="price">X ${order.quantity}개 </span>
							<%-- <input type="hidden" name="quantity" value="${order.quantity}"> --%>
							<p class="item-name">${item.product_Name}</p>
							<p class="item-description">기본구성 : ${item.base_Item} (<fmt:formatNumber value="${item.product_Price}" type="number" />원)</p>
							<%-- <input type="hidden" name="product_Seq" value="${item.product_Seq}"> --%>
							<input type="hidden" name="product_Price" value="${item.product_Price}">
							<c:if test="${order.option1_Seq ne 0}">
								<p class="item-description">옵션 1 : ${opt1.option_Name}</p>
								<%-- <input type="hidden" name="option1_Seq" value="${order.option1_Seq}"> --%>
							</c:if>
							<c:if test="${order.option2_Seq ne 0}">
								<p class="item-description">옵션 2 : ${opt2.option_Name}</p>
								<%-- <input type="hidden" name="option2_Seq" value="${order.option2_Seq}"> --%>
							</c:if>
							<p class="item-description">대여기간 : ${order.rent_Sdate} ~ ${order.rent_Edate} (${rent.rent_Name})</p>
							<input type="hidden" name="rent_Seq" value="${order.rent_Seq}">
							<input type="hidden" name="rent_Sdate" value="${order.rent_Sdate}">
							<input type="hidden" name="rent_Edate" value="${order.rent_Edate}">
							<p class="item-description">배송비 : 5,000원 (X ${order.quantity}set)</p>
							<input type="hidden" name="rent_Edate" value="${order.rent_Edate}">
							<input type="hidden" id="shipping_Fee" name="shipping_Fee" value="">
						</div>
						<div class="total">
							Total<span class="price" id="totalprice"></span>
							<input type="hidden" id="total_Price" name="total_Price" value="">
						</div>
					</div>

					<!-- 결제 정보 -->
					<div class="card-details">
						<h3 class="title">결제수단</h3>
						<div class="row">
							<div class="form-group col-sm-12">
								<label for="paymentType">결제 수단 선택</label> 
								<select id="paymentType" class="form-control" aria-label="Card Holder" aria-describedby="basic-addon1">
									<option disabled="disabled">선택 하기</option>
									<option value="card">신용카드</option>
									<option value="trans">실시간 계좌이체</option>
									<option value="vbank">가상계좌</option>
									<option value="phone">휴대폰 소액결제</option>
								</select>
							</div>
							<div class="form-group col-sm-12">
								<label for="policyagree">
									<input type="checkbox" id="policyagree" required="required">
									<span style="font-size: 13px">주문 상품정보 및 서비스 이용약관에 모두 동의합니다</span>
								</label>
							</div>
							<div class="form-group col-sm-12">
								<button type="button" class="btn btn-primary btn-block" onclick="iamport()">결제하기</button>
							</div>
						</div>
					</div>
				<!-- </form> -->
			</div>
		</section>
	</main>

	<script type="text/javascript">
	
		/* 배송비 포함한 총주문금액 계산 */
		let shippingfee = 5000 * ${order.quantity};
		$("#shipping_Fee").attr("value", shippingfee);		
		let totalprice = parseInt(${order.product_Price}) + parseInt($("#shipping_Fee").val());
		$("#totalprice").text(totalprice.toLocaleString('ko-KR') + " 원");
		$("#total_Price").attr("value", totalprice);	
		
		/* 카카오 주소검색 */
		function findAddr() {
			new daum.Postcode({
				oncomplete : function(data) {
					
					var roadAddr = data.roadAddress; // 도로명 주소
					var jibunAddr = data.jibunAddress; // 지번 주소
					var zonecode = data.zonecode; // 우편번호

					document.getElementById("delivery_post").value = zonecode;

					if (roadAddr !== '') {
						document.getElementById("delivery_addr1").value = roadAddr;
					} else if (jibunAddr !== '') {
						document.getElementById("delivery_addr1").value = jibunAddr;
					}
					
					document.getElementById("delivery_addr2").focus();
				}
			}).open();
		}
		
		/* 배송 메모 직접입력 시 */
		$(function() {

			$("#memodirect").hide();

			$("#memoselect").change(function() {
				if ($("#memoselect").val() == "direct") {
					$("#memodirect").show();
				} else {
					$("#memodirect").hide();
				}
			});
		});
		
		/* 배송정보 유효성 검사 & 결제 */
		function iamport() {

			// 정보 입력란 유효성 검사
			if(${login eq null}){
				Swal.fire({
					icon : 'warning',
					text : '로그인 후 이용해주세요'
				});
				return;
				
			}else if($("#receiver").val() == ""){
				Swal.fire({
					icon : 'warning',
					text : '받는분을 입력해주세요',
					didClose: () => {
						$("#receiver").focus();
					}			        
				});			
				return;

			}else if($("#phone1").val() == ""){
				Swal.fire({
					icon : 'warning',
					text : '전화번호를 입력해주세요',
					didClose: () => {
						$("#phone1").focus();
					}
				});
				return;

			}else if($("#phone2").val() == ""){
				Swal.fire({
					icon : 'warning',
					text : '전화번호를 입력해주세요',
					didClose: () => {
						$("#phone2").focus();
					}
				});
				return;

			}else if($("#phone3").val() == ""){
				Swal.fire({
					icon : 'warning',
					text : '전화번호를 입력해주세요',
					didClose: () => {
						$("#phone3").focus();
					}
				});
				return;

			}else if($("#delivery_post").val() == "" || $("#delivery_addr1").val() == ""){
				Swal.fire({
					icon : 'warning',
					text : '주소를 입력해주세요',
					didClose: () => {
						$("#delivery_post").focus();
					}
				});
				return;

			}else if($("#delivery_addr2").val() == ""){
				Swal.fire({
					icon : 'warning',
					text : '상세주소를 입력해주세요',
					didClose: () => {
						$("#delivery_addr2").focus();
					}
				});
				return;

			}else if($("#policyagree").is(":checked") == false) {
				Swal.fire({
					icon : 'warning',
					text : '결제 약관에 동의해주세요',
					didClose: () => {
						$("#policyagree").focus();
					}
				});
				return;
			
			}else{			
				
				IMP.init('iamport'); //가맹점 식별코드
				IMP.request_pay({
					pg : 'kcp',
					pay_method : $("#paymentType").val(), // card(신용카드), trans(실시간계좌이체), vbank(가상계좌), phone(휴대폰소액결제)
					merchant_uid : 'bit_' + new Date().getTime(),
					name : '${item.product_Name}', //결제창에서 보여질 이름
					amount : 100, // $("#total_Price").val(), //실제 결제되는 가격
					buyer_email : '${login.email}',
					buyer_name : '${login.username}',
					buyer_tel : '${login.phone}',
					buyer_addr : $("#delivery_addr1").val() + ' ' + $("#delivery_addr2").val(),
					buyer_postcode : $("#delivery_post").val()
				}, function(rsp) {
					console.log(rsp);
					if (rsp.success) {
						
						/* 전화번호 합쳐서 넣어주기 */
						let phone = $("#phone1").val() + "-" + $("#phone2").val() + "-" + $("#phone3").val();
						$("#receiver_Phone").attr("value", phone);	
						
						/* 배송메모 직접입력일시 입력값 넣어주기 */
						let dmemo = "";
						if($("#memoselect").val() == "direct"){
							
							dmemo = $("#memodirect").val();
							// $("#memo").attr("value", $("#memodirect").val());
						}else{
							// $("#memo").attr("value", $("#memoselect").val());
							dmemo = $("#memoselect").val();
						}
						
						let orderData = {
								"user_Id" : '${login.id}',
								"product_Seq" : '${item.product_Seq}',
								"option1_Seq" : '${order.option1_Seq}',
								"option2_Seq" : '${order.option2_Seq}',
								"quantity" : '${order.quantity}',
								"rent_Seq" : '${order.rent_Seq}',
								"rent_Sdate" : '${order.rent_Sdate}',
								"rent_Edate" : '${order.rent_Edate}',
								"product_Price" : '${order.product_Price}',
								"shipping_Fee" : shippingfee, 
								"total_Price" : $("#total_Price").val(), // rsp.paid_amount, = 아임포트에서 실결제된 금액
								"receiver" : $("#receiver").val(),
								"address" : rsp.buyer_postcode + ' ' + rsp.buyer_addr, 
								"receiver_Phone" : phone, 
								"memo" : dmemo, 
								"payment" : rsp.pay_method, 
								"merchant_Uid" : rsp.merchant_uid
						}
						
						// alert(JSON.stringify(orderData));
						
						console.log("orderData =  " + orderData);
	
						$.ajax({
							url : "/rent/paymentAf.do",
							type : "POST",
							/* headers : {
								"Content-Type" : "application/json"
							}, */
							data : orderData,
							dataType : 'json',
							success : function(result){

								console.log(result);

								if(result == 1) {
									
									Swal.fire({
										icon : 'success',
										text : '결제가 완료되었습니다.'
									});
									
									// alert("DB저장성공");
									location.href = "complete.do?merchant_Uid=" + rsp.merchant_uid; 
								}else{
									// alert("DB입력실패");
								}
							},
							error : function(a,b,c){
								
							}
						})
						
						/* var msg = '결제가 완료되었습니다.';
						msg += '고유ID : ' + rsp.imp_uid;
						msg += '상점 거래ID : ' + rsp.merchant_uid;
						msg += '결제 금액 : ' + rsp.paid_amount;
						msg += '카드 승인번호 : ' + rsp.apply_num; */
						
					} else {
						Swal.fire({
							icon : 'error',
							text : '결제에 실패했습니다. \n 에러내용 : ' + rsp.error_msg
						});
					}
				});
			}
		}
		
	</script>

<!-- 	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script> -->

</body>
</html>
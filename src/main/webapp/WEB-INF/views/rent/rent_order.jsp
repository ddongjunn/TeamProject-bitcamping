<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
  <title>Payment</title>
  <meta charset="utf-8">
  
  <!-- css -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="/resources/css/rentOrder.css" />
  <!-- kakao api -->
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  
</head>
<body>
  <main class="page payment-page">
    <section class="payment-form dark">
      <div class="container">
        <div class="block-heading">
          <h2>결제하기</h2>
          <!-- <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc quam urna, dignissim nec auctor in, mattis vitae leo.</p> -->
        </div>
        <form>
        <!-- 배송 정보 -->
        <div class="card-details">
            <h3 class="title">배송 정보 입력</h3>
            <div class="row">
              <div class="form-group col-sm-4">
                <label id="delivery_post">받는분</label>
				<input id="delivery_post" type="text" class="form-control" placeholder="이름" aria-label="이름" aria-describedby="basic-addon1">
              </div>
              <div class="form-group col-sm-8">
                <label id="">전화번호</label>
                <div style="display: flex; vertical-align: center;">
					<input id="" type="text" class="form-control" placeholder="" aria-label="" aria-describedby="basic-addon1" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="flex: 1;">
					<span class="date-separator">-</span>
					<input id="" type="text" class="form-control" placeholder="" aria-label="" aria-describedby="basic-addon1" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="flex: 1;">
					<span class="date-separator">-</span>
					<input id="" type="text" class="form-control" placeholder="" aria-label="" aria-describedby="basic-addon1" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="flex: 1;">
				</div>
              </div>
              <div class="form-group col-sm-4">
                <label id="delivery_post">우편번호</label>
				<input id="delivery_post" type="text" class="form-control" placeholder="우편번호검색" aria-label="우편번호" aria-describedby="basic-addon1" onclick="findAddr()" readonly>
              </div>
              <div class="form-group col-sm-8">
                <label for="delivery_addr">주소</label>
                <input id="delivery_addr" type="text" class="form-control" placeholder="주소" aria-label="주소" aria-describedby="basic-addon1" onclick="findAddr()" readonly>                
              </div>
              <div class="form-group col-sm-12">
                <label for="card-number">상세주소</label>
                <input id="card-number" type="text" class="form-control" placeholder="상세 주소 입력" aria-label="Card Holder" aria-describedby="basic-addon1">
              </div>
              <div class="form-group col-sm-12">
                <label for="card-number">배송요청사항</label>
                <select id="card-number" class="form-control" aria-label="Card Holder" aria-describedby="basic-addon1">
                	<option>요청사항을 선택해주세요</option>
                	<option>부재시 경비실에 맡겨주세요</option>
                	<option>부재시 문앞에 놓아주세요</option>
                	<option>배송 전에 연락주세요</option>
                	<option value="direct">직접 입력</option>
                </select>
                <input id="card-number" type="text" class="form-control" placeholder="상세 주소 입력" aria-label="Card Holder" aria-describedby="basic-addon1">
              </div>
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
              <p class="item-name">${item.product_Name} (<fmt:formatNumber value="${item.product_Price}" type="number"/>원)</p>
              <p class="item-description">기본구성 : ${item.base_Item}</p>
              <c:if test="${order.option1_Seq ne 0}">
              	<p class="item-description">옵션 1 : ${opt1.option_Name}</p>
              </c:if>
              <c:if test="${order.option2_Seq ne 0}">
              	<p class="item-description">옵션 2 : ${opt2.option_Name}</p>
              </c:if>
            </div>
            <!-- <div class="item">
              <span class="price">120</span>
              <p class="item-name">Product 2</p>
              <p class="item-description">Lorem ipsum dolor sit amet</p>
            </div> -->
            <div class="total">Total<span class="price"><fmt:formatNumber value="${order.product_Price}" type="number"/>원</span></div>
          </div>
          
          <!-- 결제 정보 -->
          <div class="card-details">
            <h3 class="title">Credit Card Details</h3>
            <div class="row">
              <div class="form-group col-sm-7">
                <label for="card-holder">Card Holder</label>
                <input id="card-holder" type="text" class="form-control" placeholder="Card Holder" aria-label="Card Holder" aria-describedby="basic-addon1">
              </div>
              <div class="form-group col-sm-5">
                <label for="">Expiration Date</label>
                <div class="input-group expiration-date">
                  <input type="text" class="form-control" placeholder="MM" aria-label="MM" aria-describedby="basic-addon1">
                  <span class="date-separator">/</span>
                  <input type="text" class="form-control" placeholder="YY" aria-label="YY" aria-describedby="basic-addon1">
                </div>
              </div>
              <div class="form-group col-sm-8">
                <label for="card-number">Card Number</label>
                <input id="card-number" type="text" class="form-control" placeholder="Card Number" aria-label="Card Holder" aria-describedby="basic-addon1">
              </div>
              <div class="form-group col-sm-4">
                <label for="cvc">CVC</label>
                <input id="cvc" type="text" class="form-control" placeholder="CVC" aria-label="Card Holder" aria-describedby="basic-addon1">
              </div>
              <div class="form-group col-sm-12">
                <button type="button" class="btn btn-primary btn-block">결제하기</button>
              </div>
            </div>
          </div>
          
        </form>
      </div>
    </section>
  </main>
  
<script type="text/javascript">
	function findAddr(){
		new daum.Postcode({
	        oncomplete: function(data) {
	        	
	        	console.log(data);
	        	console.log(data.zonecode);
	        	
	            var roadAddr = data.roadAddress; // 도로명 주소 변수
	            var jibunAddr = data.jibunAddress; // 지번 주소 변수
	            var zonecode = data.zondcode;
	            
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById("delivery_post").value = zonecode;
	
	            if(roadAddr !== ''){
	                document.getElementById("delivery_addr").value = roadAddr;
	            } 
	            else if(jibunAddr !== ''){
	                document.getElementById("delivery_addr").value = jibunAddr;
	            }
	        }
	    }).open();
	} 
	
	
</script>

</body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

</body>
</html>
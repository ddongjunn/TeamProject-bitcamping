<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/resources/css/rentDetail.css" />
<link href="https://fonts.googleapis.com/css?family=Raleway:400,700,900" rel="stylesheet">
</head>
<body>

<section class="product">
	<div class="product__photo">
		<div class="photo-container">
			<div class="photo-main">
				<!-- <div class="controls">
					<i class="material-icons">share</i>
					<i class="material-icons">favorite_border</i>
				</div> -->
				<img src="/resources/upload/${item.thumbnailName}" style="max-width: 700px; max-height: 550px;" alt="상품 썸네일 이미지">
			</div>
			<!-- <div class="photo-album">
				<ul>
					<li><img src="https://res.cloudinary.com/john-mantas/image/upload/v1537302064/codepen/delicious-apples/green-apple2.png" alt="green apple"></li>
					<li><img src="https://res.cloudinary.com/john-mantas/image/upload/v1537303532/codepen/delicious-apples/half-apple.png" alt="half apple"></li>
					<li><img src="https://res.cloudinary.com/john-mantas/image/upload/v1537303160/codepen/delicious-apples/green-apple-flipped.png" alt="green apple"></li>
					<li><img src="https://res.cloudinary.com/john-mantas/image/upload/v1537303708/codepen/delicious-apples/apple-top.png" alt="apple top"></li>
				</ul>
			</div> -->
		</div>
	</div>
	<div class="product__info">
		<div class="title">
			<h1>${item.productName}</h1>
			<span>${item.productDesc}</span>
		</div>
		<div class="description">
			<h3>기본 포함 상품</h3>
				<span>${item.baseItem }</span>
		</div>
		<div class="price">
			2박3일 <br>
			<span><fmt:formatNumber value="${item.productPrice }" type="number"/>원~</span>
		</div>
		<div class="variant">
				<h4>대여 기간</h4>
				<select style="width: 60%;">
					<option value="" selected>2박 3일</option>
					<option>3박 4일</option>
					<option>4박 5일</option>
					<option>5박 6일</option>
				</select>
				<h4>대여 일자</h4>
				<input id="datepicker" type="date"><br>
				<span style="color: gray">반납 예정일 : 2021년 8월 23일</span>
		</div>
		<c:if test="${item.includeLight eq 1 or item.includeGrill eq 1}">
			<div class="variant">
				<h4>추가 옵션 선택</h4>
				<c:if test="${item.includeLight eq 1}">
					<h3>조명 추가</h3>
					<select style="width: 60%;">
						<option value="" selected disabled hidden>선택안함</option>
						<option>옵션1</option>
						<option>옵션2</option>
						<option>옵션3</option>
					</select><br>
				</c:if>
				<c:if test="${item.includeLight eq 1}">
					<h3>화로 추가</h3>
					<select style="width: 60%;">
						<option value="" selected disabled hidden>선택안함</option>
						<option>옵션1</option>
						<option>옵션2</option>
						<option>옵션3</option>
					</select>
				</c:if>
			</div>
		</c:if>

		<button class="buy--btn">바로 구매하기</button>
	</div>
</section>

<div style="height: 800px; background-color: #dddddd; margin: 100px; padding: 100px;">
	${item.content}
</div>

<%-- <div class="info-box" style="display: flex; justify-content: center; align-items: center;">
	<div style="float: left; width: 500px; height: 500px; background-color: gray">
		대표이미지 들어갈 자리
	</div>
	
	<div>
		<table border="1" style="height: 500px;">
			<colgroup>
				<col width="100px">
				<col width="400px">
			</colgroup>
			<thead>
				<tr>
					<td	colspan="2">
						상품명 입니다
					</td>
				</tr>
				<tr>
					<td	colspan="2">
						상품 한줄 설명 입니다
					</td>
				</tr>
				<tr>
					<td	colspan="2">
						상품 가격 입니다
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						조명 선택
					</td>
					<td>
						<select style="width: 100%;">
							<option value="" selected disabled hidden>선택안함</option>
							<option>옵션1</option>
							<option>옵션2</option>
							<option>옵션3</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						화로 선택
					</td>
					<td>
						<select style="width: 100%;">
							<option value="" selected disabled hidden>선택안함</option>
							<option>옵션1</option>
							<option>옵션2</option>
							<option>옵션3</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						대여기간
					</td>
					<td>
						<select style="width: 100%;">
							<option value="" selected>2박 3일</option>
							<option>3박 4일</option>
							<option>4박 5일</option>
							<option>5박 6일</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						대여 일자
					</td>
					<td>
						<input id="datepicker" type="date"><br>
						<span style="color: gray">반납 예정일 : 2021년 8월 23일</span>	
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2">
						선택옵션 & 수량 ajax로 띄워줄 자리
					</td>
				</tr>
				<tr>
					<td colspan="2">
						총 상품금액 : 999,999 원
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit" style="width: 100%">바로구매</button>
					</td>
				</tr>
			</tfoot>
		
		</table>
	</div>
</div> --%>


</body>
</html>
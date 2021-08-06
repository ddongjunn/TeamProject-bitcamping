<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="info-box" style="display: flex; justify-content: center; align-items: center;">
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
</div>

<div style="height: 800px; background-color: #dddddd;">

</div>

</body>
</html>
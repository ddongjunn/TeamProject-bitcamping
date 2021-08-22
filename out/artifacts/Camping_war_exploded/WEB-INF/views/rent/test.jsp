
<form name="regi_frm" method="post" action="/rent/regiAf.do" enctype="multipart/form-data">
	<table border="1" style="width: 700px; margin: auto; padding: 30px;">
	
		<thead>
			<tr>
				<th>상품 등록</th>
			</tr>
		</thead>
		
		<tbody>
			<tr>
				<td>
					<span class="table_head">상품명</span><br>
					<input type="text" name="productName" style="width: 80%" placeholder="3인용 초보자 세트" maxlength="100" required>
				</td>
			</tr>
			<tr>
				<td>
					<span class="table_head">한줄 설명</span><br>
					<input type="text" name="productDesc" style="width: 80%" placeholder="캠핑 초보를 위한 구성!" maxlength="400" required>
				</td>
			</tr>
			<tr>
				<td>
					<span class="table_head">기본 구성</span><br>
					<input type="text" name="baseItem" style="width: 80%" placeholder="[듀랑고]에어미니 타프 스타터세트, [스탠리]클래식 포어 오버 커피 드리퍼 세트, ..." maxlength="400" required>
				</td>
			</tr>
			<tr>
				<td>
					<span class="table_head">가격</span><br>
					<input type="text" name="productPrice" style="width: 80px;" pattern="^[0-9]+$" maxlength="8" oninvalid="this.setCustomValidity('숫자를 입력하세요')" required> 원
				</td>
			</tr>
			<tr>
				<td>
					<span class="table_head">재고</span><br>
					<input type="text" name="productStock" style="width: 80px;" pattern="^[0-9]+$" maxlength="8" oninvalid="this.setCustomValidity('숫자를 입력하세요')" required> 개
				</td>
			</tr>
			<tr>
				<td>
					<span class="table_head">추가 옵션 선택</span><br>		
					<input type="checkbox" name="includeLight" id="option1" value="1"><label for="option1">조명 옵션 포함</label>
					<input type="checkbox" name="includeGrill" id="option2" value="1"><label for="option2">화로 옵션 포함</label>
				</td>
			</tr>
			<tr>
				<td>
					<span class="table_head">썸네일 이미지 등록</span><br>
					<div class="image-container">
		    			<img style="height: 300px;" id="preview-image" src="https://dummyimage.com/500x500/ffffff/000000.png&text=preview+image">
		    			<input type="file" name="thumbnail" accept="image/*" id="input-image" style="display: block;" required>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<span class="table_head">대여료</span><br>			

					<div style="float: left; padding: 40px;">
						<label for="type1">			
							<input type="radio" id="type1" name="rentType" value="1" checked="checked"> 유형 1<br>
							2박 3일 (기본)<br>
							3박 4일 (+7,000원)<br>
							4박 5일 (+14,000원)<br>
							5박 6일 (+21,000원)
						</label>
					</div>
					<div style="float: left; padding: 40px;">
						<label for="type2">	
							<input type="radio" id="type2" name="rentType" value="2"> 유형 2<br>
							2박 3일 (기본)<br>
							3박 4일 (+25,000원)<br>
							4박 5일 (+50,000원)<br>
							5박 6일 (+75,000원)
						</label>
					</div>		
				</td>
			</tr>
			<tr>
				<td>
					<span class="table_head">상세 설명</span><br>
					<div id="summernote_box" style="width: 800px; margin: auto;">
			  			<textarea id="summernote" name="content" ></textarea>
					</div>

				</td>
			</tr>
		</tbody>
 		<tfoot>
			<tr>
				<td align="center">
					<button type="submit">상품 등록</button>	
				</td>
			</tr>
		</tfoot>
	</table>
</form>
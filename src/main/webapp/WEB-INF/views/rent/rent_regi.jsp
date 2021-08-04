<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">
<style>
.table_head{
	color: red;
	font-size: 9pt;
	font-weight: bolder;
}
</style>

<form id="frm">
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
			<input type="text" style="width: 80%" placeholder="3인용 초보자 세트" required>
		</td>
	</tr>
	<tr>
		<td>
			<span class="table_head">한줄 설명</span><br>
			<input type="text" style="width: 80%" placeholder="캠핑 초보를 위한 구성" required>
		</td>
	</tr>
	<tr>
		<td>
			<span class="table_head">기본 구성</span><br>
			<input type="text" style="width: 80%" placeholder="[듀랑고]에어미니 타프 스타터세트, [스탠리]클래식 포어 오버 커피 드리퍼 세트, ...">
		</td>
	</tr>
	<tr>
		<td>
			<span class="table_head">가격</span><br>
			<input type="text" style="width: 80px;"> 원
		</td>
	</tr>
	<tr>
		<td>
			<span class="table_head">재고</span><br>
			<input type="text" style="width: 80px;"> 개
		</td>
	</tr>
	<tr>
		<td>
			<span class="table_head">추가 옵션 선택</span><br>		
			<input type="checkbox" id="option1"><label for="option1">조명 옵션 포함</label>
			<input type="checkbox" id="option2"><label for="option2">화로 옵션 포함</label>
		</td>
	</tr>
	<tr>
		<td>
			<span class="table_head">썸네일 이미지 등록</span><br>
			<div class="image-container">
    			<img style="height: 300px;" id="preview-image" src="https://dummyimage.com/500x500/ffffff/000000.png&text=preview+image">
    			<input style="display: block;" type="file" accept="image/*" id="input-image">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<span class="table_head">대여료</span><br>			
		</td>
	</tr>
		<tr>
		<td>
			<div style="float: left; padding: 40px;">
				<label for="type1">			
					<input type="radio" id="type1" name="chk_rent" value="1" checked="checked"> 유형 1<br>
					2박 3일 (기본)<br>
					3박 4일 (+7,000원)<br>
					4박 5일 (+14,000원)<br>
					5박 6일 (+21,000원)
				</label>
			</div>
			<div style="float: left; padding: 40px;">
				<label for="type2">	
					<input type="radio" id="type2" name="chk_rent" value="2"> 유형 2<br>
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
	  			<textarea id="summernote" name="editordata" placeholder="상품 설명을 입력해 주세요."></textarea>
			</div>			
		</td>
	</tr>
		<tr>
			<td align="center">
				<button type="submit">등록</button>		
			</td>
		</tr>
</tbody>
</table>
</form>


<script type="text/javascript">
$(document).ready(function() {
	
	/* summernote */
	$(function(){
		$('#summernote').summernote({
			height: 600,
			fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
			fontNamesIgnoreCheck : [ '맑은고딕' ],
			focus: false,
	
			callbacks: {
			onImageUpload: function(files, editor, welEditable) {
			            for (var i = files.length - 1; i >= 0; i--) {
			             sendFile(files[i], this);
			            }
			        }
			}

		});

	});

	function sendFile(file, el) {
		
		var form_data = new FormData();		
		form_data.append('file', file);		
		$.ajax({
	        data: form_data,
	        type: "POST",
	        url: './profileImage.mpf',
	        cache: false,
	        contentType: false,
	        enctype: 'multipart/form-data',
	        processData: false,
	        success: function(img_name) {
	          $(el).summernote('editor.insertImage', img_name);
	        }
		});
	}
	
	/* thumbnail */
	function readImage(input) {
	    // 인풋 태그에 파일이 있는 경우
	    if(input.files && input.files[0]) {
	        // 이미지 파일인지 검사 (생략)
	        // FileReader 인스턴스 생성
	        const reader = new FileReader()
	        // 이미지가 로드가 된 경우
	        reader.onload = e => {
	            const previewImage = document.getElementById("preview-image")
	            previewImage.src = e.target.result
	        }
	        // reader가 이미지 읽도록 하기
	        reader.readAsDataURL(input.files[0])
	    }
	}
	// input file에 change 이벤트 부여
	const inputImage = document.getElementById("input-image")
	inputImage.addEventListener("change", e => {
	    readImage(e.target)
	});
});
</script>
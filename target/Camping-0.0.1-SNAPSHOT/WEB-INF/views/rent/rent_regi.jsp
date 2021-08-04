<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">

<table border="1">
<colgroup>
	<col width="200px" />
	<col width="700px" />
</colgroup>
<thead>
	<tr>
		<th colspan="2">상품 등록</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td>
			상품명<br>
			<input type="text" style="width: 100%" placeholder="3인용 초보자 세트">
		</td>
	</tr>
	<tr>
		<td>
			한줄 설명<br>
			<input type="text" style="width: 100%" placeholder="캠핑 초보를 위한 세트">
		</td>
	</tr>
	<tr>
		<td>
			기본 구성<br>
			<input type="text" style="width: 100%" placeholder="[듀랑고]에어미니 타프 스타터세트, [스탠리]클래식 포어 오버 커피 드리퍼 세트[화이트]">
		</td>
	</tr>
	<tr>
		<td>
			가격<br>
			<input type="text" style="width: 100%"> 원
		</td>
	</tr>
	<tr>
		<td>
			재고<br>
			<input type="text" style="width: 100%"> 개
		</td>
	</tr>
	<tr>
		<td>
			추가 옵션 선택<br>		
			<input type="checkbox" id="option1"><label for="option1">조명 옵션 포함</label>
			<input type="checkbox" id="option2"><label for="option2">화로 옵션 포함</label>
		</td>
	</tr>
	<tr>
		<td>
			썸네일 이미지 등록<br>
			<div class="image-container">
    			<img style="width: 500px;" id="preview-image" src="https://dummyimage.com/500x500/ffffff/000000.png&text=preview+image">
    			<input style="display: block;" type="file" accept="image/*" id="input-image">
			</div>
		</td>
	</tr>
	<tr>
		<td>대여료<br>
			
		</td>
	</tr>
	<tr>
		<td>상세 설명<br>
			<div id="summernote_box" style="width: 800px; margin: auto;">
				<form method="post">
	  				<textarea id="summernote" name="editordata"></textarea>
				</form>
			</div>			
		</td>
	</tr>
</tbody>
</table>

<script type="text/javascript">
$(document).ready(function() {
	
	/* summernote */
	$(function(){
		$('#summernote').summernote({
			height: 600,
			fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
			fontNamesIgnoreCheck : [ '맑은고딕' ],
			focus: true,
	
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
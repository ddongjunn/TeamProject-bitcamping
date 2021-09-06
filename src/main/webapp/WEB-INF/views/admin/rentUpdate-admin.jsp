<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/resources/css/rentRegi.css" />
<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">

<form name="update_frm" method="post" action="/admin/product-updateAf.do" enctype="multipart/form-data" autocomplete="off">
  <h1>상품 정보 수정</h1>
  <input type="hidden" name="product_Seq" value="${item.product_Seq}">  
  <div class="question">
	<input type="text" name="product_Name" maxlength="100" value="${item.product_Name}" autocomplete="off" required />
    <label>상품명</label>
  </div>
  <div class="question">
	<input type="text" name="product_Desc" maxlength="400" value="${item.product_Desc}" autocomplete="off" required />
    <label>한줄 설명</label>
  </div>
  <div class="question">
	<input type="text" name="base_Item" maxlength="400" value="${item.base_Item}" autocomplete="off" required />
    <label>기본 구성</label>
  </div>
  <div class="question">
	<input type="text" name="product_Price" value="${item.product_Price}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="8" autocomplete="off" required />
    <label>가격(원)</label>
  </div>
    <div class="question">
    <input type="text" name="product_Stock" value="${item.product_Stock}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="8" autocomplete="off" required />
    <label>재고(개)</label>
  </div>
  <div class="borderbox">
    <label>추가 옵션 선택</label><br>
    <input type="checkbox" name="include_Light" id="option1" value="1"><label for="option1">조명 옵션 포함</label><br>    
	<input type="checkbox" name="include_Grill" id="option2" value="1"><label for="option2">화로 옵션 포함</label>
  </div>
  <div class="borderbox">
    <label>썸네일 이미지 등록</label><br>
    <div class="image-container">
		<img style="height: 300px;" id="preview-image" src="/resources/upload/${item.thumbnail_Name}">
		<input type="file" name="thumbnail" accept="image/*" id="input-image" style="display: block;">
	</div>
  </div>
  <div class="borderbox">
    <label>대여료</label><br>
	<div class="rentbox">
	<label for="type1">			
			<input type="radio" id="type1" name="rent_Type" value="1"> 유형 1<br>
			2박 3일 (기본)<br>
			3박 4일 (+7,000원)<br>
			4박 5일 (+14,000원)<br>
			5박 6일 (+21,000원)
	</label>
	</div>
	<div class="rentbox">
		<label for="type2">	
			<input type="radio" id="type2" name="rent_Type" value="2"> 유형 2<br>
			2박 3일 (기본)<br>
			3박 4일 (+25,000원)<br>
			4박 5일 (+50,000원)<br>
			5박 6일 (+75,000원)
		</label>
	</div>
  </div>
  <div class="contentbox">
    <label>상세 설명</label><br><br>
    <div id="summernotebox" style="width: 800px; margin: auto;">
		<textarea id="summernote" name="content" >${item.content}</textarea>
	</div>
  </div>
  <button type="submit">상품 수정</button>
</form>


<script type="text/javascript">
	$(document).ready(function() {
		
		/* checkbox, radio 부분 기존 상품정보대로 적용 */
		if(${item.include_Light eq 1}){
			$("input:checkbox[name='include_Light']").prop("checked", true);
		}
		if(${item.include_Grill eq 1}){
			$("input:checkbox[name='include_Grill']").prop("checked", true);
		}		
		$("input:radio[name='rent_Type']:radio[value='${item.rent_Type}']").prop("checked", true);
		
		
		/* summernote 설정 */
		$('#summernote').summernote({
			height: 800,
			dialogsInBody: true,
			lang: "ko-KR",
			toolbar: [
			    ['font', ['bold', 'italic', 'underline', 'clear']],
			    ['color', ['color']],
			    ['para', ['paragraph']],
			    ['height', ['height']],
			    ['table', ['table']],
			    ['insert', ['link', 'picture', 'hr']],
			    ['view', ['codeview']],
			    ['help', ['help']]
			  ],
			focus: false,
			placeholder: '상품 설명을 입력해 주세요',
			
			callbacks: {
		         onImageUpload: function(files, editor, welEditable) {
		               for (var i = files.length - 1; i >= 0; i--) {
		                  sendFile(files[i], this);
		               }
		           }
		      }
		});
	});
	
	/* summernote 파일 저장 */
	function sendFile(file, el) {
		var form_data = new FormData();
      	form_data.append('file', file);
      	$.ajax({
        	data: form_data,
        	type: 'POST',
        	url: '/summernote/upload.do',
        	cache: false,
        	contentType: false,
        	enctype: 'multipart/form-data',
        	processData: false,
        	success: function(img_name) {
          		$(el).summernote('editor.insertImage', img_name);
        	}
      	});     	
    }

	
	/* thumbnail 미리보기*/
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
	
</script>
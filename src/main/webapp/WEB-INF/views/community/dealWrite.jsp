<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- summernote -->
<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">

<style type="text/css">
	.dealWrite{
		width: 85%;
	}
	.dealWrite td{
		padding: 10px 0px;
		border-bottom: 1px solid gray;
	}
	.title{
		width: 100%;
		font-size: 18px;
	}
	.file{
		width: 100%
	}
	.submitbox{
		width: 85%;
		margin: 10px;
		text-align: right;
	}
</style>
</head>
<body>

<form id="dealWriteForm" action="/community/dealWriteAf.do" method="post" enctype="multipart/form-data" >
<table class="dealwWrite">
	<tbody>
		<tr>
			<td>
				<label><input type="radio" id="choice" name="bbstype" value="sell"> 팝니다 </label>
				<label><input type="radio" id="choice" name="bbstype" value="buy"> 삽니다 </label>
			</td>
		</tr>
		<tr>
			<td>
				<input type="text" id="title" class="title" name="title" placeholder="제목을 입력해 주세요">
			</td>
		</tr>
			
		<tr>
			<td>
				<textarea id="summernote" name="content">
					<p>※ 판매글 제목 양식: 제품명과 컬러/그외 단어 첨부 삼가(예: ~팝니다, 급처, 가격인하 등)<br /> <br /> 
					   ※ 1 판매글 1 제품만 등록/1일 판매글 3개까지 가능/1일 동일 제품 중복판매 금지/1개월간 신용 및 거래확인을 위해 판매글 삭제금지(판매 후 개인정보 삭제 가능)-규정 위반 시 제재 대상&nbsp;</p> <p><br /> <br /> <br />&nbsp;</p> 
					<p>1. 활동명(닉네임):</p> <p><br />&nbsp;</p> 
					<p>2. 연락처(전화번호 필수-한글차용 가능/카톡만 등록 불가능/해외거주자 경우 국제 전화번호 등록):</p> <p><br />&nbsp;</p> 
					<p>3. 거래지역:&nbsp;</p> <p><br />&nbsp;</p> 
					<p>4. 제품명:</p><p><br />&nbsp;</p>  
					<p>5. 제품상태(상세하게):&nbsp;</p> <p><br />&nbsp;</p> 
					<p>6. 희망가격(협의/경매금지):</p> <p><br />&nbsp;</p> 
					<p>7. 거래방법:&nbsp;</p> <p><br />&nbsp;</p> 
					<p>8. 제품 이미지(네임택 첨부 필수-카페명+닉네임/중고제품 상세사진 필수):&nbsp;</p>
				</textarea>
			</td>
		</tr>
	</tbody>
</table>
<div class="submitbox">
	<input type="button" name="upload" class="btnSimple" value="등록">
</div>

<input type="hidden" name="user_id" value="${login.id}">
</form>

<script type="text/javascript">


	$(document).ready(function() {
		
		/* summernote 설정 */
		$('#summernote').summernote({
			height: 500,
			dialogsInBody: true,
			lang: "ko-KR",
			disableResizeEditor: true,	// 크기 조절 기능 삭제
			toolbar: [
			    ['style', ['style']],
			    ['font', ['bold', 'italic', 'underline', 'clear']],
			    ['fontname', ['fontname']],
			    ['color', ['color']],
			    ['height', ['height']],
			    ['table', ['table']],
			    ['insert', ['link', 'picture', 'hr']],
			    ['view', ['fullscreen', 'codeview']],
			    ['help', ['help']]
			  ],
			fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
			fontNamesIgnoreCheck : [ '맑은고딕' ],
			focus: false,
			placeholder: '내용을 입력해 주세요',
			
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
	$('input[name="upload"]').click(function () {

		//alert($('input[name=title]').val()); 
		//alert($('#summernote').val());
		// alert($("input[name=bbstype]:radio:checked").val());
		
		var content = $("#summernote").val();
		//alert("content" + content.length);
		
		if($("input[name=bbstype]:radio:checked").length == 0){
			Swal.fire({
				icon : 'warning',
				text : '카테고리를 선택해주세요',
				didClose: () => {
					$("input[name=bbstype]:radio:checked").focus();
				}			        
			});	
			return;
			
		}else if($('input[name=title]').val() == "") {
			Swal.fire({
				icon : 'warning',
				text : '제목을 입력해주세요',
				didClose: () => {
					$('input[name=title]').focus();
				}			        
			});	
			return;
			
		}else if(content.length < 567) {
			Swal.fire({
				icon : 'warning',
				text : '내용을 입력해주세요',
				didClose: () => {
					$('#summernote').focus();
				}			
			});
			return;
		}
		document.getElementById('dealWriteForm').submit(); 
	});
</script>

</body>
</html>
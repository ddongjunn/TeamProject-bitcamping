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

	<div align="left">
	<img src="../resources/images/deal.jpg" height="300" width="800px">
	</div>
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
					<p>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p> 
					<p>제품 :</p> <p>&nbsp;</p> 
					<p>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p> 
					<p>희망 가격 :&nbsp; &nbsp; &nbsp;</p> 
					<p>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p> 
					<p>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p> 
					<p>상품 상태 :</p> <p>&nbsp;&nbsp;</p> 
					<p>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p> 
					<p>연락처 :&nbsp;</p>
				</textarea>
			</td>
		</tr>
	</tbody>
</table>
<div class="submitbox">
	<input type="button" name="upload" value="등록하기">
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
			
		}else if($('#summernote').val() == "") {
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
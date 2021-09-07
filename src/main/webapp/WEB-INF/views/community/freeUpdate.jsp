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
.freeWrite{
	width: 85%;
}
.freeWrite td{
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

<form id="freeUpdateForm" action="/community/freeUpdateAf.do" method="post" enctype="multipart/form-data" >
<table class="freeWrite">
	<tbody>
		<tr>
			<td>
				<input type="text" class="title" name="title" value="${data.title}" placeholder="제목을 입력해 주세요"/>
			</td>
		</tr>
		<tr>
			<td>
				<textarea id="summernote" name="content" required>${data.content}</textarea>
			</td>
		</tr>
	</tbody>
</table>
	<div class="submitbox" >
		<input type="button" class="btnSimple" name="update" value="수정하기">
	</div>

<input type="hidden" name="id" value="${data.user_id }">
<input type="hidden" name="bbstype" value="free">
<input type="hidden" name="community_seq" value="${data.community_seq }">

</form>

<script type="text/javascript">

	$(document).ready(function() {
		
		/* summernote 설정 */
		$('#summernote').summernote({
			height: 500,
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
	$('input[name="update"]').click(function () {

		//alert($('input[name=title]').val()); 
		//alert($('#summernote').val());
		
		var content = $("#summernote").val();
		//alert("content" + content.length);
		
		if($('input[name=title]').val() == "") {
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
		document.getElementById('freeUpdateForm').submit(); 
	});
</script>

</body>
</html>


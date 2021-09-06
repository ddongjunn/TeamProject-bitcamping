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
	.findWrite{
		width: 85%;
	}
	.findWrite td{
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


<form id="findWriteForm" action="/community/findWriteAf.do" method="post" enctype="multipart/form-data" >
<table class="findWrite">
	<tbody>
		<tr>
			<td>
				<input type="text" class="title" name="title" placeholder="제목을 입력해 주세요">
			</td>
		</tr>	
		<tr> 
			<td>
				<textarea id="summernote" name="content">
					<p><br /> ※ 제목 양식 : [지역] ~모집합니다/그외 단어 첨부 삼가</p> <p><br /><br /></p>
               <p>1. 연락처(전화번호 필수-한글차용 가능/카톡만 등록 불가능/해외거주자 경우 국제 전화번호 등록):</p> <p><br />&nbsp;</p> 
               <p>2. 캠핑지역:</p> <p><br />&nbsp;</p> 
               <p>3. 캠핑날짜(ex: 21/06/29- 21/06/30):</p> <p><br />&nbsp;</p> 
               <p>4. 캠핑유형(글램핑,차박 etc) :</p> <p><br />&nbsp;</p> 
               <p>5. 모집인원:</p> <p><br />&nbsp;</p> 
               <p>6. 모집소개:</p>
				</textarea>
			</td>
		</tr>
	</tbody>
</table>
<div class="submitbox">
		<input type="button" name="upload" class="btnSimple" value="등록">
</div>

<input type="hidden" name="user_id" value="${login.id}">
<input type="hidden" name="bbstype" value="find">
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
	
		
		$('input[name="upload"]').click(function () {

			//alert($('input[name=title]').val()); 
			//alert($('#summernote').val());
			var content = $("#summernote").val();
			alert("content" + content.length);
			
		    if($('input[name=title]').val() == "") {
				Swal.fire({
					icon : 'warning',
					text : '제목을 입력해주세요',
					didClose: () => {
						$('input[name=title]').focus();
					}			        
				});	
				return;
				
			}else if(content.length === 427) {
				Swal.fire({
					icon : 'warning',
					text : '내용을 입력해주세요',
					didClose: () => {
						$('#summernote').focus();
					}			
				});
				return;
			}
			document.getElementById('findWriteForm').submit(); 
		});
</script>

</body>
</html>
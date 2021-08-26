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
				<input type="text" class="title" name="title" placeholder="제목을 입력해 주세요" required>
			</td>
		</tr>	
		<tr> 
			<td>
				<textarea id="summernote" name="content">
				<p>&lt;수제비 멤버스 가입 양식&gt;</p> <p>&nbsp;</p> <p>1. 응시종목 :</p> 
				<p>ex) 정보처리기사 / 빅데이터 분석기사 등</p> <p>&nbsp;</p> <p>2.전공여부 :</p> 
				<p>ex) 전공(IT관련) / 비전공</p> <p>&nbsp;</p> 
				<p>3. 체크리스트(&nbsp;https://cafe.naver.com/soojebi/19981&nbsp;) 확인여부 :</p> 
				<p>ex) 반드시 확인해주세요!</p> <p>&nbsp;</p> <p>4. 하고 싶은 말 :</p> 
				<p>ex) 앞으로 잘 부탁드립니다~!</p> <p>﻿</p>
				</textarea>
			</td>
		</tr>
	</tbody>
</table>
<div class="submitbox">
	<input type="submit" id="write" value="등록">
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
	
</script>

</body>
</html>
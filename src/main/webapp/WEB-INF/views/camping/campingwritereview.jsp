<%@page import="com.camping.bit.dto.CampingDetailDto"%>
<%@page import="com.camping.bit.dto.CampingListDto"%>
<%@page import="com.camping.bit.dto.CampingBbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">
<link href="/resources/css/campingsite/campingreview1.css" rel="stylesheet" type = "text/css">
</head>
<body>
<% 
CampingListDto campinglist = (CampingListDto)request.getAttribute("campinglistfordetail");
%>

<form id = "writeform" name = "write_review_form" method="post" action="campingwritereviewAf.do" enctype = "multipart/form-data" autocomplete = "off">

<div style="clear:both"></div>

<div id = "writer_info">
<input type="hidden" name="user_id" value="${login.id}">
<input type="hidden" name = "nickname" value ="${login.nickname}">
<input type = "hidden" name = "contentid" value = '<%=campinglist.getContentid() %>'>
	<h2>${login.nickname}님의 소중한 리뷰</h2>
	<h2><input name="title" id = "title" type = "text" placeholder = "제목을 입력해주세요" size = "51"></h2>
</div>

<div style="clear:both"></div>
<div id="summernotebox">
		<textarea id="summernote" name="content" wrap = "hard"></textarea>
</div>

<div class = "writebutton">
 <button type = "button" value = "writeReview" id = "campingwritereview" class = "btn btn-light">글쓰기</button>
 </div>
</form>
</body>

<script type="text/javascript">
	$(document).ready(function() {
		
		/* summernote 설정 */
		$('#summernote').summernote({
			height: 600,
			width : 850,
			dialogsInBody: true,
			lang: "ko-KR",
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
			placeholder: '소중한 리뷰는 다른 캠핑러에게 큰 도움이 됩니다!',
			
			callbacks: {
		         onImageUpload: function(files, editor, welEditable) {
		               for (var i = files.length - 1; i >= 0; i--) {
		                  sendFile(files[i], this);
		               }
		           }
		      }
		}); //summernote 끝나는 곳
		
		$("#campingwritereview").click(function(){
			var title = $("#title").val();
			var content = $("#summernote").val();
			
			if(title == ""){
				alert("제목을 입력하지 않으셨네요!");
				$("#title").focus();
			}
			if(content == ""){
				alert("내용을 적어주시면 큰 도움이 될 거에요");
				$("#summernote").focus();
			}
			if(title != "" && content != ""){
			document.getElementById("writeform").submit();
			}
			
		});//click function 끝나는 곳
	});//document.ready 끝나는 곳
	
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
</html>
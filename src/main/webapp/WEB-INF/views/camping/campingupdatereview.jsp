<%@page import="com.camping.bit.dto.CampingDetailDto"%>
<%@page import="com.camping.bit.dto.CampingListDto"%>
<%@page import="com.camping.bit.dto.CampingBbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
CampingBbsDto campingbbs = (CampingBbsDto)request.getAttribute("campingdetailreview");

%>

<form name = "update_review_form" action="campingupdatereviewAf.do" method="post">
<c:set var = "campingbbs" value = '<%=campingbbs%>'></c:set>
<input type= "hidden" name="review_seq" value="${campingbbs.review_seq}">
<input type = "hidden" name = "contentid" value = "${campingbbs.contentid}">

<div style="clear:both"></div>
<div id = "writer_info">
	<h2>${login.nickname}님 무엇을 수정해볼까요?</h2>
	<h2><input name="title" type = "text" placeholder = "제목을 입력해주세요" value = ${campingbbs.title }></h2>
</div>

<div style="clear:both"></div>

<div id="summernotebox">
		<textarea id="summernote" name="content" >${campingbbs.content}</textarea>
</div>
<button type = "submit" value = "수정하기" id = "campingupdatereview" class = "btn btn-outline-success btn-sm">수정하기</button>

</form>
</body>

<script type="text/javascript">
	$(document).ready(function() {
		
		/* summernote 설정 */
		$('#summernote').summernote({
			height: 800,
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
</html>
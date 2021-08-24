<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- JQuery -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<!-- summernote -->
<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">
<!-- sweetalert2 -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style type="text/css">

@import url(//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);

fieldset, label { margin: 0; padding: 0; }
body{ margin: 20px; }
h1 { font-size: 1.5em; margin: 10px; }

/****** Style Star Rating Widget *****/

.rating { 
  border: none;
  float: left;
}

.rating > input { display: none; } 
.rating > label:before { 
  margin: 5px;
  font-size: 1.25em;
  font-family: FontAwesome;
  display: inline-block;
  content: "\f005";
}

.rating > .half:before { 
  content: "\f089";
  position: absolute;
}

.rating > label { 
  color: #ddd; 
 float: right; 
}

/***** CSS Magic to Highlight Stars on Hover *****/

.rating > input:checked ~ label, /* show gold star when clicked */
.rating:not(:checked) > label:hover, /* hover current star */
.rating:not(:checked) > label:hover ~ label { color: #FFD700;  } /* hover previous stars in list */

.rating > input:checked + label:hover, /* hover current star when changing rating */
.rating > input:checked ~ label:hover,
.rating > label:hover ~ input:checked ~ label, /* lighten current selection */
.rating > input:checked ~ label:hover ~ label { color: #FFED85;  } 

</style>
</head>
<body>
<form id="reviewForm" action="/rent/writeReviewAf.do" method="post" enctype="multipart/form-data" autocomplete="off">
	<h3>상품 후기 입력</h3>
	
	<div>별점입력</div>
	<div>
		<fieldset class="rating">
		    <input type="radio" id="star5" name="rate" value="5" required /><label class = "full" for="star5"></label>
		    <!-- <input type="radio" id="star4half" name="rate" value="4.5" /><label class="half" for="star4half"></label> -->
		    <input type="radio" id="star4" name="rate" value="4" /><label class = "full" for="star4"></label>
		    <!-- <input type="radio" id="star3half" name="rate" value="3.5" /><label class="half"></label> -->
		    <input type="radio" id="star3" name="rate" value="3" /><label class = "full" for="star3"></label>
		    <!-- <input type="radio" id="star2half" name="rate" value="2.5" /><label class="half" for="star2half"></label> -->
		    <input type="radio" id="star2" name="rate" value="2" /><label class = "full" for="star2"></label>
		    <!-- <input type="radio" id="star1half" name="rate" value="1.5" /><label class="half" for="star1half"></label> -->
		    <input type="radio" id="star1" name="rate" value="1" /><label class = "full" for="star1"></label>
		    <!-- <input type="radio" id="starhalf" name="rate" value="0.5" /><label class="half" for="starhalf"></label> -->
		</fieldset>
	</div>
	<br>
	<br>
	<div>제목</div>
	<div id="contentbox" style="width: 100%; margin: auto;">
		<input type="text" id="title" name="title" placeholder="제목을 입력해 주세요" style="width: 100%">
	</div>
	<div>후기 작성</div>
	<div id="contentbox" style="width: 100%; margin: auto;">
		<textarea id="content" name="content" placeholder="리뷰를 입력해 주세요" style="width: 100%"></textarea>
	</div>
	<div>사진 등록</div>
	<div class="image-container">
			<img style="height: 100px;" id="preview-image" src="https://dummyimage.com/500x500/ffffff/000000.png&text=preview+image">
			<input type="file" name="reviewImage" accept="image/*" id="input-image" style="display: block;">
	</div>
	
	<input type="hidden" name="order_Seq" value="${order_Seq}">
	<input type="hidden" name="user_Id" value="${login.id}">
	
	<div>
		<input type="button" id="send" value="제출하기">
	</div>
	
</form>

<script type="text/javascript">
	
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
	
	$("#send").click(function() {		
		
		if(${login == null}) {
			
    		Swal.fire({
    			  icon: 'warning',
    			  title: '로그인 후 이용해 주세요',
    			  confirmButtonText: '닫기',
    			  showCancelButton: true,
    			  cancelButtonText: '뒤로',
    		}).then((result) => {
    			if (result.isConfirmed) {
    				window.close();
    			}
    		});
    		
    	} else if($("input[name=rate]:radio:checked").length < 1){
    		
			Swal.fire({
	  			  icon: 'warning',
	  			  title: '별점을 입력해 주세요!'
	  		});
			
		} else if($("#title").val() == ""){
			
			Swal.fire({
	  			  icon: 'warning',
	  			  title: '제목을 입력해 주세요!'
	  		});
			$("#title").focus();
			
		} else if($("#content").val() == ""){
			
			Swal.fire({
	  			  icon: 'warning',
	  			  title: '후기를 입력해 주세요!'
	  		});
			$("#content").focus();
			
		} else {
			
	 		var params = $("#reviewForm").serialize();
	 		
			$.ajax({
				url : '<c:url value='/rent/writeReviewAf.do' />',
				data : params,
				success : function(xh){	
							opener.parent.location.reload();
							window.close();
				}
			});
        }
	});
	
</script>

</body>
</html>
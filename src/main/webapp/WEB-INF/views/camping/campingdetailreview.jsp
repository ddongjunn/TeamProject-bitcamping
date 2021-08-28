<%@page import="com.camping.bit.dto.CampingCommentDto"%>
<%@page import="java.util.List"%>
<%@page import="com.camping.bit.dto.CampingDetailDto"%>
<%@page import="com.camping.bit.dto.CampingListDto"%>
<%@page import="com.camping.bit.dto.CampingBbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!--
CREATE TABLE CAMPING_BBS_COMMENT
(
    COMMENT_SEQ    NUMBER(8)         NOT NULL, 
    REVIEW_SEQ     NUMBER(8)         NOT NULL, 
    USER_ID        VARCHAR2(100)     NOT NULL, 
    CONTENT        VARCHAR2(4000)    NOT NULL, 
    WDATE          DATE              NOT NULL, 
    REF            NUMBER(8)         NOT NULL, 
    STEP           NUMBER(8)         NOT NULL, 
    DEPTH          NUMBER(8)         NOT NULL, 
    CONSTRAINT PK_CAMPING_BBS_COMMENT PRIMARY KEY (COMMENT_SEQ)
)

CREATE SEQUENCE CAMPING_BBS_COMMENT_SEQ
START WITH 1
INCREMENT BY 1;

ALTER TABLE CAMPING_BBS_COMMENT
ADD CONSTRAINT FK_CAMPING_BBS_COMMENT_REVIEW_ FOREIGN KEY (REVIEW_SEQ)
REFERENCES CAMPING_BBS (REVIEW_SEQ);

ALTER TABLE CAMPING_BBS_COMMENT
ADD CONSTRAINT FK_CAMPING_BBS_COMMENT_USER_ID FOREIGN KEY (USER_ID)
REFERENCES MEMBER (id);-->

<link href="/resources/css/campingsite/campingreview1.css" rel="stylesheet" type = "text/css">
</head>
<body>
<% 
CampingBbsDto campingbbs = (CampingBbsDto)request.getAttribute("campingdetailreview");
%>
<input type = "hidden" name = "contentid" value = "${campingbbs.contentid}">
<input type="hidden" name="user_id" value="${login.id}">
<h2><%=campingbbs.getUser_id() %>님의 소중한 리뷰</h2>
<div style="clear:both"></div>
<div id = "review">
<h3>후기 번호 : <%=campingbbs.getReview_seq() %></h3>
<h3>제목 : <%=campingbbs.getTitle() %></h3>
<h3>작성일 : <%=campingbbs.getWdate() %> </h3>
<h3>내용 : <%=campingbbs.getContent() %></h3>

<c:set var = "id" value = '<%=campingbbs.getUser_id()%>'/>
<c:if test="${login.id eq id}">
	<button type = "button" id = "updateBtn" class = "btn btn-outline-success btn-sm" >리뷰 수정하기</button>
	<button type = "button" id = 'deleteBtn' class = "btn btn-outline-success btn-sm" >리뷰 삭제하기</button>
</c:if>
</div>
<div id = "commentlist">
<div id = "writer">
	<c:choose>
		<c:when test="${not empty useridx}">
			${login.nickname}님 댓글을 남겨주세요!
			<textarea name = "comment" id = "content" placeholder="댓글을 입력해주세요" rows = "5" cols = "100" ></textarea>
			<button type = "button" id = "writeCommentBtn" class = "btn btn-outline-success btn-sm" >등록</button> 
		</c:when>
		<c:otherwise>
			댓글 등록은 로그인 후 가능합니다!
		</c:otherwise>
	</c:choose>
</div>
 
 <table>
    <thead>
        <tr>
          <td></td>
          <td></td>
        </tr>
    </thead>
    <tbody id="commentlisting">
    <!-- ajax로 불러와서 뿌려주는 공간 -->
    </tbody>	
</table>

 
 <div class="container" style = "width : 100%; text-align : center">
    <div style = "display : inline-block">
	    <nav aria-label="Page navigation">
	        <ul class="pagination" id="pagination"></ul>
	    </nav>
    </div>
</div>
 
</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	
	comments(); //댓글뿌리기
	
	$("#updateBtn").click(function(){ //리뷰 수정하기
		location.href = "campingupdatereview.do?review_seq=" +<%=campingbbs.getReview_seq()%> + "&contentid=" + <%=campingbbs.getContentid()%>;
	}); //updateBtn 끝나는 곳
	
	$("#deleteBtn").click(function(){ //리뷰 삭제하기
		console.log("click");
	if(confirm("삭제하시겠습니까?")){
		var paramData = {"review_seq" : <%=campingbbs.getReview_seq()%>};
	$.ajax({
		url : '/csite/campingdeletereview.do',
		type : 'post',
		data : paramData,
		dataType : 'text',
		success : function(result){
			if(result =='success'){
				alert("성공적으로 삭제되었습니다");
			 	location.href = "campingdetail.do?contentid=" + <%=campingbbs.getContentid()%>;	
			}
		}, 
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			}); //ajax (delete)끝나는 곳
		} //삭제여부 물어보는 곳
	}); //deleteBtn 끝나는 곳

	$("#writeCommentBtn").click(function(){ //리뷰에 댓글달기
		//console.log("click");
		const user_id = "${login.id}";
		const nickname = "${login.nickname}";
		const review_seq = new URLSearchParams(location.search).get('review_seq');
		const content =  $("#content").val();
		<fmt:formatDate var="formatdate" value="${today}" pattern="yyyy년 MM월 dd일"/>
		const wdate = "${formatdate}";
		
		let today = new Date();   

		let year = today.getFullYear(); // 년도
		let month = leadZero((today.getMonth() + 1),2);  // 월
		let date = today.getDate();  // 날짜
		
		var paramData = {"user_id" : user_id, "nickname" : nickname, "review_seq" : review_seq, "content" : content};
		console.log(paramData);
		$.ajax({
			url : '/csite/campingWriteComment.do',
			type : 'get',
			dataType : 'text',
			data : paramData,
			success : function(result){
				//console.log(result);
				if(result == "success"){
				//$("#commentlisting").html("");
					let str = "<tr>"
						+ "<td>" + nickname + "</td>"
						+ "<td>" + year + "-" + month + "-" + date + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td>" + content + "</td>"
						+ "<td>" + "<a href = 'javascript:commentUpdate();'>수정</a>" 
						+ "<a href = 'javascript:commentDelete();'>삭제</a>" 
						+ "</td>" + "</tr>";
					$(".nodata").html("");
					$("#commentlisting").prepend(str);
				
				}
			}, //success 끝나는 곳
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    console.log("실패");
			}
		}); //ajax commentBtn 끝나는 곳 
	});//writeCommentBtn 끝나는 곳
	
	
	let totalCount = ${commentPage};	// 서버로부터 총글의 수를 취득
	//alert(totalCount);
	let nowPage = ${pageNumber};	// 서버로부터 현재 페이지를 취득
	//alert(nowPage);

	let pageSize = 10;//페이지의 크기(1~10) [1] ~ [10]

	let _totalPages = totalCount / pageSize;

	if(totalCount % pageSize > 0){
		_totalPages++;
	}
	 if($('#pagination').data("twbs-pagination")){
		  $('#pagination').twbsPagination('destroy');}// 페이지 갱신 : 페이징을 갱신해 줘야 번호가 재설정된다.

		 $("#pagination").twbsPagination({ 
			startPage : nowPage,
			totalPages : (_totalPages==0)?1:_totalPages, //전체 페이지
			visiblePages: 10, //최대로 보여줄 페이지
			first: '<span sria-hidden="true">«</span>',
			prev: "이전",
			next: "다음",
			last: '<span sria-hidden="true">»</span>',
			initiateStartPageClick:false,
			onPageClick: function(event,page){
				pagemove(page);
			}
		}); //페이지네이션 끝 
	}); //document.ready 끝나는곳

	function commentDelete(comment_seq){	
	console.log("delete되나요click");
	var paramData = {"comment_seq" : comment_seq};
	console.log(paramData);
	 $.ajax({
		url : '/csite/campingDeleteComment.do',
		type : 'post',
		dataType : 'text',
		data : paramData,
		success : function(result){
			console.log(result);
			if(result == "success"){
				alert("삭제 성공");
				$('.commentArea' + comment_seq).remove();
			}
		}, //success 끝나는 곳
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    console.log("실패");
		}
	}); //ajax sendUpdateBtn 끝나는 곳  
}
	function commentUpdate(comment_seq,content){ //폼보여주는 function
	console.log("commentUpdateBtn 클릭");
	//const content = $("#commentUpdateBtn").val();
	//console.log(comment_seq, content);
	//$('.commentContent'+comment_seq).hide();
	let str = `<textarea name ="content_${'${comment_seq}'}" id ="contentupdate" value="${'${content}'}'" placeholder="수정내용을 입력해주세요" rows="5" cols = "100">${'${content}'}'</textarea>
        <button type="button" id="sendUpdateBtn" onClick="update(${'${comment_seq}'})" class = "btn btn-outline-success btn-sm" >수정</button>`;
	//console.log(str);
	//$("#updateform").append(str);
	$('#commentUpdate' + comment_seq).html(str);
	}; //commentUpdateBtn 클릭 끝
	
	
	function update(comment_seq){	
	console.log("update되나요click");
	var updateContent = $('[name=content_'+comment_seq+']').val();
	var paramData = {"comment_seq" : comment_seq, "content" : updateContent};
	console.log(paramData);
	 $.ajax({
		url : '/csite/campingUpdateComment.do',
		type : 'post',
		dataType : 'text',
		data : paramData,
		success : function(result){
			console.log(result);
			if(result == "success"){
				//alert("수정 성공");
				let str = `${'${updateContent}'}`;
				$('.commentUpdate' + comment_seq).html(str);
			}
		}, //success 끝나는 곳
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    console.log("실패");
			}
		}); //ajax sendUpdateBtn 끝나는 곳  
	};//function update 끝나는 곳

	function comments(){ //댓글 뿌려주기
		 const review_seq = new URLSearchParams(location.search).get('review_seq');
		 var paramData = {"review_seq" : review_seq};
		 //console.log(paramData);
			$.ajax({
				url : '/csite/campingReviewComment.do',
				type : 'get',
				dataType : 'text',
				data : paramData,
				success : function(response){
					//alert(JSON.stringify(response));
					//console.log(response);
					$("#reviewlisting").html("");
					const parsedResponse = JSON.parse(response);
	
					if(response == '[]'){
						let str = "<tr>"
					    +"<td colspan='2' class='nodata'>아직 아무도 댓글을 달지 않았어요! 첫 댓글을 달아볼까요?</td>"
					    +"</tr>"
					    $("#commentlisting").append(str);
					}
					
						parsedResponse.forEach( (item, idx) => {
						let str = "<tr class = commentArea" + item.comment_seq+ ">"
							+ "<td>" + item.nickname + "</td>"
							+ "<td>" + item.wdate+ "</td>"
							+ "</tr>"
							+ "<tr class = commentArea" + item.comment_seq + " id = commentUpdate" + item.comment_seq + ">"
							+ "<td>" + item.content + "</td>"
							+ "<c:if test='${not empty useridx}'>"
							+ "<td>" + "<a href = 'javascript:commentUpdate(" + item.comment_seq + ",&quot;" + item.content + "&quot;);'>수정</a>" 
							+ "<a href = 'javascript:commentDelete(" + item.comment_seq + ");'>삭제</a>" 
							+ "</td>"+ +"</c:if>"+ "</tr>";
							console.log(item.user_id);
							//console.log(${login.id});
						$("#commentlisting").append(str);
						}); //response foreach문 끝나는 곳
						
				
				/* 	parsedResponse.forEach( (item, idx) => {
						
						let str = "<tr>"
							+ "<td>" + item.user_id + "</td>"
							+ "<td>" + item.wdate+ "</td>"
							+ "</tr>"
							+ "<tr class = commentArea" + item.comment_seq + ">"
							+ "<td>" + item.content + "</td>"
							+ "<td>" + "<a href = 'javascript:commentUpdate(" + item.comment_seq + ",&quot;" + item.content + "&quot;);'>수정</a>" 
							+ "<a href = 'javascript:commentDelete(" + item.comment_seq + ");'>삭제</a>" 
							+ "</td>"+ "</tr>";
					
						$("#commentlisting").append(str);
						}); //response foreach문 끝나는 곳 */
					},//success 끝나는 곳
				error:function(request,status,error){
				    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}//error 끝나는 곳
			}); //pagemove ajax 끝나는 곳
		}; //comments function 끝나는 곳
		
		
	function pagemove(page){ //누르는 순간 페이지네이션에 지금 page 숫자를 알려준다
		 const pageNumber = page-1;
		 //console.log(pageNumber);
		 //alert(pageNumber);
		 const review_seq = new URLSearchParams(location.search).get('review_seq');
		 var paramData = {"review_seq" : review_seq, "pageNumber" : pageNumber};
		// console.log(paramData);
			$.ajax({
				url : '/csite/campingReviewComment.do',
				type : 'POST',
				dataType : 'text',
				//contextType : "text",
				data : paramData,
				success : function(response){
					//alert(JSON.stringify(response));
					console.log(response);
					$("#commentlisting").html("");
					const parsedResponse = JSON.parse(response);
	
					if(response == '[]'){
						let str = "<tr>"
					    +"<td colspan='2' class='nodata'>에러가 발생했어요</td>"
					    +"</tr>"
					    $("#commentlisting").append(str);
					}
					parsedResponse.forEach( (item, idx) => {
						let str = "<tr>"
							+ "<td>" + item.nickname + "</td>"
							+ "<td>" + item.wdate+ "</td>"
							+ "</tr>"
							+ "<tr class = commentArea" + item.comment_seq + ">"
							+ "<td>" + item.content + "</td>"
							+ "<td>" + "<a href = 'javascript:commentUpdate(" + item.comment_seq + ",&quot;" + item.content + "&quot;);'>수정</a>" 
							+ "<a href = 'javascript:commentDelete(" + item.comment_seq + ");'>삭제</a>" 
							+ "</td>"+ "</tr>";
						$("#commentlisting").append(str);
						});
					},//success 끝나는 곳
				error:function(request,status,error){
				    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}//error 끝나는 곳
			}); //pagemove ajax 끝나는 곳
		} //pagemove function 끝나는 곳
		
		
			
			
			   function leadZero(num, n) {
		            var leadZero = "";
		            num = num.toString();
		            if (num.length < n) { for (var i = 0; i < n - num.length; i++) leadZero += "0"; }
		            return leadZero + num;
		        } //월 앞에 0붙이기
		

</script>
</html>
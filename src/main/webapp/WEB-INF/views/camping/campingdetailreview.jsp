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
 CREATE TABLE CAMPING_BBS
(
    REVIEW_SEQ    NUMBER(8)         NOT NULL, 
    CONTENTID     NUMBER(38)        NOT NULL, 
    TITLE         VARCHAR2(100)     NOT NULL, 
    CONTENT       VARCHAR2(4000)    NOT NULL, 
    WDATE         DATE              NOT NULL, 
    READCOUNT     NUMBER(8)         NOT NULL, 
    USER_ID       VARCHAR2(100)     NOT NULL, 
    REVISIT       NUMBER(8)         NOT NULL, 
    LIKE_COUNT    NUMBER(8)         NULL, 
    DEL           NUMBER(8)         NOT NULL, 
    CONSTRAINT PK_CAMPINGBBS PRIMARY KEY (REVIEW_SEQ)
) 
CREATE SEQUENCE CAMPING_BBS_SEQ
START WITH 1
INCREMENT BY 1;

ALTER TABLE CAMPING_BBS
ADD CONSTRAINT FK_CAMPING_BBS_USER_ID_member_ FOREIGN KEY (USER_ID)
REFERENCES member (id)

ALTER TABLE CAMPING_BBS
ADD CONSTRAINT FK_CAMPING_BBS_CONTENTID_CAMPI FOREIGN KEY (CONTENTID)
REFERENCES CAMPING_LIST (CONTENTID)


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
CampingListDto campinglist = (CampingListDto)request.getAttribute("campinglistfordetail");
%>
<input type = "hidden" name = "contentid" value = "${campingbbs.contentid}">
<input type="hidden" name="user_id" value="${login.id}">
<%-- <input type = "hidden" value = "<%=campinglist.getContentid()%>"> --%>

<div style="clear:both"></div>

<div class="campingreview_title" style="width: 60%;">
	캠핑장 리뷰
	<p>캠핑장 이용 경험을 다른 분들과 공유해주세요</p>
	<hr style="margin: 0 auto 30px;">
</div>

<div id = "review"><!-- 리뷰 뿌려지는 영역 -->
	<h2 class = "titless" style = "text-align : center"><%=campinglist.getFacltnm()%>에 대한 <%=campingbbs.getNickname() %>님의 소중한 리뷰

	<c:choose>
		<c:when test = "${helpcheck eq '0' or empty helpcheck}">
		<!-- 아무것도 나타나지 않음 -->
		</c:when>
		<c:otherwise>
			<img src = "<%=request.getContextPath()%>/resources/images/campingsite/positive-vote.png" width = "30" height = "20">
		</c:otherwise>
	</c:choose>
	</h2>
	<br>
	<table class = "table">
		<tr>
			<th scope = "row" style="background-color: #f0f0f0;">제목</th>
			<td><%=campingbbs.getTitle() %></td>
		</tr>
		<c:set var="writtendate" value="<%=campingbbs.getWdate()%>" />
		<tr>
			<th scope = "row" style="background-color: #f0f0f0;">작성일</th>
			<td><fmt:formatDate value="${writtendate}" type="both"/></td>
		</tr>
		<tr>
			<th scope = "row" style="vertical-align: middle; background-color: #f0f0f0;">내용</th>
			<td style="height: 200px;"><%=campingbbs.getContent() %></td>
		</tr>
	</table>
</div><!-- review div 끝나는 곳 -->

	<c:set var = "id" value = '<%=campingbbs.getUser_id()%>'/>
	<div class = "reviewmanage">
		<c:choose> <%-- 글을 쓴 사람과 로그인 한 사람이 동일인인지 구분하는 곳 --%>
			<c:when test="${login.id eq id}">
				<button type = "button" id = "goback" class = "btn btn-light btn-sm" onclick = "location.href = 'campingdetail.do?contentid=<%=campingbbs.getContentid()%>'">캠핑장 돌아가기</button>
				<button type = "button" id = "updateBtn" class = "btn btn-light btn-sm" >리뷰 수정하기</button>
				<button type = "button" id = 'deleteBtn' class = "btn btn-light btn-sm" >리뷰 삭제하기</button>
			</c:when>
			<c:otherwise>
			
				<div id = "thumbsup">
				<c:choose>
					<c:when test="${not empty useridx}"><%--글 쓴 사람과 보고 있는 사람이 다름(회원인데 글 쓴 사람은 아님)--%>
						<c:choose>
							<c:when test = "${helpcheck eq '0' or empty helpcheck}"><%--현재 로그인 한 사용자가 하트를 누르지 않았을때 like.user_id!=login.id --%>
								<button type = "button" id = "goback" class = "btn btn-light btn-sm" onclick = "location.href = 'campingdetail.do?contentid=<%=campingbbs.getContentid()%>'">캠핑장 돌아가기</button>
								<span><button type = "button" id = "recommend" class = "btn btn-light btn-sm" >도움이 됐어요</button></span>
							</c:when>
							<c:otherwise><%--likecheck가 1이면 엄지가 나옴 --%>
								<button type = "button" id = "goback" class = "btn btn-light btn-sm" onclick = "location.href = 'campingdetail.do?contentid=<%=campingbbs.getContentid()%>'">캠핑장 돌아가기</button>
							</c:otherwise>
						</c:choose><%--두번째 choose 끝 --%>
					</c:when>
					<c:otherwise><%--비회원임 --%>
						<div class = "thumbsup2">
							<button type = "button" id = "goback" class = "btn btn-light btn-sm" onclick = "location.href = 'campingdetail.do?contentid=<%=campingbbs.getContentid()%>'">캠핑장 돌아가기</button>
						</div>
					</c:otherwise>
				</c:choose><%--첫번째 choose 끝 --%>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

<div id = "commentlist">
	<div id = "writer">
		<c:choose>
			<c:when test="${not empty useridx}">
				<div style="text-align: left;">${login.nickname}님 댓글을 남겨주세요!</div>
				<br/>
				<textarea name = "comment" id = "content" placeholder="댓글을 입력해주세요"></textarea>
				<div class = "writecommentsec"><button type = "button" id = "writeCommentBtn" class = "btn btn-light btn-sm" >등록</button></div>
			</c:when>
			<c:otherwise>
				댓글 등록은 로그인 후 가능합니다!
			</c:otherwise>
		</c:choose>
	</div>
<br>
	<div class="comment_table">
		 <table style="width: 100%;">
		 	<col width="85%">
		 	<col width="15%">	 	
		    <thead>
		        <tr>
		          <td></td>
		          <td></td>
		        </tr>
		    </thead>
		    <tbody id="commentlisting"> <!-- ajax로 불러와서 뿌려주는 공간 -->
		   		
		    </tbody>	
		</table>
	</div>
 
	<div class="container"><!-- 페이지네이션 들어가는 곳 -->
	    <div style = "display : inline-block">
		    <nav aria-label="Page navigation">
		        <ul class="pagination" id="pagination"></ul>
		    </nav>
	    </div>
	</div>
</div><!-- commentlist div 끝나는 곳 -->
</body>


<script type="text/javascript">
$(document).ready(function(){

	comments(); //제일 먼저 화면에서 댓글뿌리기
	
	$("#updateBtn").click(function(){ //리뷰 수정하기
		location.href = "campingupdatereview.do?review_seq=" +<%=campingbbs.getReview_seq()%> + "&contentid=" + <%=campingbbs.getContentid()%>;
	}); //updateBtn 끝나는 곳

	$("#deleteBtn").click(function () { //리뷰 삭제하기
		//console.log("click");

		swal.fire({
			icon: 'warning',
			text: '삭제하시겠습니까?',
			showCancelButton: true,
			cancelButtonText: '취소',
			confirmButtonText: `확인`,
		}).then((result) => {
			/* Read more about isConfirmed, isDenied below */
			if (result.isConfirmed) {

				var paramData = {"review_seq": <%=campingbbs.getReview_seq()%>};

				$.ajax({
					url: '/csite/campingdeletereview.do',
					type: 'post',
					data: paramData,
					dataType: 'text',
					success: function (result) {
						if (result == 'success') {
							//alert("성공적으로 삭제되었습니다");
							location.href = "campingdetail.do?contentid=" + <%=campingbbs.getContentid()%>;
						}
					},
					error: function (request, status, error) {
						alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
					}
				}); //ajax (delete)끝나는 곳
			}
		})
	}); //deleteBtn 끝나는 곳

	////////////////////////////////////////////페이징////////////////////////////////////////////////
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
	///////////////////////////////////////////////페이징////////////////////////////////////////////
		
		
	$("#writeCommentBtn").click(function(){ //리뷰에 댓글달기
		const user_id = "${login.id}";
		const nickname = "${login.nickname}";
		const review_seq = new URLSearchParams(location.search).get('review_seq');
		const content =  $("#content").val();
		
		let today = new Date();   

		let year = today.getFullYear(); // 년도
		let month = leadZero((today.getMonth() + 1),2);  // 월
		let date = leadZero(today.getDate(),2);  // 날짜
		
		var paramData = {"user_id" : user_id, "nickname" : nickname, "review_seq" : review_seq, "content" : content};
		console.log(paramData);
			if(content ==""){
				swal.fire({
					icon: 'warning',
					text: '내용을 입력하지 않으셨네요!',
					didClose: () =>{
					}
				})

			}else{
			$.ajax({
				url : '/csite/campingWriteComment.do',
				type : 'get',
				dataType : 'text',
				data : paramData,
				success : function(response){
					if(response != -1){
						
						let conditionalname = nickname=='<%=campingbbs.getNickname()%>'? `<font color = #1FB154>${'${nickname}'} <i class="fas fa-heart"></i></font>`:nickname;
						//alert(conditionalname);
						let str = "<tr class = commentArea" + response + " style='height: 30px;'>"
							+ "<td style = 'font-weight : bold;'>" + conditionalname + "</td>"
							+ "<td style='text-align: right;'>" + year + "-" + month + "-" + date + "</td>"
							+ "</tr>"
							+ "<tr class = commentArea" + response + " id = commentUpdate" + response + " style='border-bottom: 1px solid rgb(0,0,0,.1); height: 30px;'>"
							+ "<td>" + content + "</td>"
							+ "<td style='text-align: right;'>" + "<a href = 'javascript:commentUpdate(" + response + ",&#34;" +  content + "&#34;);' style='color: #FFA600'>수정</a> / " 
							+ "<a href = 'javascript:commentDelete(" + response + ");' style='color: #FFA600'>삭제</a>" 
							+ "</td>" + "</tr>";
						$(".nodata").html("");
						document.getElementById("content").value='';
						$("#commentlisting").prepend(str);			
					}
				}, //success 끝나는 곳
				error:function(request,status,error){
				    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				    console.log("실패");
				}
			}); //ajax writeCommentBtn 끝나는 곳 
		
		$.ajax({
			url : '/csite/plusCampingReviewCommentCount.do',
			type : 'get',
			dataType : 'text',
			data : paramData,
			success : function(response){
			let totalCount = response;	// 서버로부터 총글의 수를 취득
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
			}, 
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
				}); //ajax plusCommentCount 끝나는 곳
			}//else문 끝나는 곳
		});//writeCommentBtn 끝나는 곳

	$("#recommend").click(function(){
		//console.log('추천 클릭됨');
		const review_seq = "${reviewidx}";
		const user_id = "${useridx}";
		const likecount = "${likecount}";
		const contentid = "${campingidx}";
		
		var paramData = {"review_seq" : review_seq, "user_id" : user_id, "contentid" : contentid}
		console.log(paramData);
			$.ajax({
			url : '/csite/plusCampingHelp.do',
			type : 'get',
			data : paramData,
			dataType : 'text',
			success : function(result){
				//alert(result);
				if(result !=-1){
					//alert("성공");
				}
			}, 
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
			});//ajax 끝나는 곳
		$(".titless").append("<img src = '<%=request.getContextPath()%>/resources/images/campingsite/positive-vote.png' width = '30' height = '30'>")
		$("#thumbsup").remove();
		});//click function 끝나는곳
}); //document.ready 끝나는곳

	function commentDelete(comment_seq){	
		/*console.log("delete되나요click");*/
		const review_seq = new URLSearchParams(location.search).get('review_seq');
		var paramData = {"comment_seq" : comment_seq, "review_seq" : review_seq};
		/*console.log(paramData);*/

		swal.fire({
			icon: 'warning',
			text: '삭제하시겠습니까?',
			showCancelButton: true,
			cancelButtonText: '취소',
			confirmButtonText: `확인`,
		}).then((result) => {
			/* Read more about isConfirmed, isDenied below */
			if (result.isConfirmed) {
				$.ajax({
					url : '/csite/campingDeleteComment.do',
					type : 'post',
					dataType : 'text',
					data : paramData,
					success : function(result){
						console.log(result);
						if(result !=-1){
							//alert("삭제 성공");
							$('.commentArea' + result).remove();
						}
					}, //success 끝나는 곳
					error:function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						console.log("실패");
					}
				}); //ajax sendUpdateBtn 끝나는 곳

				$.ajax({
					url : '/csite/minusCampingReviewCommentCount.do',
					type : 'get',
					dataType : 'text',
					data : paramData,
					success : function(response){
						let totalCount = response;	// 서버로부터 총글의 수를 취득
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
					},
					error:function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				}); //ajax minusCommentCount 끝나는 곳
			}
		})
		//삭제하겠다고 했을 때 function 끝나는 곳
	}//commentDelete 끝나는 곳
	
	function commentUpdate(comment_seq,content){ //폼보여주는 function
			console.log("commentUpdateBtn 클릭");
			let str = `<td colspan='2'><div style="width: 100%; text-align: center; margin: auto;"><textarea name ="content_${'${comment_seq}'}" id ="contentupdate" value="${'${content}'}'" placeholder="수정내용을 입력해주세요">${'${content}'}</textarea>
		        <button type="button" id="sendUpdateBtn" onClick="update(${'${comment_seq}'})" class = "btn btn-light btn-sm" style="float: right;">수정</button></div></td>`;
			//console.log(str);
			//$("#updateform").append(str);
			$('#commentUpdate' + comment_seq).html(str);
		}; //commentUpdateBtn 클릭 끝
		
	
	function update(comment_seq){//실제 수정하는 function
		/*console.log("update되나요click");*/
		var updateContent = $('[name=content_'+comment_seq+']').val();
		var paramData = {"comment_seq" : comment_seq, "content" : updateContent};
		console.log(updateContent);
		console.log(paramData);
		if(updateContent ==""){
			swal.fire({
				icon: 'warning',
				text: '내용을 입력하지 않으셨네요!',
				didClose: () =>{
				}
			})
			return;

		}else{
			 $.ajax({
				url : '/csite/campingUpdateComment.do',
				type : 'post',
				dataType : 'text',
				data : paramData,
				success : function(result){
					console.log(result);
					if(result == "success"){
						//alert("수정 성공");
						let str = `<td>${'${updateContent}'}</td>`;
						str += `<td style='text-align: right;'><a href = 'javascript:commentUpdate(${'${comment_seq}'}, &quot;${'${updateContent}'}&quot;);' style='color: #FFA600'>수정</a> / <a href = 'javascript:commentDelete(${'${comment_seq}'});' style='color: #FFA600'>삭제</a></td>`;
						$('#commentUpdate' + comment_seq).html("");
						$('#commentUpdate' + comment_seq).html(str);
					}
				}, //success 끝나는 곳
				error:function(request,status,error){
				    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				    console.log("실패");
					}
				}); //ajax sendUpdateBtn 끝나는 곳  
		}//updateContent가 공란이 아닐 때 끝나는 곳
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
					const user_id = "${login.id}";
					const parsedResponse = JSON.parse(response);
	
					if(response == '[]'){
						let str = "<tr>"
					    +"<td colspan='2' class='nodata' style='text-align: center; border: 1px solid rgba(0, 0, 0, 0.1);'>아직 아무도 댓글을 달지 않았어요! 첫 댓글을 달아볼까요?</td>"
					    +"</tr>"
					    $("#commentlisting").append(str);
					    //$(".container").remove();
					}
					
					parsedResponse.forEach( (item, idx) => {
						let conditionalname = item.nickname=='<%=campingbbs.getNickname()%>'? `<font color = #1FB154>${'${item.nickname}'} <i class='fas fa-heart'></i></font>` : item.nickname;
						let conditionalString = item.user_id == user_id ? `<td style='text-align: right;'><a href = 'javascript:commentUpdate(${'${item.comment_seq}'}, &quot;${'${item.content}'}&quot;);' style='color: #FFA600'>수정</a> / <a href = 'javascript:commentDelete(${'${item.comment_seq}'});' style='color: #FFA600'>삭제</a></td>` : "";
						let str = "<tr class = commentArea" + item.comment_seq+ " style='height: 30px; vertical-align: middle;'>"
							+ "<td style = 'font-weight : bold;'>" + conditionalname + "</td>"
							+ "<td style='text-align: right;'>" + item.wdate+ "</td>"
							+ "</tr>"
							+ "<tr class = commentArea" + item.comment_seq + " id = commentUpdate" + item.comment_seq + " style='border-bottom: 1px solid rgb(0,0,0,.1); height: 30px;'>"
							+ "<td>" + item.content + "</td>"
							+ conditionalString + "</tr>";
							//console.log(item.user_id);
							//console.log(${login.id});
						$("#commentlisting").append(str);
						
					}); //response foreach문 끝나는 곳
					},//success 끝나는 곳
				error:function(request,status,error){
				    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}//error 끝나는 곳
			}); //comments ajax 끝나는 곳
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
					const user_id = "${login.id}";
					if(response == '[]'){
						let str = "<tr>"
					    +"<td colspan='2' class='nodata'>에러가 발생했어요</td>"
					    +"</tr>"
					    $("#commentlisting").append(str);
					}
					parsedResponse.forEach( (item, idx) => {
							let conditionalname = item.nickname=='<%=campingbbs.getNickname()%>'? `<font color = #1FB154>${'${item.nickname}'} <i class="fas fa-heart"></i></font>` : item.nickname;
							let conditionalString = item.user_id == user_id ? `<td><a href = 'javascript:commentUpdate(${'${item.comment_seq}'}, &quot;${'${item.content}'}&quot;);' style='color: #FFA600'>수정</a>/<a href = 'javascript:commentDelete(${'${item.comment_seq}'});' style='color: #FFA600'>삭제</a></td>` : "";
							let str = "<tr class = commentArea" + item.comment_seq+ ">"
								+ "<td style = 'font-weight : bold;'>" + conditionalname + "</td>"
								+ "<td>" + item.wdate+ "</td>"
								+ "</tr>"
								+ "<tr class = commentArea" + item.comment_seq + " id = commentUpdate" + item.comment_seq + ">"
								+ "<td>" + item.content + "</td>"
								+ conditionalString + "</tr>";
						$("#commentlisting").append(str);
						});
					},//success 끝나는 곳
				error:function(request,status,error){
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}//error 끝나는 곳
			}); //pagemove ajax 끝나는 곳
		}; //pagemove function 끝나는 곳
		
			
     function leadZero(num, n) {//월 앞에 0붙이기
         var leadZero = "";
         num = num.toString();
       		 if (num.length < n) { 
       			 for (var i = 0; i < n - num.length; i++) 
       				leadZero += "0"; 
       		 }
         return leadZero + num;
      }; //leadZero 끝나는 곳

</script>
</html>
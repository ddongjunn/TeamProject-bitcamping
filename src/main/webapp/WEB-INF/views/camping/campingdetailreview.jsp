<%@page import="com.camping.bit.dto.CampingCommentDto"%>
<%@page import="java.util.List"%>
<%@page import="com.camping.bit.dto.CampingDetailDto"%>
<%@page import="com.camping.bit.dto.CampingListDto"%>
<%@page import="com.camping.bit.dto.CampingBbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
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
//List<CampingCommentDto> commentList = (List<CampingCommentDto>)request.getAttribute("commentList");
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
<c:if test="${login.id==id}">
	<button type = "button" id = "updateBtn" class = "btn btn-outline-success btn-sm" >리뷰 수정하기</button>
	<button type = "button" id = 'deleteBtn' class = "btn btn-outline-success btn-sm" >리뷰 삭제하기</button>
</c:if>
</div>
<div id = "commentlist" style = "margin-left :10px;">
<c:choose>
<c:when test="${not empty useridx}">
<div id = "comments">
<div id = "writer">
${login.id}님 댓글을 남겨주세요!
</div>
<textarea name = "comment" id = "content" placeholder="댓글을 입력해주세요" rows = "5" cols = "100" ></textarea>
<button type = "button" id = "writeCommentBtn" class = "btn btn-outline-success btn-sm" >등록</button> 
</div>

</c:when>
<c:otherwise>
댓글 등록은 로그인 후 가능합니다!
</c:otherwise>
</c:choose>
 <%-- <table border="1">
    <thead>
    <h2>댓글 목록</h2>
        <tr>
            <td>내용</td>
            <td>작성자</td>
            <td>작성일</td>
        </tr>
    </thead>
    <tbody id="commentlisting">
   
    <c:forEach items = "${commentList}" var = "comment" varStatus = "i">
    <fmt:formatDate var="formatdate" value="${comment.wdate}" pattern="yyyy년 MM월 dd일"/>
    <tr>
    <td> ${comment.content}</td>
    <td>${comment.user_id}</td>
    <td>${formatdate}</td>
    </tr>
    </c:forEach>
    </tbody>	
</table> --%>
 
 <div id = "commentlisting">
   <c:forEach items = "${commentList}" var = "comment" varStatus = "i">
    <fmt:formatDate var="formatdate" value="${comment.wdate}" pattern="yyyy년 MM월 dd일"/>
    <ul>
    	
	    <li>
	    ${comment.user_id}
	    ${formatdate}
	     
	    <div id = "hided">
	    <c:if test="${useridx==comment.user_id}">
	   
	    <button type = "button" id = 'commentUpdateBtn' class = "btn btn-outline-success btn-sm" onClick = "commentUpdate(${comment.comment_seq}, '${comment.content}')">수정</button>
	    <button type = "button" id = 'commentDeleteBtn' class = "btn btn-outline-success btn-sm" onClick = "commentDelete(${comment.comment_seq})">삭제</button>
	    </c:if>
	    </div>
	    </li>
	  	<li>
	  	<div class = "commentContent${comment.comment_seq}">
	    ${comment.content}
	    </div>
	    </li>
	    
    </ul>
     <div id = "updateform"></div>
    </c:forEach>
 </div>
 
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
		const review_seq = new URLSearchParams(location.search).get('review_seq');
		const content =  $("#content").val();
		<fmt:formatDate var="formatdate" value="${today}" pattern="yyyy년 MM월 dd일"/>
		const wdate = "${formatdate}";
		var paramData = {"user_id" : user_id, "review_seq" : review_seq, "content" : content};
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
					let str = 
						"<li>" + user_id + "님의 소중한 댓글이 추가되었습니다" + wdate +  "</li>"
						+"<li>" + content + "</li>";
					$("#commentlisting").append(str);
				}
			}, //success 끝나는 곳
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    console.log("실패");
			}
		}); //ajax commentBtn 끝나는 곳 
	});//writeCommentBtn 끝나는 곳
	
	
	let totalCount = ${ReviewPage};	// 서버로부터 총글의 수를 취득
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
				location.href = "campingdetailreview.do?contentid=" + <%=campingbbs.getContentid()%> + "&review_seq=" + <%=campingbbs.getReview_seq()%>;	
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
	console.log(comment_seq, content);
	//$('.commentContent'+comment_seq).hide();
	let str = `<textarea name ="content_${'${comment_seq}'}" id ="contentupdate" value="${'${content}'}'" placeholder="수정내용을 입력해주세요" rows="5" cols = "100">${'${content}'}'</textarea>
        <button type="button" id="sendUpdateBtn" onClick="update(${'${comment_seq}'})" class = "btn btn-outline-success btn-sm" >수정</button>`;
	console.log(str);
	//$("#updateform").append(str);
	$('.commentContent' + comment_seq).html(str);
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
				$('.commentContent' + comment_seq).html(str);
			}
		}, //success 끝나는 곳
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    console.log("실패");
			}
		}); //ajax sendUpdateBtn 끝나는 곳  
	};//function update 끝나는 곳

	function pagemove(page){ //누르는 순간 페이지네이션에 지금 page 숫자를 알려준다
		 const pageNumber = page-1;
		 console.log(pageNumber);
		 //alert(pageNumber);
		 const contentid = new URLSearchParams(location.search).get('contentid');
		 var paramData = {"reviewsorting" : $("#sorting").val(), "contentid" : contentid, "choice" : $("#choice").val(), "search" : $("#search").val(), "pageNumber" : pageNumber};
		 console.log(paramData);
			$.ajax({
				url : '/csite/campingSearchReview.do',
				type : 'POST',
				dataType : 'text',
				//contextType : "text",
				data : paramData,
				success : function(response){
					//alert(JSON.stringify(response));
					console.log(response);
					$("#reviewlisting").html("");
					const parsedResponse = JSON.parse(response);
	
					if(response == '[]'){
						let str = "<tr>"
					    +"<td colspan='5' class='nodata'>검색 조건을 충족하는 결과가 없어요</td>"
					    +"</tr>"
					    $("#reviewlisting").append(str);
					}
					parsedResponse.forEach( (item, idx) => {
						let str = "<tr>"
							+ "<td>" + (idx + 1) + "</td>"
							+ "<td><a href='campingdetailreview.do?review_seq=" + item.review_seq + "&contentid=" + item.contentid +"'>" + item.title + "</a></td>"	
							+ "<td>" + item.user_id + "</td>"
							+ "<td>" + item.readcount + "</td>"
							+ "<td>" + item.wdate + "</td>"
							+ "</tr>";
						$("#reviewlisting").append(str);
						$("#searchBox").show();
						});
					},//success 끝나는 곳
				error:function(request,status,error){
				    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}//error 끝나는 곳
			}); //pagemove ajax 끝나는 곳
		} //pagemove function 끝나는 곳

</script>
</html>
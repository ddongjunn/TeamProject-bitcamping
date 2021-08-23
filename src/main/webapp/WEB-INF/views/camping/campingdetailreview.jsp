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
	<button type = "button" id = "updateBtn">리뷰 수정하기</button>
	<button type = "button" id = 'deleteBtn'>리뷰 삭제하기</button>
</c:if>

<div id = "commentlist" style = "margin-left :10px;">
<c:choose>
<c:when test="${not empty useridx}">
<div id = "writer">
${login.id}님 댓글을 남겨주세요!
</div>
<div id = "comments">
<textarea name = "comment" id = "content" placeholder="댓글을 입력해주세요" rows = "5" cols = "100" ></textarea>
</div>
<button type = "button" id = "writeCommentBtn">등록</button> 
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
	   
	    <button type = "button" id = 'commentUpdateBtn' value = '${comment.content}'>수정</button>
	    <button type = "button" id = 'commentDeleteBtn' value = '${comment.comment_seq}'>삭제</button>
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
 
</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#updateBtn").click(function(){
		location.href = "campingupdatereview.do?review_seq=" +<%=campingbbs.getReview_seq()%> + "&contentid=" + <%=campingbbs.getContentid()%>;
	}); //updateBtn 끝나는 곳
	
	$("#deleteBtn").click(function(){
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

	$("#writeCommentBtn").click(function(){
		//console.log("click");
		const user_id = "${login.id}";
		const review_seq = new URLSearchParams(location.search).get('review_seq');
		const content =  $("#content").val();
		<fmt:formatDate var="formatdate" value="${comment.wdate}" pattern="yyyy년 MM월 dd일"/>
		const wdate = "${formatdate}";
		var paramData = {"user_id" : user_id, "review_seq" : review_seq, "content" : content};
		//console.log(paramData);
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
						"<li>" + user_id + wdate + "<button type = 'text' id = 'commentUpdateBtn'>" + '수정' + "</button>" 
						+ "<button type = 'text' id = 'commentDeleteBtn'>" + '삭제'+ "</button>" + "</li>"
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
	
	$("#commentDeleteBtn").click(function(){
		//console.log("댓글 삭제 click");
	if(confirm("삭제하시겠습니까?")){
		const comment = $("#commentDeleteBtn").val();
		const review_seq = new URLSearchParams(location.search).get('review_seq');
		var paramData = {"comment_seq" : comment};
		//console.log(paramData);
	$.ajax({
		url : '/csite/campingDeleteComment.do',
		type : 'post',
		data : paramData,
		dataType : 'text',
		success : function(result){
			if(result =='success'){
				//alert("성공적으로 삭제되었습니다");
			 	location.href = "campingdetailreview.do?contentid=" + <%=campingbbs.getContentid()%> + "&review_seq=" + review_seq;	
			}
		}, 
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			}); //ajax (delete)끝나는 곳
		} //삭제여부 물어보는 곳
	}); //deleteBtn 끝나는 곳
	
	
	$("#commentUpdateBtn").click(function(){
	console.log("commentUpdateBtn 클릭");
	const content = $("#commentUpdateBtn").val();
	//console.log(content);
	//$("#originalContent").hide();
	$("#original").hide();
	let str = 
		"<textarea name = 'comment' id = 'contentupdate' placeholder = '수정내용을 입력해주세요' rows = '5' cols = '100'>" + content + "</textarea>"
		+ "<button type = 'button' id = 'sendUpdateBtn' onClick = 'update()' data-comment_seq = ${comment.comment_seq}>" + '수정'+ "</button>";
	$("#updateform").append(str);
	}); //commentUpdateBtn 클릭 끝

}); //document.ready 끝나는곳

	function update(){	
	console.log("되나요click");
	//const comment_seq = $("#comment_seq").val();
	const content =  $("#contentupdate").val();
	const comment_seq = data-comment_seq;
	var paramData = {"comment_seq" : 
		comment_seq,"content" : content};
	console.log(paramData);
	 $.ajax({
		url : '/csite/campingUpdateComment.do',
		type : 'get',
		dataType : 'text',
		data : paramData,
		success : function(result){
			console.log(result);
			if(result == "success"){
				alert("수정 성공");
					let str = 
 					"<li>" + user_id + wdate + "<button type = 'button' id = 'commentUpdateBtn'>" + '수정' + "</button>" 
					+ "<button type = 'button' id = 'commentDeleteBtn'>" + '삭제'+ "</button>" + "</li>" 
					"<li>" + content + "</li>";
				$("#commentlisting").append(str);
			}
		}, //success 끝나는 곳
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    console.log("실패");
		}
	}); //ajax sendUpdateBtn 끝나는 곳  
};//function update 끝나는 곳

</script>
</html>
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
%>

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


<div id = "commentlist">
<table border=1>
    <thead>
        <tr>
            <td>내용</td>
            <td>작성자</td>
            <td>작성일</td>
        </tr>
    </thead>
    <tbody id="commentlisting">
    
    </tbody>	
</table>
</div>
<form method="post" action="campingWriteComment.do">
댓글 작성 : <textarea name = "comment" id = "content" placeholder="댓글을 입력해주세요"></textarea>
작성자 아이디 : <input type = "text" id = "user_id" value = "${login.id}">
<button type = "submit" id = "commentwriteBtn">등록</button>
</form>
</div>
</body>
<script type="text/javascript">
$(document).ready(function () {
	
	$("#updateBtn").click(function(){
		location.href = "campingupdatereview.do?review_seq=" +<%=campingbbs.getReview_seq()%> + "&contentid=" + <%=campingbbs.getContentid()%>;
	}); //updateBtn 끝나는 곳
	
	$("#deleteBtn").click(function(){
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
	
	$("commentwriteBtn").click(function(){
		const user_id = "${login.id}";
		const review_seq = new URLSearchParams(location.search).get('review_seq');
		const content =  $("#content").val()
		
		var paramData = {"user_id" : user_id, "review_seq" : review_seq, "content" : content};
		$.ajax({
			url : '/csite/campingShowComment.do',
			type : 'get',
			dataType : 'text',
			data : paramData,
			success : function(response){
				console.log(response);
				$("#commentlisting").html("");
				const parsedResponse = JSON.parse(response);

				if(response == '[]'){
						let str = "<tr>"
					    +"<td colspan='3' class='nodata'>아직 댓글이 없어요! 첫 댓글을 남겨주세요</td>"
					    +"</tr>"
					    $("#commentlisting").append(str);
				}
				parsedResponse.forEach( (item, idx) => {
					let str = "<tr>"
						+ "<td>" + item.content + "</td>"	
						+ "<td>" + item.user_id + "</td>"
						+ "<td>" + item.wdate + "</td>"
						+ "</tr>";
					$("#commentlisting").append(str);
				});
			}, 
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    console.log("실패");
			}
		}); //ajax commentBtn 끝나는 곳 
	});//commentwriteBtn 끝나는 곳
});//document.ready 끝나는곳

</script>
</html>
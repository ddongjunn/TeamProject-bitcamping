<%@page import="com.camping.bit.dto.MemberDto"%>
<%@page import="com.camping.bit.dto.CampingLikeDto"%>
<%@page import="com.camping.bit.dto.CampingImageDto"%>
<%@page import="java.util.List"%>
<%@page import="com.camping.bit.dto.CampingListDto"%>
<%@page import="com.camping.bit.dto.CampingDetailDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!--CREATE TABLE CAMPING_LIKE(
LIKE_AUTO_SEQ NUMBER(8) NOT NULL, 
CONTENTID NUMBER(38) NOT NULL,
USER_ID VARCHAR2(100) NOT NULL, 
CONTENT_TYPE NUMBER(8) NOT NULL, 
CONSTRAINT PK_CAMPING_LIKE PRIMARY KEY (LIKE_AUTO_SEQ),
CONSTRAINT FK_CAMPING_LIKECI FOREIGN KEY(CONTENTID) REFERENCES CAMPING_LIST(CONTENTID),
CONSTRAINT FK_CAMPING_LIKEUI FOREIGN KEY(USER_ID) REFERENCES MEMBER(ID));


CREATE SEQUENCE CAMPING_LIKE_SEQ
START WITH 1
INCREMENT BY 1; 

ALTER TABLE CAMPING_LIKE
ADD CONSTRAINT FK_CAMPING_LIKE_USER_ID_member FOREIGN KEY (USER_ID)
REFERENCES member (id)

ALTER TABLE CAMPING_LIKE
ADD CONSTRAINT FK_CAMPING_LIKE_CONTENTID_CAMP FOREIGN KEY (CONTENTID)
REFERENCES CAMPING_LIST (CONTENTID)
-->
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/css/campingsite/campingdetail.css" rel="stylesheet" type = "text/css">
</head>
<body>

<%

CampingDetailDto campingdetail = (CampingDetailDto)request.getAttribute("campingdetail");
CampingListDto campinglist = (CampingListDto)request.getAttribute("campinglistfordetail");
CampingLikeDto campinglike = (CampingLikeDto)request.getAttribute("campinglike");
String login_id = (String)request.getAttribute("login_id");

%>
<a href = "campinglist.do">목록으로 돌아가기</a> 
<input type = "hidden" name = "login_id" value = "${login.id}">
<input type = "text" value = "${login_id}"/>
<!--<input type="hidden" name="user_id" value="login.id"> -->

<div class = "camping_list">
	<ul>
		<li style = "list-style : none;">
			<div class = "image" style = "float : left ; margin-right : 10px" >
				<img src = "<%=campinglist.getFirstimageurl() %>" onerror="this.src='<%=request.getContextPath()%>/resources/images/campingsite/csite_alt_image.png'" width = "400" height = "400">
			</div>
			<div class = "camping_information" style = "float : left">
				<div class = "camping_site name">
					<h2 class = "camping_site_name">	
							<%=campinglist.getFacltnm()%>
						<span class = "readcount" style = "font-size : 15px">조회수 : <%=campinglist.getReadcount()%></span>
						<span class = "readcount" style = "font-size : 15px">추천수 : <%=campinglist.getLikecount()%></span>
					</h2>
				</div>
				<hr>
				 <div>주소  : <%=campinglist.getAddr1() %></div>
				 <div>전화번호 : <%=campinglist.getTel() %></div>
				 <div>캠핑장 환경 : <%=campinglist.getLctcl() %>/<%=campinglist.getFacltdivnm() %></div>
				 <div>캠핑장 유형 : <%=campinglist.getInduty() %></div>
				 <div>운영기간 : <%=campingdetail.getOperpdcl() %></div>
				 <div>운영일 : <%=campingdetail.getOperdecl() %></div>
				 <div> 시설 : <%=campinglist.getSbrscl() %></div>
				<c:url value="<%=campinglist.getHomepage() %>" var="url" />
				<c:url value="<%=campingdetail.getResveurl() %>" var="url1" />
					<c:choose>
					  	<c:when test="${url eq 'none'}">
					       	홈페이지 준비중 / 
					    </c:when>
					    <c:otherwise>
					        <button type = button onclick = "location.href ='${url}'" class="btn btn-outline-success btn-sm">홈페이지</button>
					    </c:otherwise>
					</c:choose>
					<c:choose>
					  	<c:when test="${url1 eq 'none'}">
					        전화예약
					    </c:when>
					    <c:otherwise>
					        <button type = button onclick = "location.href ='${url1}'" class = "btn btn-outline-success btn-sm">예약하기</button>
					    </c:otherwise>
					</c:choose>
				


<input type = "hidden" name = "campingidx" value = "${campingidx}"/>
<input type = "hidden" name = "useridx" value = "${useridx}"/>
<br>
<div id = "like_heart">
<c:choose>
	<%--첫번째 choose(로그인 했는지 안 했는지) --%>
	<c:when test="${not empty useridx}">
		<c:choose>
			<c:when test = "${likecheck eq '0' or empty likecheck}"><%--현재 로그인 한 사용자가 하트를 누르지 않았을때 like.user_id!=login.id --%>
				<span><a href = "javascript:" class = "heart-click">
					<svg xmlns = "http://www.w3.org/2000/svg" width = "30" height = "30" fill ="currentColor" class = "bi bi-suit-heart" viewBox = "0 -20 480 480">
				<path d="m348 0c-43 .0664062-83.28125 21.039062-108 56.222656-24.71875-35.183594-65-56.1562498-108-56.222656-70.320312 0-132 65.425781-132 140 0 72.679688 41.039062 147.535156 118.6875 216.480469 35.976562 31.882812 75.441406 59.597656 117.640625 82.625 2.304687 1.1875 5.039063 1.1875 7.34375 0 42.183594-23.027344 81.636719-50.746094 117.601563-82.625 77.6875-68.945313 118.726562-143.800781 118.726562-216.480469 0-74.574219-61.679688-140-132-140zm-108 422.902344c-29.382812-16.214844-224-129.496094-224-282.902344 0-66.054688 54.199219-124 116-124 41.867188.074219 80.460938 22.660156 101.03125 59.128906 1.539062 2.351563 4.160156 3.765625 6.96875 3.765625s5.429688-1.414062 6.96875-3.765625c20.570312-36.46875 59.164062-59.054687 101.03125-59.128906 61.800781 0 116 57.945312 116 124 0 153.40625-194.617188 266.6875-224 282.902344zm0 0"/>
				</svg></a></span>
			</c:when>
			<c:otherwise><%--likecheck가 1이면 꽉 찬 하트가 나옴 --%>
				<span><a href ="javascript:" class = "heart-click">
					<svg xmlns = "http://www.w3.org/2000/svg" width = "30" height = "30" fill ="currentColor" class = "bi bi-suit-heart-fill" viewBox = "0 -20 480 480">
				<path d="m340 0c-44.773438.00390625-86.066406 24.164062-108 63.199219-21.933594-39.035157-63.226562-63.19531275-108-63.199219-68.480469 0-124 63.519531-124 132 0 172 232 292 232 292s232-120 232-292c0-68.480469-55.519531-132-124-132zm0 0" fill="#ff6243"/><path d="m32 132c0-63.359375 47.550781-122.359375 108.894531-130.847656-5.597656-.769532-11.242187-1.15625025-16.894531-1.152344-68.480469 0-124 63.519531-124 132 0 172 232 292 232 292s6-3.113281 16-8.992188c-52.414062-30.824218-216-138.558593-216-283.007812zm0 0" fill="#ff5023"/>
				</svg></a></span>
			</c:otherwise>
		</c:choose><%--두번째 choose 끝 --%>
		<div id = "likecount" style = "margin-left : 5px;"> ${likecount}</div>
	</c:when>
	<%--로그인 상태가 아닐 때 빈 하트 나옴 --%>
	<c:otherwise>
		<span><a href = "javascript:" class = "heart-notlogin">
			<svg class = "heart3" xmlns = "http://www.w3.org/2000/svg" width = "30" height = "30" fill ="currentColor" class = "bi bi-suit-heart" viewBox = "0 -20 480 480">
		<path d="m348 0c-43 .0664062-83.28125 21.039062-108 56.222656-24.71875-35.183594-65-56.1562498-108-56.222656-70.320312 0-132 65.425781-132 140 0 72.679688 41.039062 147.535156 118.6875 216.480469 35.976562 31.882812 75.441406 59.597656 117.640625 82.625 2.304687 1.1875 5.039063 1.1875 7.34375 0 42.183594-23.027344 81.636719-50.746094 117.601563-82.625 77.6875-68.945313 118.726562-143.800781 118.726562-216.480469 0-74.574219-61.679688-140-132-140zm-108 422.902344c-29.382812-16.214844-224-129.496094-224-282.902344 0-66.054688 54.199219-124 116-124 41.867188.074219 80.460938 22.660156 101.03125 59.128906 1.539062 2.351563 4.160156 3.765625 6.96875 3.765625s5.429688-1.414062 6.96875-3.765625c20.570312-36.46875 59.164062-59.054687 101.03125-59.128906 61.800781 0 116 57.945312 116 124 0 153.40625-194.617188 266.6875-224 282.902344zm0 0"/>
		</svg></a>로그인 후 사용 가능합니다!</span>
	</c:otherwise>
</c:choose><%--첫번째 choose 끝 --%>

</div> <!-- likedheart 끝나는 곳 --> 


			</div><!-- campinginformation 오른쪽 부분 div 끝나는 곳 -->
			<div style="clear:both"></div>
		</li>
	</ul>
</div>

<script type="text/javascript">
$(document).ready(function(){

 	$(".heart-click").click(function(){
		 /* const contentid = new URLSearchParams(location.search).get('contentid');
		 const user_id = '${login.id}';
		 var paramData = {"contentid" : contentid, "user_id" : user_id}
		 console.log(paramData); */
		 const contentid = "${campingidx}";
		 const user_id = "${useridx}";
		var paramData = {"contentid" : contentid, "user_id" : user_id}
		console.log(paramData);
		 if($(this).children('svg').attr('class')=="bi bi-suit-heart"){
			 console.log('빈 하트 클릭' + contentid)
		$.ajax({
		url : '/csite/plusCampingHeart.do',
		type : 'get',
		data : paramData,
		dataType : 'text',
		success : function(result){
			if(result !=-1){
				//alert("하트 누르기");
				
			 	location.href = "campingdetail.do?contentid=" + contentid;	
			}
		}, 
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});//빈하트 ajax 끝나는 곳
		$(this).html('<svg xmlns = "http://www.w3.org/2000/svg" width = "30" height = "30" fill ="currentColor" class = "bi bi-suit-heart-fill" viewBox = "0 -20 480 480"><path d="m340 0c-44.773438.00390625-86.066406 24.164062-108 63.199219-21.933594-39.035157-63.226562-63.19531275-108-63.199219-68.480469 0-124 63.519531-124 132 0 172 232 292 232 292s232-120 232-292c0-68.480469-55.519531-132-124-132zm0 0" fill="#ff6243"/><path d="m32 132c0-63.359375 47.550781-122.359375 108.894531-130.847656-5.597656-.769532-11.242187-1.15625025-16.894531-1.152344-68.480469 0-124 63.519531-124 132 0 172 232 292 232 292s6-3.113281 16-8.992188c-52.414062-30.824218-216-138.558593-216-283.007812zm0 0" fill="#ff5023"/></svg>');	
		 }//하트 채우기 끝
		 else if($(this).children('svg').attr('class')=="bi bi-suit-heart-fill"){
		$.ajax({
		url : '/csite/minusCampingHeart.do',
		type : 'get',
		data : paramData,
		dataType : 'text',
		success : function(result){
			if(result != -1){
				//alert("하트 없애기");
			 	location.href = "campingdetail.do?contentid=" + contentid;	
			}
		}, 
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});//꽉 찬 하트 ajax 끝나는 곳
		$(this).html('<svg class = "heart3" xmlns = "http://www.w3.org/2000/svg" width = "30" height = "30" fill ="currentColor" class = "bi bi-suit-heart" viewBox = "0 -20 480 480"><path d="m348 0c-43 .0664062-83.28125 21.039062-108 56.222656-24.71875-35.183594-65-56.1562498-108-56.222656-70.320312 0-132 65.425781-132 140 0 72.679688 41.039062 147.535156 118.6875 216.480469 35.976562 31.882812 75.441406 59.597656 117.640625 82.625 2.304687 1.1875 5.039063 1.1875 7.34375 0 42.183594-23.027344 81.636719-50.746094 117.601563-82.625 77.6875-68.945313 118.726562-143.800781 118.726562-216.480469 0-74.574219-61.679688-140-132-140zm-108 422.902344c-29.382812-16.214844-224-129.496094-224-282.902344 0-66.054688 54.199219-124 116-124 41.867188.074219 80.460938 22.660156 101.03125 59.128906 1.539062 2.351563 4.160156 3.765625 6.96875 3.765625s5.429688-1.414062 6.96875-3.765625c20.570312-36.46875 59.164062-59.054687 101.03125-59.128906 61.800781 0 116 57.945312 116 124 0 153.40625-194.617188 266.6875-224 282.902344zm0 0"/></svg>');
		}//꽉 찬 하트 비우기 끝
	});//heart-click function 끝나는 곳 
	
	$(".heart-click").click(function(){
		 const contentid = "${campingidx}";
		 const user_id = "${useridx}";
		var paramData = {"contentid" : contentid, "user_id" : user_id}
		console.log(paramData);
		
	}); //heart-click function 끝나는 곳
});//document.ready 끝나는 곳
</script>
</body>
</html>
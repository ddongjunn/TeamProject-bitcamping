<%@page import="com.camping.bit.dto.CampingDetailDto"%>
<%@page import="com.camping.bit.dto.CampingListDto"%>
<%@page import="com.camping.bit.dto.CampingBbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- CREATE TABLE CAMPING_BBS
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
-->
<link href="/resources/css/campingsite/campingreview1.css" rel="stylesheet" type = "text/css">
</head>
<body>
<% 
CampingBbsDto campingbbs = (CampingBbsDto)request.getAttribute("campingdetailreview");
CampingListDto campinglist = (CampingListDto)request.getAttribute("campinglistfordetail");
CampingDetailDto campingdetail = (CampingDetailDto)request.getAttribute("campingdetail");
%>
<input type = "hidden" value = "<%=campinglist.getContentid()%>">
<%-- <div class = "image">
<a href = "campingdetail.do?contentid=<%=campinglist.getContentid()%>">
<img src = "<%=campinglist.getFirstimageurl() %>" onerror="this.src='<%=request.getContextPath()%>/resources/images/campingsite/csite_alt_image.png'" width = "500" height = "500">
</a>
</div> 

<div class = "introduction">
<h2><%=campinglist.getFacltnm() %></h2>
<h3><%=campinglist.getAddr1() %></h3>
<h5> 시설 : <%=campinglist.getSbrscl() %></h5>
<br>

<c:url value="<%=campinglist.getHomepage() %>" var="url" />
<c:url value="<%=campingdetail.getResveurl() %>" var="url1" />
	<c:choose>
	  	<c:when test="${url eq 'none'}">
	       	홈페이지 준비중 / 
	    </c:when>
	    <c:otherwise>
	        <button type = button onclick = "location.href ='${url}'" class = "btn btn-outline-success btn-sm" >홈페이지</button>
	    </c:otherwise>
	</c:choose>
	<c:choose>
	  	<c:when test="${url1 eq 'none'}">
	        전화예약
	    </c:when>
	    <c:otherwise>
	        <button type = button onclick = "location.href ='${url1}'" class = "btn btn-outline-success btn-sm" >예약하기</button>
	    </c:otherwise>
	</c:choose>
<!-- <h3>평균 평점 : </h3> -->
<div>
<c:set var = "campinglist" value = '<%=campinglist%>'/>
<%-- <span class = "readcount" style = "font-size : 15px">조회수 : ${campinglist.readcount}</span>

 </div>
 
 <div class = "camping_list">
	<ul>
		<li style = "list-style : none;">
			<div class = "camping_information" style = "float : left">
				<div class = "camping_site name">
					<h2 class = "camping_site_name">	
							<%=campinglist.getFacltnm()%>
					</h2>
				</div>
		
<div id = "thumbsup">
<c:choose>
	<%--첫번째 choose(로그인 했는지 안 했는지) --%>




<script type="text/javascript">
$(document).ready(function(){


}); //document ready 끝나는 곳

</script>
</body>
</html>
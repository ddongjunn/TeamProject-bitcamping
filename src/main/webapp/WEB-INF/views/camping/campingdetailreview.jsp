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
</head>
<body>
<% 
CampingBbsDto campingbbs = (CampingBbsDto)request.getAttribute("campingdetailreview");
CampingListDto campinglist = (CampingListDto)request.getAttribute("campinglistfordetail");
CampingDetailDto campingdetail = (CampingDetailDto)request.getAttribute("campingdetail");
%>

<div class = "image" style = "float : left ; margin-right : 10px; margin-left : 20px; margin-top : 20px" >
				<img src = "<%=campinglist.getFirstimageurl() %>" onerror="this.src='<%=request.getContextPath()%>/resources/image/csite_alt_image.png'" width = "200" height = "200">
</div>
<div class = "introduction" style = "float : left; margin-right : 10px; margin-left : 20px; margin-top : 20px">
<h2><%=campinglist.getFacltnm() %></h2>
<h3><%=campinglist.getAddr1() %></h3>
<h3>평균 평점 : </h3>
<c:url value="<%=campinglist.getHomepage() %>" var="url" />
<c:url value="<%=campingdetail.getResveurl() %>" var="url1" />
	<c:choose>
	  	<c:when test="${url eq 'none'}">
	       	홈페이지 준비중 / 
	    </c:when>
	    <c:otherwise>
	        <button type = button onclick = "location.href ='${url}'">홈페이지</button>
	    </c:otherwise>
	</c:choose>
	<c:choose>
	  	<c:when test="${url1 eq 'none'}">
	        전화예약
	    </c:when>
	    <c:otherwise>
	        <button type = button onclick = "location.href ='${url1}'">예약하기</button>
	    </c:otherwise>
	</c:choose>
<h5> 시설 : <%=campinglist.getSbrscl() %></h5>
<button type = "button" value = "recommend">도움이 됐어요</button> <h5>이 글에 도움 받은 사람 : 명</h5>
</div>
<div style="clear:both"></div>
<div id = "review">
<h3>후기 번호 : <%=campingbbs.getReview_seq() %></h3>
<h3>제목 : <%=campingbbs.getTitle() %></h3>
<h3>작성일 : <%=campingbbs.getWdate() %> </h3>
<h3>내용 : <%=campingbbs.getContent() %></h3>
<div id = "commentlist"></div>
<form method="get" action="campingcommentwrite.do">
댓글 작성 <textarea name = "comment"  placeholder="댓글을 입력해주세요"></textarea>
<button type = "submit" id = "commentwrite">등록</button>
</form>
</div>
</body>
</html>
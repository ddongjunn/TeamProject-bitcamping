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
<a href = "campingmap.do">지도로 가기</a>
<table class = "list_table" style = "width : 85%" id = "_list_table">
<colgroup>
	<col style = "width : 70px">
	<col style = "width : 80px">
	<col style = "width : 50px">
	<col style = "width : 100px">
</colgroup>

	<tr>
		<th>번호</th><th>사진</th><th>캠핑장 이름</th><th>주소</th>
	</tr>
	<c:if test = "${empty campinglist}">
	<tr>
		<td colspan = "3">작성된 글이 없습니다</td>
	</tr>
	</c:if>

	<c:forEach items = "${campinglist}" var = "camping" varStatus = "i">
		<tr>
			
			<td>${i.count}</td>
			<td><img src = ${camping.firstimageurl} onerror="this.src='<%=request.getContextPath()%>/resources/image/csite_alt_image.png'"
				width = "500" height = "300"></td>
			<td><a href = "campingdetail.do?contentid=${camping.contentid}">${camping.facltnm}</a></td>
			<td> ${camping.addr1}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>
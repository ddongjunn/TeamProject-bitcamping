<%@page import="com.camping.bit.dto.CampingDetailDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
CampingDetailDto campingdetail = (CampingDetailDto)request.getAttribute("campingdetail");
%>

<table>
<tr>
	<th>작성자</th>
	<td><%=campingdetail.getContentid()%></td>
</tr>

<tr>
	<th>제목</th>
	<td><%=campingdetail.getContentid() %></td>
</tr>

<tr>
	<th>작성일</th>
	<td><%=campingdetail.getContentid()%></td>
</tr>

<tr>
	<th>조회수</th>
	<td><%=campingdetail.getContentid()%></td>
</tr>

<tr>
	<th>정보</th>
	<td>없음</td>
</tr>

<tr>
	<th>내용</th>
	<td align="center">
	<textarea rows="15" cols="100" readonly="readonly"><%=campingdetail.getContentid() %></textarea>
	</td>
</tr>
</table>
</body>
</html>
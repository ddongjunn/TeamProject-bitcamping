<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.noticeList th, td{
	padding: 5px;
	border-bottom: solid 1px gray;
	border-collapse: collapse;
	text-align: center;
}
.buttonbox{
	margin-top: 20px;
	text-align: right;
}
</style>
</head>
<body>

<table class="noticeList">

	<colgroup>
		<col width="10%">
		<col width="45%">
		<col width="10%">
		<col width="10%">
		<col width="15%">	
		<col width="10%">	
	</colgroup>
	
	<thead>
		<tr>
			<th>글번호</th> <th>제목</th> <th>첨부파일</th> <th>작성자</th> <th>작성일</th> <th>조회수</th>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach items="${notice}" var="notice">
			<tr>
				<td>${notice.notice_Seq}</td>
				<td style="text-align: left;">
					<a href="/cs/noticeDetail.do?notice_Seq=${notice.notice_Seq}">
						${notice.title}
					</a>
				</td>
				<td>
					<c:if test="${not empty notice.filename}"> 💾 </c:if>
				</td>
				<td>${notice.nickname}</td>
				<td>
 					<fmt:parseDate value="${notice.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd"/>
				</td>
				<td>${notice.readcount}</td>
			</tr>		
		</c:forEach>
	</tbody>
</table>

<div class="buttonbox">
	<button onclick="location.href='/cs/noticeWrite.do'">글쓰기</button>
</div>

</body>
</html>
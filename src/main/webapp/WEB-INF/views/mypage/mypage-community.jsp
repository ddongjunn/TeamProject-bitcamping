<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: djlee
  Date: 2021-08-15
  Time: 오후 8:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:choose>
    <when test="${bbstype} eq 'hello'">
        <h2>가입인사 게시판</h2>
    </when>
    <when test="${bbstype} eq 'deal'">
        <h2>중고거래</h2>
    </when>
    <when test="${bbstype} eq 'review'">
        <h2>캠핑&여행 후기기/h2>
    </when>
    <c:otherwise>
        <h2>캠퍼 모집</h2>
    </c:otherwise>
</c:choose>

<div>
<!-- 글 작성 리스트 틀-->
<table border="1">
    <colgroup>
        <col style="width:5%;" />
        <col style="width:auto;" />
        <col style="width:15%;" />
        <col style="width:10%;" />
        <col style="width:15%;" />
    </colgroup>

    <thead>

    <tr>
        <th>번호</th><th>제목</th><th>작성자</th><th>조회수</th><th>작성일</th>
    </tr>
    </thead>

</table>
</div>

</body>
</html>

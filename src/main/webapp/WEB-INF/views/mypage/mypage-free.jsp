<%--
  Created by IntelliJ IDEA.
  User: djlee
  Date: 2021-08-16
  Time: 오후 4:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<h2>${bbstype}</h2>

<div>
        <c:when test="${empty list}">
            <h1>작성하신 글이 없습니다.</h1>
        </c:when>
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

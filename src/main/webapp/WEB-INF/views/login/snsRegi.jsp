
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--
  Created by IntelliJ IDEA.
  User: djlee
  Date: 2021-08-04
  Time: 오후 5:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

%>

<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/snsRegi.css">
</head>
<body>
<!-- wrapper -->
<div id="wrapper">

    <!-- content-->
    <div id="content">

        <!-- ID -->
        <div>
            <h3 class="join_title">
                <label for="nickname">닉네임</label>
            </h3>
            <span class="box int_nickname">
                        <input type="text" id="nickname" class="int" maxlength="20">
                    </span>
            <span class="error_next_box"></span>
        </div>

        <!-- NAME -->
        <div>
            <h3 class="join_title"><label for="name">이름</label></h3>
            <span class="box int_name">
                        <input type="text" id="name" class="int" maxlength="20" value="${info.name}">
                    </span>
            <span class="error_next_box"></span>
        </div>

        <!-- BIRTH -->
        <div>
            <h3 class="join_title"><label for="yy">생년월일</label></h3>

            <div id="bir_wrap">
                <!-- BIRTH_YY -->
                <div id="bir_yy">
                            <span class="box">
                                <input type="text" id="yy" class="int" maxlength="4" placeholder="년(4자)" value="${info.birthyear}">
                            </span>
                </div>

                <!-- BIRTH_MM -->
                <div id="bir_mm">
                            <span class="box">
                                <select id="mm" class="sel">

                                    <c:forEach begin="1" end="12" varStatus="status">
                                        <option value="${status.index}" <c:if test="${ fn:substring(info.birthday, 1, 2) == status.index }">selected</c:if> > ${status.index} </option>
                                    </c:forEach>

                                </select>
                            </span>
                </div>

                <!-- BIRTH_DD -->
                <div id="bir_dd">
                            <span class="box">
                                <c:set var="dd" value="${fn:substring( info.birthday,5 ,6 )}" />
                                <input type="text" id="dd" class="int" maxlength="2" placeholder="일" value="${dd}">
                            </span>
                </div>

            </div>
            <span class="error_next_box"></span>
        </div>

        <!-- EMAIL -->
        <div>
            <h3 class="join_title"><label for="email">이메일</label></h3>
            <span class="box int_email">
                        <input type="text" id="email" class="int" maxlength="100" placeholder="선택입력" value="${info.email}">
                    </span>
            <span class="error_next_box">이메일 주소를 다시 확인해주세요.</span>
        </div>

        <!-- MOBILE -->
        <div>
            <h3 class="join_title"><label for="phoneNo">휴대전화</label></h3>
            <span class="box int_mobile">
                        <input type="tel" id="mobile" class="int" maxlength="16" placeholder="전화번호 입력" value="${info.mobile}">
                    </span>
            <span class="error_next_box"></span>
        </div>


        <!-- JOIN BTN-->
        <div class="btn_area">
            <button type="button" id="btnJoin">
                <span>가입하기</span>
            </button>
        </div>



    </div> <!-- content-->
</div> <!-- wrapper -->

<%--<div>
    <form id="frm">
        <table>
            <tr>
                <th>이름</th><td><input type="text" id="name" size="20" value="${info.name}"></td>
            </tr>
            <tr>
                <th>닉네임</th><td><input type="text" id="nickname" size="20" value=""></td>
            </tr>
            <tr>
                <th>휴대전화</th><td><input type="text" id="phone" size="20"></td>
            </tr>
            <tr>
                <th>이메일</th><td><input type="text" id="email" size="20" value="${info.email}"></td>
            </tr>
            <tr>
                <th>생년월일</th><td><input type="text" id="birth" size="20"></td>
            </tr>
            <tr>
                <th colspan="2"><input type="button" value="가입하기"></th>
            </tr>
        </table>
    </form>
</div>--%>

</body>
</html>

<script type="text/javascript">
$(document).ready(function () {

});

</script>

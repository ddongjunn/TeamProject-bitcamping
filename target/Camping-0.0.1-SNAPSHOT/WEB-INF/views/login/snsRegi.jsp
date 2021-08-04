<%--
  Created by IntelliJ IDEA.
  User: djlee
  Date: 2021-08-04
  Time: 오후 5:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String str = (String) request.getParameter("info");
    System.out.println(str);
%>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="/resources/css/snsRegi.css">
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
            <span class="box int_id">
                        <input type="text" id="id" class="int" maxlength="20">
                    </span>
            <span class="error_next_box"></span>
        </div>

        <!-- NAME -->
        <div>
            <h3 class="join_title"><label for="name">이름</label></h3>
            <span class="box int_name">
                        <input type="text" id="name" class="int" maxlength="20">
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
                                <input type="text" id="yy" class="int" maxlength="4" placeholder="년(4자)">
                            </span>
                </div>

                <!-- BIRTH_MM -->
                <div id="bir_mm">
                            <span class="box">
                                <select id="mm" class="sel">
                                    <option>월</option>
                                    <option value="01">1</option>
                                    <option value="02">2</option>
                                    <option value="03">3</option>
                                    <option value="04">4</option>
                                    <option value="05">5</option>
                                    <option value="06">6</option>
                                    <option value="07">7</option>
                                    <option value="08">8</option>
                                    <option value="09">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select>
                            </span>
                </div>

                <!-- BIRTH_DD -->
                <div id="bir_dd">
                            <span class="box">
                                <input type="text" id="dd" class="int" maxlength="2" placeholder="일">
                            </span>
                </div>

            </div>
            <span class="error_next_box"></span>
        </div>

        <!-- EMAIL -->
        <div>
            <h3 class="join_title"><label for="email">본인확인 이메일<span class="optional">(선택)</span></label></h3>
            <span class="box int_email">
                        <input type="text" id="email" class="int" maxlength="100" placeholder="선택입력">
                    </span>
            <span class="error_next_box">이메일 주소를 다시 확인해주세요.</span>
        </div>

        <!-- MOBILE -->
        <div>
            <h3 class="join_title"><label for="phoneNo">휴대전화</label></h3>
            <span class="box int_mobile">
                        <input type="tel" id="mobile" class="int" maxlength="16" placeholder="전화번호 입력">
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

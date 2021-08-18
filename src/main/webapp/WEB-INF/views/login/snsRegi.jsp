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
<form id="snsRegiFrm" method="post" action="/regi/addMember.do">
    <div class="snsRegi_wrap">
        <div class="snsRegi_login">
            <h2>비트캠핑</h2>

            <div class="snsRegi_login_id">
                <h4>닉네임</h4>
                <input type="text" name="nickname" id="nickname" placeholder="2~10자의 한글, 영문, 숫자만 사용 가능합니다." maxlength="10" value="${info.nickname}">
                <span class="error_next_box"></span>
            </div>
            <div class="snsRegi_login_id">
                <h4>이름</h4>
                <input type="text" name="username" id="username" placeholder="한글, 영문 사용 가능합니다.(특수기호, 공백 사용 불가)" maxlength="20" value="${info.name}">
                <span class="error_next_box"></span>
            </div>
            <div class="snsRegi_login_id">
                <h4>이메일</h4>
                <input type="email" name="email" id="email" placeholder="@까지 정확하게 입력해주세요." maxlength="50" value="${info.email}" >
                <span class="error_next_box">이메일 주소를 다시 확인해주세요.</span>
            </div>
            <div class="snsRegi_login_id">
                <h4>휴대전화</h4>
                <c:choose>
                    <c:when test="${info.mobile == null}">
                        <input type="text" id="mobile" class="int" maxlength="13" name="phone" placeholder="숫자만 입력해주세요." value="" >
                    </c:when>
                    <c:otherwise>
                        <c:set var="mobile" value="${fn:split(info.mobile,'-')}"/>
                        <input type="text" id="mobile" class="int" maxlength="13" name="phone" placeholder="숫자만 입력해주세요." value="${mobile[0]}-${mobile[1]}-${mobile[2]}" >
                    </c:otherwise>
                </c:choose>
                <span class="error_next_box"></span>
            </div>
            <div class="snsRegi_submit">
                <input type="button" class="join" name="btnJoin2" value="회원가입">
            </div>
        </div>
    </div>
    <input type="hidden" name="sns_Type" value="${sns_type}">
    <input type="hidden" name="id" value="${info.id}">
</form>

<script type="text/javascript">
    let error = document.querySelectorAll('.error_next_box');
    let emailStatus = false;
    let nicknameStatus = false;

    $(document).ready(function () {

        isEmailCorrect();
        checkNickname();

        $('#username').blur(function () {
            nameCheck();
        });
        $('#mobile').blur(function () {
            checkPhoneNum();
        });
        $('#email').blur(function () {
            isEmailCorrect();
        });
        $('#nickname').blur(function () {
            checkNickname();
        });

        $(document).on("keyup", "#mobile", function () {
            $(this).val($(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/, "$1-$2-$3").replace("--", "-"));
        });

        function NotReload(){ if( (event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) || (event.keyCode == 116) ) { event.keyCode = 0; event.cancelBubble = true; event.returnValue = false; } } document.onkeydown = NotReload;

    });

    function nameCheck() {
        let namePattern = /^[가-힣a-zA-Z]+$/;
        if ($('#username').val() === "") {
            error[2].innerHTML = "필수 정보입니다.";
            error[2].style.display = "block";
            return false;
        } else if (!namePattern.test($('#username').val()) || $('#username').val().indexOf(" ") > -1) {
            error[2].innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
            error[2].style.display = "block";
            return false;
        } else {
            error[2].style.display = "none";
            return true;
        }
    }

    //닉네임 검사
    function checkNickname() {
        let nicknamePattern = /^([a-zA-Z0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]).{1,10}$/;

        if ($('#nickname').val() === "") {
            error[1].innerHTML = "필수 정보입니다.";
            error[1].style.color = "#ff0000";
            error[1].style.display = "block";
            nicknameStatus = false;
        } else if (!nicknamePattern.test($('#nickname').val())) {
            error[1].innerHTML = "2~10자의 한글, 영문, 숫자만 사용 가능합니다.";
            error[1].style.color = "#ff0000";
            error[1].style.display = "block";
            nicknameStatus = false;
        } else {
            $.ajax({
                url: "/regi/nicknameCheck.do",
                data: {'nickname': $('#nickname').val()},
                type: "get",
                dataType: "json",
                success: function (data) {
                    if (data === false) {
                        error[1].innerHTML = "사용 가능한 닉네임입니다!";
                        error[1].style.color = "#08A600";
                        error[1].style.display = "block";
                        nicknameStatus = true;
                    } else {
                        error[1].innerHTML = "이미 존재하는 닉네임입니다!";
                        error[1].style.color = "#ff0000";
                        error[1].style.display = "block";
                        nicknameStatus = false;
                    }
                },
                error: function () {

                }
            });
        }

    }

    function checkPhoneNum() {
        var isPhoneNum = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;

        if ($('#mobile').val() === "") {
            error[4].innerHTML = "필수 정보입니다.";
            error[4].style.display = "block";
        } else if (!isPhoneNum.test($('#mobile').val())) {
            error[4].innerHTML = "형식에 맞지 않는 번호입니다.";
            error[4].style.display = "block";
        } else {
            error[4].style.display = "none";
            return true;
        }
    }

    function isEmailCorrect() {
        var emailPattern = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/i;

        if ($('#email').val() === "") {
            error[3].innerHTML = "필수 정보입니다.";
            error[3].style.color = "#ff0000";
            error[3].style.display = "block";
            emailStatus = false;
        } else if (!emailPattern.test($('#email').val())) {
            error[3].innerHTML = "형식에 맞지 않는 이메일입니다.";
            error[3].style.color = "#ff0000";
            error[3].style.display = "block";
            emailStatus = false;
        } else {
            $.ajax({
                url: "/regi/emailCheck.do",
                data: {'email': $('#email').val()},
                type: "get",
                dataType: "json",
                success: function (data) {
                    if (data === false) {
                        error[3].innerHTML = "사용 가능한 이메일입니다!";
                        error[3].style.color = "#08A600";
                        error[3].style.display = "block";
                        emailStatus = true;
                    } else {
                        error[3].innerHTML = "이미 존재하는 이메일입니다!";
                        error[3].style.color = "#ff0000";
                        error[3].style.display = "block";
                        emailStatus = false;
                    }
                },
                error: function () {

                }
            });

        }
    }

    $('input[name=btnJoin2]').click(function () {

        let nameStatus = nameCheck();
        let mobileStatus = checkPhoneNum();

        if(!nicknameStatus){
            $('#nickname').focus();
            return;
        } else if(!nameStatus) {
            $('#name').focus();
            return;
        } else if(!emailStatus){
            $('#email').focus();
            return;
        } else if(!mobileStatus){
            $('#mobile').focus();
            return;
        }

        document.getElementById('snsRegiFrm').submit();

    });
</script>

</body>
</html>


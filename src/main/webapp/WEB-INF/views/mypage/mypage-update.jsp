<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: djlee
  Date: 2021-08-15
  Time: 오후 8:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원정보 수정</title>
</head>
<body>

<div class="customer-update">
    <h2 class="title">
        회원정보 수정
    </h2>

    <form id='#updateFrm' action="/account/updateAf.do" method="post">

        <c:if test="${login.sns_Type eq 'none'}">
            <div class="userid">
                <label for="userid"> 아이디 </label> <br>
                <input type="text" id="userid" value="${login.id}" size="20" disabled>
            </div>
        </c:if>

        <div class="username">
            <label for="username"> 이름 </label> <br>
            <input type="text" id="username" value="${login.username}" disabled>
        </div>

        <div class="nickname">
            <label for="nickname"> 닉네임 </label> <br>
            <input type="text" id="nickname" name="nickname" value="${login.nickname}" maxlength="10">
            <span class="error_msg"></span>
        </div>

        <div class="phone">
            <label for="phone"> 휴대폰 </label> <br>
            <input type="text" id="phone" name="phone" value="${login.phone}" maxlength="13">
            <span class="error_msg"></span>
        </div>

        <div class="email">
            <label for="email"> 이메일 </label> <br>
            <input type="text" id="email" name="email" value="${login.email}">
            <span class="error_msg"></span>
        </div>

        <div class="reciveEmail">
            <label>
                <input type="checkbox">
                이메일을 통한 상품 및 이벤트 정보 수신에 동의합니다.(선택)
            </label>
        </div>

        <div class="recivePhone">
            <label>
                <input type="checkbox">
                휴대폰을 통한 상품 및 이벤트 정보 수신에 동의합니다.(선택)
            </label>
        </div>

        <div class="submit">
            <input type="submit" id="updateBtn" value="수정하기">
        </div>

        <input type="hidden" name="username" value="${login.username}">
        <input type="hidden" name="id" value="${login.id}">
    </form>
</div>

<script type="text/javascript">
    let errormsg = document.querySelectorAll('.error_msg');

    let nicknameStatus = true;
    let phoneStatus = true;
    let emailStatus = true;

    $(document).on("keyup", "#phone", function () {
        $(this).val($(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/, "$1-$2-$3").replace("--", "-"));
    });

    $(document).ready(function () {

       document.getElementById('nickname').addEventListener("blur",e => {
           let nicknamePattern =  RegExp(/^[가-힣a-zA-Z0-9]{2,10}$/);

           if ($('#nickname').val() === "") {
               errormsg[0].innerHTML = "변경할 닉네임을 입력해주세요.";
               errormsg[0].style.color = "#ff0000";
               errormsg[0].style.display = "block";
               nicknameStatus = false;

           } else if (!nicknamePattern.test($('#nickname').val())) {
               errormsg[0].innerHTML = "2~10자의 한글, 영문, 숫자만 사용 가능합니다.";
               errormsg[0].style.color = "#ff0000";
               errormsg[0].style.display = "block";
               nicknameStatus = false;

           } else if ($('#nickname').val() === '${login.nickname}') {
               errormsg[0].style.display = "none";
               nicknameStatus = true;

           } else {
               $.ajax({
                   url: "/regi/nicknameCheck.do",
                   data: {'nickname': $('#nickname').val()},
                   type: "get",
                   dataType: "json",
                   success: function (data) {
                       if (data === false) {
                           errormsg[0].innerHTML = "사용 가능한 닉네임입니다!";
                           errormsg[0].style.color = "#08A600";
                           errormsg[0].style.display = "block";
                           nicknameStatus = true;
                       } else {
                           errormsg[0].innerHTML = "이미 존재하는 닉네임입니다!";
                           errormsg[0].style.color = "#ff0000";
                           errormsg[0].style.display = "block";
                           nicknameStatus = false;
                       }
                   },
                   error: function () {

                   }
               });
           }
       });

        document.getElementById('phone').addEventListener("blur",e => {
            var isPhoneNum = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;

            if ($('#phone').val() === "") {
                errormsg[1].innerHTML = "변경할 번호를 입력해주세요.";
                errormsg[1].style.color = "#ff0000";
                errormsg[1].style.display = "block";
                phoneStatus = false;
            } else if (!isPhoneNum.test($('#phone').val())) {
                errormsg[1].style.color = "#ff0000";
                errormsg[1].innerHTML = "형식에 맞지 않는 번호입니다.";
                errormsg[1].style.display = "block";
                phoneStatus = false;
            } else if($('#phone').val() === '${login.phone}'){
                errormsg[1].style.display = "none";
                phoneStatus = true;
            } else {
                errormsg[1].style.display = "none";
                phoneStatus = true;
            }
        });

        document.getElementById('email').addEventListener("blur",e => {
            var emailPattern = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/i;

            if ($('#email').val() === "") {
                errormsg[2].innerHTML = "변경할 이메일을 입력해주세요.";
                errormsg[2].style.color = "#ff0000";
                errormsg[2].style.display = "block";
                emailStatus = false;
            } else if (!emailPattern.test($('#email').val())) {
                errormsg[2].innerHTML = "형식에 맞지 않는 이메일입니다.";
                errormsg[2].style.color = "#ff0000";
                errormsg[2].style.display = "block";
                emailStatus = false;
            } else if ( $('#email').val() === '${login.email}' ) {
                errormsg[2].style.display = "none";
                emailStatus = true;
            } else {
                $.ajax({
                    url: "/regi/emailCheck.do",
                    data: {'email': $('#email').val()},
                    type: "get",
                    dataType: "json",
                    success: function (data) {
                        if (data === false) {
                            errormsg[2].innerHTML = "사용 가능한 이메일입니다!";
                            errormsg[2].style.color = "#08A600";
                            errormsg[2].style.display = "block";
                            emailStatus = true;
                        } else {
                            errormsg[2].innerHTML = "이미 존재하는 이메일입니다!";
                            errormsg[2].style.color = "#ff0000";
                            errormsg[2].style.display = "block";
                            emailStatus = false;
                        }
                    },
                    error: function () {

                    }
                });
            }
        });

        document.getElementById('updateBtn').addEventListener("click",e => {
            if(!nicknameStatus){
                $('#nickname').focus();
                return;
            }else if(!phoneStatus){
                $('#phone').focus();
                return;
            }else if(!emailStatus){
                $('#email').focus();
                return;
            }

            alert('test');
            $('#updateFrm').submit();
            alert('test2');
        });

    });
</script>
</body>
</html>

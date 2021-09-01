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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <title>회원정보 수정</title>
</head>
<body>

<div class="mypage_board">
    <h2 class="title">
        회원정보 수정
    </h2>

    <form id='updateFrm' action="/account/updateAf.do" method="post">

        <c:if test="${user.sns_Type eq 'none'}">
            <div class="userid">
                <label for="userid"> 아이디 </label> <br>
                <input type="text" id="userid" value="${user.id}" size="25" disabled>
            </div>
        </c:if>

        <div class="username">
            <label for="username"> 이름 </label> <br>
            <input type="text" id="username" value="${user.username}" size="25" disabled>
        </div>

        <div class="nickname">
            <label for="nickname"> 닉네임 </label> <br>
            <input type="text" id="nickname" name="nickname" value="${user.nickname}" size="25" maxlength="10">
            <span class="error_msg"></span>
        </div>

        <div class="phone">
            <label for="phone"> 휴대폰 </label> <br>
            <input type="text" id="phone" name="phone" value="${user.phone}" size="25" maxlength="13">
            <span class="error_msg"></span>
        </div>

        <div class="email">
            <label for="email"> 이메일 </label> <br>
            <input type="text" id="email" name="email" size="25" value="${user.email}">
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

        <div class="send">
            <input type="button" name="updateBtn" value="수정하기">
        </div>

        <input type="hidden" name="id" value="${user.id}">
    </form>
</div>

<script type="text/javascript">
    let errormsg = document.querySelectorAll('.error_msg');

    let nicknameUpdateStatus = true;
    let phoneUpdateStatus = true;
    let emailUpdateStatus = true;

    $(document).ready(function () {

        let nowNickname = '${login.nickname}';
        let nowPhone = '${login.phone}';
        let nowEmail = '${login.email}';

        $('#nickname').blur(function () {
            updateNickname();
        });
        $('#mobile').blur(function () {
            updateMobile();
        });
        $('#email').blur(function () {
            updateEmail();
        });

        $(document).on("keyup", "#phone", function () {
            $(this).val($(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/, "$1-$2-$3").replace("--", "-"));
        });

       function updateNickname(){
           let nicknamePattern =  RegExp(/^[가-힣a-zA-Z0-9]{2,10}$/);

           if ($('#nickname').val() === "") {
               errormsg[0].innerHTML = "변경할 닉네임을 입력해주세요.";
               errormsg[0].style.color = "#ff0000";
               errormsg[0].style.display = "block";
               nicknameUpdateStatus = false;

           } else if (!nicknamePattern.test($('#nickname').val())) {
               errormsg[0].innerHTML = "2~10자의 한글, 영문, 숫자만 사용 가능합니다.";
               errormsg[0].style.color = "#ff0000";
               errormsg[0].style.display = "block";
               nicknameUpdateStatus = false;

           } else if ($('#nickname').val() === '${login.nickname}') {
               errormsg[0].style.display = "none";
               nicknameUpdateStatus = true;

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
                           nicknameUpdateStatus = true;
                       } else {
                           errormsg[0].innerHTML = "이미 존재하는 닉네임입니다!";
                           errormsg[0].style.color = "#ff0000";
                           errormsg[0].style.display = "block";
                           nicknameUpdateStatus = false;
                       }
                   },
                   error: function () {

                   }
               });
           }
       }

        function updateMobile() {
            var isPhoneNum = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;

            if ($('#phone').val() === "") {
                errormsg[1].innerHTML = "변경할 번호를 입력해주세요.";
                errormsg[1].style.color = "#ff0000";
                errormsg[1].style.display = "block";
                phoneUpdateStatus = false;
            } else if (!isPhoneNum.test($('#phone').val())) {
                errormsg[1].style.color = "#ff0000";
                errormsg[1].innerHTML = "형식에 맞지 않는 번호입니다.";
                errormsg[1].style.display = "block";
                phoneUpdateStatus = false;
            } else if($('#phone').val() === '${login.phone}'){
                errormsg[1].style.display = "none";
                phoneUpdateStatus = true;
            } else {
                errormsg[1].style.display = "none";
                phoneUpdateStatus = true;
            }
        }


         function updateEmail() {
            var emailPattern = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/i;

            if ($('#email').val() === "") {
                errormsg[2].innerHTML = "변경할 이메일을 입력해주세요.";
                errormsg[2].style.color = "#ff0000";
                errormsg[2].style.display = "block";
                emailUpdateStatus = false;
            } else if (!emailPattern.test($('#email').val())) {
                errormsg[2].innerHTML = "형식에 맞지 않는 이메일입니다.";
                errormsg[2].style.color = "#ff0000";
                errormsg[2].style.display = "block";
                emailUpdateStatus = false;
            } else if ( $('#email').val() === '${login.email}' ) {
                errormsg[2].style.display = "none";
                emailUpdateStatus = true;
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
                            emailUpdateStatus = true;
                        } else {
                            errormsg[2].innerHTML = "이미 존재하는 이메일입니다!";
                            errormsg[2].style.color = "#ff0000";
                            errormsg[2].style.display = "block";
                            emailUpdateStatus = false;
                        }
                    },
                    error: function () {

                    }
                });
            }

        }

        $('input[name=updateBtn]').click(function () {

            if(nowNickname == $('#nickname').val() && nowPhone == $('#phone').val() && nowEmail == $('#email').val()){
                let Toast = Swal.mixin({
                    toast: true,
                    position: 'bottom-end',
                    showConfirmButton: false,
                    timer: 2000,
                    timerProgressBar: true,
                    didOpen: (toast) => {
                        toast.addEventListener('mouseenter', Swal.stopTimer)
                        toast.addEventListener('mouseleave', Swal.resumeTimer)
                    }
                })

                Toast.fire({
                    icon: 'error',
                    title: '변경사항이 없습니다.'
                })
                return;
            }

            if(!nicknameUpdateStatus){

                $('#nickname').focus();
                return;
            }else if(!phoneUpdateStatus){

                $('#phone').focus();
                return;
            }else if(!emailUpdateStatus){

                $('#email').focus();
                return;
            }

            Swal.fire({
                title: '회원정보를 수정하시겠습니까?',
                showCancelButton: true,
                confirmButtonText: `수정하기`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    document.getElementById('updateFrm').submit();
                }
            });

        });
    });


</script>
</body>
</html>

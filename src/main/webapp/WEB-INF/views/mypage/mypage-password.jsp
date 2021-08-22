<%--
  Created by IntelliJ IDEA.
  User: djlee
  Date: 2021-08-15
  Time: 오후 8:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="customer-password">
    <h2 class="title">
        비밀번호 변경
    </h2>

        <div class="oldPassword">
            <label for="oldPassword">기존 비밀번호</label> <br>
            <input type="password" id="oldPassword" placeholder="기존 비밀번호">
            <span class="error_msg"></span>
        </div>

        <div class="newPassword">
            <label for="newPassword">새 비밀번호 입력</label> <br>
            <input type="password" id="newPassword" name="pwd" placeholder="새 비밀번호 입력">
            <span class="error_msg"></span>
        </div>

        <div class="newPassword2">
            <label for="newPassword2">새 비밀번호 확인</label> <br>
            <input type="password" id="newPassword2" placeholder="새 비밀번호 확인">
            <span class="error_msg"></span>
        </div>

        <div class="send">
            <input type="button" id="passwordBtn" value="변경하기">
        </div>
</div>

<script type="text/javascript">
$(document).ready(function () {
    let errormsg = document.querySelectorAll('.error_msg');
    let oldPassword = false;
    let newPassword = false;
    let newPassword2 = false;

    $('#oldPassword').blur(function () {
        oldPasswordCheck();
    });

    $('#newPassword').blur(function () {
        newPasswordCheck();
    });

    $('#newPassword2').blur(function () {
        newPasswordCheck2();
    });

    function oldPasswordCheck() {

        if($('#oldPassword').val() === ""){
            errormsg[0].innerHTML = "비밀번호를 입력해주세요.";
            errormsg[0].style.color = "#ff0000";
            errormsg[0].style.display = "block";
            return;
        }

        $.ajax({
            url : "/account/passwordCheck.do",
            data : { 'id' : '${login.id}', 'pwd' : $('#oldPassword').val() },
            type : "post",
            success : function (data) {
                if(data){
                    errormsg[0].style.display = "none";
                    oldPassword = true;
                    return;
                }
                errormsg[0].innerHTML = "비밀번호가 일치하지 않습니다.";
                errormsg[0].style.color = "#ff0000";
                errormsg[0].style.display = "block";
                oldPassword = false;
                $('#oldPassword').val('');
            },
            error : function (error){
                alert('error');
            }
        });
    }

    function newPasswordCheck() {
        var pwPattern = /[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]{8,16}/;

        if($('#newPassword').val() === "") {
            newPassword = false;
        } else if(!pwPattern.test($('#newPassword').val())) {
            errormsg[1].innerHTML = "8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
            errormsg[1].style.color = "#ff0000";
            errormsg[1].style.display = "block";
            newPassword = false;
        } else {
            errormsg[1].innerHTML = "사용 가능한 비밀번호입니다.";
            errormsg[1].style.color = "#08A600";
            errormsg[1].style.display = "block";
            newPassword = true;
        }
    }

    function newPasswordCheck2() {
        if($('#newPassword2').val() === "") {
            newPassword2 = false;
        }

        if($('#newPassword2').val() === $('#newPassword').val() && $('#newPassword2').val() !== "") {
            errormsg[2].innerHTML = "일치합니다.";
            errormsg[2].style.color = "#08A600";
            errormsg[2].style.display = "block";
            newPassword2 = true;
        } else if($('#newPassword2').val() !== $('#newPassword').val()) {
            errormsg[2].innerHTML = "비밀번호가 일치하지 않습니다.";
            errormsg[2].style.color = "#ff0000";
            errormsg[2].style.display = "block";
            newPassword2 = false;
        }
    }

    $('#passwordBtn').click(function () {

        if(!oldPassword){
            $('#oldPassword').focus();
            return;
        }else if(!newPassword){
            $('#newPassword').focus();
            return;
        }else if(!newPassword2) {
            $('#newPassword2').focus();
            return;
        }

        $.ajax({
            url : "/account/passwordAf.do",
            data : { 'id' : '${login.id}', 'pwd' : $('#newPassword').val() },
            type : "post",
            success : function (data) {

                    $('#oldPassword').val("");
                    $('#newPassword').val("");
                    $('#newPassword2').val("");

                    errormsg[0].style.display = "none";
                    errormsg[1].style.display = "none";
                    errormsg[2].style.display = "none";

                    oldPassword = false;
                    newPassword = false;
                    newPassword2 = false;

                    Swal.fire({
                        icon: 'success',
                        text: '비밀번호가 변경되었습니다!',
                    })
            },
            error : function (error){
                alert('error');
            }
        });

    });
});


</script>
</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: 이동준
  Date: 2021-08-10
  Time: 오전 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script defer src="${pageContext.request.contextPath}/resources/js/policy.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/normalRegi.css">
    <title>Title</title>
</head>

<body>
<div id="modal_regi" class="modal-overlay">
    <div class="modal-window">
        <%--<div class="close-area"><a href="#">X</a></div>--%>
        <div class="title">
            <h2>비트캠핑</h2>
        </div>
        <div class="content">
            <div class="wrap">
                <div class="logo"></div>
                <div class="contents">
                    <form action="/" method="POST" id="form__wrap">
                        <div class="terms__check__all">
                            <input type="checkbox" name="checkAll" id="checkAll" />
                            <label for="checkAll"
                            >비트캠핑 이용약관, 개인정보 수집 및 이용, 프로모션 정보
                                수신(선택)에모두 동의합니다.</label
                            >
                        </div>
                        <ul class="terms__list">
                            <li class="terms__box">
                                <div class="input__check">
                                    <input
                                            type="checkbox"
                                            name="agreement"
                                            id="termsOfService"
                                            value="termsOfService"
                                            required
                                    />
                                    <label for="termsOfService" class="required"
                                    >비트캠핑 이용약관 동의</label
                                    >
                                </div>
                                <div class="terms__content">
                                    여러분을 환영합니다. 비트캠핑 서비스 및 제품(이하 ‘서비스’)을 이용해
                                    주셔서 감사합니다. 본 약관은 다양한 비트캠핑 서비스의 이용과 관련하여
                                    비트캠핑 서비스를 제공하는 비트캠핑 주식회사(이하 ‘비트캠핑’)와 이를 이용하는
                                    비트캠핑 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며,
                                    아울러 여러분의 비트캠핑 서비스 이용에 도움이 될 수 있는 유익한
                                    정보를 포함하고 있습니다. 비트캠핑 서비스를 이용하시거나 비트캠핑 서비스
                                    회원으로 가입하실 경우 여러분은 본 약관 및 관련 운영 정책을
                                    확인하거나 동의하게 되므로, 잠시 시간을 내시어 주의 깊게 살펴봐
                                    주시기 바랍니다.
                                </div>
                            </li>
                            <li class="terms__box">
                                <div class="input__check">
                                    <input
                                            type="checkbox"
                                            name="agreement"
                                            id="privacyPolicy"
                                            value="privacyPolicy"
                                            required
                                    />
                                    <label for="privacyPolicy" class="required"
                                    >개인정보 수집 및 이용 동의</label
                                    >
                                </div>
                                <div class="terms__content">
                                    개인정보보호법에 따라 비트캠핑에 회원가입 신청하시는 분께 수집하는
                                    개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및
                                    이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내
                                    드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.1. 수집하는
                                    개인정보 이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등
                                    대부분의 비트캠핑 서비스를 회원과 동일하게 이용할 수 있습니다.
                                    이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제
                                    서비스를 이용하기 위해 회원가입을 할 경우, 비트캠핑는 서비스
                                    이용을 위해 필요한 최소한의 개인정보를 수집합니다.
                                </div>
                            </li>
                            <li class="terms__box">
                                <div class="input__check">
                                    <input
                                            type="checkbox"
                                            name="agreement"
                                            id="allowPromotions"
                                            value="allowPromotions"
                                    />
                                    <label for="allowPromotions">프로모션 정보 수신 동의</label>
                                </div>
                                <div class="terms__content">
                                    비트캠핑에서 제공하는 이벤트/혜택 등 다양한 정보를 휴대전화(비트캠핑앱
                                    알림 또는 문자), 이메일로 받아보실 수 있습니다. 일부 서비스(별도
                                    회원 체계로 운영하거나 비트캠핑 가입 이후 추가 가입하여 이용하는
                                    서비스 등)의 경우, 개별 서비스에 대해 별도 수신 동의를 받을 수
                                    있으며, 이때에도 수신 동의에 대해 별도로 안내하고 동의를
                                    받습니다.
                                </div>
                            </li>
                        </ul>
                        <button type="submit" class="next-button" disabled>확인</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


<form id="regiFrm" method="post" action="/regi/addMember.do">
    <div class="wrapper">
        <div class="login">
            <h2>비트캠핑</h2>

            <div class="login_id">
                <h4>아이디</h4>
                <input type="text" name="id" id="userid" placeholder="4~15자의 영문 소문자, 숫자만 사용 가능합니다." maxlength="20" >
                <span class="error_next_box"></span>
            </div>
            <div class="login_pw">
                <h4>비밀번호</h4>
                <input type="password" name="pwd" id="userpwd" placeholder="영문 대 소문+숫자+특수문자 8~16자리" maxlength="16" value="">
                <span class="error_next_box"></span>
            </div>
            <div class="login_pw">
                <h4>비밀번호 재확인</h4>
                <input type="password" name="pwd2" id="userpwd2" placeholder="비밀번호를 다시 입력해 주세요." maxlength="16" value="">
                <span class="error_next_box"></span>
            </div>
            <div class="login_id">
                <h4>닉네임</h4>
                <input type="text" name="nickname" id="nickname" placeholder="한글, 영문만 사용 가능합니다. (특수기호, 공백 사용 불가)" maxlength="20" value="">
                <span class="error_next_box"></span>
            </div>
            <div class="login_id">
                <h4>이름</h4>
                <input type="text" name="username" id="username" placeholder="한글, 영문만 사용 가능합니다. (특수기호, 공백 사용 불가)" maxlength="20" value="">
                <span class="error_next_box"></span>
            </div>
            <div class="login_id">
                <h4>이메일</h4>
                <input type="email" name="email" id="useremail" placeholder="@까지 정확하게 입력해주세요. (수신 가능 이메일)" maxlength="50" value="" >
                <span class="error_next_box">이메일 주소를 다시 확인해주세요.</span>
            </div>
            <div class="login_id">
                <h4>휴대전화</h4>
                <input type="text" id="mobile" class="int" maxlength="13" name="phone" placeholder="'-' 제외 숫자만 입력해주세요.'" value="" >
                <span class="error_next_box"></span>
            </div>
            <div class="submit">
                <input type="button" name="btnJoin" id="regiBtn" value="회원가입">
            </div>
        </div>
    </div>
    <input type="hidden" name="sns_Type" value="none">
</form>

<script type="text/javascript">

    function regiModalOff() {
        modal_regi.style.display = "none";
        $('html, body').css({'overflow': 'auto', 'height': '100%'});
    }

    let error = document.querySelectorAll('.error_next_box');
    let emailStatus = false;
    let nicknameStatus = false;
    let idStatus = false;

    $(document).ready(function () {

        const modal_regi = document.getElementById("modal_regi");
        modal_regi.style.display = "flex";
        $('html, body').css({'overflow': 'hidden', 'height': '100%'});

        $('#userid').blur(function () {
            checkId();
        });

        $('#userpwd').blur(function () {
            checkPw();
            comparePw();
        });

        $('#userpwd2').blur(function () {
           comparePw();
        });

        $('#username').blur(function () {
            nameCheck();
        });
        $('#mobile').blur(function () {
            checkPhoneNum();
        });
        $('#useremail').blur(function () {
            isEmailCorrect();
        });
        $('#nickname').blur(function () {
            checkNickname();
        });

        $(document).on("keyup", "#mobile", function () {
            $(this).val($(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/, "$1-$2-$3").replace("--", "-"));
        });

    });

    function checkId() {
        var idPattern = /^[a-zA-Z0-9]{4,12}$/;

        if($('#userid').val() === "") {
            error[1].innerHTML = "필수 정보입니다. 아이디";
            error[1].style.color = "#ff0000";
            error[1].style.display = "block";
            idStatus = false;
        } else if(!idPattern.test($('#userid').val())) {
            error[1].innerHTML = "4~15자의 영문 소문자, 숫자만 사용 가능합니다.";
            error[1].style.color = "#ff0000";
            error[1].style.display = "block";
            idStatus = false;
        } else {
            $.ajax({
                url: "/regi/idCheck.do",
                data: {'id': $('#userid').val()},
                type: "get",
                dataType: "json",
                success: function (data) {
                    if (data === false) {
                        error[1].innerHTML = "멋진 아이디네요! ";
                        error[1].style.color = "#08A600";
                        error[1].style.display = "block";
                        idStatus = true;
                    } else {
                        error[1].innerHTML = "이미 존재하는 아이디입니다!";
                        error[1].style.color = "#ff0000";
                        error[1].style.display = "block";
                        idStatus = false;
                    }
                },
                error: function () {

                }
            });
        }
    }

    function checkPw() {
        var pwPattern = /[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]{8,16}/;
        if($('#userpwd').val() === "") {
            error[2].innerHTML = "필수 정보입니다. 비밀번호";
            error[2].style.display = "block";
            return false;
        } else if(!pwPattern.test($('#userpwd').val())) {
            error[2].innerHTML = "8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
            error[2].style.color = "#ff0000";
            error[2].style.display = "block";
            return false;
        } else {
            error[2].innerHTML = "사용 가능합니다.";
            error[2].style.color = "#08A600";
            error[2].style.display = "block";
            return true;
        }
    }

    function comparePw() {
        if($('#userpwd2').val() === "") {
            error[3].innerHTML = "필수 정보입니다. 비밀번호확인";
            error[3].style.color = "#ff0000";
            error[3].style.display = "block";
            return false;
        }

        if($('#userpwd2').val() === $('#userpwd').val() && $('#userpwd2').val() !== "") {
            error[3].innerHTML = "일치합니다.";
            error[3].style.color = "#08A600";
            error[3].style.display = "block";
            return true;
        } else if($('#userpwd2').val() !== $('#userpwd').val()) {
            error[3].innerHTML = "비밀번호가 일치하지 않습니다.";
            error[3].style.color = "#ff0000";
            error[3].style.display = "block";
            return false;
        }

    }

    function nameCheck() {
        let namePattern = /^[가-힣a-zA-Z]+$/;
        if ($('#username').val() === "") {
            error[5].innerHTML = "필수 정보입니다. 이름체크";
            error[5].style.display = "block";
            return false;
        } else if (!namePattern.test($('#username').val()) || $('#username').val().indexOf(" ") > -1) {
            error[5].innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
            error[5].style.display = "block";
            return false;
        } else {
            error[5].style.display = "none";
            return true;
        }
    }

    //닉네임 검사
    function checkNickname() {
        let nicknamePattern =  RegExp(/^[가-힣a-zA-Z0-9]{2,10}$/);

        if ($('#nickname').val() === "") {
            error[4].innerHTML = "필수 정보입니다. 닉네임";
            error[4].style.color = "#ff0000";
            error[4].style.display = "block";
            nicknameStatus = false;
        } else if (!nicknamePattern.test($('#nickname').val())) {
            error[4].innerHTML = "2~10자의 한글, 영문, 숫자만 사용 가능합니다.";
            error[4].style.color = "#ff0000";
            error[4].style.display = "block";
            nicknameStatus = false;
        } else {
            $.ajax({
                url: "/regi/nicknameCheck.do",
                data: {'nickname': $('#nickname').val()},
                type: "get",
                dataType: "json",
                success: function (data) {
                    if (data === false) {
                        error[4].innerHTML = "사용 가능한 닉네임입니다!";
                        error[4].style.color = "#08A600";
                        error[4].style.display = "block";
                        nicknameStatus = true;
                    } else {
                        error[4].innerHTML = "이미 존재하는 닉네임입니다!";
                        error[4].style.color = "#ff0000";
                        error[4].style.display = "block";
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

            error[7].innerHTML = "필수 정보입니다. 핸드폰";
            error[7].style.color = "#ff0000";
            error[7].style.display = "block";
            return false;
        } else if (!isPhoneNum.test($('#mobile').val())) {
            error[7].style.color = "#ff0000";
            error[7].innerHTML = "형식에 맞지 않는 번호입니다.";
            error[7].style.display = "block";
            return false;
        } else {
            error[7].style.display = "none";
            return true;
        }
    }

    function isEmailCorrect() {
        var emailPattern = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/i;

        if ($('#useremail').val() === "") {
            error[6].innerHTML = "필수 정보입니다. 이메일 ";
            error[6].style.color = "#ff0000";
            error[6].style.display = "block";
            emailStatus = false;
        } else if (!emailPattern.test($('#useremail').val())) {
            error[6].innerHTML = "형식에 맞지 않는 이메일입니다.";
            error[6].style.color = "#ff0000";
            error[6].style.display = "block";
            emailStatus = false;
        } else {
            $.ajax({
                url: "/regi/emailCheck.do",
                data: {'email': $('#useremail').val()},
                type: "get",
                dataType: "json",
                success: function (data) {
                    if (data === false) {
                        error[6].innerHTML = "사용 가능한 이메일입니다!";
                        error[6].style.color = "#08A600";
                        error[6].style.display = "block";
                        emailStatus = true;
                    } else {
                        error[6].innerHTML = "이미 존재하는 이메일입니다!";
                        error[6].style.color = "#ff0000";
                        error[6].style.display = "block";
                        emailStatus = false;
                    }
                },
                error: function () {

                }
            });

        }
    }

    $('input[name=btnJoin]').click(function () {
        let nameStatus = nameCheck();
        let mobileStatus = checkPhoneNum();
        let pwdStatus = checkPw();
        let pwd2Status = comparePw();
        checkId();
        checkNickname();
        isEmailCorrect();

        if (!idStatus) {
            $('#userid').focus();
            return;
        } else if (!pwdStatus) {
            $('#userpwd').focus();
            return;
        } else if (!pwd2Status) {
            $('#userpwd2').focus();
            return;
        } else if (!nicknameStatus) {
            $('#nickname').focus();
            return;
        } else if (!nameStatus) {
            $('#username').focus();
            return;
        } else if (!emailStatus) {
            $('#useremail').focus();
            return;
        } else if (!mobileStatus) {
            $('#mobile').focus();
            return;
        }

        $('#regiFrm').submit();

    });
</script>

</body>
</html>

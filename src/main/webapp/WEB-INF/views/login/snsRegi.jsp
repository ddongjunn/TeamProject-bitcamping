
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

<form id = "frm">
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
                        <input type="text" id="nickname" class="int" name="nickname" maxlength="10" required>
                    </span>
            <span class="error_next_box"></span>
        </div>

        <!-- NAME -->
        <div>
            <h3 class="join_title"><label for="name">이름</label></h3>
            <span class="box int_name">
                        <input type="text" id="name" class="int" name="name" maxlength="20" value="${info.name}" required>
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
                                <input type="text" id="yy" class="int" name="yy" maxlength="4" placeholder="년(4자)" value="${info.birthyear}" required>
                            </span>
                </div>

                <!-- BIRTH_MM -->
                <div id="bir_mm">
                            <span class="box">
                                <select id="mm" class="sel" name="mm" required>
                                        <option value="월">월</option>
                                    <c:forEach begin="1" end="12" varStatus="status">
                                        <option value="${status.index}" <c:if test="${ fn:substring(info.birthday, 0, 2) == status.index }">selected</c:if> > ${status.index} </option>
                                    </c:forEach>

                                </select>
                            </span>
                </div>

                <!-- BIRTH_DD -->
                <div id="bir_dd">
                    <span class="box">
                        <c:choose>
                            <c:when test="${info.birthday == null}">
                                <input type="text" id="dd" name="dd" class="int" maxlength="2" placeholder="일" required>
                            </c:when>
                            <c:when test="${fn:substring(info.birthday, 3, 4) eq '0'}">
                                <input type="text" id="dd" class="int" name="dd" maxlength="2" placeholder="일" value="${ fn:substring( info.birthday,4 ,5 )}" required>
                            </c:when>
                            <c:otherwise>
                                <input type="text" id="dd" class="int" name="dd" maxlength="2" placeholder="일" value="${ fn:substring( info.birthday,3 ,5 )}" required>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
            <span class="error_next_box"></span>
        </div>

        <!-- EMAIL -->
        <div>
            <h3 class="join_title"><label for="email">이메일</label></h3>
            <span class="box int_email">
                        <input type="text" id="email" class="int" maxlength="100" name="email" placeholder="이메일" value="${info.email}" required>
                    </span>
            <span class="error_next_box">이메일 주소를 다시 확인해주세요.</span>
        </div>

        <!-- MOBILE -->
        <div>
            <h3 class="join_title"><label for="phoneNo">휴대전화</label></h3>
            <span class="box int_mobile">
                        <c:choose>
                            <c:when test="${info.mobile == null}">
                                <input type="text" id="mobile" class="int" maxlength="13" name="phone" placeholder="전화번호 입력" value="" required >
                            </c:when>
                            <c:otherwise>
                                <c:set var="mobile" value="${fn:split(info.mobile,'-')}"/>
                                <input type="text" id="mobile" class="int" maxlength="13" name="phone" placeholder="전화번호 입력" value="${mobile[0]}-${mobile[1]}-${mobile[2]}" required>
                            </c:otherwise>
                        </c:choose>

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

    <input type="hidden" name="snsType" value="${sns_type}">
    <input type="hidden" name="id" value="${info.id}">
</form>

<script type="text/javascript">
    let error = document.querySelectorAll('.error_next_box');
    let nicknameFlag = false;
    let nameFlag = false;
    let yyFlag = false;
    let phoneFlag = false;
    let emailFlag = false;

$(document).ready(function () {

    $('#name').blur(function () {
        nameCheck();
    });

    $('#yy').blur(function () {
       isBirthCompleted();
    });
    $('#mm').blur(function () {
        isBirthCompleted();
    });
    $('#dd').blur(function () {
        isBirthCompleted();
    });
    $('#mobile').blur(function () {
        checkPhoneNum();
    });
    $('#email').blur(function (){
        isEmailCorrect();
    });

    $(document).on("keyup", "#mobile", function() { $(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); });

});

    function nameCheck() {
        let namePattern = /[a-zA-Z가-힣]/;
        if($('#name').val() === "") {
            error[1].innerHTML = "필수 정보입니다.";
            error[1].style.display = "block";
            nameFlag = false;
        } else if(!namePattern.test($('#name').val()) || $('#name').val().indexOf(" ") > -1) {
            error[1].innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
            error[1].style.display = "block";
            nameFlage = false;
        } else {
            error[1].style.display = "none";
            nameFlag = true;
        }
    }

    //닉네임 검사
    $('#nickname').blur(function () {
        let nicknamePattern = /^([a-zA-Z0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]).{1,10}$/;

        if( $('#nickname').val() === "") {
            error[0].innerHTML = "필수 정보입니다.";
            error[0].style.color = "#ff0000";
            error[0].style.display = "block";
            nicknameFlag = false;
        } else if(!nicknamePattern.test($('#nickname').val())) {
            error[0].innerHTML = "2~10자의 한글, 영문, 숫자만 사용 가능합니다.";
            error[0].style.color = "#ff0000";
            error[0].style.display = "block";
            nicknameFlag = false;
        }else {
            $.ajax({
                url: "/regi/nicknameCheck.do",
                data: {'nickname': $('#nickname').val()},
                type: "get",
                dataType: "json",
                success: function (data) {
                    if(data === false){
                        error[0].innerHTML = "사용 가능한 닉네임입니다!";
                        error[0].style.color = "#08A600";
                        error[0].style.display = "block";
                        nameFlag = true;
                    }else{
                        error[0].innerHTML = "이미 존재하는 닉네임입니다!";
                        error[0].style.color = "#ff0000";
                        error[0].style.display = "block";
                        nicknameFlag = false;
                    }
                },
                error: function () {

                }
            });
        }

    });

    function isBirthCompleted() {
        let yearPattern = /[0-9]{4}/;

        if(!yearPattern.test($('#yy').val())) {
            error[2].innerHTML = "태어난 년도 4자리를 정확하게 입력하세요.";
            error[2].style.display = "block";
            yyFlag = false;
        } else {
            isMonthSelected();
        }


        function isMonthSelected() {
            if($('#mm').val() === "월") {
                error[2].innerHTML = "태어난 월을 선택하세요.";
                yyFlag = false;
            } else {
                isDateCompleted();
            }
        }

        function isDateCompleted() {
            if($('#dd').val() === "") {
                error[2].innerHTML = "태어난 일(날짜) 2자리를 정확하게 입력하세요.";
                yyFlag = false;
            } else {
                isBirthRight();
            }
        }
    }

    function isBirthRight() {
        var datePattern = /\d{1,2}/;
        if(!datePattern.test($('#dd').val()) || Number($('#dd').val())<1 || Number($('#dd').val())>31) {
            error[2].innerHTML = "생년월일을 다시 확인해주세요.";
            yyFlag = false;
        }else{
            checkAge();
        }
    }

    function checkAge() {
        if($('#yy').val() === "" && $('#dd').val() === ""){
            error[2].innerHTML = "필수 정보입니다.";
            error[2].style.display = "block";
            yyFlag = false;
            return;
        }

        if(Number($('#yy').val()) < 1920) {
            error[2].innerHTML = "정말이세요?";
            error[2].style.display = "block";
            yyFlag = false;
        } else if(Number($('#yy').val()) > 2020) {
            error[2].innerHTML = "미래에서 오셨군요. ^^";
            error[2].style.display = "block";
            yyFlag = false;
        } else if(Number($('#yy').val()) > 2005) {
            error[2].innerHTML = "만 14세 미만의 어린이는 보호자 동의가 필요합니다.";
            error[2].style.display = "block";
            yyFlag = false;
        } else {
            error[2].style.display = "none";
            yyFlag = true;
        }
    }

    function checkPhoneNum() {
        var isPhoneNum = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;

        if($('#mobile').val() === "") {
            error[4].innerHTML = "필수 정보입니다.";
            error[4].style.display = "block";
            phoneFlag = false;
        } else if(!isPhoneNum.test($('#mobile').val())) {
            error[4].innerHTML = "형식에 맞지 않는 번호입니다.";
            error[4].style.display = "block";
            phoneFlag = false;
        } else {
            error[4].style.display = "none";
            phoneFlag = true;
        }
    }

    function isEmailCorrect() {
        var emailPattern = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/i

        if(email.value === ""){
            error[3].innerHTML = "필수 정보입니다.";
            error[3].style.display = "block";
            emailFlag = false;
        } else if(!emailPattern.test(email.value)) {
            error[3].style.display = "block";
            emailFlag = false;
        } else {
            $.ajax({
                url: "/regi/emailCheck.do",
                data: {'email': $('#email').val()},
                type: "get",
                dataType: "json",
                success: function (data) {
                    console.log("data" + data);
                    if(data === false){
                        error[3].innerHTML = "사용 가능한 이메일입니다!";
                        error[3].style.color = "#08A600";
                        error[3].style.display = "block";
                        emailFlag = true;
                    }else{
                        error[3].innerHTML = "이미 존재하는 이메일입니다!";
                        error[3].style.color = "#ff0000";
                        error[3].style.display = "block";
                        emailFlag = false;
                    }
                },
                error: function () {

                }
            });
        }
    }

    $('#btnJoin').click(function () {
        if(nicknameFlag === false && nameFlag === false && yyFlag === false && emailFlag === false && phoneFlag === false ){
            alert('잘못된 정보를 입력하셨습니다!');
            return;
        }

        $.ajax({
            url: "/regi/addMember.do",
            data: $('#frm').serialize(),
            type: "get",
            dataType: "json",
            success: function (data) {

            },
            error: function () {

            }
        });
    });
</script>

</body>
</html>


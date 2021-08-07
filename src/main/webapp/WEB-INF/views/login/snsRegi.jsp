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

<form id="frm" method="post" action="/regi/addMember.do">
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
                        <input type="text" id="name" class="int" name="username" maxlength="20" value="${info.name}"
                               required>
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
                                <input type="text" id="yy" class="int" name="yy" maxlength="4" placeholder="년(4자)"
                                       value="${info.birthyear}" required>
                            </span>
                    </div>

                    <!-- BIRTH_MM -->
                    <div id="bir_mm">
                            <span class="box">
                                <select id="mm" class="sel" name="mm" required>
                                        <option value="월">월</option>
                                    <c:forEach begin="1" end="12" varStatus="status">
                                        <option value="${status.index}"
                                                <c:if test="${ fn:substring(info.birthday, 0, 2) == status.index }">selected</c:if> > ${status.index} </option>
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
                                <input type="text" id="dd" class="int" name="dd" maxlength="2" placeholder="일"
                                       value="${ fn:substring( info.birthday,4 ,5 )}" required>
                            </c:when>
                            <c:otherwise>
                                <input type="text" id="dd" class="int" name="dd" maxlength="2" placeholder="일"
                                       value="${ fn:substring( info.birthday,3 ,5 )}" required>
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
                        <input type="text" id="email" class="int" maxlength="100" name="email" placeholder="이메일"
                               value="${info.email}" required>
                    </span>
                <span class="error_next_box">이메일 주소를 다시 확인해주세요.</span>
            </div>

            <!-- MOBILE -->
            <div>
                <h3 class="join_title"><label for="phoneNo">휴대전화</label></h3>
                <span class="box int_mobile">
                        <c:choose>
                            <c:when test="${info.mobile == null}">
                                <input type="text" id="mobile" class="int" maxlength="13" name="phone"
                                       placeholder="전화번호 입력" value="" required>
                            </c:when>
                            <c:otherwise>
                                <c:set var="mobile" value="${fn:split(info.mobile,'-')}"/>
                                <input type="text" id="mobile" class="int" maxlength="13" name="phone"
                                       placeholder="전화번호 입력" value="${mobile[0]}-${mobile[1]}-${mobile[2]}" required>
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
    let emailStatus = false;
    let nicknameStatus = false;
    let mmStatus = false;
    let ddStatus = false;

    $(document).ready(function () {

        isEmailCorrect();

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
        $('#email').blur(function () {
            isEmailCorrect();
        });

        $(document).on("keyup", "#mobile", function () {
            $(this).val($(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/, "$1-$2-$3").replace("--", "-"));
        });

    });

    function nameCheck() {
        let namePattern = /^[가-힣a-zA-Z]+$/;
        if ($('#name').val() === "") {
            error[1].innerHTML = "필수 정보입니다.";
            error[1].style.display = "block";
            return false;
        } else if (!namePattern.test($('#name').val()) || $('#name').val().indexOf(" ") > -1) {
            error[1].innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
            error[1].style.display = "block";
            return false;
        } else {
            error[1].style.display = "none";
            return true;
        }
    }

    //닉네임 검사
    $('#nickname').blur(function () {
        let nicknamePattern = /^([a-zA-Z0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]).{1,10}$/;

        if ($('#nickname').val() === "") {
            error[0].innerHTML = "필수 정보입니다.";
            error[0].style.color = "#ff0000";
            error[0].style.display = "block";
            nicknameStatus = false;
        } else if (!nicknamePattern.test($('#nickname').val())) {
            error[0].innerHTML = "2~10자의 한글, 영문, 숫자만 사용 가능합니다.";
            error[0].style.color = "#ff0000";
            error[0].style.display = "block";
            nicknameStatus = false;
        } else {
            $.ajax({
                url: "/regi/nicknameCheck.do",
                data: {'nickname': $('#nickname').val()},
                type: "get",
                dataType: "json",
                success: function (data) {
                    if (data === false) {
                        error[0].innerHTML = "사용 가능한 닉네임입니다!";
                        error[0].style.color = "#08A600";
                        error[0].style.display = "block";
                        nicknameStatus = true;
                    } else {
                        error[0].innerHTML = "이미 존재하는 닉네임입니다!";
                        error[0].style.color = "#ff0000";
                        error[0].style.display = "block";
                        nicknameStatus = false;
                    }
                },
                error: function () {

                }
            });
        }

    });

    function isBirthCompleted() {
        let yearPattern = /[0-9]{4}/;

        if (!yearPattern.test($('#yy').val())) {
            error[2].innerHTML = "태어난 년도 4자리를 정확하게 입력하세요.";
            error[2].style.display = "block";
        } else {
            isMonthSelected();
        }


        function isMonthSelected() {
            if ($('#mm').val() === "월") {
                error[2].innerHTML = "태어난 월을 선택하세요.";
            } else {
                mmStatus = true;
                isDateCompleted();
            }
        }

        function isDateCompleted() {
            if ($('#dd').val() === "") {
                error[2].innerHTML = "태어난 일(날짜) 2자리를 정확하게 입력하세요.";
            } else {
                isBirthRight();
            }
        }
    }

    function isBirthRight() {
        var datePattern = /\d{1,2}/;
        if (!datePattern.test($('#dd').val()) || Number($('#dd').val()) < 1 || Number($('#dd').val()) > 31) {
            error[2].innerHTML = "생년월일을 다시 확인해주세요.";
        } else {
            ddStatus = true;
            checkAge();
        }
    }

    function checkAge() {
        if ($('#yy').val() === "" && $('#dd').val() === "") {
            error[2].innerHTML = "필수 정보입니다.";
            error[2].style.display = "block";
            return;
        }

        if (Number($('#yy').val()) < 1920) {
            error[2].innerHTML = "정말이세요?";
            error[2].style.display = "block";
        } else if (Number($('#yy').val()) > 2020) {
            error[2].innerHTML = "미래에서 오셨군요. ^^";
            error[2].style.display = "block";
        } else if (Number($('#yy').val()) > 2005) {
            error[2].innerHTML = "만 14세 미만의 어린이는 보호자 동의가 필요합니다.";
            error[2].style.display = "block";
        } else {
            error[2].style.display = "none";
            return true;
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

            /*$('#frm').submit();*/
        }
    }

    $('#btnJoin').click(function () {
        let nameStatus = nameCheck();
        isBirthCompleted();
        let yyStatus = checkAge();
        let mobileStatus = checkPhoneNum();

        if(!nicknameStatus){
            $('#nickname').focus();
        } else if(!nameStatus) {
            $('#name').focus();
        } else if(!yyStatus) {
            $('#yy').focus();
        } else if(!mmStatus) {
            $('#mm').focus();
        } else if (!ddStatus || ($('#dd').val() < 1 && $('#dd').val() > 31)) {
            $('#dd').focus();
        } else if(!emailStatus){
            $('#email').focus();
        } else if(!mobileStatus){
            $('#mobile').focus();
        } else {
            $('#frm').submit();
        }

    });
</script>

</body>
</html>


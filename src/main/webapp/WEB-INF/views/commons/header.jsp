<%@ page import="com.camping.bit.dto.MemberDto" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html>
<head>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">

    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath() %>/resources/jquery/jquery.twbsPagination.min.js"></script>

    <!-- 공통 css -->
    <link rel="stylesheet" type="text/css" href="/resources/css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/css/header.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/css/footer.css"/>

    <!-- 공통 css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/findAccount.css">

    <!-- page별 css -->
    <link rel="stylesheet" type="text/css" href="/resources/css/home.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/css/board.css"/>
    
    <meta charset="UTF-8">

    <title>비트캠핑</title>

</head>
<body>

<div id="ground">
    <!-- header start -->
    <div id="header">
    	<a href="/main.do"><img class="sidelogo" src="/resources/images/newlogo.png" alt="로고"></a>
        <div class="indiv">
            <div class="logobox">
                <a href="/main.do">
                	<img id="logo" src="/resources/images/newlogo.png" alt="로고">
                </a>
            </div>
			<ul id="menu">
				<li><a href="/aboutUs.do">ABOUT US</a></li>
                <li><a href="/csite/campinglist.do">캠핑장 검색</a></li>
                <li><a href="/rent/list.do">캠핑장비 대여</a></li>
                <li><a href="/community/main.do">캠핑커뮤니티</a></li>
                <li><a href="/cs/csMain.do">고객센터</a></li>
            </ul>
            <div id="gnb">
                <c:choose>
                    <c:when test="${empty login}">
                        <a href="javascript:void(0)" id="header_login">로그인</a> <a href="/regi/normal.do">회원가입</a>
                    </c:when>
                    <c:when test="${login.auth == 0}">
                        <a href="/login/logout.do">로그아웃</a> <a href="/account/main.do">마이페이지</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/login/logout.do">로그아웃</a> <a href="/admin/main.do">관리자페이지</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <!-- header end-->
	<div></div>
    <div>
        <div id="login_modal" class="login_modal-overlay" style="z-index: 800;">
            <div class="login_modal-window">
                <div class="login_modal_close-area"><span id="close" style="cursor: pointer">X</span></div>
                <div class="login_modal_title">
                    <div class="modal_login">
                        <div class="modal_logo">
                        	<img src="/resources/images/newlogo.png">
                        </div>
                        <div class="modal_login_sns">
                            <form style="display: inline" action="/login/naver.do" method="post">
                                <button class='btn-social-login' style='background:#1FC700'><i
                                        class="xi-3x xi-naver"></i>
                                </button>
                            </form>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <form style="display: inline" action="/login/kakao.do" method="post">
                                <button class='btn-social-login' style='background:#FFEB00'><i
                                        class="xi-3x xi-kakaotalk text-dark"></i></button>
                            </form>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <form style="display: inline" action="javascript:void(0)">
                                <button class='btn-social-login' style='background:#D93025'><i
                                        class="xi-3x xi-google"></i>
                                </button>
                            </form>
                        </div>
                        <div class="modal_login_id">
                            <h4>아이디</h4>
                            <input type="email" name="" id="id" placeholder="ID">
                        </div>
                        <div class="modal_login_pw">
                            <h4>비밀번호</h4>
                            <input type="password" name="" id="pwd" placeholder="Password">
                        </div>
                        <div class="modal_login_etc">
                            <div class="checkbox">

                            </div>
                            <div class="modal_forgot_pw">
                                <a href="#none" id="findId" style="color: #353535">아이디</a> / <a href="#none" id="findPw" style="color: #353535">비밀번호찾기</a>
                            </div>
                        </div>
                        <div class="modal_submit">
                            <input type="submit" id="loginBtn" value="로그인" style="margin-bottom: 15px">
                            <a href="/regi/normal.do"><input type="button" value="회원가입"></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div id="modal_findId" class="modal-overlay_findId" style="display: none;" aria-hidden="false">
            <div class="modal-window">
                <%--<div class="close_findId" style="">X</div>--%>
                <div class="login_modal_close-area"><span class="close_findId" style="cursor: pointer">X</span></div>
                <div class="modal_login">
                    <h2>아이디 찾기</h2>
                    <div class="modal_login_id">

                        <h4><b>이름</b></h4>
                        <input type="text" name="" id="find_name" placeholder="이름을 입력해주세요.">
                    </div>
                    <div class="modal_login_pw">
                        <h4><b>이메일</b></h4>
                        <input type="text" name="" id="find_email" placeholder="이메일을 입력해주세요.">

                    </div>

                    <div style="height: 30px; margin-top: 15px">
                        <span class="error_next_box"></span>
                    </div>

                    <div class="modal_submit">
                        <input type="submit" id="findIdBtn" value="아이디 찾기" style="margin-bottom: 15px">
                    </div>
                </div>
            </div>
        </div>


        <div id="modal_findPw" class="modal-overlay_findId" style="display: none;" aria-hidden="false">
            <div class="modal-window">
                <%--<div class="close_findId" style="">X</div>--%>
                <div class="login_modal_close-area"><span class="close_findPw" style="cursor: pointer">X</span></div>
                <div class="modal_login">

                    <h2>비밀번호 찾기</h2>
                    <div class="modal_login_id">

                        <h4><b>아이디</b></h4>
                        <input type="text" name="" id="findPw_id" placeholder="아이디를 입력해주세요.">
                    </div>
                    <div class="modal_login_pw">
                        <h4><b>이메일</b></h4>
                        <input type="text" name="" id="findPw_email" placeholder="이메일을 입력해주세요.">

                    </div>

                    <div style="height: 30px; margin-top: 15px">
                        <span class="error_findPw_box"></span>
                    </div>

                    <div class="modal_submit">
                        <input type="submit" id="findPwBtn" value="비밀번호 찾기" style="margin-bottom: 15px">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function(){	

	var navBar = $("#menu");
	var hdrHeight = $(".logobox").height();

	$(window).scroll(function() {
	  if( $(this).scrollTop() > hdrHeight + 50) {
	    navBar.addClass("navScrolled");
	    $(".sidelogo").show();
	  } else {
	    navBar.removeClass("navScrolled");
	    $(".sidelogo").hide();
	  }
	});
	
});
</script>

<script type="text/javascript">
    //로그인 모달
    const modal = document.getElementById("login_modal");

    $(document).ready(function () {
        let div = $('#login_modal');
        div.css("position", "fixed");
        div.css("top", Math.max(0, (($(window).height() - div.outerHeight()) / 2) + $(window).scrollTop()) + "px");
        div.css("left", Math.max(0, (($(window).width() - div.outerWidth()) / 2) + $(window).scrollLeft()) + "px");
    });

    function modalOn() {

        /*$('#login_modal').fadeIn(500);*/

        modal.style.display = "flex"
        modalOff_findId();
        modalOff_findPw();
        $('html, body').css({/*'overflow': 'hidden',*/ 'height': '100%'}); // 모달팝업 중 html,body의 scroll을 hidden시킴
    }

    function isModalOn() {
        return modal.style.display === "flex"
    }

    function modalOff() {
        modal.style.display = "none"
        $('html, body').css({'overflow': 'auto', 'height': '100%'});
    }

    const btnModal = document.getElementById("header_login");
    btnModal.addEventListener("click", e => {
        modalOn();
    });

    //x버튼으로 모달창 닫기
    const closeBtn = document.getElementById("close");
    closeBtn.addEventListener("click", e => {
        modalOff();
    });

    //바깥쪽 클릭으로 모달창 닫기
    /*   modal.addEventListener("click", e => {
            const evTarget = e.target
            if(evTarget.classList.contains("login_modal-overlay")) {
                modalOff();
            }
        });*/

    //esc키로 모달창 닫기
    window.addEventListener("keyup", e => {
        if (isModalOn() && e.key === "Escape") {
            modalOff();
        }
    });

    /////////////////////////////////////////////////////////////////
    //아이디찾기
    const modal_findId = document.getElementById("modal_findId");

    function modalOn_findId() {
        modal_findId.style.display = "flex"
    }

    function isModalOn_findId() {
        return modal_findId.style.display === "flex"
    }

    function modalOff_findId() {
        modal_findId.style.display = "none"
    }

    const btnModal_findId = document.getElementById("findId");
    btnModal_findId.addEventListener("click", e => {
        modalOff();
        modalOn_findId();
        findId_error[0].style.display = "none";
    });

    const closeBtn_findId = modal_findId.querySelector(".close_findId");

    closeBtn_findId.addEventListener("click", e => {
        modalOff_findId();
        $('#find_name').val("");
        $('#find_email').val("");
    });

    /*modal.addEventListener("click", e => {
        const evTarget = e.target
        if(evTarget.classList.contains("modal-overlay_findId")) {
            modalOff_findId()
        }
    })
    window.addEventListener("keyup", e => {
        if(isModalOn() && e.key === "Escape") {
            modalOff_findId()
        }
    })*/

    $('#loginBtn').click(function () {
        if ($('#id').val().trim() === "") {
            alert('아이디를 입력해주세요.');
            return;
        } else if ($('#pwd').val().trim() === "") {
            alert('비밀번호를 입력해주세요.');
            return;
        }

        $.ajax({
            url: "/login/normal.do",
            data: {'id': $('#id').val(), 'pwd': $('#pwd').val()},
            type: "post",
            dataType: "json",
            success: function (data) {
                if (data) {
                    location.href = '${param.move}';
                    return;
                }
                alert('아이디와 비밀번호를 확인해주세요.');
            },
            error: function (error) {

            }
        });
    });

    //아이디 찾기
    let findId_error = document.querySelectorAll('.error_next_box');

    $('#findIdBtn').click(function () {

        if ($('#find_name').val().trim() === "") {
            findId_error[0].innerHTML = "아이디를 입력해주세요.";
            findId_error[0].style.color = "#ff0000";
            findId_error[0].style.display = "block";
            return;

        } else if ($('#find_email').val().trim() === "") {
            findId_error[0].innerHTML = "이메일을 입력해주세요";
            findId_error[0].style.color = "#ff0000";
            findId_error[0].style.display = "block";
            return;

        } else {

            $.ajax({
                url: "/login/findId.do",
                data: {'username': $('#find_name').val(), 'email': $('#find_email').val()},
                type: "post",
                success: function (data) {
                    if (data === "null") {
                        findId_error[0].innerHTML = "일치하는 회원 정보가 없습니다.";
                        findId_error[0].style.color = "#ff0000";
                        findId_error[0].style.display = "block";
                        return;
                    }
                    modalOff_findId();
                    $('#find_name').val("");
                    $('#find_email').val("");
                    Swal.fire({
                        text: '회원님의 아이디는 ' + data + ' 입니다.',
                        width: 500,
                        padding: 10
                    });
                    modalOn();
                },
                error: function (error) {

                }
            });
        }
    });

</script>


<!--비밀번호 찾기 -->
<script type="text/javascript">

    const modal_findPw = document.getElementById("modal_findPw");

    function modalOn_findPw() {
        modal_findPw.style.display = "flex"
        $('html, body').css({'overflow': 'hidden', 'height': '100%'}); // 모달팝업 중 html,body의 scroll을 hidden시킴
    }

    function isModalOn_findPw() {
        return modal_findPw.style.display === "flex"
    }

    function modalOff_findPw() {
        modal_findPw.style.display = "none"
        $('html, body').css({'overflow': 'auto', 'height': '100%'});
    }

    const btnModal_findPw = document.getElementById("findPw");
    btnModal_findPw.addEventListener("click", e => {
        modalOff();
        modalOn_findPw();
    });

    const closeBtn_findPw = modal_findPw.querySelector(".close_findPw");

    closeBtn_findPw.addEventListener("click", e => {
        modalOff_findPw();
        $('#findPw_id').val("");
        $('#findPw_email').val("");
        error[0].innerHTML = "";
    });

    let findPw_error = document.querySelectorAll('.error_findPw_box');


    $('#findPwBtn').click(function () {

        if ($('#findPw_id').val().trim() === "") {
            findPw_error[0].innerHTML = "아이디를 입력해주세요.";
            findPw_error[0].style.color = "#ff0000";
            findPw_error[0].style.display = "block";
            return;

        } else if ($('#findPw_email').val().trim() === "") {
            findPw_error[0].innerHTML = "이메일을 입력해주세요";
            findPw_error[0].style.color = "#ff0000";
            findPw_error[0].style.display = "block";
            return;

        }


        $.ajax({
            url: "/login/findPw.do",
            data: {'id': $('#findPw_id').val(), 'email': $('#findPw_email').val()},
            type: "post",
            success: function (data) {
                console.log(data);

                if (data === "null") {
                    findPw_error[0].innerHTML = "일치하는 회원 정보가 없습니다.";
                    findPw_error[0].style.color = "#ff0000";
                    findPw_error[0].style.display = "block";
                } else {
                    modalOff_findPw();

                    console.log("data = " + data);

                    Swal.fire({
                        html: '이메일 : ' + $('#findPw_email').val() + '<br>임시 비밀번호가 발송되었습니다.',
                        width: 500,
                        padding: 10
                    });

                    $('#findPw_id').val("");
                    $('#findPw_email').val("");
                    modalOn();
                }
            },
            error: function (error) {

            }
        });
    });
</script>

<c:if test="${param.move != null}">
    <script>
        move = '${param.move}';
        modalOn();
    </script>
</c:if>

</body>
</html>
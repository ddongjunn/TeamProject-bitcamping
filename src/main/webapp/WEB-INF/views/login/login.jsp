<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <!-- 카카오 로그인 -->
    <script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="login_modal" class="login_modal-overlay">
    <div class="login_modal-window">
        <div class="login_modal_close-area"><span id="close">X</span></div>
        <div class="login_modal_title">
            <h2>비트캠핑</h2>
        </div>
    </div>
</div>

<div class="modal_wrap">
    <div class="modal_login">
        <h2>비트캠핑</h2>
        <div class="modal_login_sns">
            <a href="${naverUrl}"><button class='btn-social-login' style='background:#1FC700'><i class="xi-3x xi-naver"></i></button></a>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="${kakaoUrl}"><button class='btn-social-login' style='background:#FFEB00'><i class="xi-3x xi-kakaotalk text-dark"></i></button></a>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="#none"><button class='btn-social-login' style='background:#D93025'><i class="xi-3x xi-google"></i></button></a>
        </div>
        <div class="modal_login_id">
            <h4>아이디</h4>
            <input type="email" name="" id="" placeholder="Email">
        </div>
        <div class="modal_login_pw">
            <h4>비밀번호</h4>
            <input type="password" name="" id="" placeholder="Password">
        </div>
        <div class="modal_login_etc">
            <div class="checkbox">
                <input type="checkbox" name="" id=""> 아이디 저장
            </div>
            <div class="modal_forgot_pw">
                <a href="">비밀번호 찾기</a>
            </div>
        </div>
        <div class="modal_submit">
            <input type="submit" value="로그인" style="margin-bottom: 15px">
            <input type="button" value="회원가입">
        </div>
    </div>
</div>

<script type="text/javascript">
    const modal = document.getElementById("login_modal");

    function modalOn() {
        modal.style.display = "flex"
    }
    function isModalOn() {
        return modal.style.display === "flex"
    }
    function modalOff() {
        modal.style.display = "none"
        $('html, body').css({'overflow': 'auto', 'height': '100%'}); //scroll hidden 해제 $('#element').off('scroll touchmove mousewheel'); // 터치무브 및 마우스휠 스크롤 가능
    }

    const btnModal = document.getElementById("login");
    btnModal.addEventListener("click", e => {
        modalOn();
    });

    //x버튼으로 모달창 닫기
    const closeBtn = document.getElementById("close");
    closeBtn.addEventListener("click", e => {
        modalOff();
    });

    //바깥쪽 클릭으로 모달창 닫기
    modal.addEventListener("click", e => {
        const evTarget = e.target
        if(evTarget.classList.contains("modal-overlay")) {
            modalOff();
        }
    });

    //esc키로 모달창 닫기
    window.addEventListener("keyup", e => {
        if(isModalOn() && e.key === "Escape") {
            modalOff();
        }
    })

</script>

</body>
</html>
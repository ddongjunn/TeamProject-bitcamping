<%@ page import="com.camping.bit.dto.MemberDto" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">

	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery/jquery.twbsPagination.min.js"></script>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
<div>
		<c:choose>
			<c:when test="${empty login}">
				<a href="#none" id="header_login">로그인</a> <a href="/regi/normal.do">회원가입</a>
			</c:when>
			<c:otherwise>
				<a href="/login/logout.do">로그아웃</a>
			</c:otherwise>
		</c:choose>
</div>
<div>
	<a href="/csite/campinglist.do">캠핑장검색</a> <a href="/community/main.do">커뮤니티</a> <a href="/rent/list.do">물품대여</a> <a
		href="cs.do">고객센터</a>
</div>

<div id="login_modal" class="login_modal-overlay">
	<div class="login_modal-window">
		<div class="login_modal_close-area"><span id="close">X</span></div>
		<div class="login_modal_title">
				<div class="modal_login">
					<h2>비트캠핑</h2>
					<div class="modal_login_sns">
						<form style="display: inline" action="/login/naver.do" method="post">
							<button class='btn-social-login' style='background:#1FC700'><i class="xi-3x xi-naver"></i></button>
						</form>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<form style="display: inline" action="/login/kakao.do" method="post">
							<button class='btn-social-login' style='background:#FFEB00'><i class="xi-3x xi-kakaotalk text-dark"></i></button>
						</form>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<form style="display: inline">
							<button class='btn-social-login' style='background:#D93025'><i class="xi-3x xi-google"></i></button>
						</form>
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
						<a href="/regi/normal.do"><input type="button" value="회원가입"></a>
					</div>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
	const modal = document.getElementById("login_modal");

	function modalOn() {
		modal.style.display = "flex"
		$('html, body').css({'overflow': 'hidden', 'height': '100%'}); // 모달팝업 중 html,body의 scroll을 hidden시킴
	}
	function isModalOn() {
		return modal.style.display === "flex"
	}
	function modalOff() {
		modal.style.display = "none"
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
	modal.addEventListener("click", e => {
		const evTarget = e.target
		if(evTarget.classList.contains("login_modal-overlay")) {
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
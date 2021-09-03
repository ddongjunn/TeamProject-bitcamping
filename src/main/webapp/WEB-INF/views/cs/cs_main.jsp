<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <style type="text/css"> -->
<link rel="stylesheet" type="text/css" href="/resources/css/cs.css" />
</head>
<body>

<div class="faq">

	<div class="faqintro">
		<p class="faqtitle">FAQ</p>
		<span class="faqdisc">자주 찾는 질문에서 궁금한 내용을 찾아보세요.</span>
		<hr>
	</div>

	<div class="faqmenuarea">
		<div class="faqmenu">
			<p class="faqmenutitle">나의 정보 조회</p>
			<span class="faqmenulist">
				<p>아이디 찾기</p>
				<p>패스워드 찾기</p>
				<p>회원정보 변경 및 탈퇴 안내</p>
			</span>
		</div>
		<div class="faqmenu">
			<p class="faqmenutitle">주문/배송/반품 안내</p>
			<span class="faqmenulist">
				<p> <a href="/account/myOrder.do"> 주문 내역 조회</a></p>
				<p><a href="/cs/noticeDetail.do?notice_Seq=3"> 주문 방법 및 결제 </a></p>
			</span>
		</div>
		<div class="faqmenu">
			<p class="faqmenutitle">기타문의</p>
			<span class="faqmenulist">
				<p><a href="/cs/noticeDetail.do?notice_Seq=4"> 고객센터 이용 안내 </a></p>
				<p><a href="/cs/noticeDetail.do?notice_Seq=5"> pc문제해결/오류 안내 </a></p>
				<p><a href="/cs/noticeDetail.do?notice_Seq=6">현금영수증 및 전자 영수증안내</a></p>
			</span>
		</div>
	</div>	

</div>

<div class="customer">
	<div class="customer_title"><h2>CONTACT US</h2></div>
		<hr>
			<div class="content_row">
				<div class="customer_content">
					<div class="phohe"><img src="../resources/images/cs_phone.png" style="margin-bottom: 15px" >
						<span class="content_title" >전화문의</span>
                        <p></p>
						<div id="a">
                            <p>
                                <br>
                            </p>
							<p>080-022-0182</p>
							<p>월~일: 오전 9시 ~ 오후 8시</p>
						</div>
					</div>
					<div class="chat"><img src="../resources/images/cs_chat.png" style="margin-bottom: 15px">
						<span class="content_title">1:1 채팅문의</span>
                        <p>
                            <br>
                        </p>
						<p><a href="http://pf.kakao.com/_sDxgUs/chat" target="_blank">1:1 채팅문의하기</a></p>
					</div>
					<div class="email"><img src="../resources/images/cs_email.png" style="margin-bottom: 15px">
						<span class="content_title">1:1 Email 문의</span>
                        <p>
                            <br>
                        </p>
						<p><a href="mailto:ddongjunn@gmail.com">E-mail 문의하기</a></p>
					</div>
					<div class="location"><img src="../resources/images/cs_location.png" style="margin-bottom: 15px">
						<span class="content_title">위치안내</span>
						<div id="a">
                            <p>
                                <br>
                            </p>
							<p>서울 용산구 효창원로69길 8</p>
						</div> 
					</div>
			</div>
	  </div>	
</div>

</body>
</html>
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
    <script defer src="/resources/js/policy.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/normalRegi.css">
    <title>Title</title>
</head>

<div id="modal_regi" class="modal-overlay" style="position: relative; z-index: -5">
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



<form id="frm" method="post" action="/regi/addMember.do">
    <div class="wrapper" style="position: relative; z-index: -10">
        <div class="login">
            <h2>비트캠핑</h2>

            <div class="login_id">
                <h4>닉네임</h4>
                <input type="text" name="nickname" id="nickname" placeholder="2~10자의 한글, 영문, 숫자만 사용 가능합니다." maxlength="10" value="">
                <span class="error_next_box"></span>
            </div>
            <div class="login_id">
                <h4>이름</h4>
                <input type="text" name="username" id="name" placeholder="한글, 영문 사용 가능합니다.(특수기호, 공백 사용 불가)" maxlength="20" value="">
                <span class="error_next_box"></span>
            </div>
            <div class="login_id">
                <h4>이메일</h4>
                <input type="email" name="email" id="email" placeholder="@까지 정확하게 입력해주세요." maxlength="50" value="" >
                <span class="error_next_box">이메일 주소를 다시 확인해주세요.</span>
            </div>
            <div class="login_id">
                <h4>휴대전화</h4>
                <input type="text" id="mobile" class="int" maxlength="13" name="phone" placeholder="숫자만 입력해주세요." value="" >
                <span class="error_next_box"></span>
            </div>
            <div class="submit">
                <input type="button" name="btnJoin" value="회원가입">
            </div>
        </div>
    </div>
    <input type="hidden" name="sns_Type" value="${sns_type}">
    <input type="hidden" name="id" value="${info.id}">
</form>

<script type="text/javascript">
    $(document).ready(function () {
        const modal_regi = document.getElementById("modal_regi")

        regiModalOn();

    });

    function regiModalOn() {
        modal_regi.style.display = "flex"
        $('html, body').css({'overflow': 'hidden', 'height': '100%'}); // 모달팝업 중 html,body의 scroll을 hidden시킴
    }
    function regiIsModalOn() {
        return modal_regi.style.display === "flex"
    }

    function regiModalOff() {
        modal_regi.style.display = "none"
    }

/*    const btnModal = document.getElementById("btn-modal")
    btnModal.addEventListener("click", e => {
        regiModalOn();
    })

    const closeBtn = modal.querySelector(".close-area")
    closeBtn.addEventListener("click", e => {
        regiModalOff();
    })

    modal_regi.addEventListener("click", e => {
        const evTarget = e.target
        if(evTarget.classList.contains("modal-overlay")) {
            regiModalOff();
        }
    })

    window.addEventListener("keyup", e => {
        if(regiIsModalOn() && e.key === "Escape") {
            regiModalOff();
        }
    })*/

</script>
</body>
</html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style>
        .driver:before {
            display: block;
            position: absolute;
            top: 1px;
            left: 0;
            width: 1px;
            height: 10px;
            background: #FFFFFF;
        }

        .col-xs-6 col-sm-3 > span, .col-xs-6 col-sm-3 > i {
            margin-bottom: 3px;
            color: #FFFFFF;
        }

        .col-xs6 col-sm-3 {
            padding: 16px 0 25px;
            font-size: 11px;
            color: #111;
            max-width: 100%;
            line-height: 18px;
            margin: 0 auto 0 auto;
        }

        .info {
            color: #999999;
            font-size: 11px;
            padding: 16px 0 25px;
            max-width: 100%;
            line-height: 18px;
            margin: 0 auto 0 auto;
        }

        .col-xs-6 col-sm-3 .insurance .insurance_info {
            display: inline-block;
            margin-right: 16px;
            margin-bottom: 20px;
        }

        .escrow-icon-img {
            width: 24px;
            height: 24px;
            cursor: pointer;
            display: inline-block;
            vertical-align: top;
        }

        .footer_content{
          color: #999999;
          font-size: 13px;
          padding: 16px 0 25px;
          max-width: 100%;
          line-height: 18px;
          margin: 0 0 8px;
        }

        .footer_content a{
          color: #999999;
          font-size: 11px;
        }

        .footer_content p{
          margin : 0 0 8px;
        }

       /* .footer_facebook{
          color: #999999;
        }*/

        .row a{
          text-decoration: none;
        }

        .row a:hover {
          color : white;
        }



    </style>
</head>

<footer style="width: 100%">
    <div class="row" style="background: black; padding: 16px 0; margin-right: 0px; margin-left: 0px; border-bottom: solid 0.1rem #fff; ">
        <div class="col"></div>
        <div class="col">
          <span class="footer_content">
            <span><p> <a href="" style="color: white; font-size: 13px">위치안내</a></p></span>
              <c:if test="${empty login}">
                  <p><span style="color: white"><a onclick="modalOn()" style="color: white; font-size: 13px">로그인</a></span></p>
                  <p style="color: white"><a href="/regi/normal.do" style="color: white; font-size: 13px">회원가입</a></p>
              </c:if>
              <c:if test="${login.auth == 0}">
                  <p style="color: white"><a href="/account/main.do" style="color: white; font-size: 13px">마이페이지</a></p>
                  <p style="color: white"><a href="/login/logout.do" style="color: white; font-size: 13px">로그아웃</a></p>
              </c:if>
              <c:if test="${login.auth == 1}">
                  <p style="color: white"><a href="/admin/main.do" style="color: white; font-size: 13px">관리자페이지</a></p>
              </c:if>
          </span>
        </div>
        <div class="col">
          <span class="footer_content">
            <p><span style="color: white">고객센터</span></p>
            <p><a href="/cs/notice.do">공지사항</a></p>
            <p><a href="/agreement.do">이용약관</a></p>
            <p><a href="/personalInfo.do">개인정보취급방침</a></p>
            <p><a href="tel:010-3258-0508">광고 및 제휴문의</a></p>
          </span>
        </div>
        <div class="col">
          <span class="footer_content">
            <span style="color: white">ABOUT BITCAMPING</span><br>
            <p><a href="tel:010-3258-0508">비트캠핑 소개</a></p>
          </span>
        </div>
        <div class="col">
          <span class="footer_content">
            <span style="color: white">SOCIAL</span><br>
              <span class="footer_sns" style="cursor:pointer; font-size: 20px;" >
                  <span class="footer_facebook">
                <i class="fab fa-facebook fa-fw"></i>&nbsp;
                  </span>
                <i class="fab fa-twitter fa-fw"></i>&nbsp;
                <i class="fab fa-google-plus-g fa-fw"></i>
              </span>
          </span>
        </div>
        <div class="col"></div>
    </div>
    <div class="row" style="background: black; padding: 16px 0 25px; margin-right: 0px; margin-left: 0px">
        <div class="col-xs-6 col-sm-3"></div>
        <div class="col-xs-6 col-sm-3">
          <span class="info">
            <span>(주)비트캠핑</span>
            <span>대표 <i style="color: #999999">조민경</i> |</span>
            <span>개인정보보호책임자 <i style="color: #999999">엄영신</i></span><br>
            <span class="driver">서울 마포구 백범로 23 지하1층, 3층  </span>
            <br><span>통신판매업 신고번호 제2021-서울마포-00029 | </span>
            <span class="driver">사업자등록번호 220-88-90629 </span> <br>
            <span>고객센터 전화문의 <a href="tel:010-3258-0508" style="color: white"><i>080-022-0182</i></a></span>
            <br>
            <span class="driver">FAX <i>02-622-3214</i> |</span>
            <span class="driver">E-mail <a href="mailto:ddongjunn@gmail.com" style="color: white;"><i>service@bitcamping.co.kr</i></a></span>
          </span>
        </div>
        <!-- 필요한 뷰포트에만 clearfix 를 추가하세요 -->
        <div class="clearfix visible-xs-block"></div>

        <div class="col-xs-6 col-sm-3">
          <span class="info">
            <span class="insurance_info">
                안전거래를 위해 현금 등으로 결제 시 저희 쇼핑몰에서 가입한 <br>
                KG 이니시스의 구매안전 서비스 (채무지급보증)를 이용하실 수 있습니다.
            </span><br><br>
            <span style="white-space:nowrap;">
            <span class="insurance_info">
                온라인디지털콘텐츠사업발전법에 의한
                <a href="javascript:;" data-uk-modal="{target:'#privacy-personal'}" class="underline"
                   style="color: #FFFFFF; font-size: 11px">콘텐츠보호안내 자세히보기</a>
                &nbsp;&nbsp;&nbsp;
            </span>
            <span class="escrow-icon-img">
						<img src="//image.inicis.com/mkt/certmark/escrow/escrow_43x43_gray.png" border="0"
                             alt="클릭하시면 이니시스 결제시스템의 유효성을 확인하실 수 있습니다." style="max-width: 100%">
					</span>
            </span>
            </span>
        </div>
        <div class="col-xs-6 col-sm-3"></div>
    </div>
</footer>

</html>
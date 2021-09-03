<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>

	<!-- slick -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/jquery.slick/1.6.0/slick.css">
	<script type="text/javascript" src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery.slick/1.6.0/slick.min.js"></script>
	
	<!-- easy-pie-chart -->
	<script type="text/javascript" src="https://rendro.github.io/easy-pie-chart/javascripts/jquery.easy-pie-chart.js"></script>
</head>
<body>
<%--<div class="bgimage">
	<img src='/resources/images/main_background.jpg' />
</div>--%>
<!-- container start -->
<div id="container">
	<div class="search-area">
		<div class="img-area">
			<!-- <img src='/resources/images/camp-bg.png' /> -->
		</div>
		<%--<div class="search-container">
			<div class="title f_wcolor">지역별 캠핑장 검색</div>
			<div class="search-contents mt50">
				<input type="text" placeholder="지역을 입력하세요" class="shadow"/>
				<button class="search-btn shadow"></button>
			</div>
		</div>--%>


		<!-- campingtype data start -->
		<div class="campsitetype" style="">
			<div class="campsitetitle">전국 <span class="count" data-esing="swing">2647</span>개의
				<p class="mt10">캠핑장 데이터를 한 곳에!</p> </div>
			<div class="campsitechart">
				<div class="chart type1" data-percent="64">일반야영장 64%</div>
				<div class="chart type2" data-percent="35">자동차야영장 35%</div>
				<div class="chart type3" data-percent="12">카라반 12%</div>
				<div class="chart type4" data-percent="15">글램핑 15%</div>
			</div>
		</div>
		<!-- campingtype data end -->

	</div>

	<div class="row" style="width: 100%; height: 130px;">
		<div class=".col-xs12 .col-md-8" style="background-color: #1FB154 ; width: 70%; display: table-cell; vertical-align: middle">
			<div style="text-align: center; position: relative; top:40px;justify-content: center ">
				<div style="position: relative; top:-1px">
					<div style="font-size: 30px; font-weight: bold; color: white; padding-right: 15px; display: inline; position: relative; top: 6px">어디로 떠날까?</div>
					<div style="display: inline">
						<input class="search__input" type="text" placeholder="지역을 입력하세요">
					</div>
				</div>
			</div>
		</div>
		<div class=".col-xs6 .col-md-4" style="background-color:  #FFA600 ; width: 30%; display: table-cell; vertical-align: middle" >
			<div style="text-align: center; position: relative; top:18px ">
				<div style="margin-top: 3px"><span style="font-size: 15px; color: #FFFFFF">비트캠핑 고객센터</span></div>
				<div class="mt10"><span style="font-size: 30px; color: #FFFFFF; font-weight: bold">1577 . 8282</span></div>
				<div class="mt10"><span style="font-size: 15px; color: #FFFFFF">상담시간 : AM 9시 ~ PM 6시 까지</span></div>
			</div>
		</div>
	</div>

	<div class="contents-area mt150">
		<!-- recommend area start -->
		<div class="recommendslide">
			<div class="lefttitle">
				<span class="stroke-shadow-orange" style="font-family: 'TTTogether' !important;">추천</span>
				<span class="stroke-shadow-gray" style="font-family: 'TTTogether' !important;"> 캠핑장</span>
			</div>
			

			<div class="tarkikComandSlider">
				<c:forEach items = "${campinglist}" var = "camping">
					<article class="comandSlider__item">
						<header>
							<p class="comandSlider__item_name"><a href="/csite/campingdetail.do?contentid=${camping.contentid}">${camping.facltnm}</a></p>
							<p class="comandSlider__item_status">${camping.addr1}</p>
						</header>
						<a href="/csite/campingdetail.do?contentid=${camping.contentid}">
							<img class="comandSlider__item_photo" src="${camping.firstimageurl}" alt="캠핑장 이미지" />
						</a>
						<div class="comandSlider__item_contact"><span>유형</span>${camping.induty}</div>
						<div class="comandSlider__item_contact"><span>환경</span>${camping.lctcl}/${camping.facltdivnm}</div>
					</article>
				</c:forEach>
			</div>
		</div>
		<!-- recommend area end -->

		<div class="mt50" style="margin: 0 60px 50px 60px; height: 400px;">
			<div style="float: left; border-top: 1px solid #999999; border-bottom: 1px solid #999999; width: 20%; margin-right: 30px; position: relative; height: 100%;">
				<div class="" style="float: left; margin-right: 30px;">
					<div class="mt20">
						<div>
							<h2>추천장비</h2>
						</div>
						<div style="height: 200px">
							<p>test2</p>
							<div>
								test3
							</div>
						</div>
					</div>
				</div>
				<div style="position: absolute; bottom: 10px; right: 10px;"><p>더보기</p></div>
			</div>
			<div style="float: left; width: 75%; height: 100%;">
				<div class="item_box">
					<div id="tab" >
						<ul class="content_ul">
							<li><img src="/resources/images/testimg.jpg" width="400" height="80"></li>
							<li><img src="/resources/images/testimg.jpg" width="400" height="80"></li>
							<li><img src="/resources/images/testimg.jpg" width="400" height="80"></li>
							<li><img src="/resources/images/testimg.jpg" width="400" height="80"></li>
							<li><img src="/resources/images/testimg.jpg" width="400" height="80"></li>
							<li><img src="/resources/images/testimg.jpg" width="400" height="80"></li>
							<li><img src="/resources/images/testimg.jpg" width="400" height="80"></li>
							<li><img src="/resources/images/testimg.jpg" width="400" height="80"></li>
							<li><img src="/resources/images/testimg.jpg" width="400" height="80"></li>
							<li><img src="/resources/images/testimg.jpg" width="400" height="80"></li>
							<li><img src="/resources/images/testimg.jpg" width="400" height="80"></li>
							<li><img src="/resources/images/testimg.jpg" width="400" height="80"></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<!-- community recent start -->
		<div class="commuity-area mt50" style="clear: both;">
			<div class="lefttitle">
				<span class="stroke-shadow-gray" style="font-family: 'TTTogether' !important;">최신글</span>
			</div>
			<div class="community-container mt10">
				<div class="community-contents">
					<div class="sub-title" style="display: block; overflow:hidden;">
						<span class="fl">자유게시판</span>
						<span class="fr">
                           <a href="/community/free.do">+</a>
                        </span>
					</div>
					<div class="community-contents-list">
						<ul>
							<c:forEach var="list" items="${recentCommunity.free}">
								<li>
									- <a href="/community/dealDetail.do?community_seq=${list.community_seq }">
										${list.title}
								</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="community-contents">
					<div class="sub-title" style="display: block;overflow:hidden">
						<span class="fl">캠퍼모집</span>
						<span class="fr">
                           <a href="/community/find.do">+</a>
                        </span>
					</div>

					<div class="community-contents-list">
						<ul>
							<c:forEach var="list" items="${recentCommunity.find}">
								<li>
									- <a href="/community/dealDetail.do?community_seq=${list.community_seq }">
										${list.title}
								</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="community-contents">
					<div class="sub-title" style="display: block;overflow:hidden">
						<span class="fl">캠핑여행&후기</span>
						<span class="fr">
                           <a href="/community/review.do">+</a>
                        </span>
					</div>
					<div class="community-contents-list">
						<ul>
							<c:forEach var="list" items="${recentCommunity.review}">
								<li>
									- <a href="/community/dealDetail.do?community_seq=${list.community_seq }">
										${list.title}
								</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="community-contents">
					<div class="sub-title" style="display: block;overflow:hidden">
						<span class="fl">중고거래</span>
						<span class="fr">
                           <a href="/community/deal.do">+</a>
                        </span>
					</div>
					<div class="community-contents-list">
						<ul>
							<c:forEach var="list" items="${recentCommunity.deal}">
								<li>
									- <a href="/community/dealDetail.do?community_seq=${list.community_seq }">
										${list.title}
								</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- community recent end -->

	</div>
</div>
<!-- container end -->

<script type="text/javascript">

	$(document).ready(function(){
		$('.search-btn.shadow').click(function(){
			const searchWord = $(".shadow").val();
			location.href = "./csite/campinglist.do?searchWord=" + searchWord;
		});
		
		/* 캠핑장 유형 숫자 이펙트 */
		$(".count").each(function() {
		  $(this)
		    .prop("Counter", 0)
		    .animate(
		      {
		        Counter: $(this).text()
		      },
		      {
		        duration: 4000,
		        easing: $(this).data("esing"),
		        step: function(now) {
		          $(this).text(Math.ceil(now));
		        }
		      }
		    );
		});
		/* 캠핑장 유형 파이차트 */
		$(function() {
			$('.type1').easyPieChart({
				scaleColor: "rgba(255, 255, 255, 0)",
				lineWidth: 15,
				lineCap: 'butt',
				barColor: '#ff7761',
				trackColor:	"#ecf0f1",
				size: 200,
				animate: 1000
			});
			$('.type2').easyPieChart({
				scaleColor: "rgba(255, 255, 255, 0)",
				lineWidth: 15,
				lineCap: 'butt',
				barColor: '#fdc23e',
				trackColor:	"#ecf0f1",
				size: 200,
				animate: 1000
			});
			$('.type3').easyPieChart({
				scaleColor: "rgba(255, 255, 255, 0)",
				lineWidth: 15,
				lineCap: 'butt',
				barColor: '#f9a11b',
				trackColor:	"#ecf0f1",
				size: 200,
				animate: 1000
			});
			$('.type4').easyPieChart({
				scaleColor: "rgba(255, 255, 255, 0)",
				lineWidth: 15,
				lineCap: 'butt',
				barColor: '#274555',
				trackColor:	"#ecf0f1",
				size: 200,
				animate: 1000
			});
		});
	});

	/* recommend slider */
	$('.tarkikComandSlider').slick({
		slidesToShow: 4,
		slidesToScroll: 1,
		autoplay: true,
		autoplaySpeed: 5000,
		dots: true,
	});

</script>

</body>
</html>
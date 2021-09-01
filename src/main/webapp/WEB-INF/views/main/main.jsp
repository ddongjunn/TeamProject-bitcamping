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
<div class="bgimage">
	<img src='https://images.unsplash.com/photo-1592351763700-b9b35a6465ea?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80' />
</div>
<!-- container start -->
<div id="container">
	<div class="search-area">
		<div class="img-area">
			<!-- <img src='/resources/images/camp-bg.png' /> -->
		</div>
		<div class="search-container">
			<div class="title f_wcolor">지역별 캠핑장 검색</div>
			<div class="search-contents mt50">
				<input type="text" placeholder="지역을 입력하세요" class="shadow"/>
				<button class="search-btn shadow"></button>
			</div>
		</div>
		
	
		
	</div>
	<div class="contents-area mt50">
	
		<!-- recommend area start -->
		<div class="recommendslide">
			<div class="lefttitle">
				<span class="stroke-shadow-orange" style="font-family: 'TTTogether' !important;">추천</span>
				<span class="stroke-shadow-gray" style="font-family: 'TTTogether' !important;"> 캠핑장</span>
			</div>
			
			
		</div>
		<!-- recommend area end -->

		<!-- community recent start -->
		<div class="commuity-area mt30">
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
				barColor: '#87C4B7',
				trackColor:	"#ecf0f1",
				size: 200,
				animate: 1000
			});
			$('.type2').easyPieChart({
				scaleColor: "rgba(255, 255, 255, 0)",
				lineWidth: 15,
				lineCap: 'butt',
				barColor: '#E07260',
				trackColor:	"#ecf0f1",
				size: 200,
				animate: 1000
			});
			$('.type3').easyPieChart({
				scaleColor: "rgba(255, 255, 255, 0)",
				lineWidth: 15,
				lineCap: 'butt',
				barColor: '#FBC853',
				trackColor:	"#ecf0f1",
				size: 200,
				animate: 1000
			});
			$('.type4').easyPieChart({
				scaleColor: "rgba(255, 255, 255, 0)",
				lineWidth: 15,
				lineCap: 'butt',
				barColor: '#78E6D0',
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
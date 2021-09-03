<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 쓰기</title>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
</head>
<body>

<nav id="review" class="menu-nav">
	<ul>
		<li><a href="#">상품 선택</a></li>
		<li><a href="#content">상품 상세</a></li>
		<li><a href="#review" class="nav-selected">상품 리뷰</a></li>
		<li><a href="#qna">Q&A</a></li>
	</ul>
</nav>

<script type="text/x-handlebars-template" id="review-template">

	<div>
		<div id="review-box" class="review-area">
			<div class="review-count">리뷰 <span class="c_point">{{totalCount}}</span>개</div>
			
			{{#ifCond totalCount 0}}
				<div class="review-row">
					<div class="list-empty">작성된 리뷰가 없습니다</div>
				</div>

			{{else}}

				{{#each reviewList}}
					<div class="review-row">
						<div id="ratebox" class="review-rate">
							{{rating rate}}
						</div>
						<div id="reviewtitle" class="review-title" onclick="showHideReview({{review_Seq}})">
							{{title}}
						</div>
						<div class="review-info">
							<div class="inner-info">
								<i class="fas fa-user-circle fa-sm"></i> {{nickname}}<br>
								<i class="far fa-calendar-alt fa-sm"></i> {{dating wdate}}
							</div>
						</div>
					</div>
					<div id="reviewcontent{{review_Seq}}" class="review-content-box">
						<div class="review-content">
							{{content}}
						</div>
						<div class="review-image">
							{{imaging image}}
						</div>
					</div>
				{{/each}}

			{{/ifCond}}

		</div>

		<nav aria-label="Page navigation" class="pagination-nav">
			<ul class="pagination justify-content-center" id="pagination"></ul>
		</nav>
	</div>
</script>

<div id="review-content"></div>

<div id="pageMarkerSpace"></div>

<script type="text/javascript">

	$(document).ready(function () {
		var result;

		reviewAjax();

		//review list 뿌려주기
		function reviewAjax(pageNumber){

			if(pageNumber === undefined){
				pageNumber = 0;
			}

			$.ajax({
				url : '/rent/detail-review.do',
				type : 'post',
				dataType : 'json',
				data : {'product_Seq' : searchParam('product_Seq'), 'pageNumber' : pageNumber },
				success : function (data) {

					result = data;
					//핸들바 템플릿 가져오기
					let source = $("#review-template").html();

					//핸들바 템플릿 컴파일
					let template = Handlebars.compile(source);

					let html = template(result);

					//생성된 HTML을 DOM에 주입
					$('#review-content').html(html);

					let totalCount = data.totalCount;	// 서버로부터 총글의 수를 취득
					//alert(totalCount);

					let nowPage = data.nowPage;	// 서버로부터 현재 페이지를 취득
					//alert(nowPage);

					if(totalCount === 0){
						totalCount = 1;
					}

					let pageSize = 5;//페이지의 크기(1~10) [1] ~ [10]

					let totalPages = totalCount / pageSize;

					if(totalCount % pageSize > 0){
						totalPages++;
					}

					/*페이지 갱신 : 페이징을 갱신해 줘야 번호가 재설정된다.*/
					if($('#pagination').data("twbs-pagination")){
						$('#pagination').twbsPagination('destroy');
					}

					$("#pagination").twbsPagination({
						startPage : nowPage,
						totalPages : totalPages, //전체 페이지
						visiblePages: 10, //최대로 보여줄 페이지
						first: '<span sria-hidden="true">«</span>',
						prev: "이전",
						next: "다음",
						last: '<span sria-hidden="true">»</span>',
						initiateStartPageClick:false,
						onPageClick: function(event,page){
							reviewAjax(page - 1);
						}
					});

				},
				error : function () {

				}
			})
		}

		Handlebars.registerHelper('rating', function (rate) {
			let stars = "<i class='fas fa-star'></i>".repeat(rate) + "<i class='far fa-star'></i>".repeat(5-rate);
			return new Handlebars.SafeString(stars);
		});

		Handlebars.registerHelper('dating', function (wdate) {
			return wdate.substr(0,10);
		});

/* 		Handlebars.registerHelper('imaging', function (image) {
			return wdate.substr(0,10);
		}); */

		Handlebars.registerHelper('imaging', function (image) {
			if(image != null) {
				var result = '<img src = "/resources/upload/' + image + '" alt = "상품평 이미지" height = "250px">';
				return new Handlebars.SafeString(result)
			}
			return;
		});
		
		Handlebars.registerHelper('ifCond', function(v1, v2, options) {
			  if(v1 === v2) {
			    return options.fn(this);
			  }
			  return options.inverse(this);
		});

	});


	function showHideReview(seq){

		if($("#reviewcontent"+seq).css("display") == "none"){
			$("#reviewcontent"+seq).show();
		}else{
			$("#reviewcontent"+seq).hide();
		}
	}

	function searchParam(key) {
		return new URLSearchParams(location.search).get(key);
	}

</script>

</body>
</html>
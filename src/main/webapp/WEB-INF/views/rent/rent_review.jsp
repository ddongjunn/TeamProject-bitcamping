<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>리뷰 쓰기</title>

	<style type="text/css">

		.reviewtitle:hover {
			text-decoration: underline;
		}

	</style>

</head>
<body>

<nav id="review">
	<ul>
		<li><a href="#">상품 선택</a></li>
		<li><a href="#content">상품 상세</a></li>
		<li><a href="#review">상품 리뷰</a></li>
		<li><a href="#qna">Q&A</a></li>
	</ul>
</nav>

<script type="text/x-handlebars-template" id="review-template">

	<div>
		<div id="reviewbox" style="height: auto; margin: auto; width: 80%; padding: 20px; background-color: tomato;">
			<span>리뷰{{totalCount}}개</span>
			{{#each reviewList}}
			<div class="reviewrow" style="display: flex; background-color: #F7BBBB; ">
				<div id="ratebox" class="rate" style="flex: 1 1 15%; padding: 10px; ">
					{{rating rate}}
				</div>
				<div id="reviewtitle" onclick="showHideReview({{review_Seq}})" class="reviewtitle" style="flex: 1 1 65%; overflow: hidden; padding: 10px;" >
					{{title}}
				</div>
				<div class="info" style="flex: 1 1 25%; padding: 10px;" >
					<span>작성자 : {{nickname}}</span><br>
					<span>작성일 : {{dating wdate}}
				</div>
			</div>
			<hr>
			<div id="reviewcontent{{review_Seq}}" class="reviewcontent" style="height: auto; padding: 10px; display: none;" >
				<div style="background-color: #CDE8FD;">
					<div>
						{{content}}
					</div>
					<div id="">
						{{imaging image}}
					</div>
				</div>
				<hr>
			</div>
			{{/each}}
			<!--  <div style = "display : inline-block"> -->
		</div>
		<nav aria-label="Page navigation">
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
			return "⭐".repeat(rate);
		});

		Handlebars.registerHelper('dating', function (wdate) {
			return wdate.substr(0,10);
		});

		Handlebars.registerHelper('imaging', function (image) {
			return wdate.substr(0,10);
		});

		Handlebars.registerHelper('imaging', function (image) {
			if(image != null) {
				var result = '<img src = "/resources/upload/' + image + '" alt = "상품평 이미지" height = "250px">';
				return new Handlebars.SafeString(result)
			}
			return;
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
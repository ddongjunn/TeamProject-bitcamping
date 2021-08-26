<%@page import="com.camping.bit.dto.CampingImageDto"%>
<%@page import="java.util.List"%>
<%@page import="com.camping.bit.dto.CampingListDto"%>
<%@page import="com.camping.bit.dto.CampingDetailDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- bootstrap 추가 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- bxslider -->
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
<link href="/resources/css/campingsite/campingdetail.css" rel="stylesheet" type = "text/css">
</head>
<body>

<%
CampingDetailDto campingdetail = (CampingDetailDto)request.getAttribute("campingdetail");
CampingListDto campinglist = (CampingListDto)request.getAttribute("campinglistfordetail");
@SuppressWarnings("unchecked")
List<CampingImageDto> campingimage = (List<CampingImageDto>)request.getAttribute("campingimage");
String campingintro = (String)request.getAttribute("campingintro");
%>


<div id ="section">
	<span><button type = "button" id = "introBtn" class="btn btn-outline-success">캠핑장 소개</button></span>
	<span><button type = "button" id = "mapBtn" class="btn btn-outline-success">오시는 길</button></span>
	<span><button type = "button" id = "reviewBtn" class="btn btn-outline-success">캠핑장 후기</button></span>
</div>

	<div id = "contents">
		<div id = "intro" class = "layout">
			<ul class = "layout_5">
				<li class = "intro">
					<c:choose>
					<c:when test = "${campingintro=='none'}">
						캠핑장 소개글을 꼼꼼하게 준비하고 있습니다!
					</c:when>
					<c:otherwise>
						<%=campingintro%>
					</c:otherwise>
				</c:choose>
			</li>			 
		</ul>
	</div>
	
	<br>
	
	<div id = "sbrscl">
		주요 시설 : <%=campinglist.getSbrscl() %>
	</div>
	
	<br>
	
	<div id = "mainFacility">
		<c:set value="<%=campingdetail.getGnrlsiteco() %>" var="gnrl" />
		<c:set value="<%=campingdetail.getAutositeco() %>" var="auto" />
		<c:set value="<%=campingdetail.getGlampsiteco() %>" var="glamp" />
		<c:set value="<%=campingdetail.getCaravsiteco() %>" var="carav" />
		<c:set value="<%=campingdetail.getIndvdlcaravsiteco() %>" var="indiv"/>
		
				<c:if test ="${gnrl!=0}">
					<div>일반야영장 : ${gnrl}</div>
				</c:if>
				<c:if test="${auto!=0}">
					<div>자동차야영장사이트 : ${auto}</div>
				</c:if>
				<c:if test="${glamp!=0}">
					<div>글램핑시설 : ${glamp}</div>
				</c:if>
				<c:if test="${carav!=0}">
					<div>카라반 : ${carav}</div>
				</c:if>
				<c:if test="${indiv!=0}">
					<div>개인카라반 : ${indiv}</div>
				</c:if>
	
		<c:set value="<%=campinglist.getSitebottomcl1() %>" var="bottom1" />
		<c:set value="<%=campinglist.getSitebottomcl2() %>" var="bottom2" />
		<c:set value="<%=campinglist.getSitebottomcl3() %>" var="bottom3" />
		<c:set value="<%=campinglist.getSitebottomcl4() %>" var="bottom4" />
		<c:set value="<%=campinglist.getSitebottomcl5() %>" var="bottom5" />
		
		<c:set value = "0" var = "sum"/>
		(총 <c:out value = "${sum + bottom1  + bottom2 + bottom3 + bottom4 + bottom5 }"/>면)
	</div>
	
	<div id = "siteBottom">
		바닥 형태 :
				<c:if test="${bottom1!=0}">
					<div>잔디 : ${bottom1}면</div>
				</c:if>
				<c:if test="${bottom2!=0}">
					<div>파쇄석 : ${bottom2}면</div>
				</c:if>
				<c:if test="${bottom3!=0}">
					<div>자갈 : ${bottom3}면</div>
				</c:if>
				<c:if test="${bottom4!=0}">
					<div>맨흙 : ${bottom4}면</div>
				</c:if>
				<c:if test="${bottom5!=0}">
					<div>툴팁 : ${bottom5}면</div>
				</c:if>
	</div>
	
	<div id = "siteSize">
		<c:set value="<%=campingdetail.getSitemg1width() %>" var="width1" />
		<c:set value="<%=campingdetail.getSitemg1vrticl()%>" var="vertical1" />
		<c:set value="<%=campingdetail.getSitemg1co()%>" var="count1" />
		<c:set value="<%=campingdetail.getSitemg2width()%>" var="width2" />
		<c:set value="<%=campingdetail.getSitemg2vrticl()%>" var="vertical2" />
		<c:set value="<%=campingdetail.getSitemg2co()%>" var="count2" />
		사이즈 크기 
		<c:if test="${width1 !=0}">
		${width1}
		</c:if>
		*
		<c:if test="${vertical1 !=0}">
		${vertical1}
		</c:if>
		<c:if test="${count1 !=0}">
		${count1}개 //
		</c:if>
		<c:if test="${width2 !=0}">
		${width2}
		</c:if>
		*
		<c:if test="${vertical2 !=0}">
		${vertical2}
		</c:if>
		<c:if test="${count2 !=0}">
		${count2}개
		</c:if>
		<div>사이트 간격 : <%=campingdetail.getSitedstnc() %>M</div>
	</div>
	
	<div id = "equip">
	<c:set value="<%=campinglist.getEqpmnlendcl()%>" var="equip" />
	<c:if test="${equip !='none' }">
		대여 가능한 장비 : ${equip}
	</c:if>
	</div>
	
	<div id = "trler">
		<c:set value="<%=campingdetail.getTrleracmpnyat()%>" var="trler" />
	<c:choose>
		<c:when test="${trler == 'Y' }">
		개인 트레일러 동반 가능
		</c:when>
		<c:otherwise>
		개인 트레일러 동반 불가
		</c:otherwise>
	</c:choose>
	</div>
	
	<div id = "program">
		<c:set value="<%=campingdetail.getExprnprogrm()%>" var="program" />
		<c:choose>
		<c:when test="${program != 'none' }">
		진행 프로그램 : ${program}
		</c:when>
		<c:otherwise>
		프로그램 진행 불가
		</c:otherwise>
	</c:choose>
	</div>
	<div id = "animal">
		<c:set value="<%=campinglist.getAnimalcmgcl()%>" var="animal" />
		<c:choose>
		<c:when test="${animal == '가능' }">
			반려동물 동반 캠핑 가능
		</c:when>
		<c:when test="${animal == '가능(소형견)' }">
			반려동물 동반 캠핑 가능(소형견 기준)
		</c:when>
		<c:otherwise>
			반려동물 동반 캠핑 불가
		</c:otherwise>
		</c:choose>
	</div>
</div> <!-- contents div 끝나는 곳  -->
 
<div id="map"></div>

<div id = "photos" class = "photos">
	<table>
	<tr>
		<c:forEach items = "${campingimage}" var = "campingimage" varStatus = "i" end = "14">
			<c:if test="${i.index%5==0}">
				</tr><tr>
			</c:if>
		    <td><img src = "${campingimage.imageurl}" onerror="this.src='<%=request.getContextPath()%>/resources/images/campingsite/csite_alt_image.png'" onClick="window.open(this.src)" width = "200" height = "200"></td>
		</c:forEach>
	</tr>
	</table>

 	<ul class = "bxslider">
		<c:forEach items = "${campingimage}" var = "campingimage" varStatus = "i" end = "14">
 			<li><img src = "${campingimage.imageurl}"></li>
 		</c:forEach>
 	</ul>
  </div>






<div id = "review">
<!-- 캠핑장 검색창 -->
<div id = "select_sorting">
	<select class = "sorting_select" id = "sorting" title = "정렬">
		<option value = "image" selected = "selected">--정렬--</option>
		<option value = "create">최신등록순</option>
		<option value = "read">조회순</option>
		<option value = "like">추천순</option>
	</select>
</div>
<span><button type = "button" class="btn btn-outline-success" onclick = "location.href ='campingwritereview.do?contentid=' + <%=campinglist.getContentid()%>">리뷰 작성하기</button></span>

<table class="table table-hover">
    <thead>
        <tr>
            <td>글번호</td>
            <td>제목</td>
            <td>작성자</td>
            <td>조회수</td>
            <td>작성일</td>
        </tr>
    </thead>
    <tbody id="reviewlisting">
    <!-- ajax로 불러와서 뿌려주는 공간 -->
    </tbody>	
</table>
<!-- <button id = "addBtn" class="btn btn-outline-success" onClick = "moreList()">더 많은 리뷰 보기(more)</button>
 -->
<div class="container" style = "width : 100%; text-align : center">
    <div style = "display : inline-block">
	    <nav aria-label="Page navigation">
	        <ul class="pagination" id="pagination"></ul>
	    </nav>
    </div>
</div>

<div id = "searchBox">
<table>
	<tr>
		<td>
			<select id = "choice" name = "choice">
				<option value = "" selected = "selected">--선택--</option>
				<option value = "title">제목</option>
				<option value = "content">내용</option>
				<option value = "writer">작성자</option>
			</select>
		</td>
		<td>
			<i class="fas fa-search"></i>
			<input type = "text" id = "search" name = "searchWord" placeholder = "검색어를 입력해주세요" onkeypress="if( event.keyCode == 13 ){searchData();}"/>	   	
		</td>
		<td>
			<span class = "button blue">
<!-- 				<button type = "button" id = "searchBtn" class="btn btn-outline-success">검색</button> -->	
			 <a href = "javascript:campingsearchlist(this)"><img src ="<%=request.getContextPath()%>/resources/images/campingsite/searchicon.PNG" width = "50"></a>
			</span>
		</td>
	</tr>
</table>

</div>
</div>

 <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=105020d5be336948ef903114d3711ff8"></script>
	<script>	    
	    var mapContainer = document.getElementById('map'), // 지도의 중심좌표
	    mapOption = { 
	        center: new kakao.maps.LatLng(<%=campingdetail.getMapy()%>, <%=campingdetail.getMapx()%>), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    }; 
	    
	    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	    
	 // 지도에 마커를 표시합니다 
	    var marker = new kakao.maps.Marker({
	        map: map, 
	        position: new kakao.maps.LatLng(<%=campingdetail.getMapy()%>, <%=campingdetail.getMapx()%>)
	    });
	    
	    var content = '<div class="wrap">' + 
        '    <div class="info">' + 
        '        <div class="title">' + 
        '            <%=campinglist.getFacltnm()%>' + 
        '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
        '        </div>' + 
        '        <div class="body">' + 
        '            <div class="img">' +
        '                <img src = "<%=campinglist.getFirstimageurl() %>" onerror="this.src="<%=request.getContextPath()%>/resources/image/csite_alt_image.png">' +
        '           </div>' + 
        '            <div class="desc">' + 
        '                <div class="address"><%=campinglist.getAddr1().substring(0,15)+"..."%></div>' + 
        '                <div class="jibun ellipsis"><%=campinglist.getTel()%></div>' + 
        '                <div><a href="<%=campinglist.getHomepage() %>" target="_blank" class="link">홈페이지</a></div>' + 
        '            </div>' + 
        '        </div>' + 
        '    </div>' +    
        '</div>';
        
     // 마커 위에 커스텀오버레이를 표시합니다
     // 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
     var overlay = new kakao.maps.CustomOverlay({
         content: content,
         map: map,
         position: marker.getPosition()       
     });

     // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
     kakao.maps.event.addListener(marker, 'click', function() {
         overlay.setMap(map);
     });

     // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
     function closeOverlay() {
         overlay.setMap(null);     
     }
	</script> 

<script type="text/javascript">
$(document).ready(function(){
	
	$('.bxslider').bxSlider();
	$('select').niceSelect();

	
	$('#map').hide();
	$('#review').hide();
	$('#searchBox').hide();
	 $("#sorting").change(function(){ 
			$("#sortingval").val($("#sorting option:selected").val());
		});
	 
$("#introBtn").click(function(){
	 $('#map').hide();
	 $('#intro').show();
	 $('#photos').show();
	 $('#contents').show();
	 $('#review').hide();
	 $('#searchBox').hide();
	 
}); //introBtn 끝나는 곳
	    
$("#mapBtn").click(function(){
	  $('#intro').hide();
	  $('#photos').hide();
	  $('#map').show(); 
	  $('#review').hide();
	  $('#searchBox').hide();
	  $('#contents').hide();
}); //mapBtn 끝나는 곳

  $("#reviewBtn").click(function campingbbslist(){
	 $('#intro').hide();
	 $('#photos').hide();
	 $('#map').hide();
	 $('#contents').hide();
	 $('#review').show();
	 $('.container').show();
	 const contentid = new URLSearchParams(location.search).get('contentid');
	 console.log('content id', contentid)
			$.ajax({
				url : '/csite/campingreview.do',
				type : 'get',
				dataType : 'text',
				data : {'contentid':contentid},
				success : function(response){
					//console.log(response);
					//alert("success");
					$("#reviewlisting").html("");

					const parsedResponse = JSON.parse(response);
	
					if(response == '[]'){
						let str = "<tr>"
					    +"<td colspan='5' class='nodata'>아직 등록된 후기가 없습니다. 첫번째 리뷰어가 되어보세요!</td>"
					    +"</tr>"
					    $("#reviewlisting").append(str);
					}
					parsedResponse.forEach( (item, idx) => {
						let str = "<tr>"
							+ "<td>" + (idx + 1) + "</td>"
							+ "<td><a href='campingdetailreview.do?review_seq=" + item.review_seq + "&contentid=" + item.contentid +"'>" + item.title + "</a></td>"	
							+ "<td>" + item.user_id + "</td>"
							+ "<td>" + item.readcount + "</td>"
							+"<td>" + item.wdate + "</td>"
							+ "</tr>";
						$("#reviewlisting").append(str);
						$("#searchBox").show();
					});
				}, 
				error:function(request,status,error){
				    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});//ajax reviewBtn 끝나는 곳
	});//reviewBtn function 끝나는 곳
	
		
	 $("#searchBtn").click(function campingsearchlist(){
		 $('#intro').hide();
		 $('#photos').hide();
		 $('#map').hide();
		 $('#contents').hide();
		 $('#review').show();	
		 const contentid = new URLSearchParams(location.search).get('contentid');
		 var paramData = {"choice" : $("#choice").val(), "search" : $("#search").val(), "contentid" : contentid};
	
				$.ajax({
					url : '/csite/campingSearchReview.do',
					type : 'get',
					dataType : 'text',
					data : paramData,
					success : function(response){
						console.log("페이지 눌렀을 때", response);
						$("#reviewlisting").html("");
						const parsedResponse = JSON.parse(response);
		
						if(response == '[]'){
							let str = "<tr>"
						    +"<td colspan='5' class='nodata'>검색 조건을 충족하는 결과가 없어요</td>"
						    +"</tr>"
						    $("#reviewlisting").append(str);
						}
						parsedResponse.forEach( (item, idx) => {
							let str = "<tr>"
								+ "<td>" + (idx + 1) + "</td>"
								+ "<td><a href='campingdetailreview.do?review_seq=" + item.review_seq + "&contentid=" + item.contentid +"'>" + item.title + "</a></td>"	
								+ "<td>" + item.user_id + "</td>"
								+ "<td>" + item.readcount + "</td>"
								+ "<td>" + item.wdate + "</td>"
								+ "</tr>";
							$("#reviewlisting").append(str);
							$("#searchBox").show();
						});
					}, 
					error:function(request,status,error){
					    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				}); //ajax searchBtn 끝나는 곳
		});//searchBtn function 끝나는 곳
		
		 $("#sorting").change(function campingsorting(){
			 $('#intro').hide();
			 $('#photos').hide();
			 $('#map').hide();
			 $('#contents').hide();
			 $('#review').show();	
		
			 $("#sorting").val($("#sorting option:selected").val());
			 const contentid = new URLSearchParams(location.search).get('contentid');
			 var paramData = {"reviewsorting" : $("#sorting").val(), "contentid" : contentid, "choice" : $("#choice").val(), "search" : $("#search").val()};
		
					$.ajax({
						url : '/csite/campingSearchReview.do',
						type : 'get',
						dataType : 'text',
						data : paramData,
						success : function(response){
							console.log(response);
							$("#reviewlisting").html("");
							const parsedResponse = JSON.parse(response);
			
							if(response == '[]'){
								let str = "<tr>"
							    +"<td colspan='5' class='nodata'>검색 조건을 충족하는 결과가 없어요</td>"
							    +"</tr>"
							    $("#reviewlisting").append(str);
							}
							parsedResponse.forEach( (item, idx) => {
								let str = "<tr>"
									+ "<td>" + (idx + 1) + "</td>"
									+ "<td><a href='campingdetailreview.do?review_seq=" + item.review_seq + "&contentid=" + item.contentid +"'>" + item.title + "</a></td>"	
									+ "<td>" + item.user_id + "</td>"
									+ "<td>" + item.readcount + "</td>"
									+"<td>" + item.wdate + "</td>"
									+ "</tr>";
								$("#reviewlisting").append(str);
								$("#searchBox").show();
							});
						}, 
						error:function(request,status,error){
						    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
					}); //ajax searchBtn 끝나는 곳
			});//searchBtn function 끝나는 곳
			
		let totalCount = ${ReviewPage};	// 서버로부터 총글의 수를 취득
		//alert(totalCount);
		let nowPage = ${pageNumber};	// 서버로부터 현재 페이지를 취득
		//alert(nowPage);

		let pageSize = 10;//페이지의 크기(1~10) [1] ~ [10]

		let _totalPages = totalCount / pageSize;

		if(totalCount % pageSize > 0){
			_totalPages++;
		}
		 if($('#pagination').data("twbs-pagination")){
			  $('#pagination').twbsPagination('destroy');}// 페이지 갱신 : 페이징을 갱신해 줘야 번호가 재설정된다.

			 $("#pagination").twbsPagination({ 
				startPage : nowPage,
				totalPages : (_totalPages==0)?1:_totalPages, //전체 페이지
				visiblePages: 10, //최대로 보여줄 페이지
				first: '<span sria-hidden="true">«</span>',
				prev: "이전",
				next: "다음",
				last: '<span sria-hidden="true">»</span>',
				initiateStartPageClick:false,
				onPageClick: function(event,page){
					pagemove(page);
				}
			}); //페이지네이션 끝 
}); //document.ready 끝나는 곳


/*
function moreList(){
	var startNum = $("#reviewlisting tr").length; //tr 몇개 들어있나 구하기(제목, 작성자 줄은 빼기 위해서 1 뺌)
	var addListHtml = "";
	console.log("startNum", startNum); //현재 화면에 보이는 글 수 만큼 콘솔에 찍히는지 확인하기
	var paramData = {"startNum" : startNum}
	$.ajax({
		url : '/csite/campingMoreList.do',
		type : 'get',
		dataType : 'json',
		data : paramData,
		success : function(response){
			
			if(response.length>0){
				var addListHtml = "";
				for(var i = 0; i<response.length;i++){
					var idx = Number(StartNum)+Number(i)+1;
					addListHtml+="<tr>";
					addListHtml+="<td>" + idx + "</td>";
					addListHtml+="<td>" + response[i].title + "</td>";
					addListHtml+="<td>" + response[i].user_id + "</td>";
					addListHtml+="<td>" + response[i].readcount + "</td>";
					addListHtml+="</tr>";
				}
				$("#reviewlisting").append(addListHtml);
			}else if(response.length<5){
					$("#addBtn").remove(); // 더보기로 불러온 글이 5개가 넘지 않으면 더보기 안 나오게 하기
				}
			},//success 끝나는 곳
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}//error 끝나는 곳
	}); //moreList ajax 끝나는 곳
} //moreContent 끝나는 곳
*/

function pagemove(page){ //누르는 순간 페이지네이션에 지금 page 숫자를 알려준다
	 const pageNumber = page-1;
	 console.log(pageNumber);
	 //alert(pageNumber);
	 const contentid = new URLSearchParams(location.search).get('contentid');
	 var paramData = {"reviewsorting" : $("#sorting").val(), "contentid" : contentid, "choice" : $("#choice").val(), "search" : $("#search").val(), "pageNumber" : pageNumber};
	 console.log(paramData);
		$.ajax({
			url : '/csite/campingSearchReview.do',
			type : 'POST',
			dataType : 'text',
			//contextType : "text",
			data : paramData,
			success : function(response){
				//alert(JSON.stringify(response));
				console.log(response);
				$("#reviewlisting").html("");
				const parsedResponse = JSON.parse(response);

				if(response == '[]'){
					let str = "<tr>"
				    +"<td colspan='5' class='nodata'>검색 조건을 충족하는 결과가 없어요</td>"
				    +"</tr>"
				    $("#reviewlisting").append(str);
				}
				parsedResponse.forEach( (item, idx) => {
					let str = "<tr>"
						+ "<td>" + (idx + 1) + "</td>"
						+ "<td><a href='campingdetailreview.do?review_seq=" + item.review_seq + "&contentid=" + item.contentid +"'>" + item.title + "</a></td>"	
						+ "<td>" + item.user_id + "</td>"
						+ "<td>" + item.readcount + "</td>"
						+ "<td>" + item.wdate + "</td>"
						+ "</tr>";
					$("#reviewlisting").append(str);
					$("#searchBox").show();
					});
				},//success 끝나는 곳
			error:function(request,status,error){
			    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}//error 끝나는 곳
		}); //pagemove ajax 끝나는 곳
} //pagemove function 끝나는 곳


function campingsearchlist(){
	 $('#intro').hide();
	 $('#photos').hide();
	 $('#map').hide();
	 $('#contents').hide();
	 $('#review').show();	
	 const contentid = new URLSearchParams(location.search).get('contentid');
	 var paramData = {"choice" : $("#choice").val(), "search" : $("#search").val(), "contentid" : contentid};

			$.ajax({
				url : '/csite/campingSearchReview.do',
				type : 'get',
				dataType : 'text',
				data : paramData,
				success : function(response){
					console.log("페이지 눌렀을 때", response);
					$("#reviewlisting").html("");
					const parsedResponse = JSON.parse(response);
	
					if(response == '[]'){
						let str = "<tr>"
					    +"<td colspan='5' class='nodata'>검색 조건을 충족하는 결과가 없어요</td>"
					    +"</tr>"
					    $("#reviewlisting").append(str);
					}
					parsedResponse.forEach( (item, idx) => {
						let str = "<tr>"
							+ "<td>" + (idx + 1) + "</td>"
							+ "<td><a href='campingdetailreview.do?review_seq=" + item.review_seq + "&contentid=" + item.contentid +"'>" + item.title + "</a></td>"	
							+ "<td>" + item.user_id + "</td>"
							+ "<td>" + item.readcount + "</td>"
							+ "<td>" + item.wdate + "</td>"
							+ "</tr>";
						$("#reviewlisting").append(str);
						$("#searchBox").show();
					});
				}, 
				error:function(request,status,error){
				    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			}); //ajax searchBtn 끝나는 곳
	};//searchBtn function 끝나는 곳

</script>
</body>
</html>
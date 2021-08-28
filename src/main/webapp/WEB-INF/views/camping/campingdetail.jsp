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
<style>
    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
    .desc .address {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
</style> 
</head>
<body>

<!-- 사용 xx -->
<%
CampingDetailDto campingdetail = (CampingDetailDto)request.getAttribute("campingdetail");
CampingListDto campinglist = (CampingListDto)request.getAttribute("campinglistfordetail");
@SuppressWarnings("unchecked")
List<CampingImageDto> campingimage = (List<CampingImageDto>)request.getAttribute("campingimage");
String campingintro = (String)request.getAttribute("campingintro");
%>
<!-- <a href = "campinglist.do">목록으로 돌아가기</a> -->
<div class = "camping_list">
	<ul>
		<li style = "list-style : none;">
			<div class = "image" style = "float : left ; margin-right : 10px" >
				<img src = "<%=campinglist.getFirstimageurl() %>" onerror="this.src='<%=request.getContextPath()%>/resources/images/campingsite/csite_alt_image.png'" width = "400" height = "400">
			</div>
			<div class = "camping_information" style = "float : left">
				<div class = "camping_site name">
					<h2 class = "camping_site_name">	
							<%=campinglist.getFacltnm()%>
						<span class = "readcount" style = "font-size : 15px">조회수 : <%=campinglist.getReadcount()%></span>
						<span class = "readcount" style = "font-size : 15px">추천수 : <%=campinglist.getLikecount()%></span>
					</h2>
				</div>
				<hr>
				<h5> 주소  : <%=campinglist.getAddr1() %></h5>	
				<h5> 전화번호 : <%=campinglist.getTel() %></h5>
				<h5> 캠핑장 환경 : <%=campinglist.getLctcl() %>/<%=campinglist.getFacltdivnm() %></h5>	
				<h5> 캠핑장 유형 : <%=campinglist.getInduty() %></h5>
				<h5> 운영기간 : <%=campingdetail.getOperpdcl() %></h5>
				<h5> 운영일 : <%=campingdetail.getOperdecl() %></h5>
				
				<c:url value="<%=campinglist.getHomepage() %>" var="url" />
				<c:url value="<%=campingdetail.getResveurl() %>" var="url1" />
					<c:choose>
					  	<c:when test="${url eq 'none'}">
					       	홈페이지 준비중 / 
					    </c:when>
					    <c:otherwise>
					        <button type = button onclick = "location.href ='${url}'">홈페이지</button>
					    </c:otherwise>
					</c:choose>
					<c:choose>
					  	<c:when test="${url1 eq 'none'}">
					        전화예약
					    </c:when>
					    <c:otherwise>
					        <button type = button onclick = "location.href ='${url1}'">예약하기</button>
					    </c:otherwise>
					</c:choose>
				<h5> 시설 : <%=campinglist.getSbrscl() %></h5>
			</div>
			<div style="clear:both"></div>
		</li>
	</ul>
</div>
<div id ="section">
		<h2 class="skip">캠핑장 디테일 화면 분할</h2>
			<div class="layout">
				<span><button type = "button" id = "introBtn">캠핑장 소개</button></span>
				<span><button type = "button" id = "mapBtn">오시는 길</button></span>
				<span><button type = "button" id = "reviewBtn">캠핑장 후기</button></span>
			
		</div>
	</div>


<div id = "contents">
	<div id = "intro" class = "layout">
		<ul class = "layout_5">
			<li class = "intro">
				<a href = "campingdetail.do?contentid=<%=campinglist.getContentid()%>">캠핑장 소개</a>
				<br>
				<%=campingintro%>			 
		</ul>
	</div>
	<br>
	<div id = "sbrscl">
		주요 시설 : <%=campinglist.getSbrscl() %>
	</div>
	<div id = "mainFacility">
		<c:set value="<%=campingdetail.getGnrlsiteco() %>" var="gnrl" />
		<c:set value="<%=campingdetail.getAutositeco() %>" var="auto" />
		<c:set value="<%=campingdetail.getGlampsiteco() %>" var="glamp" />
		<c:set value="<%=campingdetail.getCaravsiteco() %>" var="carav" />
		<c:set value="<%=campingdetail.getIndvdlcaravsiteco() %>" var="indiv"/>
		
				<c:if test ="${gnrl!=0}">
					<h4>일반야영장 : ${gnrl}</h4>
				</c:if>
				<c:if test="${auto!=0}">
					<h4>자동차야영장사이트 : ${auto}</h4>
				</c:if>
				<c:if test="${glamp!=0}">
					<h4>글램핑시설 : ${glamp}</h4>
				</c:if>
				<c:if test="${carav!=0}">
					<h4>카라반 : ${carav}</h4>
				</c:if>
				<c:if test="${indiv!=0}">
					<h4>개인카라반 : ${indiv}</h4>
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
					<h4>잔디 : ${bottom1}면</h4>
				</c:if>
				<c:if test="${bottom2!=0}">
					<h4>파쇄석 : ${bottom2}면</h4>
				</c:if>
				<c:if test="${bottom3!=0}">
					<h4>자갈 : ${bottom3}면</h4>
				</c:if>
				<c:if test="${bottom4!=0}">
					<h4>맨흙 : ${bottom4}면</h4>
				</c:if>
				<c:if test="${bottom5!=0}">
					<h4>툴팁 : ${bottom5}면</h4>
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
		
		<h4>사이트 간격 : <%=campingdetail.getSitedstnc() %>M</h4>
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
<div id="map" style="width:500px;height:400px;"></div> 

<div id = "photos" class = "photos">
	<table>
	<tr>
		<c:forEach items = "${campingimage}" var = "campingimage" varStatus = "i" end = "14">
			<c:if test="${i.index%5==0}">
				</tr><tr>
			</c:if>
		    <td><img src = "${campingimage.imageurl}" onerror="this.src='<%=request.getContextPath()%>/resources/images/csite_alt_image.png'" width = "200" height = "200"></td>
		</c:forEach>
	</tr>
	</table>
</div>
<div id = "review">
<button type = "button" onclick = "location.href ='campingwritereview.do?contentid=' + <%=campinglist.getContentid()%>">리뷰 작성하기</button>
<table border=1>
    <thead>
        <tr>
            <td>글번호</td>
            <td>제목</td>
            <td>작성자</td>
            <td>조회수</td>
        </tr>
    </thead>
    <tbody id="reviewlisting">
    
    </tbody>	
</table>
<div id = "searchBox">
<table style = "margin-left : auto; margin-right : auto; margin-top : 3px; margin-bottom : 3px">
	<tr>
		<td style = "padding-left:5px">
			<select id = "choice" name = "choice">
				<option value = "" selected = "selected">--선택--</option>
				<option value = "title">제목</option>
				<option value = "content">내용</option>
				<option value = "writer">작성자</option>
			</select>
		</td>
		<td style = "padding-left:5px">
			<input type = "text" id = "search" name = "searchWord">
		</td>
		<td style = "padding-left:5px">
			<span class = "button blue">
				<button type = "button" id = "searchBtn">검색</button>
			</span>
		</td>
	</tr>
</table>
<!-- 캠핑장 검색창 -->
<div id = "select_sorting" style = "margin-top : 5px; margin-bottom : 10px">
	<!-- <label for = "selectListOrder" class = "skip">정렬하기</label> -->
	<table style = "margin-left : left; margin-right : left; margin-top : 3px; margin-bottom : 3px">
		<tr>
			<td style = "padding-left:5px">
				<select class = "sorting_select" id = "sorting" title = "정렬">
					<option value = "image" selected = "selected">--정렬--</option>
					<option value = "create">최신등록순</option>
					<option value = "read">조회순</option>
					<option value = "like">추천순</option>
				</select>
			</td>
		</tr>
	</table>
</div>
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
	 const contentid = new URLSearchParams(location.search).get('contentid');
	 console.log('content id', contentid)
			$.ajax({
				url : '/csite/campingreview.do',
				type : 'get',
				dataType : 'text',
				data : {'contentid':contentid},
				success : function(response){
					console.log(response);
					//alert("success");
					$("#reviewlisting").html("");

					const parsedResponse = JSON.parse(response);
	
					if(response == '[]'){
						let str = "<tr>"
					    +"<td colspan='4' class='nodata'>아직 등록된 후기가 없습니다. 첫번째 리뷰어가 되어보세요!</td>"
					    +"</tr>"
					    $("#reviewlisting").append(str);
					}
					parsedResponse.forEach( (item, idx) => {
						let str = "<tr>"
							+ "<td>" + (idx + 1) + "</td>"
							+ "<td><a href='campingdetailreview.do?review_seq=" + item.review_seq + "&contentid=" + item.contentid +"'>" + item.title + "</a></td>"	
							+ "<td>" + item.user_id + "</td>"
							+ "<td>" + item.readcount + "</td>"
							+ "</tr>";
						$("#reviewlisting").append(str);
						$("#searchBox").show();
					});
				}, 
				error:function(request,status,error){
				    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
			
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
						console.log(response);
						$("#reviewlisting").html("");
						const parsedResponse = JSON.parse(response);
		
						if(response == '[]'){
							let str = "<tr>"
						    +"<td colspan='4' class='nodata'>검색 조건을 충족하는 결과가 없어요</td>"
						    +"</tr>"
						    $("#reviewlisting").append(str);
						}
						parsedResponse.forEach( (item, idx) => {
							let str = "<tr>"
								+ "<td>" + (idx + 1) + "</td>"
								+ "<td><a href='campingdetailreview.do?review_seq=" + item.review_seq + "&contentid=" + item.contentid +"'>" + item.title + "</a></td>"	
								+ "<td>" + item.user_id + "</td>"
								+ "<td>" + item.readcount + "</td>"
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
							    +"<td colspan='4' class='nodata'>검색 조건을 충족하는 결과가 없어요</td>"
							    +"</tr>"
							    $("#reviewlisting").append(str);
							}
							parsedResponse.forEach( (item, idx) => {
								let str = "<tr>"
									+ "<td>" + (idx + 1) + "</td>"
									+ "<td><a href='campingdetailreview.do?review_seq=" + item.review_seq + "&contentid=" + item.contentid +"'>" + item.title + "</a></td>"	
									+ "<td>" + item.user_id + "</td>"
									+ "<td>" + item.readcount + "</td>"
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
}); //document.ready 끝나는 곳
</script>
</body>
</html>
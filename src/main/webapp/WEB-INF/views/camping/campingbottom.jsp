<%@page import="com.camping.bit.dto.CampingImageDto"%>
<%@page import="java.util.List"%>
<%@page import="com.camping.bit.dto.CampingListDto"%>
<%@page import="com.camping.bit.dto.CampingDetailDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 캠핑장 DB 수정 
ALTER TABLE CAMPING_BBS ADD NICKNAME VARCHAR2(20) DEFAULT '0' NOT NULL;

ALTER TABLE CAMPING_BBS ADD COMMENTCOUNT NUMBER(8) DEFAULT '0' NOT NULL;

ALTER TABLE CAMPING_BBS_COMMENT ADD NICKNAME VARCHAR2(20) DEFAULT '0' NOT NULL;
 -->
<!-- bxslider -->
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.4.0/js/all.js"></script>
<link href="/resources/css/campingsite/campingdetail.css" rel="stylesheet" type = "text/css">
</head>
<body>
<%
response.setHeader("Cache-Control","no-store");  
response.setHeader("Pragma","no-cache");  
response.setDateHeader("Expires",0);  
if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
CampingDetailDto campingdetail = (CampingDetailDto)request.getAttribute("campingdetail");
CampingListDto campinglist = (CampingListDto)request.getAttribute("campinglistfordetail");
@SuppressWarnings("unchecked")
List<CampingImageDto> campingimage = (List<CampingImageDto>)request.getAttribute("campingimage");
String campingintro = (String)request.getAttribute("campingintro");
%>

<c:set value = "<%=campinglist.getDonm()%>" var = "donm"/>

<div id ="section">
		<span><button type = "button" id = "introBtn" class="btn btn-light">캠핑장 소개</button></span>
		<span><button type = "button" id = "mapBtn" class="btn btn-light">오시는 길</button></span>
		<span><button type = "button" id = "reviewBtn" class="btn btn-light">캠핑장 후기</button></span>
</div>

<div id = "contents">
	
	<c:set value="<%=campinglist.getFacltnm()%>" var="facltnm" />
	<div>
		<c:choose>
			<c:when test = "${empty login}">
				<font size = "4pt">검색하신 캠핑장에 대해 알아볼까요?</font> 
			</c:when>
			<c:otherwise>
				<font size = "4pt"><span style="color: #1FB154; font-size: 20px; font-weight: bold;">${login.nickname}</span>님이 검색하신 캠핑장에 대해 알아볼까요?</font> 
			</c:otherwise>
		</c:choose>
		<hr>
	</div>
<br>
	<div id = "intro" class = "layout">
		<div class="campingdetail_subtitle">
			<i class="far fa-compass"></i> 캠핑장 소개
		</div>
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
	
<br><br><br>

	<div class="campingdetail_subtitle">
		<i class="far fa-compass"></i> 캠핑장 시설정보
	</div>

	 <div id = "sbrscl"> 
		<c:set value = "<%=campinglist.getSbrscl() %>" var = "service"/>
			<c:if test="${fn:contains(service, '전기')}">
				<div class = "campingservice">
					<img src ="<%=request.getContextPath()%>/resources/images/campingsite/plug.png" width = "60" style = "display : inline-block;"><h4>전기</h4>
				</div>
			</c:if>
			<c:if test="${fn:contains(service, '무선인터넷')}">
				<div class = "campingservice">
					<img src ="<%=request.getContextPath()%>/resources/images/campingsite/wi-fi.png" width = "60"><h4>무선인터넷</h4>
				</div>
			</c:if>
			<c:if test="${fn:contains(service, '장작판매')}">
				<div class = "campingservice">
					<img src ="<%=request.getContextPath()%>/resources/images/campingsite/firewood.png" width = "60"style = "display : inline-block;"><h4>장작판매</h4>
				</div>
			</c:if>
			<c:if test="${fn:contains(service, '온수')}">
				<div class = "campingservice">
					<img src ="<%=request.getContextPath()%>/resources/images/campingsite/hot-water.png" width = "60" style = "display : inline-block;"><h4>온수</h4>
				</div>
			</c:if>
			<c:if test="${fn:contains(service, '마트.편의점')}">
				<div class = "campingservice">
					<img src ="<%=request.getContextPath()%>/resources/images/campingsite/shopping-cart.png" width = "60"><h4>마트/편의점</h4>
				</div>
			</c:if>
			<c:if test="${fn:contains(service, '트렘폴린')}">
				<div class = "campingservice">
					<img src ="<%=request.getContextPath()%>/resources/images/campingsite/trampoline.png" width = "60"><h4>트렘폴린</h4>
				</div>
			</c:if>
			<c:if test="${fn:contains(service, '물놀이장')}">
				<div class = "campingservice">
					<img src ="<%=request.getContextPath()%>/resources/images/campingsite/water-park.png" width = "60"><h4>물놀이장</h4>
				</div>
			</c:if>
			<c:if test="${fn:contains(service, '놀이터')}">
				<div class = "campingservice">
					<img src ="<%=request.getContextPath()%>/resources/images/campingsite/slider.png" width = "60"><h4>놀이터</h4>
				</div>
			</c:if>
			<c:if test="${fn:contains(service, '산책로')}">
				<div class = "campingservice">
					<img src ="<%=request.getContextPath()%>/resources/images/campingsite/river-trail.png" width = "60"><h4>산책로</h4>
				</div>
			</c:if>
			<c:if test="${fn:contains(service, '운동시설')}">
				<div class = "campingservice">
					<img src ="<%=request.getContextPath()%>/resources/images/campingsite/gym.png" width = "60"><h4>운동시설</h4>
				</div>
			</c:if>
			<c:if test="${fn:contains(service, '운동장')}">
				<div class = "campingservice">
					<img src ="<%=request.getContextPath()%>/resources/images/campingsite/playground.png" width = "60"><h4>운동장</h4>
				</div>
			</c:if>
		</div>

<br><br>

	<div class="campingdetail_subtitle">
		<i class="far fa-compass"></i> 기타 주요시설
	</div>
<!-- 야영장 종류 -->
	<c:set value="<%=campingdetail.getGnrlsiteco() %>" var="gnrl" />
	<c:set value="<%=campingdetail.getAutositeco() %>" var="auto" />
	<c:set value="<%=campingdetail.getGlampsiteco() %>" var="glamp" />
	<c:set value="<%=campingdetail.getCaravsiteco() %>" var="carav" />
	<c:set value="<%=campingdetail.getIndvdlcaravsiteco() %>" var="indiv"/>
<!-- 야영장 바닥 -->
	<c:set value="<%=campinglist.getSitebottomcl1() %>" var="bottom1" />
	<c:set value="<%=campinglist.getSitebottomcl2() %>" var="bottom2" />
	<c:set value="<%=campinglist.getSitebottomcl3() %>" var="bottom3" />
	<c:set value="<%=campinglist.getSitebottomcl4() %>" var="bottom4" />
	<c:set value="<%=campinglist.getSitebottomcl5() %>" var="bottom5" />
<!-- 야영장 크기 -->
	<c:set value="<%=campingdetail.getSitemg1width() %>" var="width1" />
	<c:set value="<%=campingdetail.getSitemg1vrticl()%>" var="vertical1" />
	<c:set value="<%=campingdetail.getSitemg1co()%>" var="count1" />
	<c:set value="<%=campingdetail.getSitemg2width()%>" var="width2" />
	<c:set value="<%=campingdetail.getSitemg2vrticl()%>" var="vertical2" />
	<c:set value="<%=campingdetail.getSitemg2co()%>" var="count2" />
	<c:set value="<%=campingdetail.getSitedstnc() %>" var = "sitedistance"/>
	
	<table class = "table table">
		<tr align = "center" style = "font-weight : bold">
			<td rowspan = "2" style = "vertical-align: middle;" >주요시설</td>
			<td>일반야영장</td>
			<td>자동차야영장</td>
			<td>글램핑</td>
			<td>카라반</td>
			<td>개인카라반</td>
		</tr>
	
		<tr align = "center">
			<c:choose>
				<c:when test = "${gnrl==0 && auto ==0 && glamp ==0 && carav ==0 && indiv ==0 }">
					<td colspan = "5" align = "center">
							캠핑장에서 제공하지 않는 정보입니다. 
					</td>
				</c:when>
				<c:otherwise>
					<td>
						<c:if test ="${gnrl!=0}">
								${gnrl}면
						</c:if>
					</td>
					<td>
						<c:if test="${auto!=0}">
								${auto}면
						</c:if>	
					</td>
					<td>
						<c:if test="${glamp!=0}">
								${glamp}면
						</c:if>
					</td>
					<td>
						<c:if test="${carav!=0}">
								${carav}면
						</c:if>
					</td>
					<td>
						<c:if test="${indiv!=0}">
								${indiv}면
						</c:if>
					</td>
				</c:otherwise>
			</c:choose>
		</tr>
	
		<tr align = "center" style = "font-weight : bold">
			<td rowspan = "2" style = "vertical-align: middle;">캠핑장 바닥</td>
			<td>잔디</td>
			<td>파쇄석</td>
			<td>테크</td>
			<td>자갈</td>
			<td>맨흙</td>
		</tr>
	
		<tr align = "center">
			<c:choose>
				<c:when test = "${bottom1==0 && bottom2 ==0 && bottom3 ==0 && bottom4 ==0 && bottom5 ==0 }">
					<td colspan = "5" align = "center">
						캠핑장에서 제공하지 않는 정보입니다. 
					</td>
				</c:when>
				<c:otherwise>
					<td>
						<c:if test="${bottom1!=0}">
							${bottom1}면
						</c:if>
					</td>
					<td>
						<c:if test="${bottom2!=0}">
							${bottom2}면
						</c:if>
					</td>
					<td>
						<c:if test="${bottom3!=0}">
							${bottom3}면
						</c:if>
					</td>
					<td>
						<c:if test="${bottom4!=0}">
							${bottom4}면
						</c:if>
					</td>
					<td>
						<c:if test="${bottom5!=0}">
							${bottom5}면
						</c:if>
					</td>
				</c:otherwise>
			</c:choose>
			
		</tr>
	
		<tr align = "center">
			<td align = "center" style = "font-weight : bold">사이트 크기</td>
				<c:choose>
					<c:when test= "${width1==0 && vertical1==0 && width2==0 && vertical2==0}">
						<td colspan = "5" align = "center">
							캠핑장에서 제공하지 않는 정보입니다. 
						</td>
					</c:when>
					<c:otherwise>
						<td colspan = "2">
							<c:if test="${width1 !=0}">
								${width1} * 
							</c:if>
							<c:if test="${vertical1 !=0}">
								${vertical1}
							</c:if>
						</td>
						<td></td>
						<td colspan = "2">
							<c:if test="${width2 !=0}">
								${width2} * 
							</c:if>
							<c:if test="${vertical2 !=0}">
								${vertical2}
							</c:if>
						</td>
					</c:otherwise>
				</c:choose>
		</tr>
	
		<tr align = "center">
			<td align = "center" style = "font-weight : bold">개수</td>
				<c:choose>
					<c:when test = "${count1==0 && count2==0}">
						<td colspan = "5" align = "center">
							캠핑장에서 제공하지 않는 정보입니다. 
						</td>
					</c:when>
					<c:otherwise>
						<td colspan = "2" align = "center">
							<c:if test="${count1 !=0}">
								${count1}개
							</c:if>
						</td>
						<td></td>
						<td colspan = "2" align = "center">
							<c:if test="${count2 !=0}">
								${count2}개
							</c:if>
						</td>
					</c:otherwise>
				</c:choose>
		</tr>
	
		<tr align = "center">
			<td align = "center" style = "font-weight : bold">사이트 간격</td>
			<td colspan = "5" align = "center">
				<c:choose>
					<c:when test = "${sitedistance!=0}">
						${sitedistance}M
					</c:when>
					<c:otherwise>
						캠핑장에서 제공하지 않는 정보입니다. 
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</table>

<br><br>

	<div class="campingdetail_subtitle">
		<i class="far fa-compass"></i> 캠핑장 주요 서비스
	</div>
<!-- 야영장 서비스 -->
	<c:set value="<%=campinglist.getResvecl()%>" var="reservation" />
	<c:set value="<%=campingdetail.getResveurl()%>" var = "resveurl"/>
	<c:set value="<%=campinglist.getExprnprogrm()%>" var="program" />
	<c:set value="<%=campinglist.getAnimalcmgcl()%>" var="animal" />
	<c:set value="<%=campinglist.getEqpmnlendcl()%>" var = "equip"/>
	<c:url value="<%=campinglist.getHomepage() %>" var="url" />
	<c:url value="<%=campingdetail.getResveurl() %>" var="url1" />

	<div class="row card_row">
		<div class="col card_col">
			<div class="card">
				<img class="card-img-top" src ="<%=request.getContextPath()%>/resources/images/campingsite/social.png" alt="Card image cap">
				<div class="card-block">
					<br><h4 class="card-title">체험프로그램 진행</h4>
					<c:choose>
						<c:when test="${program != 'none'}">
							<p class="card-text" style = "text-align : center">${program}</p><br>
						</c:when>
						<c:otherwise>
							<p class = "card-text"  style = "text-align : center">프로그램을 진행하지 않아요</p><br>
								<div class="slash"><i class="fas fa-slash"></i></div>
								<a href="javascript:campingexperience()" class="add-to-cart btn btn-primary">가능한 캠핑장 알아보기</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		
		<div class="col card_col">
			<div class="card">
				<img class="card-img-top" src ="<%=request.getContextPath()%>/resources/images/campingsite/dog.png" height = "130px" alt="Card image cap">
				<div class="card-block">
					<br><h4 class="card-title">반려동물 동반</h4>
					<c:choose>
						<c:when test="${animal == '가능' }">
							<p class="card-text"  style = "text-align : center">어떤 강아지라도 환영해요</p><br>
						</c:when>
						<c:when test="${animal == '가능(소형견)' }">
							<p class="card-text"  style = "text-align : center">규정상 소형견만 동반할 수 있어요</p><br>
						</c:when>
						<c:otherwise>
							<p class = "card-text"  style = "text-align : center">아쉽지만 반려동물 동반이 어려워요</p><br>
								<div class="slash"><i class="fas fa-slash"></i></div>
								<a href="javascript:campingpet()" class="add-to-cart btn btn-primary">가능한 캠핑장 알아보기</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		
		<div class="col card_col">
			<div class="card">
				<img class="card-img-top" src ="<%=request.getContextPath()%>/resources/images/campingsite/settings.png" height = "130px" alt="Card image cap">
				<div class="card-block">
					<br><h4 class="card-title">캠핑 장비 대여</h4>
					<c:choose>
						<c:when test="${equip !='none' }">
							<p class="card-text" style = "text-align : center">${equip}</p><br>
						</c:when>
						<c:otherwise>
							<p class = "card-text"  style = "text-align : center">장비 대여가 불가해요</p><br>
								<div class="slash"><i class="fas fa-slash"></i></div>
								<a href="javascript:campingequip()" data-name="Orange" data-price="0.5" class="add-to-cart btn btn-primary">가능한 캠핑장 알아보기</a>
						</c:otherwise>
					</c:choose>
					</div>
				</div>
			</div>
		
		<div class="col card_col">
			<div class="card">
				<img class="card-img-top" src ="<%=request.getContextPath()%>/resources/images/campingsite/reserved.png" alt="Card image cap">
				<div class="card-block">
					<br><h4 class="card-title">온라인 예약</h4>
					<c:choose>
						<c:when test="${fn:contains(reservation, '온라인')}">
							<p class="card-text" style = "text-align : center">온라인으로 예약이 가능해요</p><br>
								<a href="javascript:campingreservenow()" class="add-to-cart btn btn-primary">지금 예약하기</a>
						</c:when>
						<c:when test="${fn:contains(reservation,'전화')}">
							<p class = "card-text"  style = "text-align : center">전화 예약이 가능해요</p><br>
						</c:when>
						<c:otherwise>
							<p class = "card-text"  style = "text-align : center">현장 예약만 가능해요</p><br>
								<div class="slash"><i class="fas fa-slash"></i></div>
								<a href="javascript:campingreserveboth()" class="add-to-cart btn btn-primary">가능한 캠핑장 알아보기</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
</div> <!-- contents div 끝나는 곳  -->
 
 

<div id = "mapintro">
	<div class="campingdetail_subtitle">
		<i class="far fa-compass"></i> 캠핑장 오시는 길
	</div>
	지도를 전체적으로 보고 싶으실 땐 잠시 꺼주세요, 파란 마커를 누르면 다시 등장합니다. 
</div>
 
<div id="map" style="margin: auto"></div><!-- 지도 -->

<br>


<div id = "photos">

	<div class="campingdetail_subtitle">
		<i class="far fa-compass"></i> 캠핑장 둘러보기
	</div>
	
	<table style="width: 100%;">
		<tr class = "smallphotos">
			<c:forEach items = "${campingimage}" var = "campingimage" varStatus = "i" end = "14">
				<c:if test="${i.index%5==0}">
					</tr><tr>
				</c:if>
			    <td>
			    	<img class = "smallpic" src = "${campingimage.imageurl}" onerror="this.src='<%=request.getContextPath()%>/resources/images/campingsite/csite_alt_image.png'" onClick="window.open(this.src)">
			    </td>
			</c:forEach>
		</tr>
	</table>

 	<ul class = "bxslider"> 
		<c:forEach items = "${campingimage}" var = "campingimage" varStatus = "i" end = "14">
 			<li>
 				<img src = "${campingimage.imageurl}" data-image = "${campingimage.imageurl}" onerror="this.src='<%=request.getContextPath()%>/resources/images/campingsite/csite_alt_image.png'">
 			</li>
 		</c:forEach>
 	</ul>
 	
 	<div class="campingdetail_subtitle" style="margin: 0px auto 30px;"></div>
</div><!-- 사진 -->


<div id = "review"><!-- 캠핑장 검색창 -->
	<div id = "select_sorting" style = "display : inline-block">
		<select class = "sorting_select" id = "sorting" title = "정렬">
			<option value = "image" selected = "selected">--정렬--</option>
			<option value = "create">최신등록순</option>
			<option value = "read">조회순</option>
			<option value = "like">추천순</option>
		</select>
	</div>
	<button type = "button" class="btn btn-light" onclick = "location.href ='campingwritereview.do?contentid=' + <%=campinglist.getContentid()%>" style="float: right;">리뷰 작성하기</button>

	<table class="table table-hover" style="font-weight: bold;">
	    <thead>
	        <tr>
	            <td>글번호</td>
	            <td width = "450px">제목</td>
	            <td>작성자</td>
	            <td>조회수</td>
	            <td>추천수</td>
	            <td>작성일</td>
	        </tr>
	    </thead>
	    <tbody id="reviewlisting"> <!-- ajax로 불러와서 뿌려주는 공간 -->
	   
	    </tbody>	
	</table>

	<div class="container">
	    <div style = "display : inline-block">
		    <nav aria-label="Page navigation">
		        <ul class="pagination" id="pagination"></ul>
		    </nav>
	    </div>
	</div>

	<div class = "rows"> <!-- 리뷰 검색하는 부분 -->
		<div class = "col_first" style = "display : inline-block">		
			<select id = "choice" name = "choice">
				<option value = "" selected = "selected">--선택--</option>
				<option value = "title">제목</option>
				<option value = "content">내용</option>
				<option value = "writer">작성자</option>
			</select>
		</div>
		<div class = "col_second" style = "display : inline-block">
			<input type = "text" id = "search" name = "searchWord" placeholder = "검색어를 입력해주세요" onkeypress="if( event.keyCode == 13 ){searchData();}" style="margin-left: 10px;" />	   	
		</div>
		<a href = "javascript:campingsearchlist(this)" style="color: #1FB154; font-size: 26px; margin-left: 20px;">
			<i class="fas fa-search"></i>
		</a>
	</div>	
</div> <!-- review div 끝나는 부분 -->

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
        '                <img src = "<%=campinglist.getFirstimageurl() %>" onerror="this.src=\'<%=request.getContextPath()%>/resources/images/campingsite/csite_alt_image.png\'">' +
        '           </div>' + 
        '            <div class="desc">' + 
        '                <div class="address"><%=campinglist.getAddr1().substring(0,15)+"..."%></div>' + 
        '                <div class="jibun ellipsis"><%=campinglist.getTel()%></div>' + 
        '               <div><c:url value="<%=campinglist.getHomepage() %>" var="url" /><c:choose><c:when test="${fn:contains(url, 'http')}"><a href="${url}" target="_blank" class="link">홈페이지</a></c:when><c:otherwise><a href="http:&#47;&#47;${url}" target="_blank" class="link">홈페이지</a></c:otherwise></c:choose></div>' + 
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
	//슬라이더, 정렬 먹히는 부분 시작
	$('.bxslider').bxSlider();
	
 	setTimeout(() => {
		$('.bx-viewport').css("height", "600px");
		document.getElementsByClassName('bx-viewport')[0].height = '600px';
		}, 2000); 
	
	$('select').niceSelect();
	//슬라이더, 정렬 먹히는 부분 끝
	
	$('#map').hide();
	$('#mapintro').hide();
	$('#review').hide();
	$('#searchBox').hide();
	$("#sorting").change(function(){ 
		$("#sortingval").val($("#sorting option:selected").val());
	});
	 
	$("#introBtn").click(function(){
		 $('#map').hide();
		 $('#mapintro').hide();
		 $('#intro').show();
		 $('#photos').show();
		 $('#contents').show();
		 $('#review').hide();
		 $('#searchBox').hide();
		 
	});//introBtn 끝나는 곳
	    
	$("#mapBtn").click(function(){
		  $('#intro').hide();
		  $('#photos').hide();
		  $('#map').show(); 
		  $('#mapintro').show();
		  $('#review').hide();
		  $('#searchBox').hide();
		  $('#contents').hide();
	}); //mapBtn 끝나는 곳

  	$("#reviewBtn").click(function campingbbslist(){
		 $('#intro').hide();
		 $('#photos').hide();
		 $('#map').hide();
		 $('#mapintro').hide();
		 $('#contents').hide();
		 $('#review').show();
		 $('.container').show();
		 $("#sorting").val("image").prop("selected", true);
		 const contentid = new URLSearchParams(location.search).get('contentid');
		 console.log('content id', contentid)
			$.ajax({
				url : '/csite/campingreview.do',
				type : 'get',
				dataType : 'text',
				data : {'contentid':contentid},
				success : function(response){
					$("#reviewlisting").html("");

					const parsedResponse = JSON.parse(response);
	
					if(response == '[]'){
						let str = "<tr>"
					    +"<td colspan='6' class='nodata'>아직 등록된 후기가 없습니다. 첫번째 리뷰어가 되어보세요!</td>"
					    +"</tr>"
					    $("#reviewlisting").append(str);
					}
					parsedResponse.forEach( (item, idx) => {
						
						let commentCount = item.commentCount >0 ? " [" + item.commentCount + "]" : "";
						let str = "<tr>"
							+ "<td>" + (idx + 1) + "</td>"
							+ "<td><a href='campingdetailreview.do?review_seq=" + item.review_seq + "&contentid=" + item.contentid +"'>" + item.title + "</a><font color = 'green'>" + commentCount + "</font></td>"	
							+ "<td>" + item.nickname + "</td>"
							+ "<td>" + item.readcount + "</td>"
							+ "<td>" + item.like_count + "</td>"
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
		 $('#mapintro').hide();
		 $('#contents').hide();
		 $('#review').show();	
		 const contentid = new URLSearchParams(location.search).get('contentid');
		 var paramData = { "choice" : $("#choice").val(), "search" : $("#search").val(), "contentid" : contentid};
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
					    +"<td colspan='6' class='nodata'>검색 조건을 충족하는 결과가 없어요</td>"
					    +"</tr>"
					    $("#reviewlisting").append(str);
					}
					parsedResponse.forEach( (item, idx) => {
						let commentCount = item.commentCount >0 ? " [" + item.commentCount + "]" : ""
						let str = "<tr>"
							+ "<td>" + (idx + 1) + "</td>"
							+ "<td><a href='campingdetailreview.do?review_seq=" + item.review_seq + "&contentid=" + item.contentid +"'>" + item.title + "</a><font color = 'green'>" + commentCount + "</font></td>"	
							+ "<td>" + item.nickname + "</td>"
							+ "<td>" + item.readcount + "</td>"
							+ "<td>" + item.like_count + "</td>"
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
		 $('#mapintro').hide();
		 $('#contents').hide();
		 $('#review').show();	
	
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
					    +"<td colspan='6' class='nodata'>검색 조건을 충족하는 결과가 없어요</td>"
					    +"</tr>"
					    $("#reviewlisting").append(str);
					}
					parsedResponse.forEach( (item, idx) => {
						
						let commentCount = item.commentCount >0 ? " [" + item.commentCount + "]" : ""
						let str = "<tr>"
							+ "<td>" + (idx + 1) + "</td>"
							+ "<td><a href='campingdetailreview.do?review_seq=" + item.review_seq + "&contentid=" + item.contentid +"'>" + item.title + "</a><font color = 'green'>" + commentCount + "</font></td>"	
							+ "<td>" + item.nickname + "</td>"
							+ "<td>" + item.readcount + "</td>"
							+ "<td>" + item.like_count + "</td>"
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
			
	let totalCount = ${searchReviewPage};	// 서버로부터 총글의 수를 취득
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


function pagemove(page){ //누르는 순간 페이지네이션에 지금 page 숫자를 알려준다
	 const pageNumber = page-1;
	 //console.log(pageNumber);
	 const contentid = new URLSearchParams(location.search).get('contentid');
	 var paramData = {"reviewsorting" : $("#sorting").val(), "contentid" : contentid, "choice" : $("#choice").val(), "search" : $("#search").val(), "pageNumber" : pageNumber};
	 //console.log(paramData);
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
				    +"<td colspan='6' class='nodata'>검색 조건을 충족하는 결과가 없어요</td>"
				    +"</tr>"
				    $("#reviewlisting").append(str);
				}
				parsedResponse.forEach( (item, idx) => {
					let commentCount = item.commentCount >0 ? "[" + item.commentCount + "]" : ""
					let str = "<tr>"
						+ "<td>" + (idx + 1) + "</td>"
						+ "<td><a href='campingdetailreview.do?review_seq=" + item.review_seq + "&contentid=" + item.contentid +"'>" + item.title + "</a><font color = 'green'>" + commentCount + "</font></td>"	
						+ "<td>" + item.nickname + "</td>"
						+ "<td>" + item.readcount + "</td>"
						+ "<td>" + item.like_count + "</td>"
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
	 $('#mapintro').hide();
	 $('#contents').hide();
	 $('#review').show();	
	 const contentid = new URLSearchParams(location.search).get('contentid');
	 var paramData = {"reviewsorting" : $("#sorting").val(), "choice" : $("#choice").val(), "search" : $("#search").val(), "contentid" : contentid};
		$.ajax({
			url : '/csite/campingSearchReview.do',
			type : 'get',
			dataType : 'text',
			data : paramData,
			success : function(response){
				//console.log("페이지 눌렀을 때", response);
				$("#reviewlisting").html("");
				const parsedResponse = JSON.parse(response);

				if(response == '[]'){
					let str = "<tr>"
				    +"<td colspan='6' class='nodata'>검색 조건을 충족하는 결과가 없어요</td>"
				    +"</tr>"
				    $("#reviewlisting").append(str);
				}
				parsedResponse.forEach( (item, idx) => {
					let commentCount = item.commentCount >0 ? "[" + item.commentCount + "]" : "";
					let str = "<tr>"
						+ "<td>" + (idx + 1) + "</td>"
						+ "<td><a href='campingdetailreview.do?review_seq=" + item.review_seq + "&contentid=" + item.contentid +"'>" + item.title + "</a><font color = 'green'>" + commentCount + "</font></td>"	
						+ "<td>" + item.nickname + "</td>"
						+ "<td>" + item.readcount + "</td>"
						+ "<td>" + item.like_count + "</td>"
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
			
			$.ajax({
				url : '/csite/getCampingSearchReviewCount.do',
				type : 'get',
				dataType : 'text',
				data : paramData,
				success : function(response){
				
				let totalCount = response;	// 서버로부터 총글의 수를 취득
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
				}, 
				error:function(request,status,error){
				    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			}); //ajax searchReviewCount 끝나는 곳	
		};//searchBtn function 끝나는 곳
	

function campingexperience(){
	location.href = "campinglist.do?exprnProgrm=exok&searchDo=${donm}";
};

function campingpet(){
	location.href = "campinglist.do?animalCmgCl=가능&searchDo=${donm}";
};

function campingequip(){
	location.href = "campinglist.do?eqpmnLendCl=eqok&searchDo=${donm}";
};

function campingreserveboth(){
	location.href = "campinglist.do?resveCl=온라인&resveCl=전화&searchDo=${donm}";
};

function campingreservenow(){
	var resveurl = "<c:out value= '${url1}'/>";
	var homeurl = "<c:out value = '${url}'/>";
	
	if(resveurl != 'none'){
		if(resveurl.indexOf("http")>-1){
			location.href = resveurl;
		}else{
			location.href = "http://" + resveurl;
		}	
	}else{ //예약 홈페이지가 존재하지 않을 때 
		if(homeurl.indexOf("http")>-1){
			location.href = homeurl;
		}else{
			location.href = "http://" + homeurl;
		}
	}
};

</script>
</body>
</html>
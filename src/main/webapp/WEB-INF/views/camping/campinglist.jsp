<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!--DB에 컬럼 추가 
ALTER TABLE CAMPING_LIST ADD READCOUNT NUMBER(8) DEFAULT '0' NOT NULL; 
ALTER TABLE CAMPING_LIST ADD LIKECOUNT NUMBER(8) DEFAULT '0' NOT NULL;



CREATE TABLE CAMPING_LIKE(
LIKE_AUTO_SEQ NUMBER(8) NOT NULL, 
LIKED_PAGE NUMBER(8) NOT NULL,
USER_ID VARCHAR2(100) NOT NULL, 
CONTENT_TYPE NUMBER(8) NOT NULL, 
CONSTRAINT PK_CAMPING_LIKE PRIMARY KEY (LIKE_AUTO_SEQ),
CONSTRAINT FK_CAMPING_LIKE FOREIGN KEY(USER_ID) REFERENCES MEMBER(ID));
    
CREATE SEQUENCE CAMPING_LIKE_SEQ
START WITH 1
INCREMENT BY 1;
-->
<!DOCTYPE html>
<%  
response.setHeader("Cache-Control","no-store");  
response.setHeader("Pragma","no-cache");  
response.setDateHeader("Expires",0);  
if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
String[]searchDo = request.getParameterValues("searchDo");
String[]searchCl = request.getParameterValues("searchCl");
String[]lctCl = request.getParameterValues("lctCl");
String[]induty = request.getParameterValues("induty");
String[]resveCl = request.getParameterValues("resveCl");
String eqpmnLendCl = request.getParameter("eqpmnLendCl");
String exprnProgrm = request.getParameter("exprnProgrm");
String[]animalCmgCl = request.getParameterValues("animalCmgCl");
String[]sbrsCl = request.getParameterValues("sbrsCl");
String siteBottomCl1 = request.getParameter("siteBottomCl1");
String siteBottomCl2 = request.getParameter("siteBottomCl2");
String siteBottomCl3 = request.getParameter("siteBottomCl3");
String siteBottomCl4 = request.getParameter("siteBottomCl4");
String siteBottomCl5 = request.getParameter("siteBottomCl5");
String user_id = (String)request.getAttribute("user_id");

String searchWord = (String)request.getParameter("searchWord");

String addressRegion = request.getParameter("addressRegion");
String doNm = request.getParameter("doNm");
String sigunguNm = request.getParameter("sigunguNm");
%>  
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bootstrap 추가 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
<link href="/resources/css/campingsite/campinglist.css" rel="stylesheet" type = "text/css">
</head>
<body>

<div class="campinglist_title">
	캠핑장 검색
	<p>'자세하기 검색하기'를 클릭해서 나에게 꼭 맞는 캠핑장을 검색해 보세요</p>
</div>

<div class = "deep-search">
	<form id = "searchForm1" action ="campinglist.do" method = "get" class = "form-inline">
		<div id = "address"> 
			<input id = "sortingval" name = "sorting" type = "hidden" class = "sorting_select"/>
			    <select name="addressRegion" id="addressRegion1"></select>&nbsp;
			    <select name="doNm" id="addressDo1"></select>&nbsp;
			    <select name="sigunguNm" id="addressSiGunGu1"></select>&nbsp;
		</div>
		<br>
	   	<div id = "searchkeyword" >
<!-- 	    	<i class="fas fa-search"></i> -->
	    	<input type = "text" id = "search" name = "searchWord" placeholder = "캠핑장을 검색해볼까요?" onkeypress="if( event.keyCode == 13 ){searchData();}">
	   	</div>
		<br>
		    <a href = "#" onClick = "document.getElementById('searchForm1').submit();"><img src ="<%=request.getContextPath()%>/resources/images/campingsite/searchicon.PNG" width = "50"></a>
	</form>
</div>

<div class="option-content" >
  <button class="category" id="que-1"><span id="que-1-toggle">+</span><span>자세하게 검색하기</span></button>
  <div class="detailSearch" id="ans-1">
	<!-- 여기서부터 상세검색!!!!!!!!!!!!!!!!!!!!!!!! -->
	<form id = "searchForm2" action = "campinglist.do"method = "get">
	<div id = "total" >
	<table>
	<tr colspan= "2">
		<th>지역별</th>
		<td>
			<div class="cities">
				<input type="checkbox" name="searchDo" id="서울시" class="check01" value="서울시" title="1"/>
						<label for="c_do01">서울시</label>
				<input type="checkbox" name="searchDo" id="부산시" class="check01" value="부산시" title="2"/>
						 <label for="c_do02">부산시</label>
				<input type="checkbox" name="searchDo" id="대구시" class="check01" value="대구시" title="3"/>
						 <label for="c_do03">대구시</label>
				<input type="checkbox" name="searchDo" id="인천시" class="check01" value="인천시" title="4"/>
						 <label for="c_do04">인천시</label>
				<input type="checkbox" name="searchDo" id="광주시" class="check01" value="광주시" title="5"/>
						 <label for="c_do05">광주시</label>
				<input type="checkbox" name="searchDo" id="대전시" class="check01" value="대전시" title="6"/>
						<label for="c_do06">대전시</label>
				<input type="checkbox" name="searchDo" id="울산시" class="check01" value="울산시" title="7"/>
						 <label for="c_do07">울산시</label>
				<input type="checkbox" name="searchDo" id="세종시" class="check01" value="세종시" title="8"/>
						 <label for="c_do08">세종시</label>
			</div>
		
		
			<div class = "check_w">
				<input type="checkbox" name="searchDo" id="경기도" class="check01" value="경기도" title="9"/>
						<label for="c_do09">경기도</label>
				<input type="checkbox" name="searchDo" id="강원도" class="check01" value="강원도" title="10"/>
						 <label for="c_do010">강원도</label>
				<input type="checkbox" name="searchDo" id="충청북도" class="check01" value="충청북도" title="11"/>
						 <label for="c_do011">충청북도</label>
				<input type="checkbox" name="searchDo" id="충청남도" class="check01" value="충청남도" title="12"/>
						 <label for="c_do012">충청남도</label>
				<input type="checkbox" name="searchDo" id="전라북도" class="check01" value="전라북도" title="13"/>
						 <label for="c_do013">전라북도</label>
				<input type="checkbox" name="searchDo" id="전라남도" class="check01" value="전라남도" title="14"/>
						 <label for="c_do014">전라남도</label>
				<input type="checkbox" name="searchDo" id="경상북도" class="check01" value="경상북도" title="15"/>
						 <label for="c_do015">경상북도</label>
				<input type="checkbox" name="searchDo" id="경상남도" class="check01" value="경상남도" title="16"/>
						 <label for="c_do016">경상남도</label>
				<input type="checkbox" name="searchDo" id="제주도" class="check01" value="제주도" title="17"/>
						<label for="c_do017"> 제주도</label>
			</div>
		</td>
	</tr>
	<tr>
		<th>운영 주체</th>
		<td>
			<div class="check_w">
				<input type="checkbox" name="searchCl" id="지자체" class="check01" value="지자체" title="18"/>
						 <label for="c_cl01">지자체</label>
				<input type="checkbox" name="searchCl" id="국립공원" class="check01" value="국립공원" title="19"/>
						 <label for="c_cl02">국립공원</label>
				<input type="checkbox" name="searchCl" id="자연휴양림" class="check01" value="자연휴양림" title="20"/>
						 <label for="c_cl03">자연휴양림</label>
				<input type="checkbox" name="searchCl" id="국민여가" class="check01" value="국민여가" title="21"/>
						 <label for="c_cl04">국민여가</label>
				<input type="checkbox" name="searchCl" id="민간" class="check01" value="민간" title="22"/>
						 <label for="c_cl05">민간</label>
			</div>
		</td>
	</tr>
	<tr>
		<th>주변 환경</th>
		<td>
			<div class="check_w">
				<input type="checkbox" name="lctCl" id="해변" class="check01" value="해변" title="23"/>
						 <label for="c_lct_cl01">해변</label>
				<input type="checkbox" name="lctCl" id="섬" class="check01" value="섬" title="24"/>
						 <label for="c_lct_cl02">섬</label>
				<input type="checkbox" name="lctCl" id="산" class="check01" value="산" title="25"/>
						 <label for="c_lct_cl03">산</label>
				<input type="checkbox" name="lctCl" id="숲" class="check01" value="숲" title="26"/>
						 <label for="c_lct_cl04">숲</label>
				<input type="checkbox" name="lctCl" id="계곡" class="check01" value="계곡" title="27"/>
						 <label for="c_lct_cl05">계곡</label>
				<input type="checkbox" name="lctCl" id="강" class="check01" value="강" title="28"/>
						 <label for="c_lct_cl06">강</label>
				<input type="checkbox" name="lctCl" id="호수" class="check01" value="호수" title="29"/>
						 <label for="c_lct_cl07">호수</label>
				<input type="checkbox" name="lctCl" id="도심" class="check01" value="도심" title="30"/>
						 <label for="c_lct_cl08">도심</label>
			</div>
		</td>
	</tr>
	<tr>
		<th>야영장 분류</th>
		<td>
			<div class="check_w">
					<input type="checkbox" name="induty" id="일반야영장" value="일반야영장" title="31" class="check01"/>
							<label for="c_induty01">일반야영장</label>
					<input type="checkbox" name="induty" id="자동차야영장" value="자동차야영장" title="32" class="check01"/>
			 				<label for="c_induty02">자동차야영장</label>
					<input type="checkbox" name="induty" id="카라반" value="카라반" title="33" class="check01"/>
							<label for="c_induty03">카라반</label>
					<input type="checkbox" name="induty" id="글램핑" value="글램핑" title="34" class="check01"/>
						 	<label for="c_induty04">글램핑</label>
			</div>
		</td>
	</tr>
	<tr>
		<th>예약방식</th>
		<td>
			<div class="check_w">
				<input type="checkbox" name="resveCl" id="온라인" value="온라인" title="35" class="check01"/>
						 <label for="c_resveCl01">온라인</label>
				<input type="checkbox" name="resveCl" id="전화" value="전화" title="36" class="check01"/>
						 <label for="c_resveCl02">전화</label>
				<input type="checkbox" name="resveCl" id="현장" value="현장" title="37" class="check01"/>
						 <label for="c_resveCl03">현장</label>
			</div>
		</td>
	</tr>
	<tr>
		<th>장비 대여</th>
		<td>
			<div class="check_w">
				<input type="checkbox" name="eqpmnLendCl" id="eqok" value="eqok" title="38" class="check01"/>
						<label for="c_eqpmnLendCl01">가능</label>
			</div>
		</td>
	</tr>
	<tr>
		<th>반려동물 동반</th>
		<td>
			<div class="check_w">
				<input type="checkbox" name="animalCmgCl" id="가능" value="가능" title="39" class="check01"/>
						<label for="c_animalCmgCl01">가능</label>
				<input type="checkbox" name="animalCmgCl" id="소형견" value="소형견" title="40" class="check01"/>
						<label for="c_animalCmgCl01">가능(소형견)</label>
				<input type="checkbox" name="animalCmgCl" id="불가능" value="불가능" title="41" class="check01"/>
						<label for="c_animalCmgCl01">불가능</label>
			</div>
		</td>
	</tr>
	<tr>
		<th>체험 프로그램</th>
		<td>
			<div class = "check_w">
				<input type="checkbox" name="exprnProgrm" id="exok" value="exok" title="42" class="check01"/>
						<label for="c_exprnProgrm01">진행</label>
			</div>
		</td>
	</tr>
	<tr>
		<th>캠핑장 기본 시설</th>
		<td>
			<div class="check_w">
				<input type="checkbox" name="sbrsCl" id="전기" value="전기" title="43" class="check01"/>
						 <label for="searchSbrsClCode01">전기</label>
				<input type="checkbox" name="sbrsCl" id="무선인터넷" value="무선인터넷" title="44" class="check01"/>
						 <label for="searchSbrsClCode02">무선인터넷</label>
				<input type="checkbox" name="sbrsCl" id="장작판매" value="장작판매" title="45" class="check01"/>
						 <label for="searchSbrsClCode03">장작판매</label>
				<input type="checkbox" name="sbrsCl" id="온수" value="온수" title="46" class="check01"/>
						 <label for="searchSbrsClCode04">온수</label>
			 	<input type="checkbox" name="sbrsCl" id="편의점" value="편의점" title="47" class="check01"/>
				 		 <label for="searchSbrsClCode011">마트.편의점</label>
				 		 
				<div>
				<input type="checkbox" name="sbrsCl" id="트렘폴린" value="트렘폴린" title="48" class="check01"/>
						 <label for="searchSbrsClCode05">트렘폴린</label>
				<input type="checkbox" name="sbrsCl" id="물놀이장" value="물놀이장" title="49" class="check01"/>
						 <label for="searchSbrsClCode06">물놀이장</label>
				<input type="checkbox" name="sbrsCl" id="놀이터" value="놀이터" title="50" class="check01"/>
						 <label for="searchSbrsClCode07">놀이터</label>
				<input type="checkbox" name="sbrsCl" id="산책로" value="산책로" title="51" class="check01"/>
						 <label for="searchSbrsClCode08">산책로</label>
				<input type="checkbox" name="sbrsCl" id="운동장" value="운동장" title="52" class="check01"/>
						 <label for="searchSbrsClCode09">운동장</label>
				<input type="checkbox" name="sbrsCl" id="운동시설" value="운동시설" title="53" class="check01"/>
						<label for="searchSbrsClCode010">운동시설</label>
				</div>
			</div>
		</td>
	</tr>
	<tr>
		<th>캠핑장 바닥</th>
		<td>
			<div class="check_w">
				<input type="checkbox" class="check01" name="siteBottomCl1" id="잔디"  title="54" value="잔디" title="잔디"/>
					<label for="searchSiteBottomCl1" class="label_name">잔디</label>
				<input type="checkbox" class="check01" name="siteBottomCl2" id="데크"  title="55" value="데크" title="데크"/>
					<label for="searchSiteBottomCl2" class="label_name">데크</label>
				<input type="checkbox" class="check01" name="siteBottomCl3" id="파쇄석" title="56" value="파쇄석" title="파쇄석"/>
					<label for="searchSiteBottomCl3" class="label_name">파쇄석</label>
				<input type="checkbox" class="check01" name="siteBottomCl4" id="자갈"  title="57" value="자갈" title="자갈"/>
					<label for="searchSiteBottomCl4" class="label_name">자갈</label>
				<input type="checkbox" class="check01" name="siteBottomCl5" id="맨흙"  title="58" value="맨흙" title="맨흙"/>
					<label for="searchSiteBottomCl5" class="label_name">맨흙</label>
			</div>
		</td>
	</tr>
	</table>
	<br>
			<div class="detailSearch_btn">
				<button type = "button" class = "btn btn-light" id = "resetBtn">초기화</button>
				<button type="submit" class="btn btn-light" id = "specifiedBtn">검색하기</button>
			</div>
		</div>
		</form>
	</div><!-- 상세검색 아래 펼쳐지는 부분 끝나는 곳 -->
	
	<!-- 캠핑장 정렬 -->
<div class = "search_sorting">
	<div class = "howmany">
		<span class="campsite_number">${campingSearchPage}</span>개의 캠핑장이 기다리고 있습니다
	</div>
	<select id = "sorting" title = "정렬" class="sorting_select">
		<option value = "image" selected = "selected">--정렬--</option>
		<option value = "create">최신등록순</option>
		<option value = "update">업데이트순</option>
		<option value = "read">조회순</option>
		<option value = "like">추천순</option>
	</select>
</div>
	
</div><!-- 자세하게 검색하기 끝나는 곳 -->


<br>
<!-- 리스트 시작 -->
<c:choose>
	<c:when test= "${campingSearchPage != 0}">
		<c:forEach items = "${campinglist}" var = "camping" varStatus = "i">
			<div class = "camping_search_list">
			<ul>
				<li style = "list-style : none;">
					<div class = "mainimage">
						<a href = "campingdetail.do?contentid=${camping.contentid}">	
						<img src = "${camping.firstimageurl}" onerror="this.src='<%=request.getContextPath()%>/resources/images/campingsite/csite_alt_image.png'" width = "300" height = "200">
						</a>
					</div>
					<div class = "camping_information">
						<div class = "camping_site name">
							<h4 class="campsite_name">
								<a href = "campingdetail.do?contentid=${camping.contentid}">${camping.facltnm}</a>
								<span class = "readcount" style = "font-size : 15px">조회수 : ${camping.readcount}</span>
								<span class = "likecount" style = "font-size : 15px">추천수 : ${camping.likecount}</span>
							</h4>
						</div>
						
						<c:choose>
							<c:when test = "${fn:length(camping.addr1)>35}">
								<c:set var = "TextValue" value = "${camping.addr1}"/>
								<c:set var = "string1" value = "${fn:substring(TextValue, 0,30)}"/>
								<h3>${string1}...</h3>
							</c:when>
							<c:otherwise>
								<h5>${camping.addr1}</h5>
							</c:otherwise>
						</c:choose>
						<c:if test="${camping.lineintro!='none'}">
							<c:choose>
								<c:when test = "${fn:length(camping.lineintro)>35}">
									<c:set var = "TextValue1" value = "${camping.lineintro}"/>
									<c:set var = "string1" value = "${fn:substring(TextValue1, 0,60)}"/>
									<p class="lineintro">${string1}...</p>
								</c:when>
								<c:otherwise>
									<p class="lineintro">${camping.lineintro}</p>
								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${camping.tel!='none'}">
							<span>
							<img src ="<%=request.getContextPath()%>/resources/images/campingsite/phone-call.png" width = "20"></span>
							<span class="campsite_tel">${camping.tel}</span>
						</c:if>
						<c:choose>
							<c:when test="${camping.homepage eq 'none'}">
								<span><%-- <img src ="<%=request.getContextPath()%>/resources/images/campingsite/home.png" width = "25"> --%>홈페이지 준비중</span>
							</c:when>
							<c:otherwise>
								<c:url value="${camping.homepage}" var="url" />
								<span><%-- <img src ="<%=request.getContextPath()%>/resources/images/campingsite/home.png" width = "25"> --%></span>
									<c:choose>
										<c:when test="${fn:contains(url, 'http')}">
											<button type = button  class="btn btn-light btn-sm" onclick = "location.href ='${url}'" ><i class="fas fa-home"></i> 홈페이지</button></c:when>
										<c:otherwise>
											<button type = button  class="btn btn-light btn-sm" onclick = "location.href ='http://${url}'" ><i class="fas fa-home"></i> 홈페이지</button>
										</c:otherwise>
									</c:choose>
							</c:otherwise>
						</c:choose>
						<div id = "service">
							<c:set value = "${camping.sbrscl}" var = "service"/>
								<c:if test="${fn:contains(service, '전기')}">
									<span class="tag tag1"><img src ="<%=request.getContextPath()%>/resources/images/campingsite/plug.png" width = "30"></span>
								</c:if>
								<c:if test="${fn:contains(service, '무선인터넷')}">
									<span class="tag tag1"><img src ="<%=request.getContextPath()%>/resources/images/campingsite/wi-fi.png" width = "30"></span>
								</c:if>
								<c:if test="${fn:contains(service, '장작판매')}">
									<span class="tag tag1"><img src ="<%=request.getContextPath()%>/resources/images/campingsite/firewood.png" width = "30"></span>
								</c:if>
								<c:if test="${fn:contains(service, '온수')}">
									<span class="tag tag1"><img src ="<%=request.getContextPath()%>/resources/images/campingsite/hot-water.png" width = "30"></span>
								</c:if>
								<c:if test="${fn:contains(service, '마트.편의점')}">
									<span class="tag tag1"><img src ="<%=request.getContextPath()%>/resources/images/campingsite/shopping-cart.png" width = "30"></span>
								</c:if>
								<c:if test="${fn:contains(service, '트렘폴린')}">
									<span class="tag tag1"><img src ="<%=request.getContextPath()%>/resources/images/campingsite/trampoline.png" width = "30"></span>
								</c:if>
								<c:if test="${fn:contains(service, '물놀이장')}">
									<span class="tag tag1"><img src ="<%=request.getContextPath()%>/resources/images/campingsite/water-park.png" width = "30"></span>
								</c:if>
								<c:if test="${fn:contains(service, '놀이터')}">
									<span class="tag tag1"><img src ="<%=request.getContextPath()%>/resources/images/campingsite/slider.png" width = "30"></span>
								</c:if>
								<c:if test="${fn:contains(service, '산책로')}">
									<span class="tag tag1"><img src ="<%=request.getContextPath()%>/resources/images/campingsite/river-trail.png" width = "30"></span>
								</c:if>
								<c:if test="${fn:contains(service, '운동시설')}">
									<span class="tag tag1"><img src ="<%=request.getContextPath()%>/resources/images/campingsite/gym.png" width = "30"></span>
								</c:if>
								<c:if test="${fn:contains(service, '운동장')}">
									<span class="tag tag1"><img src ="<%=request.getContextPath()%>/resources/images/campingsite/playground.png" width = "30"></span>
								</c:if>
							</div>
						</div>
					<div style="clear:both"></div>
				</li>
			</ul>
		</div>
	</c:forEach>
	</c:when>
<c:otherwise>
<img src ="<%=request.getContextPath()%>/resources/images/campingsite/nosearch.png" class = "nosearchpic" width = "500" height = "500">
</c:otherwise>
</c:choose>

<div class="container">
    <div style = "display : inline-block">
	    <nav aria-label="Page navigation">
	        <ul class="pagination" id="pagination"></ul>
	    </nav>
    </div>
</div>
<br>
<script type="text/javascript">
$(document).ready(function () {
	
	$('#sorting').niceSelect();
	
 <%if (searchDo != null){ 
 for(int i =0; i < searchDo.length; i++){ %>
   $("#<%=searchDo[i]%>").prop("checked", true);
<%  }
} %>
   
<%if (searchCl != null){ 
   for(int i =0; i < searchCl.length; i++){ %>
     $("#<%=searchCl[i]%>").prop("checked", true);
<%  }
} %>
<%if (lctCl != null){ 
   for(int i =0; i < lctCl.length; i++){ %>
     $("#<%=lctCl[i]%>").prop("checked", true);
<%  }
} %>
<%if (induty != null){ 
   for(int i =0; i < induty.length; i++){ %>
     $("#<%=induty[i]%>").prop("checked", true);
<%  }
} %>
<%if (resveCl != null){ 
   for(int i =0; i < resveCl.length; i++){ %>
     $("#<%=resveCl[i]%>").prop("checked", true);
<%  }
} %> 
<%if (eqpmnLendCl != null){ %>
	$("#<%=eqpmnLendCl%>").prop("checked", true);
	<% } %> 
<%if (exprnProgrm != null){ %>
    $("#<%=exprnProgrm%>").prop("checked", true);
	<% } %> 
<%if (animalCmgCl != null){ 
   for(int i =0; i < animalCmgCl.length; i++){ %>
	 $("#<%=animalCmgCl[i]%>").prop("checked", true);
<%  }
} %> 
<%if (sbrsCl != null) {
   for(int i = 0; i < sbrsCl.length; i++) {%>
	 $("#<%=sbrsCl[i]%>").prop("checked", true);
<%	}
} %> 
<%if (siteBottomCl1 != null) {%>
    $("#<%=siteBottomCl1%>").prop("checked", true);
	<% } %> 
<%if (siteBottomCl2 != null) {%>
    $("#<%=siteBottomCl2%>").prop("checked", true);
	<% } %>
<%if (siteBottomCl2 != null) {%>
    $("#<%=siteBottomCl2%>").prop("checked", true);
	<% } %> 
<%if (siteBottomCl3!= null){ %>
	$("#<%=siteBottomCl3%>").prop("checked", true);
	<% } %> 
<%if (siteBottomCl4!= null){ %>
	$("#<%=siteBottomCl4%>").prop("checked", true);
	<% } %> 
<%if (siteBottomCl5!= null){ %>
	$("#<%=siteBottomCl5%>").prop("checked", true);
	<% } %> 
<%if (searchWord!= null){ %>
	document.getElementById("search").value="<%=searchWord%>";
	<% } %>  
	
//페이지네이션
let totalCount = ${campingSearchPage};	// 서버로부터 총글의 수를 취득
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
			var pa = window.location.search.split("&pageNumber");
			if (window.location.href.indexOf("?") > -1 && window.location.href.indexOf("&")>-1) {
				location.href = "campinglist.do"+ pa[0] + "&pageNumber=" + (page - 1);
			}else if(window.location.href.indexOf("?PageNumber")>-1){
				var sa = window.location.search.split("?PageNumber");
				location.href = "campinglist.do" + sa[0] + "&pageNumber=" + (page - 1);
			}else{
				location.href = "campinglist.do?pageNumber=" + (page - 1);
			}
		}
	}); //페이지네이션 끝
	  
	//정렬 바꾸면 업데이트순, 최신순, 조회순, 추천순으로 바뀌기
	$("#sorting").change(function(){ 
		$("#sortingval").val($("#sorting option:selected").val());
		//console.log($("#sorting").val());
		$("#searchForm1").submit();
		//window.location = window.location.pathname;
	});

	// 상세검색 조건 초기화
	$("#resetBtn").click(function() {
		$("#searchForm2").find("input:checkbox").prop("checked", false);
	});
	
	//대분류 검색 버튼
	$("#bigSearchBtn").click(function(){
		$("#searchForm1").submit();
	});

	// 시군구 셀렉트 태그 셋팅
	$(function(){
	    areaSelectMaker("select[name=addressRegion]");
	 // selectbox styling
	 // $('select').niceSelect();
	});

	var areaSelectMaker = function(target){
	    if(target == null || $(target).length == 0){
	        console.warn("Unknown Area Tag");
	        return;
	    }

	    var area = {
	        "수도권" :{
	            "서울시" : [ "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구" ],
	            "경기도" : [ "수원시", "성남시", "의정부시", "안양시", "부천시", "광명시", "평택시", "동두천시", "안산시", "고양시",
	                	 "과천시", "구리시", "남양주시", "오산시", "시흥시", "군포시", "의왕시", "하남시", "용인시" , "파주시", "이천시", "안성시", "김포시", "화성시", "광주시", "양주시", "포천시", "여주시", "연천군", "가평군","양평군" ],
	            "인천시" : [ "계양구", "미추홀구", "남동구", "동구", "부평구", "서구", "연수구", "중구", "강화군", "옹진군" ]			
	        },
	        "강원권" :{
	            "강원도" : [ "춘천시", "원주시", "강릉시", "동해시", "태백시", "속초시", "삼척시", "홍천군", "횡성군", "영월군", "평창군", "정선군", "철원군", "화천군", "양구군", "인제군", "고성군", "양양군" ]			
	        },
	        "충청권" :{
	            "충청북도" : [ "청주시", "충주시", "제천시", "보은군", "옥천군", "영동군", "증평군", "진천군", "괴산군", "음성군", "단양군", "청원군" ],
	            "충청남도" : [ "천안시", "공주시", "보령시", "아산시", "서산시", "논산시", "계룡시", "당진시", "금산군", "부여군", "서천군", "청양군", "홍성군", "예산군", "태안군" ],
	            "대전시" : [ "대덕구", "동구", "서구", "유성구", "중구" ],
	            "세종시" : [ "금남면", "세종시", "소정면", "연서면", "전동면" ]			
	        },
	        "전라권" :{
	            "전라북도" : [ "전주시", "군산시", "익산시", "정읍시", "남원시", "김제시", "완주군", "진안군", "무주군", "장수군", "임실군", "순창군", "고창군", "부안군" ],
	            "전라남도" : [ "목포시", "여수시", "순천시", "나주시", "광양시", "담양군", "곡성군", "구례군", "고흥군", "보성군", "화순군", "장흥군", "강진군", "해남군", "영암군", "무안군", "함평군", "영광군", "장성군", "완도군", "진도군", "신안군" ],
	            "광주시" : [ "광산구", "남구", "동구", "북구", "서구" ]			
	        },
	        "경상권" : {
	            "경상북도" : [ "포항시", "경주시", "김천시", "안동시", "구미시", "영주시", "영천시", "상주시", "문경시", "경산시", "군위군", "의성군", "청송군", "영양군", "영덕군", "청도군", "고령군", "성주군", "칠곡군", "예천군", "봉화군", "울진군", "울릉군" ],
	            "경상남도" : [ "창원시", "진주시", "통영시", "사천시", "김해시", "밀양시", "거제시", "양산시", "의령군", "함안군", "창녕군", "고성군", "남해군", "하동군", "산청군", "함양군", "거창군", "합천군" ],
	            "부산시" : [ "강서구", "금정구", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구", "기장군" ],
	            "대구시" : [ "남구", "달서구", "동구", "북구", "서구", "수성구", "중구", "달성군" ],
	            "울산시" : [ "남구", "동구", "북구", "중구", "울주군" ]			
	        },
	        "제주권" : {
	            "제주도" : [ "서귀포시", "제주시" ]			
	        }
	    };

	    for(i=0; i<$(target).length; i++){
	        (function(z){
	            var a1 = $(target).eq(z);
	            var a2 = a1.next();
	            var a3 = a2.next();

	            //초기화
	            init(a1, true);

	            //권역 기본 생성
	            var areaKeys1 = Object.keys(area);
	            console.log(areaKeys1);
	            areaKeys1.forEach(function(Region){
	                a1.append("<option value="+Region+">"+Region+"</option>");
	            });

	            //첫번째 변경 이벤트
	            $(a1).on("change", function(){
	                init($(this), false);
	                var Region = $(this).val();
	                console.log(Region);
	                var keys = Object.keys(area[Region]);
	                console.log(keys);
	                keys.forEach(function(Do){
	                    a2.append("<option value="+Do+">"+Do+"</option>");    
	                });
	            });
				
	            //두번째 변경 이벤트
	            $(a2).on("change", function(){
	                a3.empty().append("<option value=''>선택</option>");
	                var Region = a1.val();
	                var Do = $(this).val();
	                var keys = Object.keys(area[Region][Do]);
	                console.log(keys);
	                keys.forEach(function(SiGunGu){
	                    a3.append("<option value="+area[Region][Do][SiGunGu]+">"+area[Region][Do][SiGunGu]+"</option>");    
	                });
	            });
	        })(i);        

	        function init(t, first){
	            first ? t.empty().append("<option value=''>권역</option>") : "";
	            t.next().empty().append("<option value=''>도/시</option>");
	            t.next().next().empty().append("<option value=''>시군구</option>");
	        }
	    }
	}
	
	
 	//캠핑장 자동검색어
 	/*
	var loopSearch = true;
	function autoSearch(){
		if(loopSearch==false){
			return;
		}
		var value = document.frmSearch.searchWord.value;
		$.ajax({
			type : "get",
			async : true, 
			url : "${contextPath}/camping/autoSearch.do",
			data : {keyword:value},
			success : function(data, textStatus){
				var jsonInfo = JSON.parse(data);
				displayResult(jsonInfo);
			},
			error : function(data, textStatus){
				alert(" 에러 발생 " + data);
			}, 
			complete : function(data, textStatus){
				alert(" 작업 완료 ");
			}
		});
	}
	function displayResult(jsonInfo){
		var count = jsonInfo.keyword.length;
		if(count>0){
			var html = '';
			for(var i in jsonInfo.keyword){
				html +="a href = "javascript:select('"+jsonInfo.keyword[i]+"')">"
				jsonInfo.keyword[i]+"</a><br>";
			}
			var listView = document.getElementById("suggestList");
			listView.innerHTML = html;
			show('suggest');
		}else{
			hide('suggest');
			}
		}
	} */
}); //$(document).ready 끝나는 곳


//상세검색 화면창
const items = document.querySelectorAll('.category');

function openCloseAnswer() {
  const answerId = this.id.replace('que', 'ans');

  if(document.getElementById(answerId).style.display === 'block') {
    document.getElementById(answerId).style.display = 'none';
    document.getElementById(this.id + '-toggle').textContent = '+';
  } else {
    document.getElementById(answerId).style.display = 'block';
    document.getElementById(this.id + '-toggle').textContent = '-';
  }
}
items.forEach(item => item.addEventListener('click', openCloseAnswer));
</script>
</body>
</html>
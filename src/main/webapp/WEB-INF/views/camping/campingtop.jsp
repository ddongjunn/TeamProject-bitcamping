<%@page import="com.camping.bit.dto.MemberDto"%>
<%@page import="com.camping.bit.dto.CampingLikeDto"%>
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
<!--CREATE TABLE CAMPING_LIKE(
LIKE_AUTO_SEQ NUMBER(8) NOT NULL, 
CONTENTID NUMBER(38) NOT NULL,
USER_ID VARCHAR2(100) NOT NULL, 
CONTENT_TYPE NUMBER(8) NOT NULL, 
CONSTRAINT PK_CAMPING_LIKE PRIMARY KEY (LIKE_AUTO_SEQ),
CONSTRAINT FK_CAMPING_LIKECI FOREIGN KEY(CONTENTID) REFERENCES CAMPING_LIST(CONTENTID),
CONSTRAINT FK_CAMPING_LIKEUI FOREIGN KEY(USER_ID) REFERENCES MEMBER(ID));



ALTER TABLE CAMPING_LIKE ADD REVIEW_SEQ NUMBER(8) DEFAULT '0' NOT NULL;
ALTER TABLE CAMPING_LIKE ADD COMMENT_SEQ NUMBER(8) DEFAULT '0' NOT NULL;


CREATE SEQUENCE CAMPING_LIKE_SEQ
START WITH 1
INCREMENT BY 1; 

ALTER TABLE CAMPING_LIKE
ADD CONSTRAINT FK_CAMPING_LIKE_USER_ID_member FOREIGN KEY (USER_ID)
REFERENCES member (id)

ALTER TABLE CAMPING_LIKE
ADD CONSTRAINT FK_CAMPING_LIKE_CONTENTID_CAMP FOREIGN KEY (CONTENTID)
REFERENCES CAMPING_LIST (CONTENTID)
-->
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/css/campingsite/campingdetail.css" rel="stylesheet" type = "text/css">
</head>
<body>

<%

CampingDetailDto campingdetail = (CampingDetailDto)request.getAttribute("campingdetail");
CampingListDto campinglist = (CampingListDto)request.getAttribute("campinglistfordetail");
CampingLikeDto campinglike = (CampingLikeDto)request.getAttribute("campinglike");
String login_id = (String)request.getAttribute("login_id");

%>
<input type = "hidden" name = "login_id" value = "${login.id}">
<input type = "hidden" name = "campingidx" value = "${campingidx}"/>
<input type = "hidden" name = "useridx" value = "${useridx}"/>

<div class="campingtop_border">
	<div class = "camping_top_information">
		<ul>
			<li style = "list-style : none;">
				<div class = "mainimage" >
					<img src = "<%=campinglist.getFirstimageurl() %>" onerror="this.src='<%=request.getContextPath()%>/resources/images/campingsite/csite_alt_image.png'" width = "600" height = "480">
				</div>
				<br>
				<div class = "camping_information">
					<div class = "camping_site name">
						<div class = "camping_site_name">	
								<%=campinglist.getFacltnm()%>
							<span class = "readcount" style = "font-size : 15px; color: gray;">????????? : <%=campinglist.getReadcount()%></span>
							<span class = "likecount" style = "font-size : 15px; color: gray;">????????? : <%=campinglist.getLikecount()%></span>
							
							<div id = "like_heart" style="position: absolute; right: 45px; bottom: 0;">
							<c:choose>
								<%--????????? choose(????????? ????????? ??? ?????????) --%>
								<c:when test="${not empty useridx}">
									<c:choose>
										<c:when test = "${likecheck eq '0' or empty likecheck}"><%--?????? ????????? ??? ???????????? ????????? ????????? ???????????? like.user_id!=login.id --%>
											<span><a href = "javascript:" class = "heart-click">
												<svg xmlns = "http://www.w3.org/2000/svg" width = "30" height = "30" fill ="currentColor" class = "bi bi-suit-heart" viewBox = "0 -20 480 480">
											<path d="m348 0c-43 .0664062-83.28125 21.039062-108 56.222656-24.71875-35.183594-65-56.1562498-108-56.222656-70.320312 0-132 65.425781-132 140 0 72.679688 41.039062 147.535156 118.6875 216.480469 35.976562 31.882812 75.441406 59.597656 117.640625 82.625 2.304687 1.1875 5.039063 1.1875 7.34375 0 42.183594-23.027344 81.636719-50.746094 117.601563-82.625 77.6875-68.945313 118.726562-143.800781 118.726562-216.480469 0-74.574219-61.679688-140-132-140zm-108 422.902344c-29.382812-16.214844-224-129.496094-224-282.902344 0-66.054688 54.199219-124 116-124 41.867188.074219 80.460938 22.660156 101.03125 59.128906 1.539062 2.351563 4.160156 3.765625 6.96875 3.765625s5.429688-1.414062 6.96875-3.765625c20.570312-36.46875 59.164062-59.054687 101.03125-59.128906 61.800781 0 116 57.945312 116 124 0 153.40625-194.617188 266.6875-224 282.902344zm0 0"/>
											</svg></a></span>
										</c:when>
										<c:otherwise><%--likecheck??? 1?????? ??? ??? ????????? ?????? --%>
											<span><a href ="javascript:" class = "heart-click">
												<svg xmlns = "http://www.w3.org/2000/svg" width = "30" height = "30" fill ="currentColor" class = "bi bi-suit-heart-fill" viewBox = "0 -20 480 480">
											<path d="m340 0c-44.773438.00390625-86.066406 24.164062-108 63.199219-21.933594-39.035157-63.226562-63.19531275-108-63.199219-68.480469 0-124 63.519531-124 132 0 172 232 292 232 292s232-120 232-292c0-68.480469-55.519531-132-124-132zm0 0" fill="#ff6243"/><path d="m32 132c0-63.359375 47.550781-122.359375 108.894531-130.847656-5.597656-.769532-11.242187-1.15625025-16.894531-1.152344-68.480469 0-124 63.519531-124 132 0 172 232 292 232 292s6-3.113281 16-8.992188c-52.414062-30.824218-216-138.558593-216-283.007812zm0 0" fill="#ff5023"/>
											</svg></a></span>
										</c:otherwise>
									</c:choose><%--????????? choose ??? --%>
								</c:when>
								<%--????????? ????????? ?????? ??? ??? ?????? ?????? --%>
								<c:otherwise>
									<span><a href = "javascript:" class = "heart-notlogin">
										<svg class = "heart3" xmlns = "http://www.w3.org/2000/svg" width = "30" height = "30" fill ="currentColor" class = "bi bi-suit-heart" viewBox = "0 -20 480 480">
									<path d="m348 0c-43 .0664062-83.28125 21.039062-108 56.222656-24.71875-35.183594-65-56.1562498-108-56.222656-70.320312 0-132 65.425781-132 140 0 72.679688 41.039062 147.535156 118.6875 216.480469 35.976562 31.882812 75.441406 59.597656 117.640625 82.625 2.304687 1.1875 5.039063 1.1875 7.34375 0 42.183594-23.027344 81.636719-50.746094 117.601563-82.625 77.6875-68.945313 118.726562-143.800781 118.726562-216.480469 0-74.574219-61.679688-140-132-140zm-108 422.902344c-29.382812-16.214844-224-129.496094-224-282.902344 0-66.054688 54.199219-124 116-124 41.867188.074219 80.460938 22.660156 101.03125 59.128906 1.539062 2.351563 4.160156 3.765625 6.96875 3.765625s5.429688-1.414062 6.96875-3.765625c20.570312-36.46875 59.164062-59.054687 101.03125-59.128906 61.800781 0 116 57.945312 116 124 0 153.40625-194.617188 266.6875-224 282.902344zm0 0"/>
									</svg></a>&nbsp;<span class="likelogin"><a href="javascript:modalOn();" style="color: #ff6243; text-decoration: underline;">?????????</a> ??? ?????? ???????????????!</span></span>
								</c:otherwise>
							</c:choose><%--????????? choose ??? --%>
							</div> <!-- likedheart ????????? ??? --> 		
						
						</div>
					</div>
						<div class="campsite-info">
							<table class="campsite-info-table">
								<col width="30%">
								<col width="70%">
								<tr>
									<th>??????</th> <td><%=campinglist.getAddr1() %></td>
								</tr>
								<tr>
									<th>????????????</th> <td><%=campinglist.getTel() %></td>
								</tr>
								<tr>
									<th>????????? ??????</th> <td><%=campinglist.getLctcl() %>/<%=campinglist.getFacltdivnm() %></td>
								</tr>
								<tr>
									<th>????????? ??????</th> <td><%=campinglist.getInduty() %></td>
								</tr>
								<tr>
									<th>????????????</th> <td><%=campingdetail.getOperpdcl() %></td>
								</tr>
								<tr>
									<th>?????????</th> <td><%=campingdetail.getOperdecl() %></td>
								</tr>
								<tr>
									<th>??????</th> <td><%=campinglist.getSbrscl() %></td>
								</tr>
							</table>
						</div>	
					<c:url value="<%=campinglist.getHomepage() %>" var="url" />
					<c:url value="<%=campingdetail.getResveurl() %>" var="url1" />
							<c:choose>
								<c:when test="${url eq 'none'}">
									<span>
									<svg height="35" viewBox="0 0 128 128" width="35" xmlns="http://www.w3.org/2000/svg">
									<path d="m105.9 49.027-35.824-29.592a9.555 9.555 0 0 0 -12.152 0l-35.824 29.592a13.306 13.306 0 0 0 -4.85 10.291v42.841a8.6 8.6 0 0 0 8.591 
									8.591h24.117a1.75 1.75 0 0 0 1.75-1.75v-27.353a6.757 6.757 0 0 1 6.749-6.747h11.086a6.757 6.757 0 0 1 6.749 6.749v27.351a1.75 1.75 0 0 0 1.75 
									1.75h24.117a8.6 8.6 0 0 0 8.591-8.591v-42.841a13.306 13.306 0 0 0 -4.85-10.291zm1.348 53.132a5.1 5.1 0 0 1 -5.091 5.091h-22.365v-25.6a10.261 10.261 0 0 0 
									-10.249-10.25h-11.086a10.261 10.261 0 0 0 -10.249 10.247v25.6h-22.367a5.1 5.1 0 0 1 -5.091-5.091v-42.838a9.817 9.817 0 0 1 3.576-7.591l35.826-29.593a6.047 
									6.047 0 0 1 7.7 0l35.826 29.593a9.817 9.817 0 0 1 3.576 7.591z"/></svg>???????????? ?????????</span>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${fn:contains(url, 'http')}">
											<button type = button  class="btn btn-light btn-sm" onclick = "window.open('${url}')" >????????????</button>
											</c:when>
										<c:otherwise>
											<button type = button  class="btn btn-light btn-sm" onclick = "window.open('http://${url}')" >????????????</button>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
							<c:choose>
						  	<c:when test="${url1 eq 'none'}">
						        ????????????
						    </c:when>
						    <c:otherwise>
						    <c:choose>
								<c:when test="${fn:contains(url1, 'http')}">
						       		 <button type = button onclick = "window.open('${url1}')" class = "btn btn-light btn-sm" target = "_blank">????????????</button>
								</c:when>
								<c:otherwise>	
									<button type = button onclick = "window.open('http://${url1}')" class = "btn btn-light btn-sm" target = "_blank">????????????</button>			    
						    	</c:otherwise>
						    </c:choose>
						    </c:otherwise>
						</c:choose>
	<br>
	
				</div><!-- camping_information ????????? ?????? div ????????? ??? -->
				<div style="clear:both"></div>
			</li>
		</ul>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function(){

 	$(".heart-click").click(function(){
		 const contentid = "${campingidx}";
		 const user_id = "${useridx}";
		 const likecount = "${likecount}";
		 /*alert(likecount);*/
		var paramData = {"contentid" : contentid, "user_id" : user_id}
		console.log(paramData);
		 if($(this).children('svg').attr('class')=="bi bi-suit-heart"){
			 /*console.log('??? ?????? ??????' + contentid)*/
		$.ajax({
		url : '/csite/plusCampingHeart.do',
		type : 'get',
		data : paramData,
		dataType : 'text',
		success : function(result){
			/*alert("?????????" + result)*/
			if(result !=-1){
				$('.likecount').html("");
				$('.likecount').html('????????? : ' + result);
			}
		}, 
		error:function(request,status,error){
		    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});//????????? ajax ????????? ???
		$(this).html('<svg xmlns = "http://www.w3.org/2000/svg" width = "30" height = "30" fill ="currentColor" class = "bi bi-suit-heart-fill" viewBox = "0 -20 480 480"><path d="m340 0c-44.773438.00390625-86.066406 24.164062-108 63.199219-21.933594-39.035157-63.226562-63.19531275-108-63.199219-68.480469 0-124 63.519531-124 132 0 172 232 292 232 292s232-120 232-292c0-68.480469-55.519531-132-124-132zm0 0" fill="#ff6243"/><path d="m32 132c0-63.359375 47.550781-122.359375 108.894531-130.847656-5.597656-.769532-11.242187-1.15625025-16.894531-1.152344-68.480469 0-124 63.519531-124 132 0 172 232 292 232 292s6-3.113281 16-8.992188c-52.414062-30.824218-216-138.558593-216-283.007812zm0 0" fill="#ff5023"/></svg>');	
		 }//?????? ????????? ???
		 else if($(this).children('svg').attr('class')=="bi bi-suit-heart-fill"){
		$.ajax({
		url : '/csite/minusCampingHeart.do',
		type : 'get',
		data : paramData,
		dataType : 'text',
		success : function(result){
			/*alert("??????" + result);*/
			if(result != -1){
				$('.likecount').html("");	
				$('.likecount').html('????????? : ' + result);
			}
		}, 
		error:function(request,status,error){
		    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});//??? ??? ?????? ajax ????????? ???
		$(this).html('<svg xmlns = "http://www.w3.org/2000/svg" width = "30" height = "30" fill ="currentColor" class = "bi bi-suit-heart" viewBox = "0 -20 480 480"><path d="m348 0c-43 .0664062-83.28125 21.039062-108 56.222656-24.71875-35.183594-65-56.1562498-108-56.222656-70.320312 0-132 65.425781-132 140 0 72.679688 41.039062 147.535156 118.6875 216.480469 35.976562 31.882812 75.441406 59.597656 117.640625 82.625 2.304687 1.1875 5.039063 1.1875 7.34375 0 42.183594-23.027344 81.636719-50.746094 117.601563-82.625 77.6875-68.945313 118.726562-143.800781 118.726562-216.480469 0-74.574219-61.679688-140-132-140zm-108 422.902344c-29.382812-16.214844-224-129.496094-224-282.902344 0-66.054688 54.199219-124 116-124 41.867188.074219 80.460938 22.660156 101.03125 59.128906 1.539062 2.351563 4.160156 3.765625 6.96875 3.765625s5.429688-1.414062 6.96875-3.765625c20.570312-36.46875 59.164062-59.054687 101.03125-59.128906 61.800781 0 116 57.945312 116 124 0 153.40625-194.617188 266.6875-224 282.902344zm0 0"/></svg>');
		 }//??? ??? ?????? ????????? ???
	});//heart-click function ????????? ??? 
});//document.ready ????????? ???
</script>
</body>
</html>
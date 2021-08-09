<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- bootstrap 추가 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!--DB에 컬럼 추가 
ALTER TABLE CAMPING_LIST ADD READCOUNT NUMBER(8) DEFAULT '0' NOT NULL; 
ALTER TABLE CAMPING_LIST ADD LIKECOUNT NUMBER(8) DEFAULT '0' NOT NULL;
-->
<!DOCTYPE html>
<%  
response.setHeader("Cache-Control","no-store");  
response.setHeader("Pragma","no-cache");  
response.setDateHeader("Expires",0);  
if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
%>  
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
ul li{list-style-type : none; float : left; margin-left : 10px}
</style>
</head>
<body>
<a href = "campingmap.do">지도로 가기</a>

<!-- 캠핑장 검색창 -->
<div class = "search_sorting" style = "margin-top : 5px; margin-bottom : 10px">
	<!-- <label for = "selectListOrder" class = "skip">정렬하기</label> -->
	<table style = "margin-left : left; margin-right : left; margin-top : 3px; margin-bottom : 3px">
		<tr>
			<td style = "padding-left:5px">
				<select class = "sorting_select" id = "sorting" title = "정렬">
					<option value = "image" selected = "selected">--정렬--</option>
					<option value = "create">최신등록순</option>
					<option value = "update">업데이트순</option>
					<option value = "read">조회순</option>
					<option value = "like">추천순</option>
				</select>
			</td>
		</tr>
	</table>
</div>

<!-- <div class = "sorting_style">
	<form id = "searchForm1" action = "campinglist.do" method = "get">
	</form>
</div> -->

<div class = "deep search">
	<form id = "searchForm1" action ="campinglist.do" method = "get">
		<input id = "sortingval" name = "sorting" type = "hidden" value = ""/>
		<input id = "searchDo" name = "Do" type = "hidden" value = ""/>
		<ul>
			<li class="tt"><strong class="title">지역</strong>
				<div class="select_box">
					<label for="c_do">도/특별시</label>
						<select id="c_do" name="c_do" class="detail_select" title="도/특별시">
							<option value="" selected="selected">전체</option>
							<option value="1">서울시</option><option value="2">부산시</option><option value="3">대구시</option><option value="4">인천시</option><option value="5">광주시</option><option value="6">대전시</option><option value="7">울산시</option><option value="8">세종시</option><option value="9">경기도</option><option value="10">강원도</option><option value="11">충청북도</option><option value="12">충청남도</option><option value="13">전라북도</option><option value="14">전라남도</option><option value="15">경상북도</option><option value="16">경상남도</option><option value="17">제주도</option>
						</select>
				</div>
			</li>
		</ul>
	</form>
</div>


<li>
	<div class="tm_ver f_open">
		<!-- <button type="button">지역별</button> -->
			<!--div의 클래스명이 f_open이면 아래의 folder_w가 활성화되고, f_close가 되면 folder_w가 비활성화 됩니다-->
			<form id = "searchForm2" action = "campinglist.do" method = "get">
					<div class="folder_w">
						<strong>지역별</strong>
							<div class="check_w">
					<ul>
						<!-- <li><input type="checkbox" name="searchDo" id="c_do00" class="check00" value="0" title="-"checked="checked"/>
								<label for="c_do00">전체</label></li> -->
						<li><input type="checkbox" name="searchDo" id="c_do01" class="check01" value="서울시" title="1"checked="checked"/>
								<label for="c_do01">서울시</label></li>
						<li><input type="checkbox" name="searchDo" id="c_do02" class="check01" value="부산시" title="2"/>
								 <label for="c_do02">부산시</label></li>
						<li><input type="checkbox" name="searchDo" id="c_do03" class="check01" value="대구시" title="3"/>
								 <label for="c_do03">대구시</label></li>
						<li><input type="checkbox" name="searchDo" id="c_do04" class="check01" value="인천시" title="4"/>
								 <label for="c_do04">인천시</label></li>
						<li><input type="checkbox" name="searchDo" id="c_do05" class="check01" value="광주시" title="5"/>
								 <label for="c_do05">광주시</label></li>
						<li><input type="checkbox" name="searchDo" id="c_do06" class="check01" value="대전시" title="6"/>
								<label for="c_do06">대전시</label></li>
						<li><input type="checkbox" name="searchDo" id="c_do07" class="check01" value="울산시" title="7"/>
								 <label for="c_do07">울산시</label></li>
						<li><input type="checkbox" name="searchDo" id="c_do08" class="check01" value="세종시" title="8"/>
								 <label for="c_do08">세종시</label></li>
						<li><input type="checkbox" name="searchDo" id="c_do09" class="check01" value="경기도" title="9"/>
								<label for="c_do09">경기도</label></li>
						<li><input type="checkbox" name="searchDo" id="c_do010" class="check01" value="강원도" title="10"/>
								 <label for="c_do010">강원도</label></li>	
						<li><input type="checkbox" name="searchDo" id="c_do011" class="check01" value="충청북도" title="11"/>
								 <label for="c_do011">충청북도</label></li>
						<li><input type="checkbox" name="searchDo" id="c_do012" class="check01" value="충청남도" title="12"/>
								 <label for="c_do012">충청남도</label></li>
						<li><input type="checkbox" name="searchDo" id="c_do013" class="check01" value="전라북도" title="13"/>
								 <label for="c_do013">전라북도</label></li>
						<li><input type="checkbox" name="searchDo" id="c_do014" class="check01" value="전라남도" title="14"/>
								 <label for="c_do014">전라남도</label></li>
						<li><input type="checkbox" name="searchDo" id="c_do015" class="check01" value="경상북도" title="15"/>
								 <label for="c_do015">경상북도</label></li>	
						<li><input type="checkbox" name="searchDo" id="c_do016" class="check01" value="경상남도" title="16"/>
								 <label for="c_do016">경상남도</label></li>
						<li><input type="checkbox" name="searchDo" id="c_do017" class="check01" value="제주도" title="17"/>
								 <label for="c_do017">제주도</label></li>
					</ul>
				</div>
				
			</div>
			<button type="submit" class="b_blue" onclick="checkboxList()"><i class="btn_search">검색하기</i></button>
		</form>
	</div>
</li>
	

<c:forEach items = "${campinglist}" var = "camping" varStatus = "i">
<div class = "camping_search_list">
	<ul>
		<li style = "list-style : none;">
			<div class = "image" style = "float : left ; margin-right : 10px" >
				<a href = "campingdetail.do?contentid=${camping.contentid}">	
				<img src = "${camping.firstimageurl}" onerror="this.src='<%=request.getContextPath()%>/resources/image/csite_alt_image.png'"
				width = "300" height = "200"></a>
			</div>
			<div class = "camping_information" style = "float : left">
				<div class = "camping_site name">
					<h2 class = "camping_site_name">
						<a href = "campingdetail.do?contentid=${camping.contentid}">	
							${camping.facltnm}
						</a>
						<span class = "readcount" style = "font-size : 15px">조회수 : ${camping.readcount}</span>
						<span class = "readcount" style = "font-size : 15px">추천수 : ${camping.likecount}</span>
					</h2>
					
				</div>
				<c:set var="TextValue" value="${camping.addr1}"/>
				<c:choose>
					<c:when test = "${fn:length(camping.addr1)>40}">
						<c:set var = "string1" value = "${fn:substring(TextValue, 0,30)}"/>
						<h2>주소 :${string1}...</h2>
					</c:when>
					<c:otherwise>
						<h2>주소 :${camping.addr1}</h2>
					</c:otherwise>
				</c:choose>
				<c:if test="${camping.lineintro!='none'}">
					<h5>${camping.lineintro}</h5>
				</c:if>
				<c:if test="${camping.tel!='none'}">
					<h5>${camping.tel}</h5>
				</c:if>
				<c:choose>
					<c:when test="${camping.homepage eq 'none'}">
						홈페이지 준비중 
					</c:when>
					<c:otherwise>
						<button type = button onclick = "location.href ='${url}'">홈페이지</button>
					</c:otherwise>
				</c:choose>
				
			</div>
			<div style="clear:both"></div>
		</li>
	</ul>
</div>
</c:forEach>

<div class="container" style = "width : 100%; text-align : center">
    <div style = "display : inline-block">
	    <nav aria-label="Page navigation">
	        <ul class="pagination" id="pagination"></ul>
	    </nav>
    </div>
</div>
<br>
<script type="text/javascript">
$(document).ready(function () {
	
/* if(typeof jQuery == 'undefined'){
	console.log("not ready");
}else{
	console.log("ready");
} */

//페이지네이션
let totalCount = ${campingPage};	// 서버로부터 총글의 수를 취득
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
			//alert(page);
			location.href = "campinglist.do?pageNumber=" + (page - 1);
		}
	});
	  
	//정렬 바꾸면 업데이트순, 최신순, 조회순, 추천순으로 바뀌기
	$("#sorting").change(function(){ 
		$("#sortingval").val($("#sorting option:selected").val());
		console.log($("#sorting").val());
		$("#searchForm1").submit();
		//window.location = window.location.pathname;
	});
	
	//체크박스 체크된대로 그대로 유지 
/*  	$(function(){
	    var test = localStorage.input === 'true'? true: false;
	    $('input').prop('checked', test || false);
	});

	$('input').on('change', function() {
	    localStorage.input = $(this).is(':checked');
	    
	    console.log($(this).is(':checked'));
	});  */
	
/* 	$(function () {
		  $("input[name='searchDo']").each(function(i, checkbox) {   
		    if (localStorage['showing'+i] == 1) {
		      $(this).prop("checked", true);
		    }
		  }); 
		});
		 
		$("input[name='searchDo']").click(function () {
		    var no = $(this).index("input[name='searchDo']");
		    if ($(this).is(":checked")) {
		        localStorage.setItem("showing"+no, $(this).sval());
		    } else {
		        localStorage.removeItem("showing"+no);
		    }
		}); */
	// 시군구 셀렉트 태그 셋팅
	$("#c_do").change(function() {
		if ($("#c_do").val() != "") {
			$.ajax({
				type : 'get',
				url : 'campinglist.do',
				data : {
					'ctprvn_idx' : $("#c_do").val()
				},
				dataType : 'text',
				success : function(data) {
					$("#c_signgu").empty();
					var str = "<option value=''>전체</option>";
					var signguList = $.parseJSON(data);
					for ( var i in signguList.list) {
						str += "<option value='" + signguList.list[i].signgu_idx + "'>" + signguList.list[i].signgu_nm + "</option>"
					}
					$("#c_signgu").html(str);
				},
				error : function(error) {
					console.log("오류 발생");
				}
			});
		}
	});
		
		var chk_arr = $("input[name='searchDo']"); 
		var chk_data = []; 
		for(var i=0; i<chk_arr.length; i++) { 
			if(chk_arr[i].checked == true) { 
			chk_data.push(chk_arr[i].value); 
			} }
		console.log(chk_data);

}); //$(document).ready 끝나는 곳
</script>
</body>
</html>
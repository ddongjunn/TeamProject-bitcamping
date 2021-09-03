<%@ page language="java" contentType="text/html; charset=UTF-8"
       pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<nav id="qna" class="menu-nav">
   <ul>
      <li><a href="#">상품 선택</a></li>
      <li><a href="#content">상품 상세</a></li>
      <li><a href="#review">상품 리뷰</a></li>
      <li><a href="#qna" class="nav-selected">Q&A</a></li>
   </ul>
</nav>

<div id="qnacontent" class="qna-area">

   <div id="_qnaHeader">
   </div>

   <div id="_qnaContent">
   </div>

</div>

<nav aria-label="Page navigation" class="pagination-nav">
   <ul class="pagination justify-content-center" id="pagination2"></ul>
</nav>


<script type="text/javascript">

   $(document).ready(function () {
      qnaAjax();
   })

   function qnaAjax(pageNumber) {

      if(pageNumber === undefined){
         pageNumber = 0;
      }

      let header = "";
      let content = "";

      $.ajax({
         url : '/rent/detail-qna.do',
         type : 'post',
         dataType : 'json',
         data :  {'product_Seq' : searchParam('product_Seq') , 'pageNumber' : pageNumber },
         success : function (data) {


			header += '<div class="qna-count">'
            header += '문의 <span class="c_point">' + data.totalCount +'</span>개'
            header += '<span class="qna-write"><a href="javascript:writeqna();" >문의하기</a></span>'
            header += '</div>'
            $('#_qnaHeader').html(header);
			
			if(data.totalCount === 0){
				
				content += '<div class="qna-row">'
				content += '<div class="list-empty">작성된 문의글이 없습니다</div>'
				content += '</div>'
				
			} else {
				
	            $.each(data.qna, function (index, item) {
	               content += '<div class="qna-row">' // start <div=qna-row>
	               content += '<div id="statusbox" class="qna-status"">'
	               content +=   item.status === 0 ? '답변대기중' : '답변완료'
	               content += '</div>'
	
	               content += item.secret === 0  ?
	                     '<div id="qnatitle" onclick="showHideQna(' + item.qna_Seq + ')" class="qna-title">'
	                     :
	                     '<div id="qnatitle" onclick="noPermission(\'' + item.user_Id + '\', ' + item.qna_Seq + ')" class="qna-title">'  + '🔒'
	               content += item.title
	               content += '</div>'
	
	               content += '<div class="qna-info">'
	               content += '<div class="inner-info"><i class="fas fa-user-circle fa-sm"></i> ' + item.nickname + '<br>'
	               content += '<i class="far fa-calendar-alt fa-sm"></i> ' + item.wdate.substr(0,10) + '</div>'
	               content += '</div>'
	
	               content += '</div>' // end <div=qna-row>
	
	               content += '<div id="qnacontent' + item.qna_Seq + '" class="qna-content-box">'
	               content += '<div class="qna-content">'
	               content += item.content
	               content += '</div>'
	               
	               content += '<div id="qna_answer">'
	               if(item.status === 1){
	                  content += '<div class="qna-answer-row">'
	                  
	                  content += '<div class="qna-answer-icon">'
	                  content += ''
	                  content += '</div>'
	
	                  content += '<div class="qna-answer">' //답변내용
	                  content += '<span style="color: #75AE87; margin-right: 10px;"><i class="fas fa-arrow-right fa-sm"></i></span>' + item.answercontent
	                  content += '</div>'
	
	                  content += '<div class="qna-answer-info">'
	                  content += '<div class="inner-info"><i class="fas fa-user-circle fa-sm"></i> ' + '<span class="badge badge-pill badge-success">관리자</span>' + '<br>'
	                  content += '<i class="far fa-calendar-alt fa-sm"></i> ' + item.answerwdate.substr(0,10) + '</div>'
	                  content += '</div>'
	
	                  content += '</div>'
	               }
	               content += '</div>' // end <div=qna_answer>
	               
	               content += '</div>' // end <div=qna-content>
	            });
            
			}

            $('#_qnaContent').html(content);

            //pagination start
            let totalCount = data.totalCount;   // 서버로부터 총글의 수를 취득
            //alert(totalCount);

            let nowPage = data.nowPage;   // 서버로부터 현재 페이지를 취득
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
            if($('#pagination2').data("twbs-pagination")){
               $('#pagination2').twbsPagination('destroy');
            }

            $("#pagination2").twbsPagination({
               startPage : nowPage,
               totalPages : totalPages, //전체 페이지
               visiblePages: 10, //최대로 보여줄 페이지
               first: '<span sria-hidden="true">«</span>',
               prev: "이전",
               next: "다음",
               last: '<span sria-hidden="true">»</span>',
               initiateStartPageClick:false,
               onPageClick: function(event,page){
                  qnaAjax(page - 1);
               }
            });


         }, error : function () {

         }
      })
   }

   function writeQna() {
      qnaAjax();
   }

   function showHideQna(seq){

      if($("#qnacontent"+seq).css("display") == "none"){
         $("#qnacontent"+seq).show();
      }else{
         $("#qnacontent"+seq).hide();
      }
   }

   function noPermission(id, seq){

      if("${login.id}" == id || "${login.auth}" == 1){
         showHideQna(seq);
      } else {
         Swal.fire({
            icon: 'error',
            title: '접근 권한이 없습니다',
            text: '비밀글은 작성자와 관리자만 조회할 수 있습니다',
            didClose:() => {
               /*modalOn();*/
            }
         });
      }
   }

   /* 리뷰작성 popup open */
   function writeqna(){

      var product_Seq = ${item.product_Seq}; // 이부분 나중에 order_Seq 넣어주기
      var popupWidth = 480;
      var popupHeight = 520;

      var popupX = (window.screen.width / 2) - (popupWidth / 2);
      // 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

      var popupY= (window.screen.height / 2) - (popupHeight / 2);
      // 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음

      window.open("/rent/writeQna.do?product_Seq=" + product_Seq, "_blank", "location=no, status=no, resizable=no, height=" + popupHeight  + ", width=" + popupWidth  + ", left=" + popupX + ", top=" + popupY);
   }

   function searchParam(key) {
      return new URLSearchParams(location.search).get(key);
   }

</script>

</body>
</html>
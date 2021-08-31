<%@ page language="java" contentType="text/html; charset=UTF-8"
       pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>Insert title here</title>

   <style type="text/css">

      .qnatitle:hover {
         text-decoration: underline;
      }

   </style>

</head>
<body>

<nav id="qna">
   <ul>
      <li><a href="#">상품 선택</a></li>
      <li><a href="#content">상품 상세</a></li>
      <li><a href="#review">상품 리뷰</a></li>
      <li><a href="#qna">Q&A</a></li>
   </ul>
</nav>

<div id="qnacontent" style="height: auto; margin: auto; width: 80%; background-color: gray;">

   <div id="_qnaHeader">
   </div>

   <div id="_qnaContent">
   </div>

</div>

<nav aria-label="Page navigation">
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



            header += '<span>문의' + data.totalCount +'개</span>'
            header += '<span style="float:right;"><a href="javascript:writeqna();">문의하기</a></span>'
            $('#_qnaHeader').html(header);

            $.each(data.qna, function (index, item) {
               content += '<div class="qnarow" style="display: flex; background-color: #F7BBBB; ">' // start <div=qnarow>
               content += '<div id="statusbox" class="status" style="flex: 1 1 15%; padding: 10px; ">'
               content +=   item.status === 0 ? '답변대기중' : '답변완료'
               content += '</div>'

               content += item.secret === 0  ?
                     '<div id="qnatitle" onclick="showHideQna(' + item.qna_Seq + ')" class="qnatitle" style="flex: 1 1 65%; overflow: hidden; padding: 10px;" >'
                     :
                     '<div id="qnatitle" onclick="noPermission(\'' + item.user_Id + '\', ' + item.qna_Seq + ')" class="qnatitle" style="flex: 1 1 65%; overflow: hidden; padding: 10px;">'  + '🔒'
               content += item.title
               content +=   '</div>'

               content += '<div class="info" style="flex: 1 1 25%; padding: 10px;" >'
               content += '<span>작성자 : ' + item.nickname + '</span> <br>'
               content += '<span>작성일 : ' + item.wdate.substr(0,10) + '</span>'
               content += '</div>'

               content += '</div>' // end <div=qnarow>

               content += '<div id="qnacontent' + item.qna_Seq + '" class="qnacontent" style="height: auto; padding: 10px; display: none;" >'
               content += '<div style="background-color: #CDE8FD;">'
               content += item.content
               content += '</div id="qna_answer">'
               if(item.status === 1){
                  content += '<div class="qnarow" style="display: flex; background-color: #ffd600; ">'

                  content += '<div class="qna_answer" style="flex: 1 1 25%; padding: 10px 0 0 20px;">' //답변내용
                  content += item.answercontent
                  content += '</div>'

                  content += '<div style="background-color: #8CC63F;" >'
                  content += '<span>작성자 : ' + '관리자' + '</span> <br>'
                  content += '<span>작성일 : ' + item.answerwdate.substr(0,10) + '</span>'
                  content += '</div>'

                  content += '</div>'
               }
               content += '</div>'
            });

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
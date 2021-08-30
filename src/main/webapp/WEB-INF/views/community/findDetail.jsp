<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<table border="1" style="width: 700px">
<colgroup>
	<col style="width:30%;" />
	<col style="width:70%;" />
</colgroup>
<thead>
<tr>
	<th>작성자</th>
	<td>
		${data.nickname }
	</td>
</tr>
<tr>
	<th>작성날짜</th>
	<td>
	 	<fmt:parseDate value="${data.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
		<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd HH:mm"/>
	</td>
</tr>
<tr>
	<th>조회수</th>
	<td>
		${data.readcount }
	</td>
</tr>
<tr>
   <th>좋아요수</th>
   <td class="likeCount">
      ${likecount}
   </td>
</tr>
<tr>
	<th>제목</th>
	<td>
		${data.title }
	</td>
</tr>
<tr>
	<th>내용</th>
	<td>
		${data.content }
		
	</td>
</tr>

</thead>
</table>

<c:if test="${login.id eq data.user_id }">
	<form name="updateFrm" action="/community/findUpdate.do?bbstype=find" method="POST">
		<input type="hidden" name="community_seq" value="${data.community_seq}">
		<input type="hidden" name="user_id" value='${login.id}'>
		<button type="button" onclick="del(${data.community_seq})">삭제</button>
		<button type="button" onclick="update()">수정</button>	
	</form>
</c:if>

<c:choose>
   <c:when test="${data.liked_yn == 1 }">
      <span>
         <a href="javascript:" class="likeBtn">
            <img src="../resources/images/like.png" width="30" height="30">
         </a>
      </span>
   </c:when>
   <c:otherwise>
      <span>
         <a href="javascript:" class="likeBtn">
            <img src="../resources/images/delete_like.png" width="30" height="30">
         </a>   
      </span>
   </c:otherwise>
</c:choose>
<button type="button" onclick="location='/community/find.do'">목록</button>

<!-- 댓글 영역 시작 -->
<div class="container">
    <form id="commentForm" name="commentForm" method="post">
        <div>
            <div>
                <span><strong>Comments</strong></span> <span id="cCnt"></span>
            </div>
            <div>
                <table class="comment_table">                    
                    <tr>
                        <td>
                            <textarea style="width: 100%" rows="3" cols="30" id="comment" name="comment" placeholder="댓글을 입력하세요"></textarea>
                            <br>
                            <div style="margin: 5px; float: right;">
                                <a href="#none" id="addComment">등록</a>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <%-- <input type="hidden" id="b_code" name="b_code" value="${result.code }" /> --%>        
    </form>
</div>
<div class="container">
    <form id="commentListForm" name="commentListForm" method="post">
        <div id="commentList">
        </div>
    </form>
</div>

<div id="pagination-div">

</div>

<script type="text/javascript">

$(".likeBtn").click(function () {
    if(${login == null}) {
       Swal.fire({
          icon: 'warning',
          title: '로그인 후 이용해 주세요'
       })
       return;
    }

       $.ajax({
          url : '/community/likeClick.do',
          type : 'get',
          data : {
             'user_id' : '${login.id}',
             'community_seq' : '${data.community_seq}'
          },
          success : function(data) {

             if(data.result){
                $('.likeBtn').empty();
                $('.likeBtn').html('<img src="../resources/images/like.png" width="30" height="30">');
                $('.likeCount').html(data.likeCount);
                return;
             }
             $('.likeBtn').empty();
             $('.likeBtn').html('<img src="../resources/images/delete_like.png" width="30" height="30">');
             $('.likeCount').html(data.likeCount);

          },
          error : function() {
             alert('error');
          }
       });
 });

/* 글 삭제 알림 */
function del(community_seq){
	Swal.fire({
		  title: '삭제하시겠습니까?',
		  showDenyButton: true,
		  confirmButtonText: '삭제하기',
		  denyButtonText: '취소',
		}).then((result) => {
		  /* Read more about isConfirmed, isDenied below */
		  if (result.isConfirmed) {
			  location='/community/delete.do?community_seq=' + ${data.community_seq} + '&bbstype=find';
		  } else if (result.isDenied) {
		    return;
		  }
		})
}

/* 글 수정 알림 */
function update(){
	Swal.fire({
		  title: "수정하시겠습니까?",
		  showDenyButton: true,
		  confirmButtonText: '수정하기',
		  denyButtonText: '취소',
		}).then((result) => {
		  /* Read more about isConfirmed, isDenied below */
		  if (result.isConfirmed) {
			  javascript:document.updateFrm.submit();
		  } else if (result.isDenied) {
		    return;
		  }
		})
}

/* 댓글 불러오기 */
$(function(){
	commentList(); 
});
	
	/* 댓글 등록 */
	$("#addComment").on("click", function(){
  	var user_id;
      var community_seq = "${data.community_seq}"; // 글번호
      var content = $("#comment").val(); // 댓글내용
      var page
      
      // 로그인 여부 검사
      if(${login == null}) {
  		Swal.fire({
  			  icon: 'warning',
  			  title: '로그인 후 이용해 주세요'
  		});
      } else if(content == null || content == ""){
  		Swal.fire({
			  icon: 'warning',
			  title: '내용을 입력해 주세요'
			});
      } else {
      	// Session에서 회원 번호를 얻어옴.
          // ""를 하지 않으면 변수명 처럼 인식됨
          user_id = "${login.id}";
          // 자바 스크립트 객체 방식으로 작성
          
          $.ajax({
          	url : "/community/writeComment.do",
              type : "POST",
              data : {"content" : content,
              		"community_seq" : community_seq,
                      "user_id" : user_id},
              success : function(result){
              	var msg;
                  
                  switch(result) {
                  case 1 :  //성공
                  	msg = "댓글 등록 성공";
                      // 내용을 작성한 textarea를 다 지워줌
                      $("#comment").val("");
                      
                      commentList();
                      location.reload();
                      
                      break;
                      
                  case 0 :  //등록실패
                  	msg = "댓글 등록 실패";
                  
              		Swal.fire({
            			  icon: 'error',
            			  title: '댓글 등록에 실패했습니다'
            			});
              		
                      break;
                  case -1 :
                  	msg = "댓글 등록 오류 발생";
                  	
                  	Swal.fire({
            			  icon: 'error',
            			  title: '댓글 등록 중 오류가 발생했습니다'
            			});
                      break;
                  }
                  
                
              },
              error : function(){
              	console.log("ajax 통신 실패");
              	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
              }
          });
      }
  });

  
  // 댓글 목록 조회 함수
  function commentList(pageNumber) {
  	
  	
  	var community_seq = "${data.community_seq}";
  	pageNumber = (typeof pageNumber == "undefined") ? 0 : pageNumber;
      
      $.ajax({
      	url : "/community/commentList.do",
          type : "POST",
          data : {"community_seq" : community_seq,
          		"pageNumber" : pageNumber},
          dataType : "json", 
          success : function(data){
          	
          	var html = "";
          	var test = "";
              var cCnt = data.totalCount;
          	pageNumber += 1;

           	/* 댓글 페이징 */ 
          	let totalCount = data.totalCount;
          	let nowPage = pageNumber;
        	if(totalCount === 0){
                totalCount = 1;
            }
          	let pageSize = 10;
          	let _totalPages = totalCount / pageSize;
          	
       

          	if(totalCount % pageSize > 0){
          		_totalPages++;  
          	}
             	
          	// nowPageJS = pageNumber;            	            	
          	
          	$("#pagination-div").twbsPagination({
          		startPage: nowPage,
          		totalPages: _totalPages,
          		visiblePages: 10,
          		first:'<span sria-hidden="true">«</span>',
          		prev:"이전",
          		next:"다음",
          		last:'<span sria-hidden="true">»</span>',
          		initiateStartPageClick:false,		// onPageClick 자동 실행되지 않도록 한다
          		onPageClick:function(event, page){
          			commentList(page -1);
          		}
          	}); 

              /* 댓글 list 출력*/ 
              if(data.comment.length > 0){
                  
                  for(i=0; i<data.comment.length; i++){
                  	
                  	var wdate = (data.comment[i].wdate).substr(0, 16);
                  	wdate = wdate.replace(/-/gi, "/");
                  	
                      html += "<div>";
                      html += "<table class='comment_table'>";
                      html += "<tr><td>";
                      
                      /* 댓글 내용 div */
                      if(data.comment[i].depth == 0){
                      	html += "<h5><span style='color: tomato'>"+data.comment[i].nickname+"</span></h5>";
                          html += "<h6>" + wdate + "</h6>";
                         	html += "<div id='cmt"+data.comment[i].comment_seq+"'>";
	                        html += "<div>"+data.comment[i].content+"</div>";
                      
                      /* 대댓글 내용 div */
                      }else{
                      	html += "<div style='float: left;'>ㄴ</div>";
                      	html += "<div id='cmt"+data.comment[i].comment_seq+"' style='margin-left: 15px;'><h5><span style='color: tomato'>"+data.comment[i].nickname+"</span></h5>";
                          html += "<h6>"+wdate+"</h6>";
                          html += "<div>"+data.comment[i].content+"</div>";
                      }
                      
                      /* 수정, 삭제, 답글 div */
                      html += "<div><h5>";                        
                      if('${login.id}' === data.comment[i].user_id){         	
	                        html += "<span style='margin: 5px;'><a href='javascript:showUpdate("+data.comment[i].comment_seq+");'>수정</a></span>";
	                        html += "<span style='margin: 5px;'><a href='javascript:commentDelete("+data.comment[i].comment_seq+");'>삭제</a></span>";
                      }                        
                      html += "<span style='margin: 5px; float: right;'><a href='javascript:showAnswer("+data.comment[i].comment_seq+");'>답글</a></span>";
                      html += "</h5></div>";
                      html += "</div>"; // 댓글 내용 div 여기서 끝
                      
                      /* 대댓글 입력창 div */
                      html += "<div id='answerbox"+data.comment[i].comment_seq+"' style='display: none;'>";
                      html += "<h5><span style='color: tomato'>"+data.comment[i].nickname+"</span></h5>";
                      html += "<textarea style='width: 100%' rows='3' cols='30' id='answer"+data.comment[i].comment_seq+"' placeholder='댓글을 입력하세요'></textarea>";
                      html += "<div style='float: right;'><h5>";
                      html += "<span style='margin: 5px;'><a href='javascript:commentAnswer("+data.comment[i].comment_seq+");'>등록</a></span>";
                      html += "<span style='margin: 5px;'><a href='javascript:showAnswer("+data.comment[i].comment_seq+");'>취소</a></span>";
                      html += "</h5></div>";
                      html += "</div>";
                      
                      /* 댓글 수정창 div */
                      html += "<div id='updatebox"+data.comment[i].comment_seq+"' style='display: none;'>";
                      html += "<textarea style='width: 100%' rows='3' cols='30' id='update"+data.comment[i].comment_seq+"' placeholder='댓글을 입력하세요'>"+data.comment[i].content+"</textarea>";
                      html += "<div style='float: right;'><h5>";
                      html += "<span style='margin: 5px;'><a href='javascript:commentUpdate("+data.comment[i].comment_seq+");'>등록</a></span>";
                      html += "<span style='margin: 5px;'><a href='javascript:showUpdate("+data.comment[i].comment_seq+");'>취소</a></span>";
                      html += "</h5></div>";
                      html += "</div>";
                      
                      html += "</td></tr>";
                      html += "</table>";
                      html += "</div>";
                  }
                  
                 /* pn += "<nav aria-label='Page navigation'>";
                  pn += "<ul class='pagination' id='pagination' style='justify-content:center;'></ul>";
                  pn += "</nav>"; */
                  
             
                  
                  
              } else {             
              	/* 댓글 없을 때 */
                  /* html += "<div>";
                  html += "<table class='comment_table'><h5><strong>등록된 댓글이 없습니다.</strong></h5>";
                  html += "</table>";
                  html += "</div>"; */    
              }
          	
              $("#cCnt").html(cCnt);
              $("#commentList").html(html);
				//$("#paginationbox").html(pn);
				
				
				test += '<div id="pagination-div">';
                  test += '</div>';
               
               $("#test").html(test);
				
              
          },
          error : function(request, status, error){
          	console.log("댓글 목록 조회 ajax 통신 실패");
          	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
          }
      });
  } 
  
   /* 답글창 펼치기, 접기 */
  function showAnswer(comment_seq){
  	
  	if(${login == null}) {
  		Swal.fire({
			  icon: 'warning',
			  title: '로그인 후 이용해 주세요'
			});
      } else {
  	
			if($("#answerbox" + comment_seq).css("display") == "none"){
				$("#answerbox" + comment_seq).show();
			}else{
				$("#answerbox" + comment_seq).hide();
			}
      }
  }
   
   /* 답글 내용 등록 */
	function commentAnswer(comment_seq){
  	
  	var user_id;
      var community_seq = "${data.community_seq}"; // 글번호
      var content = $("#answer" + comment_seq).val(); // 댓글내용
      
      // 로그인 여부 검사
      if(${login == null}) {
  		Swal.fire({
  			  icon: 'warning',
  			  title: '로그인 후 이용해 주세요'
  		});
      } else if(content == null || content == ""){
  		Swal.fire({
			  icon: 'warning',
			  title: '내용을 입력해 주세요'
			});
      }  else {
      	// Session에서 회원 번호를 얻어옴.
          // ""를 하지 않으면 변수명 처럼 인식됨
          user_id = "${login.id}";
          // 자바 스크립트 객체 방식으로 작성
          
          $.ajax({
          	url : "/community/answerComment.do",
              type : "POST",
              data : {"content" : content,
              		"community_seq" : community_seq,
                      "user_id" : user_id,
                      "comment_seq" : comment_seq},
              success : function(result){
              	var msg;
                  
                  switch(result) {
                  case 1 :  //성공
                  	// msg = "대댓글 등록 성공";
                      // 내용을 작성한 textarea를 다 지워줌
                      $("#answer" + comment_seq).val("");
                      commentList(); // commnetList()함수 호출
                      break;
                      
                  case 0 :  //등록실패
              		Swal.fire({
              			icon: 'error',
              			title: '댓글 등록에 실패했습니다'
              		});
                      break;
                  case -1 :
                  	Swal.fire({
              			icon: 'error',
              			title: '댓글 등록 중 오류가 발생했습니다'
              		});
                      break;
                  }
                  
                  // alert(msg);
              },
              error : function(){
              	console.log("ajax 통신 실패");
              }
          });
      }
  } 
  
   function showUpdate(comment_seq){
  	
  	if(${login == null}) {
  		Swal.fire({
			  icon: 'warning',
			  title: '로그인 후 이용해 주세요'
			});
      } else {
  	
			if($("#updatebox" + comment_seq).css("display") == "none"){				
				$("#updatebox" + comment_seq).show();
				$("#cmt" + comment_seq).hide();
			}else{
				$("#updatebox" + comment_seq).hide();
				$("#cmt" + comment_seq).show();
			}
      }    	
  }
   
   function commentUpdate(comment_seq){	
  	
      var content = $("#update" + comment_seq).val(); // 댓글내용
      
  	$.ajax({
      	url : "/community/updateComment.do",
          type : "POST",
          data : {"content" : content,
                  "comment_seq" : comment_seq},
          success : function(result){
          	var msg;
              
              switch(result) {
              case 1 :  //성공
              	msg = "댓글 수정 성공";
                  commentList(); // commnetList()함수 호출
                  break;
                  
              case 0 :  //등록실패
              	msg = "댓글 수정 실패";
              
              	Swal.fire({
          			icon: 'error',
          			title: '댓글 수정에 실패했습니다'
          		});
              	
                  break;
              case -1 :
              	msg = "댓글 수정 오류 발생";
              	
              	Swal.fire({
          			icon: 'error',
          			title: '댓글 수정 중 오류가 발생했습니다'
          		});
              	
                  break;
              }
              
              // alert(msg);
          },
          error : function(){
          	console.log("ajax 통신 실패");
          }
      });
  } 
  
   function commentDelete(comment_seq){
  	
      if(${login == null}) {
  		Swal.fire({
  			  icon: 'warning',
  			  title: '로그인 후 이용해 주세요'
  		});
      } else {
      	
      	Swal.fire({
			  title: '삭제하시겠습니까?',
			  showCancelButton: true,
			  confirmButtonText: '삭제하기',
			  denyButtonText: '취소',
			}).then((result) => {
			  if (result.isConfirmed) {
				
		   		$.ajax({
		       		url : "/community/deleteComment.do",
					type : "POST",
					data : {"comment_seq" : comment_seq},
					success : function(result){
		           	var msg;
		               
		               switch(result) {
		               case 1 :  //성공
		               	msg = "댓글 삭제 성공";
		                   commentList();
		                   break;
		                   
		               case 0 :  //등록실패
		               	msg = "댓글 삭제 실패";
		               
		             	 Swal.fire({
            				icon: 'error',
            				title: '댓글 삭제에 실패했습니다'
            			});
		              
		                   break;
		               case -1 :
		               	msg = "댓글 삭제 오류 발생";
		               	
	  		            Swal.fire({
	              			icon: 'error',
	              			title: '댓글 삭제 중 오류가 발생했습니다'
	              		});
		              
		                   break;
		               }
		               
		               // alert(msg);
		           },
		           error : function(){
						console.log("ajax 통신 실패");
		           }
		       });	
				  
			  } else if (result.isDenied) {
			    return;
			  }
			});
      }
  } 
</script>

</body>
</html>
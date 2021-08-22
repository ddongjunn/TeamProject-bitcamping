<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.noticedetail{
	width: 85%;
}
.noticedetail > tr, td{
	padding: 10px 10px;
	border: 1px solid;
}
.container{
	width: 85%;
	margin-top: 15px;
}
.comment_table{
	width: 100%;
	margin: auto;
}
</style>
</head>
<body>

<table class="noticedetail">
	<tbody>
		<tr>
			<td>
				<span>${notice.title}</span>
			</td>
		</tr>
		<tr>
			<td>
				<span>${notice.nickname}</span>
			</td>
		</tr>
		<tr>
			<td>
				<fmt:parseDate value="${notice.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd"/>
			</td>
		</tr>
		<tr>
			<td>
				<span>조회수 ${notice.readcount}</span>
			</td>
		</tr>
		<c:if test="${not empty notice.filename}">
			<tr>
				<td>
					<span>
						💾 <a href="javascript:filedown('${notice.newfilename}', '${notice.notice_Seq}', '${notice.filename}')">${notice.filename}</a> 
						(${notice.downcount}회 다운)
					</span>
				</td>
			</tr>	
		</c:if>
		<tr>
			<td>
				<span id="text">${notice.content}</span>
			</td>
		</tr>
	</tbody>
</table>

<c:if test="${login.id eq notice.user_Id}">
	<div id="buttons_wrap">
		<button type="button" id="btnUpdate" onclick="location.href='/cs/noticeUpdate.do?notice_Seq=${notice.notice_Seq}'">수정</button>
		<button type="button" id="btnDelete" onclick="confirm()">삭제</button>	
	</div>
</c:if>

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

<form name="file_Down" action="/cs/fileDownload.do" method="post">
	<input type="hidden" name="newfilename">
	<input type="hidden" name="filename">
	<input type="hidden" name="seq">
</form>

<script type="text/javascript">

/* 	$(document).ready(function(){
		var text = $("#text").text();
		
		console.log(text);
	}) */

	var myVar;
	
	function filedown(newfilename, seq, filename) {
		let doc = document.file_Down;
		doc.newfilename.value = newfilename;
		doc.filename.value = filename;
		doc.seq.value = seq;
		doc.submit();	
		
		myVar = setTimeout(_refrush, 10);
	}	
	
	function _refrush() {
		location.reload();
		clearTimeout(myVar);
	}
	
	function confirm(){
		Swal.fire({
			  title: '삭제하시겠습니까?',
			  /* text: '정말로요?', */
			  showCancelButton: true,
			  confirmButtonText: '삭제하기',
			  denyButtonText: '취소',
			}).then((result) => {
			  /* Read more about isConfirmed, isDenied below */
			  if (result.isConfirmed) {
			    /* Swal.fire('삭제되었습니다', '', 'success'); */
			    location.href="/cs/noticeDelete.do?notice_Seq=${notice.notice_Seq}";
			  } else if (result.isDenied) {
			    return;
			  }
			})
	}
	
	
	/* 댓글 등록 */
	$("#addComment").on("click", function(){
    	var user_Id;
        var notice_Seq = "${notice.notice_Seq}"; // 글번호
        var content = $("#comment").val(); // 댓글내용
        
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
            user_Id = "${login.id}";
            // 자바 스크립트 객체 방식으로 작성
            
            $.ajax({
            	url : "/cs/writeComment.do",
                type : "POST",
                data : {"content" : content,
                		"notice_Seq" : notice_Seq,
                        "user_Id" : user_Id},
                success : function(result){
                	var msg;
                    
                    switch(result) {
                    case 1 :  //성공
                    	msg = "댓글 등록 성공";
                        // 내용을 작성한 textarea를 다 지워줌
                        $("#comment").val("");
                        commentList(); // commnetList()함수 호출
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
                    
                    // alert(msg);
                },
                error : function(){
                	console.log("ajax 통신 실패");
                }
            });
        }
    });
    
    // 댓글 목록 조회 함수
    function commentList() {
    	var notice_Seq = "${notice.notice_Seq}";
        
        $.ajax({
        	url : "/cs/commentList.do",
            type : "POST",
            data : {"notice_Seq" : notice_Seq},
            dataType : "json",
            success : function(data){
            	                
            	var html = "";
                var cCnt = data.length;
                
                if(data.length > 0){
                    
                    for(i=0; i<data.length; i++){
                    	
                    	var wdate = (data[i].wdate).substr(0, 16);
                    	wdate = wdate.replace(/-/gi, "/");
                    	
                        html += "<div>";
                        html += "<table class='comment_table'>";
                        html += "<tr><td>";
                        
                        /* 댓글 내용 div */
                        if(data[i].depth == 0){
                        	html += "<h5><span style='color: tomato'>"+data[i].nickname+"</span></h5>";
                            html += "<h6>" + wdate + "</h6>";
                           	html += "<div id='cmt"+data[i].comment_Seq+"'>";
	                        html += "<div>"+data[i].content+"</div>";
                        
                        /* 대댓글 내용 div */
                        }else{
                        	html += "<div style='float: left;'>ㄴ</div>";
                        	html += "<div id='cmt"+data[i].comment_Seq+"' style='margin-left: 15px;'><h5><span style='color: tomato'>"+data[i].nickname+"</span></h5>";
                            html += "<h6>"+wdate+"</h6>";
                            html += "<div>"+data[i].content+"</div>";
                        }
                        
                        /* 수정, 삭제, 답글 div */
                        html += "<div><h5>";                        
                        if('${login.id}' === data[i].user_Id){         	
	                        html += "<span style='margin: 5px;'><a href='javascript:showUpdate("+data[i].comment_Seq+");'>수정</a></span>";
	                        html += "<span style='margin: 5px;'><a href='javascript:commentDelete("+data[i].comment_Seq+");'>삭제</a></span>";
                        }                        
                        html += "<span style='margin: 5px; float: right;'><a href='javascript:showAnswer("+data[i].comment_Seq+");'>답글</a></span>";
                        html += "</h5></div>";
                        html += "</div>"; // 댓글 내용 div 여기서 끝
                        
                        /* 대댓글 입력창 div */
                        html += "<div id='answerbox"+data[i].comment_Seq+"' style='display: none;'>";
                        html += "<h5><span style='color: tomato'>"+data[i].nickname+"</span></h5>";
                        html += "<textarea style='width: 100%' rows='3' cols='30' id='answer"+data[i].comment_Seq+"' placeholder='댓글을 입력하세요'></textarea>";
                        html += "<div style='float: right;'><h5>";
                        html += "<span style='margin: 5px;'><a href='javascript:commentAnswer("+data[i].comment_Seq+");'>등록</a></span>";
                        html += "<span style='margin: 5px;'><a href='javascript:showAnswer("+data[i].comment_Seq+");'>취소</a></span>";
                        html += "</h5></div>";
                        html += "</div>";
                        
                        /* 댓글 수정창 div */
                        html += "<div id='updatebox"+data[i].comment_Seq+"' style='display: none;'>";
                        html += "<textarea style='width: 100%' rows='3' cols='30' id='update"+data[i].comment_Seq+"' placeholder='댓글을 입력하세요'>"+data[i].content+"</textarea>";
                        html += "<div style='float: right;'><h5>";
                        html += "<span style='margin: 5px;'><a href='javascript:commentUpdate("+data[i].comment_Seq+");'>등록</a></span>";
                        html += "<span style='margin: 5px;'><a href='javascript:showUpdate("+data[i].comment_Seq+");'>취소</a></span>";
                        html += "</h5></div>";
                        html += "</div>";
                        
                        html += "</td></tr>";
                        html += "</table>";
                        html += "</div>";
                    }
                    
                } else {                    
                   /*  html += "<div>";
                    html += "<table class='comment_table'><h5><strong>등록된 댓글이 없습니다.</strong></h5>";
                    html += "</table>";
                    html += "</div>";    */
                }
                
                $("#cCnt").html(cCnt);
                $("#commentList").html(html);
                
            },
            error : function(request, status, error){
            	console.log("댓글 목록 조회 ajax 통신 실패");
            	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    }
    
    /* 답글창 펼치기, 접기 */
    function showAnswer(comment_Seq){
    	
    	if(${login == null}) {
    		Swal.fire({
  			  icon: 'warning',
  			  title: '로그인 후 이용해 주세요'
  			});
        } else {
    	
			if($("#answerbox" + comment_Seq).css("display") == "none"){
				$("#answerbox" + comment_Seq).show();
			}else{
				$("#answerbox" + comment_Seq).hide();
			}
        }
    }
    
    /* 답글 내용 등록 */
	function commentAnswer(comment_Seq){
    	
    	var user_Id;
        var notice_Seq = "${notice.notice_Seq}"; // 글번호
        var content = $("#answer" + comment_Seq).val(); // 댓글내용
        
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
            user_Id = "${login.id}";
            // 자바 스크립트 객체 방식으로 작성
            
            $.ajax({
            	url : "/cs/answerComment.do",
                type : "POST",
                data : {"content" : content,
                		"notice_Seq" : notice_Seq,
                        "user_Id" : user_Id,
                        "comment_Seq" : comment_Seq},
                success : function(result){
                	var msg;
                    
                    switch(result) {
                    case 1 :  //성공
                    	// msg = "대댓글 등록 성공";
                        // 내용을 작성한 textarea를 다 지워줌
                        $("#answer" + comment_Seq).val("");
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
    
    function showUpdate(comment_Seq){
    	
    	if(${login == null}) {
    		Swal.fire({
  			  icon: 'warning',
  			  title: '로그인 후 이용해 주세요'
  			});
        } else {
    	
			if($("#updatebox" + comment_Seq).css("display") == "none"){				
				$("#updatebox" + comment_Seq).show();
				$("#cmt" + comment_Seq).hide();
			}else{
				$("#updatebox" + comment_Seq).hide();
				$("#cmt" + comment_Seq).show();
			}
        }    	
    }
    
    function commentUpdate(comment_Seq){	
    	
        var content = $("#update" + comment_Seq).val(); // 댓글내용
        
    	$.ajax({
        	url : "/cs/updateComment.do",
            type : "POST",
            data : {"content" : content,
                    "comment_Seq" : comment_Seq},
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
    
    function commentDelete(comment_Seq){
    	
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
  		       		url : "/cs/deleteComment.do",
  					type : "POST",
  					data : {"comment_Seq" : comment_Seq},
  					success : function(result){
  		           	var msg;
  		               
  		               switch(result) {
  		               case 1 :  //성공
  		               	msg = "댓글 삭제 성공";
  		                   commentList(); // commnetList()함수 호출
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
    
  	$(function(){
  		commentList();
        
/*         // 10초마다 댓글 갱신
        setInterval(function(){
        	commentList
        }, 10000); */
    });
  	
  	
 
  	
</script>

</body>
</html>
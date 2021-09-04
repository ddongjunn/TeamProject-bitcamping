<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
</head>
<body>

<div class="postpath">
	<span>
		<a href="/main.do"><span style="font-size: 18px;"><i class="fas fa-home fa-sm"></i></span></a> > 
		<a href="/cs/csMain.do">고객센터</a> > 
		<a href="/cs/notice.do">공지사항</a> > 
		<a href="/cs/noticeDetail.do?notice_Seq=${notice.notice_Seq}" style="color: #75AE87;">${notice.notice_Seq}</a>
	</span>
</div>

<div class="postarea">
	<table class="tabledetail">
		<tbody>
			<tr>
				<td class="detailtitle">
					<span>${notice.title}</span>
				</td>
			</tr>
			<tr>
				<td class="detailinfo">
					<span><i class="fas fa-user-circle fa-sm"></i> ${notice.nickname}</span>
					<span>
						<i class="far fa-calendar-alt fa-sm"></i>
						 <fmt:parseDate value="${notice.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd"/>
					</span>
					<span><i class="far fa-eye"></i> ${notice.readcount}</span>
					<hr>
				</td>
			</tr>
			<c:if test="${not empty notice.filename}">
				<tr>
					<td>
						<i class="fas fa-save fa-sm"></i>
						<a href="javascript:filedown('${notice.newfilename}', '${notice.notice_Seq}', '${notice.filename}')">
							<span class="detailfilename"> ${notice.filename}</span>
						</a> 
						(${notice.downcount}회 다운)
						<hr>
					</td>
				</tr>	
			</c:if>
			<tr>
				<td class="detailcontent">
					<span id="text">${notice.content}</span>
				</td>
			</tr>
		</tbody>
	</table>
</div>
	
<c:if test="${login.id eq notice.user_Id}">
	<div class="buttons_wrap" id="buttons_wrap">
		<button type="button" class="btnSimple" id="btnUpdate" onclick="location.href='/cs/noticeUpdate.do?notice_Seq=${notice.notice_Seq}'">수정</button>
		<button type="button" class="btnSimple" id="btnDelete" onclick="confirm()">삭제</button>	
	</div>
</c:if>
<!-- 댓글 영역 시작 -->
<div class="commentarea">
    <form id="commentForm" name="commentForm" method="post">
        <div>
            <div class="commentcountarea">
                <span style="margin-left: 20px;"><i class="fas fa-comment-dots"> </i><strong> 댓글</strong></span> <span id="cCnt"></span>
            </div>
            <div>
                <table class="comment_table">                    
                    <tr>
                        <td class="commentwritearea">
                            <textarea class="commenttextarea" rows="3" cols="30" id="comment" name="comment" placeholder="댓글을 입력하세요"></textarea>
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
<div class="commentlistarea">
    <form id="commentListForm" name="commentListForm" method="post">
        <div class="commentlist" id="commentList" >
        </div>
    </form>
</div>

<div id="pagination-div" >

</div> 




<form name="file_Down" action="/cs/fileDownload.do" method="post">
	<input type="hidden" name="newfilename">
	<input type="hidden" name="filename">
	<input type="hidden" name="seq">
</form>

<script type="text/javascript">
	
	// let pageNumJS;
	// let nowPageJS;


	/* 파일 다운로드 */
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
	
	/* 글 삭제 알림 */
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
	
	/* 댓글 불러오기 */
	$(function(){
  		commentList();
/*         // 10초마다 댓글 갱신
        setInterval(function(){
        	commentList
        }, 10000); */
    });
	
	/* 댓글 등록 */
	$("#addComment").on("click", function(){
    	var user_Id;
        var notice_Seq = "${notice.notice_Seq}"; // 글번호
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
                }
            });
        }
    });
    
    // 댓글 목록 조회 함수
    function commentList(pageNumber) {
    	
    	
    	var notice_Seq = "${notice.notice_Seq}";
    	pageNumber = (typeof pageNumber == "undefined") ? 0 : pageNumber;
        
        $.ajax({
        	url : "/cs/commentList.do",
            type : "POST",
            data : {"notice_Seq" : notice_Seq,
            		"pageNumber" : pageNumber},
            dataType : "json",
            success : function(data){
            	
            	
            	
            	var html = "";
            	var test = "";
                var cCnt = data.totalCount;
            	pageNumber += 1;

         
              	/* 댓글 페이징 */
            	let totalCount = data.totalCount;
            	if(totalCount === 0){
            		totalCount = 1;
            	}
            	
            	let nowPage = pageNumber;
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

                /* 댓글 list 출력 */
                if(data.comment.length > 0){
                    
                    for(i=0; i<data.comment.length; i++){
                    	
                    	var wdate = (data.comment[i].wdate).substr(0, 16);
                    	wdate = wdate.replace(/-/gi, "/");
                    	
                        html += "<div>";
                        html += "<table class='comment_table'>";
                        html += "<tr><td>";
                        
                        /* 댓글 내용 div */
                        if(data.comment[i].depth == 0){
                        	if(data.comment[i].del == 0){
	                        	html += "<span style='color: black; font-weight: bold;'>"+data.comment[i].nickname+"</span>";
	                        	html += "<span style='margin: 0 5px 5px 0; float: right;'><a href='javascript:showAnswer("+data.comment[i].comment_Seq+");'>답글</a></span>";
	                            html += "<span style='color: #ABABAB; font-size: 13px; margin-left: 10px;'>" + wdate + "</span>";
	                           	html += "<div id='cmt"+data.comment[i].comment_Seq+"'>";
		                        html += "<div style='margin: 10px 0; font-weight: bold;'>"+data.comment[i].content+"</div>";
                        	}else{
		                    	html += "<span style='color: black; font-weight: bold;'>"+data.comment[i].nickname+"</span>";
	                        	html += "<span style='margin: 0 5px 5px 0; float: right;'><a href='javascript:showAnswer("+data.comment[i].comment_Seq+");'>답글</a></span>";
	                            html += "<span style='color: #ABABAB; font-size: 13px; margin-left: 10px;'>" + wdate + "</span>";
	                           	html += "<div id='cmt"+data.comment[i].comment_Seq+"'>";
		                        html += "<div style='margin: 10px 0; color: #ABABAB;'>삭제된 댓글입니다</div>";
		                    }
                        /* 대댓글 내용 div */
                        }else{
                        	if(data.comment[i].del == 0){
                        		html += "<div style='float: left; color: #75AE87; margin-right: 5px;'><i class='fas fa-arrow-right fa-sm'></i></div>";
                            	html += "<span style='color: black; font-weight: bold;'>"+data.comment[i].nickname+"</span>";
                                html += "<span style='color: #ABABAB; font-size: 13px; margin-left: 10px;'>"+wdate+"</span>";
                            	html += "<div id='cmt"+data.comment[i].comment_Seq+"' style='margin-left: 15px;'>";
                                html += "<div style='margin: 10px 0; font-weight: bold;'>"+data.comment[i].content+"</div>";
                        	}else{
                        		html += "<div style='float: left; color: #75AE87; margin-right: 5px;'><i class='fas fa-arrow-right fa-sm'></i></div>";
                            	html += "<span style='color: black; font-weight: bold;'>"+data.comment[i].nickname+"</span>";
                                html += "<span style='color: #ABABAB; font-size: 13px; margin-left: 10px;'>"+wdate+"</span>";
                            	html += "<div id='cmt"+data.comment[i].comment_Seq+"' style='margin-left: 15px;'>";
                                html += "<div style='margin: 10px 0; color: #ABABAB;'>삭제된 댓글입니다</div>";
		                    }                        	
                        }
                        
                        /* 수정, 삭제 버튼 div */
                        html += "<div style='text-align: right;'";                        
                        if('${login.id}' === data.comment[i].user_Id && data.comment[i].del == 0){         	
	                        html += "<span style='margin: 5px;'><a href='javascript:showUpdate("+data.comment[i].comment_Seq+");'>수정</a></span>";
	                        html += "<span style='margin: 5px;'><a href='javascript:commentDelete("+data.comment[i].comment_Seq+");'>삭제</a></span>";
                        }                        
                        html += "</div>";
                        html += "<hr style='margin-bottom: 0'>";
                        html += "</div>"; // 댓글 내용 div 여기서 끝
                        
                        /* 댓글 수정창 div */
                        html += "<div id='updatebox"+data.comment[i].comment_Seq+"' style='display: none;'>";
                        html += "<textarea class='commenttextarea' style='margin: 5px' rows='3' cols='30' id='update"+data.comment[i].comment_Seq+"' placeholder='댓글을 입력하세요'>"+data.comment[i].content+"</textarea>";
                        html += "<div style='float: right; margin: 5px;'>";
                        html += "<span style='margin: 5px;'><a href='javascript:commentUpdate("+data.comment[i].comment_Seq+");'>등록</a></span>";
                        html += "<span style='margin: 5px;'><a href='javascript:showUpdate("+data.comment[i].comment_Seq+");'>취소</a></span>";
                        html += "</div>";
                        html += "</div>";
                        
                        /* 대댓글 입력창 div */
                        html += "<div class='commentanswerarea' id='answerbox"+data.comment[i].comment_Seq+"' style='display: none;'>";
                        html += "<span style='float: left; color: #75AE87; margin-right: 5px;'><i class='fas fa-arrow-right fa-sm'></i></span>"
                        html += "<span style='color: black; font-weight: bold;'>"+data.comment[i].nickname+"</span>";
                        html += "<textarea class='commenttextarea' style='margin: 5px' rows='3' cols='30' id='answer"+data.comment[i].comment_Seq+"' placeholder='댓글을 입력하세요'></textarea>";
                        html += "<div style='float: right; margin: 5px;'>";
                        html += "<span style='margin: 5px;'><a href='javascript:commentAnswer("+data.comment[i].comment_Seq+");'>등록</a></span>";
                        html += "<span style='margin: 5px;'><a href='javascript:showAnswer("+data.comment[i].comment_Seq+");'>취소</a></span>";
                        html += "</div>";
                        html += "<hr style='margin: 30px 0 0 0;'>";
                        html += "</div>";
                        
                        html += "</td></tr>";
                        html += "</table>";
                        html += "</div>";
                    }
                    
/*                     pn += "<nav aria-label='Page navigation'>";
                    pn += "<ul class='pagination' id='pagination' style='justify-content:center;'></ul>";
                    pn += "</nav>"; */
                    
               
                    
                    
                } else {             
                	/* 댓글 없을 때 */
                   /*  html += "<div>";
                    html += "<table class='comment_table'><h5><strong>등록된 댓글이 없습니다.</strong></h5>";
                    html += "</table>";
                    html += "</div>";    */
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
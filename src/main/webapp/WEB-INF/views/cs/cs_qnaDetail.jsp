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
<div class="qnabox">
	<h4>Question</h4>
	<table class="tabledetail">
		<tbody>
			<tr>
				<td class="detailtitle">
					<span>${qna.title}</span>
				</td>
			</tr>
			<tr>
				<td>
					<span>${qna.nickname}</span>
				</td>
			</tr>
			<tr>
				<td>
					<span>조회수 ${qna.readcount}</span>
				</td>
			</tr>
			<tr>
				<td>
				 	<fmt:parseDate value="${qna.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd HH:mm"/>
				</td>
			</tr>
			<tr>
				<td style="min-height: 500px;">
					<span>${qna.content}</span>
				</td>
			</tr>
		</tbody>
	</table>
	
	<c:if test="${qna.status eq 1}">
		<h4>ㄴAnswer</h4>
		<table class="qnadetail">
		<tbody>
			<tr>
				<td>
					<span>${answer.title}</span>
				</td>
			</tr>
			<tr>
				<td>
					<span>${answer.nickname}</span>
				</td>
			</tr>
			<tr>
				<td>
				 	<fmt:parseDate value="${answer.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd HH:mm"/>
				</td>
			</tr>
	
			<tr>
				<td class="tdcontent">
					<span>${answer.content}</span>
				</td>
			</tr>
		</tbody>
	</table>
	</c:if>
	
	
	<div id="buttons_wrap">
		<c:if test="${login.id eq qna.user_Id}">
			<button type="button" id="btnUpdate" onclick="location.href='/cs/qnaUpdate.do?qna_Seq=${qna.qna_Seq}'">수정</button>
			<button type="button" id="btnDelete" onclick="confirm()">삭제</button>	
		</c:if>
		<c:if test="${login.auth eq 1}">		
			<c:choose>
				<c:when test="${qna.status eq 0}">
					<button type="button" id="btnAnswer" onclick="location.href='/cs/qnaAnswer.do?qna_Seq=${qna.qna_Seq}'">답글</button>
				</c:when>
				<c:otherwise>
					<button type="button" id="btnAnswer" onclick="answerAlert()">답글</button>
				</c:otherwise>
			</c:choose>
		</c:if>
	</div>

</div>

<script type="text/javascript">	

	function showAnswerbox(){
		$("#answerbox").css("display", "");
	}
	
	function answerAlert(){
		Swal.fire({
			  icon: 'error',
			  title: '이미 답변이 달린 문의글 입니다',
			  text: '답변 수정, 삭제를 이용해 주세요'
		});
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
			    location.href="/cs/qnaDelete.do?qna_Seq=${qna.qna_Seq}";
			  } else if (result.isDenied) {
			    return;
			  }
			})
	}
	
</script>

</body>
</html>
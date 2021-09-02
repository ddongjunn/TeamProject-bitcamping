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
		<a href="/main.do"><i class="fas fa-home fa-sm"></i></a> > 
		<a href="/cs/csMain.do">고객센터</a> > 
		<a href="/cs/notice.do">Q & A</a> > 
		<a href="/cs/qnaDetail.do?qna_Seq=${qna.qna_Seq}" style="color: #75AE87;">${qna.qna_Seq}</a>
	</span>
</div>

<div class="detailboardtitle">문의 내용</div>
<div class="postarea">
	<table class="tabledetail">
		<tbody>
			<tr>
				<td class="detailtitle">
					<span>${qna.title}</span>
				</td>
			</tr>
			<tr>
				<td class="detailinfo">
					<span><i class="fas fa-user-circle fa-sm"></i> ${qna.nickname}</span>
					<span>
						<i class="far fa-calendar-alt fa-sm"></i>
						 <fmt:parseDate value="${qna.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd HH:mm"/>
					</span>
					<span>조회수 ${qna.readcount}</span>
					<hr>
				</td>
			</tr>
			<tr>
				<td class="detailcontent">
					<span>${qna.content}</span>
				</td>
			</tr>
		</tbody>
	</table>
</div>	

<div class="update_buttons_wrap">
	<c:if test="${login.id eq qna.user_Id}">
		<button type="button" class="btnSimple" id="btnUpdate" onclick="location.href='/cs/qnaUpdate.do?qna_Seq=${qna.qna_Seq}'">수정</button>
		<button type="button" class="btnSimple" id="btnDelete" onclick="confirm()">삭제</button>	
	</c:if>
	<c:if test="${login.auth eq 1}">		
		<c:choose>
			<c:when test="${qna.status eq 0}">
				<button type="button" class="btnSimple" id="btnAnswer" onclick="location.href='/cs/qnaAnswer.do?qna_Seq=${qna.qna_Seq}'">답글</button>
			</c:when>
			<c:otherwise>
				<button type="button" class="btnSimple" id="btnAnswer" onclick="answerAlert()">답글</button>
			</c:otherwise>
		</c:choose>
	</c:if>
</div>

<c:if test="${qna.status eq 1}">
	<div class="detailboardtitle">답변 내용</div>
		<div class="postarea">
			<table class="tabledetail">
			<tbody>
				<tr>
					<td class="detailtitle">
						<span>${answer.title}</span>
					</td>
				</tr>
				<tr>
					<td class="detailinfo">
						<span><i class="fas fa-user-circle fa-sm"></i> ${answer.nickname}</span>
					<span>
						<i class="far fa-calendar-alt fa-sm"></i>
						 <fmt:parseDate value="${answer.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd HH:mm"/>
					</span>
					<hr>
				</tr>		
				<tr>
					<td class="detailcontent">
						<span>${answer.content}</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</c:if>

<div class="update_buttons_wrap">
	<c:if test="${login.id eq answer.user_Id}">
		<button type="button" class="btnSimple" id="btnUpdate" onclick="location.href='/cs/qnaAnswerUpdate.do?qna_Seq=${answer.qna_Seq}'">수정</button>
		<button type="button" class="btnSimple" id="btnDelete" onclick="confirmAnswer()">삭제</button>	
	</c:if>
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
	
	function confirmAnswer(){
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
			    location.href="/cs/qnaAnswerDelete.do?qna_Seq=${answer.qna_Seq}";
			  } else if (result.isDenied) {
			    return;
			  }
			})
	}
	
</script>

</body>
</html>
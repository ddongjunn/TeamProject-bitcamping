<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/mypageMain.css">
</head>
<body>
<div class="mymain-box">

	<div class="mymain-title">
		마이페이지
	</div>
	
	<div class="mymain-profile">
		<div class="mymain-id">
			<i class="far fa-user-circle"></i> <b>${login.nickname}</b><c:if test="${login.sns_Type eq 'none'}">(${login.id})</c:if> 님
			<span class="mymain-more">
				<a href="/account/update.do"><i class="fas fa-caret-right"></i> 정보 수정</a>
			</span>
		</div>
		<div class="mymain-info">
			<b>회원등급</b>
			<c:choose>
				<c:when test="${login.auth eq -2}">
					블랙리스트
				</c:when>
				<c:when test="${login.auth eq -1}">
					탈퇴회원
				</c:when>
				<c:when test="${login.auth eq 0}">
					일반회원
				</c:when>
				<c:when test="${login.auth eq 1}">
					관리자
				</c:when>
			</c:choose>
			<br>
			<b>가입일</b> 
			<fmt:parseDate value=" ${login.create_Date}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
			<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd"/>
		</div>
	</div>
	
	<div class="mymain-subtitle">
		활동 정보
	</div>
	
	<div class="mymain-summary">
		<div class="mymain-count">글 수<br><b>${myPostCount}</b></div> <!-- 커뮤니티 + 캠핑후기 -->
		<div class="mymain-count">댓글 수<br><b>${myCommentCount}</b></div> <!-- 커뮤댓글 + 캠핑댓글 -->
		<div class="mymain-count">문의글 수<br><b>${myQuestionCount}</b></div> <!-- 고객센터 문의글 -->
		<div class="mymain-count">주문 수<br><b>${myOrderCount}</b></div> <!-- 주문 -->
	</div>
	
	<div class="mymain-subtitle">
		주문 현황
		<span class="mymain-more">
			<a href="/account/myOrder.do"><i class="fas fa-caret-right"></i> 상세 보기</a>
		</span>
	</div>
	<div class="mymain-orderstatus">
		<div class="mymain-status">결제완료<br><b>${orderStatus1}</b></div>
		<div class="mymain-arrow"><i class="fas fa-chevron-right"></i></div>
		<div class="mymain-status">배송중<br><b>${orderStatus2}</b></div>
		<div class="mymain-arrow"><i class="fas fa-chevron-right"></i></div>
		<div class="mymain-status">배송완료<br><b>${orderStatus3}</b></div>
		<div class="mymain-arrow"><i class="fas fa-chevron-right"></i></div>
		<div class="mymain-status">반납완료<br><b>${orderStatus4}</b></div>		
	</div>
	
	<div class="mymain-subtitle">
		나의 커뮤니티 최신글
		<!-- <span class="mymain-more">
			<a href="/community/hello.do"><i class="fas fa-caret-right"></i> 상세 보기</a>
		</span> -->
	</div>
	<div class="mymain-community">
		<table class="mymain-table">
			<col width="10%">
			<col width="20%">
			<col width="auto">
			<col width="20%">
			<c:if test="${empty myCommunity}">
				<tr>
					<td colspan="4" style="height: 100px;">작성된 글이 없습니다</td>
				</tr>
			</c:if>
			<c:if test="${!empty myCommunity}">
				<tr class="mymain-thead">
					<td>글번호</td> <td>게시판</td> <td>제목</td> <td>작성일</td>
				</tr>
				<c:forEach items="${myCommunity}" var="c">
				<tr>
					<td>
						${c.community_seq}
					</td>
					<td>
						<c:choose>
						    <c:when test="${c.bbstype eq 'hello'}">
						        가입인사
						    </c:when>
						    <c:when test="${c.bbstype eq 'free'}">
						        자유게시판
						    </c:when>
						    <c:when test="${c.bbstype eq 'deal'}">
						        중고거래
						    </c:when>
						    <c:when test="${c.bbstype eq 'review'}">
						        캠핑&여행후기
						    </c:when>
						    <c:otherwise>
						        캠퍼 모집
						    </c:otherwise>
						</c:choose>
					</td>
					<td style="text-align: left;">
						<a href="/community/${c.bbstype}Detail.do?community_seq=${c.community_seq}">${c.title}</a>
						<c:if test="${c.commentcount ne 0}">
							<span class="mymain-comment"> [${c.commentcount}]</span>
						</c:if>
					</td>
					<td>
						<fmt:parseDate value=" ${c.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${formatedDate}" pattern="yy/MM/dd HH:mm"/>
					</td>
				</tr>
				</c:forEach>
			</c:if>
		</table>
	</div>
	
	<div class="mymain-subtitle">
		나의 문의글
		<span class="mymain-more">
			<a href="/account/qna.do"><i class="fas fa-caret-right"></i> 상세 보기</a>
		</span>
	</div>
	
	<div class="mymain-qna">
		<table class="mymain-table">
			<col width="10%">
			<col width="20%">
			<col width="auto">
			<col width="20%">
			<c:if test="${empty myQna}">
				<tr>
					<td colspan="4" style="height: 100px;">작성된 글이 없습니다</td>
				</tr>
			</c:if>
			<c:if test="${!empty myQna}">
				<tr class="mymain-thead">
					<td>글번호</td> <td>답변상태</td> <td>제목</td> <td>작성일</td>
				</tr>
				<c:forEach items="${myQna}" var="q">
				<tr>
					<td>
						${q.qna_Seq}
					</td>
					<td>
						<c:choose>
						    <c:when test="${q.status eq 0}">
						        답변대기중
						    </c:when>
						    <c:otherwise>
						        답변완료
						    </c:otherwise>
						</c:choose>
					</td>
					<td style="text-align: left;">
						<a href="/cs/qnaDetail.do?qna_Seq=${q.qna_Seq}">${q.title}</a>
					</td>
					<td>
						<fmt:parseDate value=" ${q.wdate}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${formatedDate}" pattern="yy/MM/dd HH:mm"/>
					</td>
				</tr>
				</c:forEach>
			</c:if>
		</table>
	</div>	
</div>

</body>
</html>

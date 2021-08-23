<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>자유게시판 글 상세화면</h1>


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
		${data.wdate }
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
	<button type="button" onclick="del(${data.community_seq})">삭제</button>
	
	<form name="updateFrm" action="/community/freeUpdate.do?bbstype=free" method="POST">
		<input type="hidden" name="community_seq" value="${data.community_seq}">
		<input type="hidden" name="user_id" value='${login.id}'>
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
<button type="button" onclick="location='/community/free.do'">목록</button>

<br>


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

function del(community_seq) {
	var check = confirm("삭제하시겠습니까?");
	if (check) {
		location='/community/delete.do?community_seq=' + ${data.community_seq} + '&bbstype=free';
	}
}
function update() {
	var check = confirm("수정하시겠습니까?");
	if (check) {
		javascript:document.updateFrm.submit();
	}
}

</script>

</body>
</html>



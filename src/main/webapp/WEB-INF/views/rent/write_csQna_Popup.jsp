<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

    <!-- JQuery -->
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <!-- sweetalert2 -->
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>
<form id="qnaCommentForm" action="/rent/writeCsQnaAf.do" method="post" autocomplete="off">
    <h2>고객센터 Q&A 답변</h2>
    <div id="contentbox" style="width: 100%; margin: auto;">
        <input type="text" id="title" name="title" value="비트캠핑 고객센터입니다." style="width: 100%">
    </div>
    <p></p>
    <div id="contentbox2" style="width: 100%; margin: auto;">
        <textarea id="content" rows="8" name="content" style="width: 100%"></textarea>
    </div>

    <input type="hidden" name="qna_Seq" value="${qna_Seq}">
    <input type="hidden" name="user_Id" value="${login.id}">
    <div>
        <input type="button" id="sendQnaComment" value="확인">
    </div>
</form>

<script type="text/javascript">

    $("#sendQnaComment").click(function() {

        if(${login == null}) {

            Swal.fire({
                icon: 'warning',
                title: '로그인 후 이용해 주세요',
                confirmButtonText: '닫기',
                showCancelButton: true,
                cancelButtonText: '뒤로',
            }).then((result) => {
                if (result.isConfirmed) {
                    window.close();
                }
            });

        } else if($("#title").val() == ""){

            Swal.fire({
                icon: 'warning',
                title: '제목을 입력해 주세요!'
            });
            $("#title").focus();

        } else if($("#content").val() == ""){

            Swal.fire({
                icon: 'warning',
                title: '답변 내용을 입력해 주세요!'
            });
            $("#content").focus();

        } else {

            var params = $("#qnaCommentForm").serialize();

            $.ajax({
                url : '<c:url value='/rent/writeCsQnaAf.do' />',
                data : params,
                success : function(data){

                    opener.writeQnaAf(data);
                    window.close();

                }  ,error:function(request,status,error){
                    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            });
        }
    });

</script>

</body>
</html>
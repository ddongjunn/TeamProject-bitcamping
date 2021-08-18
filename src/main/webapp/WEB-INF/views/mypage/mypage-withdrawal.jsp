<%--
  Created by IntelliJ IDEA.
  User: djlee
  Date: 2021-08-15
  Time: 오후 8:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원탈퇴</title>
</head>
<body>
<div class="customer-withdrawal">
    <h2 class="title">
        회원탈퇴
    </h2>

    <form id="withdrawalFrm">
        <h5>회원탈퇴 사유</h5>

        <div class="withdrawal-radio">
            <p><input type="radio" name="reason" value="1"> 회원탈퇴 후 재가입을 위해서</p>
            <p><input type="radio" name="reason" value="2"> 서비스 및 고객지원이 만족스럽지 못해서</p>
            <p><input type="radio" name="reason" value="3"> 사용 PC 또는 모바일의 환경과 맞지 않아서</p>
            <p><input type="radio" name="reason" value="4"> 별다른 이유없이 탈퇴</p>
            <span class="error_msg"></span>
        </div>

        <br>

        <div class="withdrawal-textarea">
            <h5>탈퇴하시려는 사유를 입력해주세요.</h5>
            <textarea name="reason2" wrap="hard" rows="10" cols="70" maxlength="2000" placeholder="비트캠핑 운영진에게 하시고 싶은 말씀이 있으면 남겨주세요. &#13;&#10;2,000자까지 입력할 수 있습니다."></textarea>
            <span class="error_msg"></span>
        </div>

        <br>

        <div class="withdrawal-agree">
            <p><input type="checkbox"> 회원탈퇴 안내를 모두 확인하였으며 탈퇴에 동의합니다</p>
            <span class="error_msg"></span>
        </div>

        <br>

        <div class="withdrawal-guide">
            <ol type="1" start="1">
                <li>
                    회원정보는 탈퇴 시 관련법령에 따라 보관 의무가 있는 경우를 제외하고는 즉시 삭제됩니다.
                </li>
                <li>
                    전자상거래 등에서의 소비자보호에 관한 법률에 따라 계약 또는 청약철회에 관한 기록, 대금 결제 및 재화 등의 공급에 관한 기록은 5년, 그리고 소비자의 불만 또는 분쟁처리에 관한 기록은 3년간 보존됩니다.
                </li>
                <li>
                    탈퇴 이후에는 어떠한 방법으로도 삭제된 회원정보를 복원할 수 없습니다.
                </li>
            </ol>
        </div>

        <div class="submit">
            <input type="button" id="withdrawalBtn" value="탈퇴하기">
        </div>
    </form>
</div>

<script type="text/javascript">
    let errormsg = document.querySelectorAll('.error_msg');

    $('#withdrawalBtn').click(function () {

        radioCheck();
        textCheck();

        if(!radioCheck()){
            return;
        }else if(!textCheck()){
            return;
        }
            alert('전부합격');


    });

    function radioCheck(){
        if( !$('input:radio[name=reason]').is(':checked')) {
            errormsg[0].innerHTML = "필수 입력 항목입니다.";
            errormsg[0].style.color = "#ff0000";
            errormsg[0].style.display = "block";

            $('input:radio[name=reason]').focus();
            return false;
        }else{
            errormsg[0].style.display = "none";
            return true;
        }
    }

    function textCheck() {
        if( $('textarea[name=reason2]').val() === ""){
            errormsg[1].innerHTML = "필수 입력 항목입니다.";
            errormsg[1].style.color = "#ff0000";
            errormsg[1].style.display = "block";
            $('textarea[name=reason2]').focus();
            return false;
        }else{
            errormsg[1].style.display = "none";
            return true;
        }
    }
</script>
</body>
</html>

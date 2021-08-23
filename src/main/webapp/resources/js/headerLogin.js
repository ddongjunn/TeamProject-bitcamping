//로그인 모달

    const modal = document.getElementById("login_modal");

    function modalOn() {
    modal.style.display = "flex"
    modalOff_findId();
    modalOff_findPw();
    $('html, body').css({'overflow': 'hidden', 'height': '100%'}); // 모달팝업 중 html,body의 scroll을 hidden시킴
}
    function isModalOn() {
    return modal.style.display === "flex"
}
    function modalOff() {
    modal.style.display = "none"
    $('html, body').css({'overflow': 'auto', 'height': '100%'});
}

    const btnModal = document.getElementById("header_login");
    btnModal.addEventListener("click", e => {
    modalOn();
});

    //x버튼으로 모달창 닫기
    const closeBtn = document.getElementById("close");
    closeBtn.addEventListener("click", e => {
    modalOff();
});

    //바깥쪽 클릭으로 모달창 닫기
    /*	modal.addEventListener("click", e => {
    const evTarget = e.target
    if(evTarget.classList.contains("login_modal-overlay")) {
    modalOff();
}
});*/

    //esc키로 모달창 닫기
    window.addEventListener("keyup", e => {
    if(isModalOn() && e.key === "Escape") {
    modalOff();
}
});

    /////////////////////////////////////////////////////////////////
    //아이디찾기
    const modal_findId = document.getElementById("modal_findId");

    function modalOn_findId() {
    modal_findId.style.display = "flex"
}
    function isModalOn_findId() {
    return modal_findId.style.display === "flex"
}
    function modalOff_findId() {
    modal_findId.style.display = "none"
}

    const btnModal_findId = document.getElementById("findId");
    btnModal_findId.addEventListener("click", e => {
    modalOff();
    modalOn_findId();
    findId_error[0].style.display = "none";
});

    const closeBtn_findId = modal_findId.querySelector(".close_findId");

    closeBtn_findId.addEventListener("click", e => {
    modalOff_findId();
    $('#find_name').val("");
    $('#find_email').val("");
});

    /*modal.addEventListener("click", e => {
    const evTarget = e.target
    if(evTarget.classList.contains("modal-overlay_findId")) {
    modalOff_findId()
}
})
    window.addEventListener("keyup", e => {
    if(isModalOn() && e.key === "Escape") {
    modalOff_findId()
}
})*/

    $('#loginBtn').click(function () {
    if($('#id').val().trim() === ""){
    alert('아이디를 입력해주세요.');
    return;
}else if($('#pwd').val().trim() === ""){
    alert('비밀번호를 입력해주세요.');
    return;
}

    $.ajax({
    url: "/login/normal.do",
    data: {'id': $('#id').val(), 'pwd' : $('#pwd').val(), 'move' : move },
    type: "post",
    dataType: "json",
    success: function (data) {

    alert('로그인 ajax success');
    console.log(data);
    alert(data.move);
    console.log(data.move);

    if(data){

    location.href="/";

    if(data.move != null){
    location.href = data.move;
}
    return;
}
    alert('아이디와 비밀번호를 확인해주세요.');
},
    error: function ( error ) {

}
});
});

    //아이디 찾기
    let findId_error = document.querySelectorAll('.error_next_box');

    $('#findIdBtn').click(function () {

    if($('#find_name').val().trim() === ""){
    findId_error[0].innerHTML = "아이디를 입력해주세요.";
    findId_error[0].style.color = "#ff0000";
    findId_error[0].style.display = "block";
    return;

}else if($('#find_email').val().trim() === ""){
    findId_error[0].innerHTML = "이메일을 입력해주세요";
    findId_error[0].style.color = "#ff0000";
    findId_error[0].style.display = "block";
    return;

}else{

    $.ajax({
    url: "/login/findId.do",
    data: {'username': $('#find_name').val(), 'email' : $('#find_email').val()},
    type: "post",
    success: function ( data ) {
    if(data === "null"){
    findId_error[0].innerHTML = "일치하는 회원 정보가 없습니다.";
    findId_error[0].style.color = "#ff0000";
    findId_error[0].style.display = "block";
    return;
}
    modalOff_findId();
    $('#find_name').val("");
    $('#find_email').val("");
    Swal.fire({
    text : '회원님의 아이디는 ' + data + ' 입니다.',
    width : 500,
    padding : 10
});
    modalOn();
},
    error: function ( error ) {

}
});
}
});

//비밀번호 찾기
    const modal_findPw = document.getElementById("modal_findPw");

    function modalOn_findPw() {
    modal_findPw.style.display = "flex"
    $('html, body').css({'overflow': 'hidden', 'height': '100%'}); // 모달팝업 중 html,body의 scroll을 hidden시킴
}
    function isModalOn_findPw() {
    return modal_findPw.style.display === "flex"
}
    function modalOff_findPw() {
    modal_findPw.style.display = "none"
    $('html, body').css({'overflow': 'auto', 'height': '100%'});
}

    const btnModal_findPw = document.getElementById("findPw");
    btnModal_findPw.addEventListener("click", e => {
    modalOff();
    modalOn_findPw();
});

    const closeBtn_findPw = modal_findPw.querySelector(".close_findPw");

    closeBtn_findPw.addEventListener("click", e => {
    modalOff_findPw();
    $('#findPw_id').val("");
    $('#findPw_email').val("");
    error[0].innerHTML = "";
});

    let findPw_error = document.querySelectorAll('.error_findPw_box');


    $('#findPwBtn').click(function () {

    if($('#findPw_id').val().trim() === ""){
    findPw_error[0].innerHTML = "아이디를 입력해주세요.";
    findPw_error[0].style.color = "#ff0000";
    findPw_error[0].style.display = "block";
    return;

}else if($('#findPw_email').val().trim() === ""){
    findPw_error[0].innerHTML = "이메일을 입력해주세요";
    findPw_error[0].style.color = "#ff0000";
    findPw_error[0].style.display = "block";
    return;

}


    $.ajax({
    url: "/login/findPw.do",
    data: {'id': $('#findPw_id').val(), 'email' : $('#findPw_email').val()},
    type: "post",
    success: function ( data ) {
    console.log(data);

    if(data === "null"){
    findPw_error[0].innerHTML = "일치하는 회원 정보가 없습니다.";
    findPw_error[0].style.color = "#ff0000";
    findPw_error[0].style.display = "block";
}else{
    modalOff_findPw();

    console.log("data = " + data);

    Swal.fire({
    text : '이메일 : ' + $('#findPw_email').val() + '            ' +
    ' 임시 비밀번호가 발송되었습니다.',
    width : 500,
    padding : 10
});

    $('#findPw_id').val("");
    $('#findPw_email').val("");
    modalOn();
}
},
    error: function ( error ) {

}
});
});


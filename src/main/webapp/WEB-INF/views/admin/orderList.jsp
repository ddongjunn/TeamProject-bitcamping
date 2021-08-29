<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>

<div class="container-fluid" style="margin-bottom: -15px">
    <h2>주문내역</h2>
</div>

<c:forEach items="${order}" var="order">
    <div style="margin: 15px 20px 0px 20px">
		<span>
			<fmt:parseDate value="${order.order_Date}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
			<fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd HH:mm"/>
		</span>
        <div style="border: 1px solid; margin: 5px;">
            <span>상품명 :<a href="/rent/detail.do?product_Seq=${order.product_Seq}"> ${order.product_Name}</a></span>
            <div style="display: flex;">
                <hr>
                <div style="flex: 1; flex-basis: 20%;">
                    <img src="/resources/upload/${order.thumbnail_Name}" style="height: 150px;" alt="상품 썸네일 이미지">
                </div>
                <div style="flex: 1; flex-basis: 60%;">
                    <table>
                        <tr>
                            <td>주문번호&nbsp;:&nbsp;</td> <td><a href="/admin/order-detail.do?merchant_Uid=${order.merchant_Uid}">${order.merchant_Uid}</a></td>
                        </tr>
                        <tr>
                            <td>결제금액&nbsp;:&nbsp;</td> <td><fmt:formatNumber value="${order.total_Price}" type="number"/>원</td>
                        </tr>
                        <tr>
                            <td>주문상태&nbsp;:&nbsp;</td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.order_Status eq 1}">결제완료</c:when>
                                    <c:when test="${order.order_Status eq 2}">배송중</c:when>
                                    <c:when test="${order.order_Status eq 3}">배송완료</c:when>
                                    <c:when test="${order.order_Status eq 4}">반납완료</c:when>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <td>주문자&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;</td>
                            <td>${order.username}</td>
                        </tr>
                        <tr>
                            <td>연락처&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;</td>
                            <td>${order.phone}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<div class="container"> <!-- style = "width : 100%; text-align : center" -->
    <!--  <div style = "display : inline-block"> -->
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center" id="pagination"></ul>
    </nav>
</div>

<div class="row" style="justify-content: space-between; width: 350px; margin: auto">
    <select id="_choice" name="choice" class="form-control form-control-sm" style="width: 90px">
        <option value="" selected="selected">선택</option>
        <option value="name">이름</option>
        <option value="phone">연락처</option>
    </select>
    <input type="text" id="_search" name="search" placeholder="검색" class="form-control form-control-sm" style="width: 200px">
    <button type="button" id="btnSearch" class="btn btn-outline-primary btn-sm">검색</button>
</div>

<script type="text/javascript">

    let choice = '${choice}';
    let search = '${search}';

    let totalCount = ${totalCount};
    if(totalCount === 0){
        totalCount = 1;
    }

    let nowPage = ${nowPage};
    let pageSize = 10;

    let _totalPages = totalCount / pageSize;
    if(totalCount % pageSize > 0){
        _totalPages++;
    }

    $("#pagination").twbsPagination({
        startPage: nowPage,
        totalPages: _totalPages,
        visiblePages: 10,
        first:'<span sria-hidden="true">«</span>',
        prev:"이전",
        next:"다음",
        last:'<span sria-hidden="true">»</span>',
        initiateStartPageClick:false,		// onPageClick 자동 실행되지 않도록 한다
        onPageClick:function(event, page){
            location.href = "/admin/order-list.do?choice=" + choice + "&search=" + search + "pageNumber=" + (page - 1);
        }
    });

    $("#btnSearch").click(function () {

        if($('#_choice').val() === ""){
            let Toast = Swal.mixin({
                toast: true,
                position: 'bottom-end',
                showConfirmButton: false,
                timer: 2000,
                timerProgressBar: true,
                didOpen: (toast) => {
                    toast.addEventListener('mouseenter', Swal.stopTimer)
                    toast.addEventListener('mouseleave', Swal.resumeTimer)
                }
            })

            Toast.fire({
                icon: 'error',
                title: '검색옵션을 선택해주세요!'
            })
            return;

        }else if($('#_search').val() ===""){
            let Toast = Swal.mixin({
                toast: true,
                position: 'bottom-end',
                showConfirmButton: false,
                timer: 2000,
                timerProgressBar: true,
                didOpen: (toast) => {
                    toast.addEventListener('mouseenter', Swal.stopTimer)
                    toast.addEventListener('mouseleave', Swal.resumeTimer)
                }
            })

            Toast.fire({
                icon: 'error',
                title: '검색어를 입력해주세요!'
            })

            return;
        }

        location.href = "/admin/order-list.do?choice=" + $("#_choice").val() + "&search=" + $("#_search").val();
    });

</script>

</body>
</html>
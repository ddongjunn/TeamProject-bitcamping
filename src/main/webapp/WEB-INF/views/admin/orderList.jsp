<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypageRent.css">
</head>
<body>

<div class="mypage_board" style="width: 70%; margin : auto">
    <div>
        <div class="myorder-title">
            <h2>주문내역</h2>
        </div>
        <div style="margin-top:-30px; margin-bottom: 30px">
            <a href="/admin/order-list.do" class="badge badge-pill badge-default">전체</a>
            <a href="/admin/order-list.do?status=1" class="badge badge-pill badge-info">결제완료</a>
            <a href="/admin/order-list.do?status=2" class="badge badge-pill badge-primary">배송중</a>
            <a href="/admin/order-list.do?status=3" class="badge badge-pill badge-success">배송완료</a>
            <a href="/admin/order-list.do?status=4" class="badge badge-pill badge-danger">반납완료</a>
        </div>
    </div>

    <c:if test="${empty order}">
        <div class="myorder-title">
            <h2>검색된 결과가 없습니다.</h2>
        </div>
    </c:if>
    <c:forEach items="${order}" var="order">
        <div class="myorder-box">
            <div class="myorder-date">
                <span class="myorder-date-icon"><i class="fas fa-shopping-cart"></i></span>
                <fmt:parseDate value="${order.order_Date}" var="formatedDate" pattern="yyyy-MM-dd HH:mm:ss"/>
                <fmt:formatDate value="${formatedDate}" pattern="yyyy/MM/dd HH:mm"/>
            </div>
            <div class="myorder-case" style="background-color: white;">
                <div class="myorder-item">
                    <a href="/rent/detail.do?product_Seq=${order.product_Seq}">
                            ${order.product_Name}
                    </a>
                </div>
                <div class="myorder-detail">
                    <hr>
                    <div class="myorder-img">
                        <img src="/resources/upload/${order.thumbnail_Name}" alt="상품 썸네일 이미지">
                    </div>
                    <div class="myorder-info">
                        <table class="myorder-info-table">
                            <tr>
                                <th>주문번호</th>
                                <td>
                                    <a href="/admin/order-detail.do?merchant_Uid=${order.merchant_Uid}">
                                            ${order.merchant_Uid}
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <th>결제금액</th> <td><fmt:formatNumber value="${order.total_Price}" type="number"/>원</td>
                            </tr>
                            <tr>
                                <th>대여기간</th>
                                <td>
                                        ${order.rent_Sdate} ~ ${order.rent_Edate}
                                </td>
                            </tr>
                            <tr>
                                <th>주문상태</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.order_Status eq 1}">결제완료</c:when>
                                        <c:when test="${order.order_Status eq 2}">
                                            배송중 [우체국 : ${order.invoiceNumber}]
                                        </c:when>
                                        <c:when test="${order.order_Status eq 3}">배송완료</c:when>
                                        <c:when test="${order.order_Status eq 4}">반납완료</c:when>
                                    </c:choose>

                                    <c:if test="${order.order_Status ne 4}">
                                        <button type="button" class="btn btn-info btn-sm" onclick="statusChange(${order.order_Seq},'${order.order_Status}')">변경</button>
                                    </c:if>

                                    <span id="statusBtn"> </span>
                                </td>

                            </tr>
                            <tr>
                            <th>주문자</th>
                            <td>${order.username}</td>
                            </tr>
                            <tr>
                                <th>연락처</th>
                                <td>${order.phone}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <!-- pagination -->
    <div class="container"> <!-- style = "width : 100%; text-align : center" -->
        <!--  <div style = "display : inline-block"> -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center" id="pagination"></ul>
        </nav>
	</div>
</div>

<div class="row" style="justify-content: space-between; width: 350px; margin: auto; margin-bottom: 50px" >
    <select id="_choice" name="choice" class="form-control form-control-sm" style="width: 90px">
        <option value="" selected="selected">선택</option>
        <option value="name">주문자</option>
        <option value="phone">연락처</option>
    </select>
    <input type="text" id="_search" name="search" placeholder="검색" class="form-control form-control-sm" style="width: 200px">
    <button type="button" id="btnSearch" class="btn btn-outline-primary btn-sm">검색</button>
</div>

<script type="text/javascript">

    async function statusChange(order_Seq, order_Status) {
        const {value: status} = await Swal.fire({
            title: '배송상태 선택',
            input: 'select',
            inputOptions:
                {
                    '1' : '결제완료',
                    '2' : '배송중',
                    '3' : '배송완료',
                    '4' : '반납완료'
                },
            inputPlaceholder: '선택',
            showCancelButton: true,
            cancelButtonText: '취소',
            confirmButtonText: '확인',
            inputValidator: (value) => {
                return new Promise(async (resolve) => {

                    if (value === order_Status ){
                        resolve('현재 배송상태와 동일합니다.');
                    }

                    if (value === '1') {
                        resolve()

                    } else if (value === '2') {

                        const {value: invoiceNumber} = await Swal.fire({
                            title: '송장번호',
                            input: 'text',
                        })

                        if (invoiceNumber) {
                            Swal.fire({
                                icon : 'success',
                                text : '배송상태가 변경되었습니다.',
                                didClose: () => {
                                    $.ajax({
                                        url : '<c:url value='/admin/insert-orderInvoiceNumber.do' />',
                                        type: 'POST',
                                        data : {'order_Status' : value, 'order_Seq' : order_Seq, 'invoiceNumber' : invoiceNumber},
                                        success : function(xh){
                                            history.go(0);
                                        },error : function () {
                                            alert('error');
                                        }
                                    });
                                }
                            });
                        }

                    } else if (value === '3') {
                        resolve()

                    } else {

                        resolve()
                    }
                })
            }
        })

        if (status) {
            Swal.fire({
                icon : 'success',
                text : '배송상태가 변경되었습니다.',
                didClose: () => {
                    $.ajax({
                        url : '<c:url value='/admin/update-orderStatus.do' />',
                        type: 'POST',
                        data : {'order_Status' : status, 'order_Seq' : order_Seq},
                        success : function(xh){

                            history.go(0);
                        },
                    });
                }
            });

        }
    }

    let status = '${status}';
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
            location.href = "/admin/order-list.do?status=" + status + "&choice=" + choice + "&search=" + search + "pageNumber=" + (page - 1);
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

        location.href = "/admin/order-list.do?status=" + status + "&choice=" + $("#_choice").val() + "&search=" + $("#_search").val();
    });

</script>

</body>
</html>
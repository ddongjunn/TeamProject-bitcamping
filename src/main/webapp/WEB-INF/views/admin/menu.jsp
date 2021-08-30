<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: djlee
  Date: 2021-08-13
  Time: 오후 7:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
    <title>관리자 메뉴</title>
</head>
<body>
<nav class="sidenav navbar navbar-vertical  fixed-left  navbar-expand-xs navbar-light bg-white" id="sidenav-main">
    <div class="scroll-wrapper scrollbar-inner" style="position: relative;"><div class="scrollbar-inner scroll-content" style="height: 953px; margin-bottom: 0px; margin-right: 0px; max-height: none;">
        <!-- Brand -->
        <div class="sidenav-header  align-items-center">
            <a class="navbar-brand" href="/admin/main.do">
                <img src="/resources/images/adminLogo.png" alt="" height="60" width="200">
            </a>
        </div>
        <div class="navbar-inner">
            <!-- Collapse -->
            <div class="collapse navbar-collapse" id="sidenav-collapse-main">
                <!-- Nav items -->
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" href="javascript:void(0)" style="pointer-events: none;">
                            <i class="ni ni-single-02 text-yellow"></i>
                            <span class="nav-link-text">회원관리</span>
                        </a>
                            <li class="nav-item" style="margin-left: 33px">
                                <a class="nav-link " href="/admin/memberInfo.do">
                                    <span class="nav-link-text">회원정보</span>
                                </a>
                            </li>

                    <li class="nav-item">
                        <a class="nav-link active" href="javascript:void(0)" style="pointer-events: none;">
                            <i class="ni ni-pin-3 text-primary"></i>
                            <span class="nav-link-text">커뮤니티관리</span>
                        </a>
                            <li class="nav-item" style="margin-left: 33px">
                                <a class="nav-link " href="/admin/community.do?bbstype=hello">
                                    <span class="nav-link-text">가입인사</span>
                                </a>
                            </li>
                            <li class="nav-item" style="margin-left: 33px">
                                <a class="nav-link " href="/admin/community.do?bbstype=free">
                                    <span class="nav-link-text">자유게시판</span>
                                </a>
                            </li>
                            <li class="nav-item" style="margin-left: 33px">
                                <a class="nav-link " href="/admin/community-deal.do">
                                    <span class="nav-link-text">중고거래</span>
                                </a>
                            </li>
                            <li class="nav-item" style="margin-left: 33px">
                                <a class="nav-link " href="/admin/community.do?bbstype=review">
                                    <span class="nav-link-text">캠핑&여행후기</span>
                                </a>
                            </li>
                            <li class="nav-item" style="margin-left: 33px">
                                <a class="nav-link " href="/admin/community.do?bbstype=find">
                                    <span class="nav-link-text">캠퍼모집</span>
                                </a>
                            </li>
                            <li class="nav-item" style="margin-left: 33px">
                                <a class="nav-link " href="/admin/camping-review.do">
                                    <span class="nav-link-text">캠핑장리뷰</span>
                                </a>
                            </li>

                    <li class="nav-item">
                        <a class="nav-link active" href="javascript:void(0)" style="pointer-events: none;">
                            <i class="ni ni-single-02"></i>
                            <span class="nav-link-text">상품관리</span>
                        </a>
                            <li class="nav-item" style="margin-left: 33px">
                                <a class="nav-link " href="/admin/product-regi.do">
                                    <span class="nav-link-text">상품등록</span>
                                </a>
                            </li>
                            <li class="nav-item" style="margin-left: 33px">
                                <a class="nav-link " href="/admin/product.do">
                                    <span class="nav-link-text">상품리스트</span>
                                </a>
                            </li>
                            <li class="nav-item" style="margin-left: 33px">
                                <a class="nav-link " href="/admin/order-list.do">
                                    <span class="nav-link-text">주문리스트</span>
                                </a>
                            </li>
                            <li class="nav-item" style="margin-left: 33px">
                                <a class="nav-link " href="/admin/product-qna.do">
                                    <span class="nav-link-text">상품Q&A</span>
                                </a>
                            </li>

                    <li class="nav-item">
                        <a class="nav-link active" href="javascript:void(0)" style="pointer-events: none;">
                            <i class="ni ni-bullet-list-67 text-default"></i>
                            <span class="nav-link-text">고객센터관리</span>
                        </a>
                        <li class="nav-item" style="margin-left: 33px">
                            <a class="nav-link" href="/admin/qna.do">
                                <span class="nav-link-text">Q&A</span>
                            </a>
                        </li>
                </ul>
            </div>
        </div>
    </div><div class="scroll-element scroll-x"><div class="scroll-element_outer"><div class="scroll-element_size"></div><div class="scroll-element_track"></div><div class="scroll-bar" style="width: 0px;"></div></div></div><div class="scroll-element scroll-y"><div class="scroll-element_outer"><div class="scroll-element_size"></div><div class="scroll-element_track"></div><div class="scroll-bar" style="height: 0px;"></div></div></div></div>
</nav>
<%--<div class="leftmenu">
    <div class="customer-name">
        <span class="ns-profile icon-user"></span>
        <span>${login.id}</span>
    </div>

    <div class="lnb">

        <h3 class="lnb-title">회원관리</h3>
        <a href="/admin/memberInfo.do">회원정보</a>
    </div>

    <div class="lnb">
        <h3 class="lnb-title">커뮤니티관리</h3>
        <a href="/admin/community.do?bbstype=hello">가입인사</a>
        <a href="/admin/community.do?bbstype=free">자유게시판</a>
        <a href="/admin/community.do?bbstype=deal">중고거래</a>
        <a href="/admin/community.do?bbstype=review">캠핑&여행후기</a>
        <a href="/admin/community.do?bbstype=find">캠퍼모집</a>
        <a href="/admin/csite-review.do">캠핑장리뷰</a>
    </div>

    <div class="lnb">
        <h3 class="lnb-title">상품관리</h3>
        <a>상품등륵</a>
        <a>재고관리</a>
        <a>대여관리</a>
        <a>주문관리</a>
        <a>상품Q&A</a>
    </div>

    <div class="lnb">
        <h3 class="lnb-title">고객센터관리</h3>
        <a href="/admin/qna.do">Q&A</a>
    </div>

</div>--%>

</body>
</html>

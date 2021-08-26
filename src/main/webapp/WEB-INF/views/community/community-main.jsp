<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h3> 커뮤니티 눌렀을때 처음 나오는 화면</h3>
<div class="row">
        <div class="col-xl-3">
            <div class="card">
                <div class="card-header border-0">
                    <div class="row align-items-center">
                        <div class="col">
                            <h3 class="mb-0">자유게시판</h3>
                        </div>
                        <div class="col text-right">
                            <a href="/admin/community.do?bbstype=free" class="btn btn-sm btn-primary">더 보기</a>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <!-- Projects table -->
                    <table class="table align-items-center table-flush">
                        <thead class="thead-light">
                            <c:forEach var="list" items="${recentCommunity.free}">
                                <tr>
                                    <!-- a태그 걸어야함 -->
                                    <td>${list.title} <b>[${list.commentcount}]</b></td>
                                </tr>
                            </c:forEach>
                        </thead>
                    </table>
                </div>
            </div>
        </div>

        <div class="col-xl-3">
            <div class="card">
                <div class="card-header border-0">
                    <div class="row align-items-center">
                        <div class="col">
                            <h3 class="mb-0">캠퍼모집</h3>
                        </div>
                        <div class="col text-right">
                            <a href="admin/community.do?bbstype=find" class="btn btn-sm btn-primary">더 보기</a>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <!-- Projects table -->
                    <table class="table align-items-center table-flush">
                        <thead class="thead-light">
                        <c:forEach var="list" items="${recentCommunity.find}">
                            <tr>
                                <!-- a태그 걸어야함 -->
                                <td>${list.title} <b>[${list.commentcount}]</b></td>
                            </tr>
                        </c:forEach>
                        </thead>
                    </table>
                </div>
            </div>
        </div>

        <div class="col-xl-3">
            <div class="card">
                <div class="card-header border-0">
                    <div class="row align-items-center">
                        <div class="col">
                            <h3 class="mb-0">캠핑여행&후기</h3>
                       </div>
                        <div class="col text-right">
                            <a href="/admin/memberInfo.do" class="btn btn-sm btn-primary">더 보기</a>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <!-- Projects table -->
                    <table class="table align-items-center table-flush">
                        <thead class="thead-light">
                        <c:forEach var="list" items="${recentCommunity.review}">
                            <tr>
                                <!-- a태그 걸어야함 -->
                                <td>${list.title} <b>[${list.commentcount}]</b></td>
                            </tr>
                        </c:forEach>
                        </thead>
                    </table>
                </div>
            </div>
        </div>

        <div class="col-xl-3">
            <div class="card">
                <div class="card-header border-0">
                    <div class="row align-items-center">
                        <div class="col">
                            <h3 class="mb-0">중고거래</h3>
                        </div>
                        <div class="col text-right">
                            <a href="/admin/memberInfo.do" class="btn btn-sm btn-primary">더 보기</a>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <!-- Projects table -->
                    <table class="table align-items-center table-flush">
                        <thead class="thead-light">
                        <c:forEach var="list" items="${recentCommunity.deal}">
                            <tr>
                                <!-- a태그 걸어야함 -->
                                <td>${list.title} <b>[${list.commentcount}]</b></td>
                            </tr>
                        </c:forEach>
                        </thead>
                    </table>
                </div>
            </div>
        </div>

    </div>
</body>
</html>
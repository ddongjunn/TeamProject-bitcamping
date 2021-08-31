<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: djlee
  Date: 2021-08-19
  Time: 오후 5:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/resources/assets/vendor/chart.js/dist/Chart.min.js"></script>
<script src="/resources/assets/vendor/chart.js/dist/Chart.extension.js"></script>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="bg-primary pb-1" style="margin-top : -15px">
    <div class="container-fluid">
        <!-- Card stats -->
        <div class="row">
            <div class="col-xl-3 col-md-6">
                <div class="card card-stats">
                    <!-- Card body -->
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <h5 class="card-title text-uppercase text-muted mb-0">총 회원 수</h5>
                                <span class="h2 font-weight-bold mb-0">${memberCount}</span>
                            </div>
                            <div class="col-auto">
                                <div class="icon icon-shape bg-gradient-red text-white rounded-circle shadow">
                                    <i class="ni ni-single-02"></i>
                                </div>
                            </div>
                        </div>
                        <%--<p class="mt-3 mb-0 text-sm">
                            <span class="text-success mr-2"><i class="fa fa-arrow-up"></i> 3.48%</span>
                            <span class="text-nowrap">Since last month</span>
                        </p>--%>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6">
                <div class="card card-stats">
                    <!-- Card body -->
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <h5 class="card-title text-uppercase text-muted mb-0">총게시글 수</h5>
                                <span class="h2 font-weight-bold mb-0">${communityCount}</span>
                            </div>
                            <div class="col-auto">
                                <div class="icon icon-shape bg-gradient-orange text-white rounded-circle shadow">
                                    <i class="ni ni-bullet-list-67"></i>
                                </div>
                            </div>
                        </div>
                        <%--<p class="mt-3 mb-0 text-sm">
                            <span class="text-success mr-2"><i class="fa fa-arrow-up"></i> 3.48%</span>
                            <span class="text-nowrap">Since last month</span>
                        </p>--%>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6">
                <div class="card card-stats">
                    <!-- Card body -->
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <h5 class="card-title text-uppercase text-muted mb-0">오늘의 매출</h5>
                                <span class="h2 font-weight-bold mb-0">${todaySales}원</span>
                            </div>
                            <div class="col-auto">
                                <div class="icon icon-shape bg-gradient-green text-white rounded-circle shadow">
                                    <i class="ni ni-money-coins"></i>
                                </div>
                            </div>
                        </div>
                        <%--<p class="mt-3 mb-0 text-sm">
                            <span class="text-success mr-2"><i class="fa fa-arrow-up"></i> 3.48%</span>
                            <span class="text-nowrap">Since last month</span>
                        </p>--%>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6">
                <div class="card card-stats">
                    <!-- Card body -->
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <h5 class="card-title text-uppercase text-muted mb-0">답변 대기중인 문의글 </h5>
                                <span class="h2 font-weight-bold mb-0">${qnaCount} </span>
                            </div>
                            <div class="col-auto">
                                <div class="icon icon-shape bg-gradient-info text-white rounded-circle shadow">
                                    <i class="ni ni-chat-round"></i>
                                </div>
                            </div>
                        </div>
                        <%--<p class="mt-3 mb-0 text-sm">
                            <span class="text-success mr-2"><i class="fa fa-arrow-up"></i> 3.48%</span>
                            <span class="text-nowrap">Since last month</span>
                        </p>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid" style="margin-top: 15px">
    <div class="row">
        <div class="col-xl-8">
            <div class="card" >
                <div class="card-header bg-transparent">
                    <div class="row align-items-center">
                        <div class="col">
                            <%--<h6 class="text-uppercase text-muted ls-1 mb-1">Performance</h6>--%>
                            <h5 class="h3 mb-0">매출통계</h5>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Chart -->
                    <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                        <canvas id="visit-chart" class="chart-canvas chartjs-render-monitor" style="display: block; width: 231px; height: 100px;" width="500" height="100"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-4">
            <div class="card">
                <div class="card-header border-0">
                    <div class="row align-items-center">
                        <div class="col">
                            <h3 class="mb-0">회원가입 경로</h3>
                        </div>
                        <div class="col text-right">
                            <a href="/admin/memberInfo.do" class="btn btn-sm btn-primary">자세히 보기</a>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <!-- Projects table -->
                    <table class="table align-items-center table-flush">
                        <thead class="thead-light">
                        <tr>
                            <th scope="col">가입경로</th>
                            <th scope="col">회원수</th>
                            <th scope="col"></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <th scope="row">
                                비트캠핑
                            </th>
                            <td>
                                ${regiPath.BITCAMPING}
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <span class="mr-2">${regiPath.bitcampingPer}%</span>
                                    <div>
                                        <div class="progress">
                                            <div class="progress-bar bg-gradient-primary" role="progressbar" aria-valuenow="${regiPath.bitcampingPer}" aria-valuemin="0" aria-valuemax="100" style="width: ${regiPath.bitcampingPer}%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">
                                네이버
                            </th>
                            <td>
                                ${regiPath.NAVER}
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <span class="mr-2">${regiPath.naverPer}%</span>
                                    <div>
                                        <div class="progress">
                                            <div class="progress-bar bg-gradient-green" role="progressbar" aria-valuenow="${regiPath.naverPer}" aria-valuemin="0" aria-valuemax="100" style="width: ${regiPath.naverPer}%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">
                                카카오
                            </th>
                            <td>
                                ${regiPath.KAKAO}
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <span class="mr-2">${regiPath.kakaoPer}%</span>
                                    <div>
                                        <div class="progress">
                                            <div class="progress-bar bg-gradient-yellow" role="progressbar" aria-valuenow="${regiPath.kakaoPer}" aria-valuemin="0" aria-valuemax="100" style="width: ${regiPath.kakaoPer}%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">
                                구글
                            </th>
                            <td>
                                0
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <span class="mr-2">0%</span>
                                    <div>
                                        <div class="progress">
                                            <div class="progress-bar bg-gradient-red" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">
                                페이스북
                            </th>
                            <td>
                                0
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <span class="mr-2">0%</span>
                                    <div>
                                        <div class="progress">
                                            <div class="progress-bar bg-gradient-red" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">
                                깃허브
                            </th>
                            <td>
                                0
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <span class="mr-2">0%</span>
                                    <div>
                                        <div class="progress">
                                            <div class="progress-bar bg-gradient-red" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">
                                트위터
                            </th>
                            <td>
                                0
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <span class="mr-2">0%</span>
                                    <div>
                                        <div class="progress">
                                            <div class="progress-bar bg-gradient-red" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <%--<div class="container-fluid" style="margin-bottom: 15px; padding : 0 15px">
        <h2>최근 게시물</h2>
    </div>--%>
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
                                    <td>
                                        <!--태그 걸어야함 -->
                                        <a href="/community/dealDetail.do?community_seq=${list.community_seq }">
                                                ${list.title}
                                        </a>
                                        <span style="font-size: 13px; color: tomato;">[${list.commentcount}]</span>
                                    </td>
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
                                <td>
                                    <!--태그 걸어야함 -->
                                    <a href="/community/dealDetail.do?community_seq=${list.community_seq }">
                                            ${list.title}
                                    </a>
                                    <span style="font-size: 13px; color: tomato;">[${list.commentcount}]</span>
                                </td>
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
                                <td>
                                    <!--태그 걸어야함 -->
                                    <a href="/community/dealDetail.do?community_seq=${list.community_seq }">
                                            ${list.title}
                                    </a>
                                    <span style="font-size: 13px; color: tomato;">[${list.commentcount}]</span>
                                </td>
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
                                <td>
                                    <!--태그 걸어야함 -->
                                    <a href="/community/dealDetail.do?community_seq=${list.community_seq }">
                                            ${list.title}
                                    </a>
                                    <span style="font-size: 13px; color: tomato;">[${list.commentcount}]</span>
                                </td>
                            </tr>
                        </c:forEach>
                        </thead>
                    </table>
                </div>
            </div>
        </div>

    </div>
    <div class="row">
        <%--<div class="col-lg-6">
            <div class="card" style="width: 40rem;">
                <div class="card-header" style="text-align: center; padding: 10px 10px; margin-top: 8px">
                    <h2>자유게시판</h2>
                </div>
                <div class="card-body">
                    <h5 class="card-title">Card title</h5>
                    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                    <a href="#" class="btn btn-primary">자세히보기</a>
                </div>
            </div>
        </div>--%>
    </div>
</div>



<script type="text/javascript">

    $(document).ready(function () {
        const ctx = document.getElementById('visit-chart');
        const config = {
            type: 'line',
            data: {
                labels: ['${days[6]}','${days[5]}','${days[4]}','${days[3]}','${days[2]}','${days[1]}','${days[0]}'],
                datasets: [
                    {
                        label: '주',
                        data: [ '${sales.A}','${sales.B}','${sales.C}','${sales.D}','${sales.E}','${sales.F}','${sales.G}'],
                        backgroundColor: 'yellow',
                        borderColor: 'red',
                        borderWidth: 1,
                        fill : false
                    },
                    {
                        label: '월',
                        data: [0, 0, 0, 0, 0, 0],
                        backgroundColor: 'orange',
                        borderColor: 'gray',
                        borderWidth: 1
                    },
                    {
                        label: '년',
                        data: [0, 0, 0, 0, 0, 0],
                        backgroundColor: 'yellow',
                        borderColor: 'gray',
                        borderWidth: 1
                    }
                ]
            },
            options: {
                maintainAspectRatio: false,
                plugins: {
                    title: {
                        display: true,
                        text: '차트, 그것이 알고 싶다.'
                    }
                },
                scales: {
                    x: {
                        title: {
                            display: true,
                            text: '색상'
                        }
                    },
                    y: {
                        title: {
                            display: true,
                            text: '변곡량'
                        }
                    }
                },
            }
        }

        const chart = new Chart(ctx, config);

});

</script>
</body>
</html>

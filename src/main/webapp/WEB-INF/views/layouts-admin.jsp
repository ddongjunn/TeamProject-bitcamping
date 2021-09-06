<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- Favicon -->
    <link href="/resources/assets/img/brand/favicon.png" rel="icon" type="image/png">

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">

    <!-- Icons -->
    <link href="/resources/assets/vendor/nucleo/css/nucleo.css" rel="stylesheet">
    <link href="/resources/assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet">

    <!-- Argon CSS -->
    <link type="text/css" href="/resources/assets/css/argon.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery/jquery.twbsPagination.min.js"></script>

    <%--<style>
        #header {
            padding: 5px;
            margin-bottom: 5px;

        }
        #lnb {
            width: 15%;
            height: auto;
            min-height: 800px;
            padding: 50px 15px;
            float: left;
            background-color: tomato;
        }
        #content {
            width: 85%;
            padding: 50px;
            float: left;
        }
        #footer {
            clear: both;
            padding: 5px;
            background-color: lightblue;
        }
    </style>--%>

    <title>비트캠핑</title>

<!-- favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico" type="image/x-icon">
	<link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico" type="image/x-icon">
    
</head>
<body>
<div class="sidenav navbar navbar-vertical  fixed-left  navbar-expand-xs navbar-light bg-white">
    <tiles:insertAttribute name="lnb"/>
</div>

<div class="main-content">

    <tiles:insertAttribute name="header"/>

    <tiles:insertAttribute name="body"/>

</div>

<%--<script src="/resources/assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>--%>

<!-- Argon JS -->
<script src="/resources/assets/js/argon.min.js"></script>
</body>
</html>
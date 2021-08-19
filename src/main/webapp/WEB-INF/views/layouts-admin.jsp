<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:requestEncoding value="utf-8" />	<!-- time, encoding -->

<!DOCTYPE html>
<html>
<head>
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&amp;display=fallback">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="/resources/plugins/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="/resources/dist/css/adminlte.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="sidebar-mini layout-fixed" style="height: auto">
<div class="wrapper">
	<div id="header">
		<tiles:insertAttribute name="header"/>
    </div>
    <div id="sidebar-left">
        <tiles:insertAttribute name="leftmenu"/> 
    </div>
    <div id="content">
        <tiles:insertAttribute name="body"/>
    </div>
    <aside class="control-sidebar control-sidebar-dark" style="display: none;">
        <!-- Control sidebar content goes here -->
        <div class="p-3">
            <h5>Title</h5>
            <p>Sidebar content</p>
        </div>
    </aside>
    <div id="footer">
        <tiles:insertAttribute name="footer"/>
  	</div>
    <div id="sidebar-overlay"></div>
</div>

<!-- jQuery -->
<script src="/resources/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="/resources/dist/js/adminlte.min.js"></script>

</body>
</html>
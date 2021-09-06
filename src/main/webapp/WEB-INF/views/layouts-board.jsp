<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:requestEncoding value="utf-8" />	<!-- time, encoding -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <style>
        #header {
            margin-bottom: 5px;
        }
        #sidebar-left {
          width: 20%;
		  height: 100%;
		  min-height: 90%;
		  margin: 10px 0;
		  padding: 50px 15px;
		  float: left;  
		  border-right: 1px solid black;
		  text-align: right;
        }
        #content {
            width: 80%;
            padding: 20px 150px 20px 50px;
            float: left;
        }
        #footer {
            clear: both;
        }
    </style>

<title>bitcamping</title>
</head>
<body>
	<div id="header">
		<tiles:insertAttribute name="header"/>
    </div>
    <div id="sidebar-left">
        <tiles:insertAttribute name="leftmenu"/> 
    </div>
    <div id="content">
        <tiles:insertAttribute name="body"/>
    </div>
    <div id="footer">
        <tiles:insertAttribute name="footer"/>
  	</div>
</body>
</html>
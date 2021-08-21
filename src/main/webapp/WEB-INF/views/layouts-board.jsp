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
        padding: 5px;
        margin-bottom: 5px;
        background-color: lightgreen;
      }
      #sidebar-left {
          width: 15%;
          min-width: 230px;
          height: auto;
          min-height: 800px;
          padding: 50px 15px;
          float: left;
          background-color: #ffc859;
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
      
    </style>

<title>Insert title here</title>
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
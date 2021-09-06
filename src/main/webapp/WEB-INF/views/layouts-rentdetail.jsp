<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
/*       #header {
        padding: 5px;
        margin-bottom: 5px;
        background-color: lightgreen;
      }
      #sidebar-left {
        width: 15%;
        height:700px;
        padding: 5px;
        margin-right: 5px;
        margin-bottom: 5px;
        background-color: yellow;
      }
      #content {
        width: 75%;
        padding: 5px;
        margin-right: 5px;
      }
      #footer {
        padding: 5px;
        background-color: lightblue;
      } */
      
</style>
    
<title>비트캠핑</title>

<!-- favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico" type="image/x-icon">
	<link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico" type="image/x-icon">
    
</head>
<body>
	<div id="header">
		<tiles:insertAttribute name="header"/>
    </div>
    <div id="maincontent">
        <tiles:insertAttribute name="maincontent"/> 
    </div>
    <div id="subcontent1">
        <tiles:insertAttribute name="subcontent1"/>
    </div>
    <div id="subcontent2">
        <tiles:insertAttribute name="subcontent2"/>
    </div>
    <div id="footer">
        <tiles:insertAttribute name="footer"/>
  	</div>
</body>
</html>
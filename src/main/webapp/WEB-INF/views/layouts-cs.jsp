<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
#header {
  margin-bottom: 5px;
  width: 100%;
}
#lnb {
  width: 20%;
  height: 100%;
  min-height: 900px;
  margin: 10px 0;
  padding: 50px 15px;
  float: left;  
  border-right: 1px solid black;
  text-align: right;
}
#content {
  width: 80%;
  padding: 20px 150px 20px 20px;
  float: left;
  text-align: center;
}
#footer {
  clear: both;
  padding: 5px;
}
</style>
    
<title>Insert title here</title>
</head>
<body>

	<div id="header">
		<tiles:insertAttribute name="header"/>
    </div>
    <div id="box">
	    <div id="lnb">
	        <tiles:insertAttribute name="lnb"/> 
	    </div>
	    <div id="content">
	        <tiles:insertAttribute name="body"/>
	    </div>
    </div>
    <div id="footer">
        <tiles:insertAttribute name="footer"/>
  	</div>

</body>
</html>
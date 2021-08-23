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
            padding: 5px;
            margin-bottom: 5px;
            background-color: lightgreen;
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
    </style>

    <title>Insert title here</title>
</head>
<body>
<div id="header">
    <tiles:insertAttribute name="header"/>
</div>
<div id="lnb">
    <tiles:insertAttribute name="lnb"/>
</div>
<div id="content">
    <tiles:insertAttribute name="body"/>
</div>
<div id="footer">
    <tiles:insertAttribute name="footer"/>
</div>
</body>
</html>
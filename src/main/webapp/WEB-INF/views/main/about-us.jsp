<%--
  Created by IntelliJ IDEA.
  User: djlee
  Date: 2021-09-01
  Time: 오후 5:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>비트캠핑</title>
    <style>
        @media (max-width: 1300px) {
            #bluebterms, #bluebterms1 {
                width: 1000px;
            }
        }

        #bluebterms {
            font-size: 14px;
            line-height: 167%;
            margin: 30px auto;
            padding: 50px;
            background: #fff;
        }

        #bluebterms .contents{
            padding: 10px 20px;
            letter-spacing: -1px;
        }
        #bluebterms ul.agmenu{
            line-height: 30px;
            padding: 0;
            margin: 0;
            text-align: center;
        }

        #bluebterms ul.agmenu li a{
            display: inline-block;
            height: 30px;
            line-height: 31px;
            padding: 0 13px;
            letter-spacing: -0.02em;
            background: #4fd1c5;
            color: #fff;
        }
        #bluebterms ul.agmenu li:hover{
            color : black;
        }

        #bluebterms a{
            text-decoration: none;
        }

        #bluebterms ul{
            display: block;
            list-style-type: disc;
            margin-block-start: 1em;
            margin-block-end: 1em;
            margin-inline-start: 0px;
            margin-inline-end: 0px;
            padding-inline-start: 40px;
            margin:0;
            padding:0;
        }

        #bluebterms ul.agmenu li {
            display: inline-block;
        }

        #bluebterms h3{
            font-size: 22px;
            letter-spacing: -0.02em;
            margin: 30px 0 0 0;
            font-weight: bold;
            color: #4fd1c5;
            border-bottom: 2px #4fd1c5 solid;
            padding: 0 5px 5px 0;
            display: inline-block;
        }

        #bluebterms .contents h4 {
            font-size: 18px;
            letter-spacing: -0.02em;
            margin: 10px 0 5px 0;
            color: #000;
            display: block;
            margin-block-start: 1.33em;
            margin-block-end: 1.33em;
            margin-inline-start: 0px;
            margin-inline-end: 0px;
            font-weight: bold;
        }

    </style>
</head>
<body style="background: #eaebf2">
<div class="tse-scroll-content scrollwrapbox" style="margin: auto; width: 70%;">
    <div class="tse-content">
        <div id="bluebterms" >
            <h2 style="font-weight: 600; color: black"><b>ABOUT US</b></h2>
            <h3 id="ag1">제목</h3>
            <div class="contents">
                <h4>소제목</h4>
                <ul>
                    <li>
                    	내용
                    </li>
                </ul>
        	</div>
    	</div>
	</div>
</div>

</body>
</html>

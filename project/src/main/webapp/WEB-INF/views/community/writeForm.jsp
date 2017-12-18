<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>글 쓰기</title>

</head>
<body>
<div id="wrapper">

	<%@ include file="../common/header.jsp" %>
	<section>
		<div class="container subContent">
			<%@ include file="../common/boardNav.jsp" %>
			<%@ include file="../common/writeForm.jsp" %>
		</div>
	</section>
	<%@ include file="../common/footer.jsp" %>

</div> <!-- wrapper End -->
</body>
<style>


.writeFormWrap {
	width: 100%;
}
.writeFormWrap table {
	width: 100%;
	border-collapse: collapse;
	border-spacing: 0;
}
.writeFormWrap th, td {
	background-color: transparent;
	padding: 5px 10px;
	box-sizing: border-box;
}
.writeFormWrap th {
	width: 120px;
    padding: 7px 13px;
    border: 1px solid #e9e9e9;
    border-left: 0;
    background: #f5f8f9;
    text-align: left;
}
.writeFormWrap td {
	padding: 7px 10px;
    border-top: 1px solid #e9e9e9;
    border-bottom: 1px solid #e9e9e9;
    background: transparent;
}
input, textarea {
	border: 1px solid #e4eaec;
    background: #f7f7f7;
    color: #000;
    vertical-align: middle;
    line-height: 2em;
}
textarea {
	width: 100%;
	height: 200px;
}
.btnConfirm {
	margin: 20px 0;
	text-align: center;
}
.submitBtn, .cancelBtn { 
 	display: inline-block; 
     margin: 0 0 0 15px; 
     padding: 5px 30px; 
     color: #fff; 
     font-weight: 500; 
     font-size: 14px; 
     border-radius: 2px; 
     background: #5c5b65; 
     cursor: pointer; 
  	outline: none; 
  	border: none; 
 } 
 .submitBtn b { 
 	font-weight: normal; 
 } 
 .cancelBtn { 
 	background-color: #fff; 
 	border: 1px solid #e0e0e0; 
 	box-sizing: border-box; 
 	color: #111; 
} 
.uploadListWrap {
	display: block;
	margin-top: 10px;
	width: 100%;
	height: auto;
	background-color: #fff;
	border: 1px solid #bfbfbf;
	box-sizing: border-box;
}
.upListHead {
	width: 100%;
	height: 20px;
	border-bottom: 1px solid #bfbfbf;
}
.fileDrop:before {
	content: attr(placeholder);
}
.fileDrop {
	width: 100%;
	min-height: 90px;
	height: auto;
}
.allDelete {
 	float: right; 
    padding: 8px; 
    border: 0; 
    background-color: #f2f5f9; 
    letter-spacing: -0.1em; 
    cursor: pointer; 
    color: #111; 
}
@media (max-width: 1024px) {
	div.subContent {
		width: 100%; 
	}
}
@media (max-width: 768px) {
	.writeFormWrap th {
		padding: 0;
		width: 60px;
	}
	tr:nth-child(4){ 
 		display: none; 
 	} 
}
@media (max-width: 560px) {
	div.subContent {
		padding-left: 3%;
		padding-right: 3%;
	}
}
</style>
</html>
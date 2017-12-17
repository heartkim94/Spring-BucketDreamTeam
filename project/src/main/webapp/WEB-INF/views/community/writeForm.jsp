<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>글 쓰기</title>
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
	height: 300px;
}
.btnConfirm {
	margin: 20px 0;
	text-align: center;
}
input.submitBtn {
	padding: 8px;
    border: 0;
    background: orange;
    color: #fff;
    letter-spacing: -0.1em;
    cursor: pointer;
}
.cancelBtn {
	display: inline-block;
    padding: 7px;
    border: 1px solid #ccc;
    background: #fafafa;
    color: #000;
    text-decoration: none;
    vertical-align: middle;
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
	cursor: pointer;
	padding: 8px;
    border: 0;
    background: #E83F38;
    font-size: 14px;
    color: #fff;
    letter-spacing: -0.1em;
}
.human {
	cursor: pointer;
	color: red;
}
</style>
</head>
<body>
<div id="wrapper">

	<%@ include file="../common/header.jsp" %>
	<section>
		<div class="container subContent">
			<nav>
				<c:if test="${boardNum == 1}">
					<h1>NOTICE</h1>
					<span>home > community > notice</span>
				</c:if>
				<c:if test="${boardNum == 2}">
					<h1>QnA</h1>
					<span>home > community > QnA</span>
				</c:if>
				<c:if test="${boardNum == 3}">
					<h1>FAQ</h1>
					<span>home > community > FAQ</span>
				</c:if>
			</nav>
			<%@ include file="../common/writeForm.jsp" %>
		</div>
	</section>
	<%@ include file="../common/footer.jsp" %>

</div> <!-- wrapper End -->
</body>
</html>
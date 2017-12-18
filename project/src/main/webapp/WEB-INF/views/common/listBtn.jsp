<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<title>listBtn</title>
<style>
	.btnArea {
		overflow: hidden;
		margin-top: 10px;
	}
	.btnArea a {
		float: right;
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
</style>
</head>
<body>
	<div class="btnArea">
		<c:if test="${(!adminOnly || isAdmin) && boardNum != 0}">
			<td><a href="write?boardNum=${boardNum}">글쓰기</a></td>
		</c:if>
	</div>
</body>
</html>
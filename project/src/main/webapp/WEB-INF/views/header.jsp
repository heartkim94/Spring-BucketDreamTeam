<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<title>header</title>
	<link rel="stylesheet" href="/project/resources/css/normalize.css" >
	<link rel="stylesheet" href="/project/resources/css/style.css" >
	<script src="/project/resources/js/prefixfree.min.js"></script>
</head>

<body>
	<%
		String id = (String)session.getAttribute("id");
	%>
	<header>
		<c:if test="${id != null}">
			<div class="loginbtn">
				<button onclick="document.location.href='logout.do'">로그아웃</button>
				<input type="button" value="로그아웃input" onclick="document.location.href='logout.do'">
			</div>
		</c:if>
		<c:if test="${id == null}">
			<div class="loginbtn">
				<button onclick="document.location.href='home.do'">로그인</button>
				<input type="button" value="로그인input" onclick="document.location.href='home.do'">
			</div>
		</c:if>
		<c:if test="${id != null}">
			<!-- homeController에 mapping -->
			<a href="/project/groupMain.do"><strong>header</strong></a>
		</c:if>
		<c:if test="${id == null}">
			<a href="home.do"><strong>header</strong></a>			
		</c:if>
	</header>
	<hr>
</body>
</html>
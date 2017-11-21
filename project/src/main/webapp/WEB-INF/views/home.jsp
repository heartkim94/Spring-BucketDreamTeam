<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Home</title>
	<link rel="stylesheet" href="resources/style.css" type="text/css">
</head>

<body>
	<%@ include file="header.jsp" %>
	<div id="includeHeader"></div>
	<div class="contents">
		<div class="intro">
			<img alt="홈페이지 소개 사진이나 글, 슬라이드" src="resources/img/흐엉.jpg" width="300" height="300"><br>
			<h1>Hello, world!</h1>
			<p>blah blah</p>
			<button type="button" onclick="alert('Coming Soon!')">Click!!</button>
		</div>
		
		<div class="login">
			<form action="" method="post" id="loginForm">
				<br>
				<input type="text" placeholder="아이디" name="id" id="id"></label><br>
				<input type="password" placeholder="비밀번호" name="password" id="password"></label><br>
				<input type="submit" value="로그인"><br>
				<a href="#">ID / PW 찾기</a> | <a href="#">회원가입</a>
			</form>
		</div>
	</div>
	
	<%@ include file="footer.jsp" %>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
</body>
</html>

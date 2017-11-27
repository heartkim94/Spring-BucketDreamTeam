<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>MAIN</title>
<!-- 	<link rel="stylesheet" href="./resources/css/login.css"> -->
<!-- 	<script src="//code.jquery.com/jquery-3.1.0.min.js"></script> -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script>
		
		$(document).ready(function(){
			
			let Certify=${dbCertify};
			if(Certify == 0) {
				alert("회원가입 이메일 인증을 안하셨습니다.");
			}
			document.location.href="./";
		});
	
	</script>  
</head>

<body>
<div id="wrapper">
	<%@ include file="header.jsp" %>
	
	<section>
		<div class="mainContent">
			<div class="contentRow">
				<div class="intro">
					<img src="resources/img/흐엉.jpg" width="300" height="300" alt="홈페이지 소개 사진이나 글, 슬라이드"><br>
					<h1>Hello, world!</h1>
					<p>blah blah</p>
					<button type="button" onclick="alert('Coming Soon!!!')">Click!!</button>
				</div>
				
				<div class="login">
					<c:if test="${id == null}">
						<form action="/project/login.do" method="post" id="loginForm">
							<br>
							<input type="text" id="id" name="id" placeholder="아이디" required=""/><br>
							<input type="password" id="pass" name="pass" placeholder="비밀번호" required=""/><br>
							<input type="submit" value="로그인"><br>
							<a href="#">ID / PW 찾기</a> &nbsp; | &nbsp; <a href="userProvisionForm.do">회원가입</a>
						</form>
					</c:if>
					<c:if test="${id != null}">
						<center>
							<form action="/project/logout.do" method="post">
							 	<p>${id}님 환영합니다</p>
							 	<a href="/project/mypage.do">회원정보수정</a><br>
								<button id="logout">로그아웃</button>
							</form>
						</center>
					</c:if>
				</div>
			</div>
		</div>
	</section>
	
	<%@ include file="footer.jsp" %>
</div> <!-- wrapper End -->
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>메인(로그인)</title>
		<link rel="stylesheet" href="./resources/css/login.css">
<!-- 		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> -->
		<script src="//code.jquery.com/jquery-3.1.0.min.js"></script>
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
<!-- 	<div class="container">		 -->
<%-- 		<%@ include file="header.jsp" %>			 --%>
<!-- 		<section id="content"> -->
<!-- 			<form action="/project/login.do" method="post"> -->
<!-- 				<h1>로그인</h1> -->
<!-- 				<div> -->
<!-- 					<input type="text" id="id" name="id" placeholder="아이디" required=""/> -->
<!-- 				</div> -->
<!-- 				<div> -->
<!-- 					<input type="password" id="pass" name="pass" placeholder="비밀번호" required=""/> -->
<!-- 				</div> -->
<!-- 				<div> -->
<!-- 					<input type="submit" value="로그인"/> -->
<!-- 					<input type="button" value="회원가입" onclick="document.location.href='userProvisionForm.do'"> -->
<!-- 					<a href="javascript:void(window.open('/project/userIdPassFind.do', '_blank','width=450, height=270'))">아이디/비밀번호 찾기</a> -->
<!-- 				</div> -->
<!-- 			</form>form -->
<!-- 		</section>content -->
<%-- 		<%@ include file="footer.jsp" %> --%>
<!-- 	</div> -->
	
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
						<form action="/project/login.do" method="post" id="loginForm">
							<br>
							<input type="text" id="id" name="id" placeholder="아이디" required=""/><br>
							<input type="password" id="pass" name="pass" placeholder="비밀번호" required=""/><br>
							<input type="submit" value="로그인"><br>
							<a href="javascript:void(window.open('/project/userIdPassFind.do', '_blank','width=450, height=270'))">ID / PW 찾기</a> | <a href="userProvisionForm.do">회원가입</a>
						</form>
					</div>
				</div>
			</div>
		</section>
		<%@ include file="footer.jsp" %>
	
	</div> 
	
	
	
</body>
</html>

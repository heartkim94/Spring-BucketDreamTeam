<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>메인(로그인)</title>
		<link rel="stylesheet" href="./resources/css/login.css">
	</head>
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
<body>
<div class="container">					
	<section id="content">
		<form action="/project/login" method="post">
			<h1>로그인</h1>
			<div>
				<input type="text" id="id" name="id" placeholder="아이디" required=""/>
			</div>
			<div>
				<input type="password" id="pass" name="pass" placeholder="비밀번호" required=""/>
			</div>
			<div>
				<input type="submit" value="로그인"/>
				<input type="button" value="회원가입" onclick="document.location.href='userProvisionForm'">
				<a href="javascript:void(window.open('/project/userIdPassFind', '_blank','width=450, height=270'))">아이디/비밀번호 찾기</a>
			</div>
		</form><!-- form -->
	</section><!-- content -->
</div><!-- container -->
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Home</title>
</head>

<body>

	<div id="wrapper">
	
		<%@ include file="../header.jsp" %>
		<section>
			<div>
				<center>
					<p>로그인 하면 나오는 그룹메인페이지 입니다</p>
					<form action="/project/logout.do" method="post">
					 	<!-- <input type="button" value="로그아웃">  -->  
					 	<p>${id}님 환영합니다</p>
					 	<a href="/project/mypage.do">회원정보수정</a><br>
						<button id="logout">로그아웃</button> <!-- 버튼태그가 폼태그 안에 선언되었을때는 무조건 submit한다  -->
					</form>
				</center>
			</div>
		</section>
		<%@ include file="../footer.jsp" %>
	
	</div> <!-- wrapper End -->
	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
</body>
</html>

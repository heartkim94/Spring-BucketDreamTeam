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
			그룹메인
				<form action="/project/logout.user" method="post">
				 	<!-- <input type="button" value="로그아웃">  -->  
				 	<p><a href="/project/mypage.user">${id}</a>님 환영합니다</p>
					<button id="logout">로그아웃</button> <!-- 버튼태그가 폼태그 안에 선언되었을때는 무조건 submit한다  -->
				</form>
			</div>
		</section>
		<%@ include file="../footer.jsp" %>
	
	</div> <!-- wrapper End -->
	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
</body>
</html>

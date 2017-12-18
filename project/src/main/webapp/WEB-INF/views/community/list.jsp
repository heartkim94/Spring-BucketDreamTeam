<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<title>게시판</title>
<style>
	
</style>
</head>
<body>
<div id="wrapper">
	<%@ include file="../common/header.jsp" %>
	<section>
		<div class="container subContent">
		<%@ include file="../common/boardNav.jsp" %>
			<jsp:include page="${view}"/>
		</div>
	</section>
	<%@ include file="../common/footer.jsp" %>
</div>
</body>
<style>
</style>
</html>
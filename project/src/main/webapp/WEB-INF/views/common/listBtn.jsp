<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<title>listBtn</title>
<style>
	
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<title>공지사항</title>
<link href="resources/style.css" rel="stylesheet" type="text/css">
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
</head>

<body>
	<%@ include file="../header.jsp"%>
	<%@ include file="/WEB-INF/views/aside.jsp"%>
	
	<div class="section">
		<table width="700">
			<tr>
				<td align="right"><a href="write.bbs">글쓰기</a></td>
			</tr>
		</table>
		<table border="1" width="700" cellpadding="2" cellspacing="2">
			<tr height="30">
				<td align="center" width="250">제 목</td>
			</tr>
	
			<c:forEach var="article" items="${articleList}">
				<tr height="30">
					<td align="center" width="50"><c:out value="${article.title}" /></td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="5" align="center" height="40">${pageCode}</td>
			</tr>
		</table>
	</div>
	
	<%@ include file="../footer.jsp"%>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
</body>
</html>
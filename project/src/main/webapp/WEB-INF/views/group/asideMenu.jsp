<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		.groupInfo .groupNum {
			display: none;
		}
	</style>
</head>
<body>
	<aside class="groupMenu">
		<div class="groupInfo">
			<ul>
				<li><a href="view">프로필이미지</a></li>
				<li>${group.groupName}</li>
				<li class="groupNum">${groupNum}</li>
				<li><a href="todoSetting">설정</a></li>
			</ul>
		</div>
		<hr>
		메뉴<br>
		<hr>
		<ul>
			<c:forEach var="board" items="${boardList}">
				<li><a href="list?boardNum=${board.boardNum}&pageNum=1">${board.boardName}</a></li>
			</c:forEach>
			<li><a href="boardSetting">게시판 설정</a><li>
		</ul>
	</aside>
</body>
</html>
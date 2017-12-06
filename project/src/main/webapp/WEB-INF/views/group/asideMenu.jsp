<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<aside class="groupMenu">
		<a href="view">프로필이미지</a><br>
		${group.groupName}<br>
		<a href="setting">설정</a>
		<hr>
		메뉴<br>
		<hr>
		<ul>
			<c:forEach var="board" items="${boardList}">
				<li><a href="list?boardNum=${board.boardNum}&pageNum=1">${board.boardName}</a></li>
			</c:forEach>
		</ul>
	</aside>
</body>
</html>
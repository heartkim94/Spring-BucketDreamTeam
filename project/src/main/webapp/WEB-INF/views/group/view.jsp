<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		.groupMenu, .groupMain, .groupApp {
			height: 70%;
			float: left;
			border: 1px solid black;
		}
		.groupMenu {
			width: 15%;
		}
		.groupMain {
			width: 60%;
		}
		.groupApp {
			width: 15%;
		}
		.clear {
			clear: both;
		}
	</style>
</head>
<body>
	<div id="wrapper">
		<%@ include file="./../header.jsp" %>
		<section>
			<aside class="groupMenu">
				프로필이미지<br>
				그룹이름<br>
				<a href="setting.do">설정</a>
				<hr>
				메뉴<br>
				<hr>
				<ul>
					<li>메뉴1</li>
					<li>메뉴2</li>
					<li>메뉴3</li>
					<c:forEach var="board" items="${boardList}">
						<li>${board.boardName}</li>
					</c:forEach>
				</ul>
			</aside>
			<div class="groupMain">
				내용<br>
				asdsdaf
			</div>
			<aside class="groupApp">기타 기능</aside>
			<div class="clear"></div>
		</section>
		<%@ include file="./../footer.jsp" %>
	</div> <!-- wrapper End -->
</body>
</html>
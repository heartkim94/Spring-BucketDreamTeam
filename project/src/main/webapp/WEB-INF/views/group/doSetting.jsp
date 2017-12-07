<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="/project/resources/css/group.css" >
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/header.jsp" %>
		<section>
			<div class="container settingContainer groupMain">
				<h3>목표</h3>
				<hr><br>
				<div class="doListContainer">
					<ul>
						<c:forEach var="todo" items="${doList}">
							<li doNum="${todo.doNum}" style="margin-left: ${25 * todo.depth}">
								<input type="checkbox" name="done" <c:if test="${todo.done}">checked</c:if>> ${todo.doName}
								<c:if test="${todo.doWhen!=null}">
									[
									${todo.doWhen} <c:if test="${!todo.doAllDay}">${todo.doWhenTime}</c:if>
									~ ${todo.doEnd} <c:if test="${!todo.doAllDay}">${todo.doEndTime}</c:if>
									]
								</c:if>
							</li>
							<c:set var="lastPath" value="${todo.path}"/>
						</c:forEach>
					</ul>
				</div>
				<br>
				<h3>게시판 목록</h3>
				<hr>
				<div class="boardList">
					<ul>
						<c:forEach var="board" items="${boardList}">
							<li boardNum="${board.boardNum}">
								<name>${board.boardName}</name>
								<button class="rename">이름변경</button>
								<button class="saveName">저장</button>
								<button class="remove">삭제</button>
							<li>
						</c:forEach>
					</ul>
					<br>
					<button class="newBoard">새로만들기</button>
				</div>
				<br>
				<button onclick="location.href='view'">완료</button>
			</div>
		</section>
		<%@ include file="../common/footer.jsp" %>
	</div> <!-- wrapper End -->
</body>
</html>
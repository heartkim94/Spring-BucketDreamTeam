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
	<style>
		.todoContainer {
			display: flex;
		}
		.todoList {
			border: 1px solid black;
			flex: 1;
		}
		.todoList .selected {
			background: #ccc;
		}
		.todoTools {
			border: 1px solid black;
			flex: 1;
		}
		.todoList input[type=text] {
			border: 1px solid black;
		}
	</style>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/header.jsp" %>
		<section>
			<div class="container settingContainer">
				<%@ include file="asideMenu.jsp" %>
				<div class="groupMain">
					<h3>목표</h3>
					<hr><br>
					<div class="todoContainer">
						<div class="todoList">
							<ul>
								<c:forEach var="todo" items="${doList}">
									<li style="margin-left: ${25 * todo.depth}"
										doNum="${todo.doNum}" depth="${todo.depth}">
										<input type="checkbox" name="done" <c:if test="${todo.done}">checked</c:if>>
										<span class="doName">${todo.doName}</span>
										<c:if test="${todo.doWhen!=null}">
											<br>
											|    &nbsp;[
											${todo.doWhen} <c:if test="${!todo.doAllDay}">${todo.doWhenTime}</c:if>
											~ ${todo.doEnd} <c:if test="${!todo.doAllDay}">${todo.doEndTime}</c:if>
											]
										</c:if>
									</li>
									<c:set var="lastPath" value="${todo.path}"/>
								</c:forEach>
							</ul>
							<hr style="border:0.5px solid black">
							<span>
								<button class="moveUpTodo">▲</button>
								<button class="moveDownTodo">▼</button>
								<button class="moveLeftTodo">◀</button>
								<button class="moveRightTodo">▶</button>
							</span>
						</div>
						<div class="todoTools">
							<ul>
								<li><button class="renameTodo">이름 변경</button><li>
								<li><button class="addTodo">목표 추가</button></li>
								<li><button>test</button></li>
							</ul>
						</div>
					</div>
					<br>
					<button onclick="location.href='view'">취소</button>
					<button class="saveBtn" onclick="location_href='view'">저장</button>
				</div>
				<%@ include file="asideApp.jsp" %>
			</div>
		</section>
		<%@ include file="../common/footer.jsp" %>
	</div> <!-- wrapper End -->
</body>
<script src="/project/resources/js/todoTools.js"></script>
</html>
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
		#todoCalendar .todoContainer {
			display: flex;
		}
		#todoCalendar .calendarBox {
			flex: 3;
		}
		#todoCalendar .todoList {
			border: 1px solid black;
			flex: 1;
		}
		#todoCalendar .todoList .selected {
			background: #ccc;
		}
		#todoCalendar .todoList input[type=text] {
			border: 1px solid black;
		}
		#todoCalendar .folded {
			display: none;
		}
		#todoCalendar .line {
			border:0.5px solid black
		}
	</style>
</head>
<body>
		<div class="todoContainer">
		<div class="calendarBox">
			<%@ include file="calendar.jsp" %>
		</div>
		<div class="todoList">
			<ul>
				<c:forEach var="todo" items="${todoList}" varStatus="status">
					<li style="margin-left: ${10 * todo.depth}"
						doNum="${todo.doNum}" depth="${todo.depth}">
						<input type="checkbox" name="done" <c:if test="${todo.done}">checked</c:if>>
						<span class="doName">${todo.doName}</span>
						<c:if test="${todoList[status.index+1]!= null
									&& todoList[status.index+1].depth > todo.depth}">
							<button class="fold">접기</button>
						</c:if>
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
			<hr class="line">
			<span>
				<button class="moveUpTodo">▲</button>
				<button class="moveDownTodo">▼</button>
				<button class="moveLeftTodo">◀</button>
				<button class="moveRightTodo">▶</button>
			</span>
			<hr class="line">
			<div class="todoTools">
				<ul>
					<li><button class="renameTodo">이름 변경</button><li>
					<li><button class="addTodo">목표 추가</button></li>
					<li><button>test</button></li>
				</ul>
			</div>
		</div>
	</div>
</body>
<script src="/project/resources/js/todoTools.js"></script>
</html>
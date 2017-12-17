<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>그룹 일정 관리</title>
	<style>
		/* todoCaldendar */
		.todoCalendar {
			float: left;
		}
		.todoCalendar td {
			width: 90px;
			height: 100px;
			vertical-align: top;
			font-size: 0.9em;
			overflow: hidden;
		}
		.todoCalendar .todo {
			width: inherit;
			box-sizing: border-box;
			border-radius: 5px;
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
			padding: 0 5px;
		}
		
		/* todoList */
		.todoList {
			float: right;
			border: 1px solid black;
			width: 250px;
			margin-top: 30px;
		}
		.todoList .selected {
			background: #ccc;
		}
		.todoList input[type=text] {
			border: 1px solid black;
		}
		.folded {
			display: none;
		}
		.line {
			border:0.5px solid black
		}
		.todoContent td:first-child {
			width: 70px;
		}
		.todoContent input:not([type=checkbox]) {
			width: fill-available;
		}
		.todoContent .memo {
			width: fill-available;
			height: 200px;
		}
		.clear {
			clear: both;
		}
	</style>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/header.jsp" %>
		<section>
			<div class="container subContent">
				<h3>목표</h3>
				<hr><br>
				<div class="todoContainer">
					<div class="todoCalendar">
						<div class="calendar"></div>
					</div>
					<div class="todoList">
						<ul></ul>
						<hr class="line">
						<span class="todoTools">
							<button class="moveUpTodo">▲</button>
							<button class="moveDownTodo">▼</button>
							<button class="moveLeftTodo">◀</button>
							<button class="moveRightTodo">▶</button>
							<button class="addTodo">추가</button>
							<button class="deleteTodo">제거</button>
						</span>
						<hr class="line">
						<div class="todoContent">
							<table>
								<tr>
									<td>이름: </td>
									<td>
										<input type="text" name="doName">
<!-- 										<button class="renameTodo">저장</button> -->
									</td>
								</tr>
								<tr>
									<td>일시: </td>
									<td><input type="checkbox" name="doAllDay">하루종일<td>
								</tr>
								<tr>
									<td>시작: </td>
									<td><input type="date" name="doWhen"></td>
								</tr>
								<tr>
									<td>시작시간: </td>
									<td><input type="time" name="doWhenTime" readonly></td>
								</tr>
								<tr>
									<td>종료: </td>
									<td><input type="date" name="doEnd"></td>
								</tr>
								<tr>
									<td>종료시간: </td>
									<td><input type="time" name="doEndTime" readonly></td>
								</tr>
								<tr>
									<td>색깔: </td>
									<td><input type="color" name="color" value="#73AD21"></td>
								</tr>
								<tr>
									<td>메모</td>
									<td><textarea class="memo"></textarea></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<div class="clear"></div>
				<button onclick="location.href='view'">취소</button>
				<button class="saveBtn" onclick="location_href='view'">저장</button>
			</div>
		</section>
		<%@ include file="../common/footer.jsp" %>
	</div> <!-- wrapper End -->
</body>
<script src="/project/resources/js/calendar.js"></script>
<script src="/project/resources/js/todoTools.js"></script>
<script>
let todoList
$(function() {
	todoList = new TodoList(); 
	<c:forEach var="todo" items="${todoList}">
	todoList.push(new Todo({
		doNum: "${todo.doNum}",
		doName: "${todo.doName}",
		doWhen: "${todo.doWhen}",
		doWhenTime: "${todo.doWhenTime}",
		doEnd: "${todo.doEnd}",
		doEndTime: "${todo.doEndTime}",
		doAllDay: "${todo.doAllDay}",
		color: "${todo.color}",
		done: "${todo.done}",
		memo: "${todo.memo}",
		parentNum: "${todo.parentNum}",
		path: "${todo.path}",
		pos: "${todo.pos}",
		depth: "${todo.depth}",
		groupNum: "${todo.groupNum}",
		userNum: "${todo.userNum}"
	}));
	</c:forEach>
	
	todoList.list();
	
	
	$(".calendar").on("click", ".calendarLeft", function() {
		todoList.list();
	});
	
	$(".calendar").on("click", ".calendarRight", function() {
		todoList.list();
	})
});
</script>
</html>
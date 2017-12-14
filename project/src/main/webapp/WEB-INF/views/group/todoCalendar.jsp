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
		#todoCalendar .todoCalendar {
			flex: 3;
		}
		.todoCalendar td {
			width: 100px;
			height: 100px;
			vertical-align: top;
			font-size: 0.9em;
		}
		.todoCalendar .todo {
			border-radius: 5px;
			background: #73AD21;
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
			padding: 0 5px;
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
	<div class="todoCalendar">
		<div class="calendar"></div>
	</div>
	<div class="todoList">
		<ul></ul>
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
				<li>
					<button class="renameTodo">이름 변경</button>
					<button class="addTodo">목표 추가</button>
					<button class="deleteTodo">목표 제거</button>
				</li>
			</ul>
		</div>
		<div class="todoContent">
			<br>
			<ul>
				<li>
					<label>이름: <input type="text" name="doName"></label>
				<li>
				<li>일시 <input type="checkbox" name="doAllDay"></li>
				<li>시작:
					<input type="date" name="doWhen">
					<input type="time" name="doWhenTime">
				</li>
				<li>종료: [2017-12:15] [오후 12:00]</li>
				<li>메모</li>
				<li><textarea>aaa</textarea><li>
			</ul>
			<div class="test">
			</div>
		</div>
	</div>
</body>
<script src="/project/resources/js/calendar.js"></script>
<script src="/project/resources/js/todoTools.js"></script>
<script>
</script>
</html>
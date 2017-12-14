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
		
		/* #todoCaldendar */
		.todoList {
			flex: 3;
		}
	</style>
	<style>
		.todoContainer {
			display: flex;
		}
		.todoCalendar {
			flex: 3;
		}
		.todoCalendar td {
			width: 100px;
			height: 100px;
			vertical-align: top;
			font-size: 0.9em;
			overflow: hidden;
		}
		.todoCalendar .todo {
			width: 100px;
			box-sizing: border-box;
			border-radius: 5px;
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
			padding: 0 5px;
		}
		.todoList {
			border: 1px solid black;
			flex: 1;
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
	</style>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/header.jsp" %>
		<section>
			<div class="container xgroupContainer">
<%-- 				<%@ include file="asideMenu.jsp" %> --%>
<!-- 				<div class="groupMain"> -->
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
<!-- 							<div class="todoTools"> -->
<!-- 								<ul> -->
<!-- 									<li> -->
<!-- 										<button class="renameTodo">이름 변경</button> -->
<!-- 										<button class="addTodo">목표 추가</button> -->
<!-- 										<button class="deleteTodo">목표 제거</button> -->
<!-- 									</li> -->
<!-- 								</ul> -->
<!-- 							</div> -->
							<div class="todoContent">
								<br>
								<ul>
									<li>
										<label>이름: <input type="text" name="doName"></label>
										<button>저장</button>
									<li>
									<li>일시 <input type="checkbox" name="doAllDay">하루종일</li>
									<li>시작: <input type="date" name="doWhen"></li>
									<li>시작시간: <input type="time" name="doWhenTime" readonly></li>
									<li>종료: <input type="date" name="doEnd"></li>
									<li>종료시간: <input type="time" name="doEndTime" readonly></li>
									<li>색깔: <input type="color" name="color" value="#73AD21"></li>
									<li>메모</li>
									<li><textarea class="memo"></textarea><li>
								</ul>
								<div class="test">
								</div>
							</div>
						</div>
					</div>
					<br>
					<button onclick="location.href='view'">취소</button>
					<button class="saveBtn" onclick="location_href='view'">저장</button>
<!-- 				</div> -->
<%-- 				<%@ include file="asideApp.jsp" %> --%>
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
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
		/* #todoList */
		#todoList .todoList {
			flex: 1;
		}
		#todoList .todoTools {
			border: 1px solid black;
			flex: 1;
		}
		/* #todoCaldendar */
		#todoCalendar .todoList {
			flex: 3;
		}
	</style>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/header.jsp" %>
		<section>
			<div class="container groupContainer">
				<%@ include file="asideMenu.jsp" %>
				<div class="groupMain">
					<h3>목표</h3>
					<hr><br>
					<div class="tabContainer">
						<ul class="tabs">
							<li class="tabCurrent"><a href="#todoList">목록</a></li>
							<li><a href="#todoCalendar">달력</a></li>
							<li><a href="#todoFlow?">플로우?</a></li>
							<!-- 간트 차트(Gantt chart) -->
						</ul>
						<div class="clear"></div>
						<div class="tabContent tabCurrent" id="todoList">
							<%@ include file="todoList.jsp" %>
						</div>
						<div class="tabContent" id="todoCalendar">
							<%@ include file="todoCalendar.jsp" %>
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
<script>
	let todoList = new TodoList(); 
	<c:forEach var="todo" items="${todoList}">
	todoList.push(new Todo({
		doNum: "${todo.doNum}",
		doName: "${todo.doName}",
		doWhen: "${todo.doWhen}",
		doWhenTime: "${todo.doWhenTime}",
		doEnd: "${todo.doEnd}",
		doEndTime: "${todo.doEndTime}",
		doAllDay: "${todo.doAllDay}",
		done: "${todo.done}",
		parentNum: "${todo.parentNum}",
		path: "${todo.path}",
		pos: "${todo.pos}",
		depth: "${todo.depth}",
		groupNum: "${todo.groupNum}",
		userNum: "${todo.userNum}"
	}));
	</c:forEach>
	console.log(todoList);
	
	todoList.list();
</script>
<script src="/project/resources/js/tabs.js"></script>
<script src="/project/resources/js/todoTools.js"></script>
</html>
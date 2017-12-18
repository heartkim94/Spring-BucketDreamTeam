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
		/* todoList */
		.todoList {
			float: right;
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
							<button onclick="location.href='view'">취소</button>
							<button class="saveBtn">저장</button>
						</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
		</section>
		<%@ include file="../common/footer.jsp" %>
	</div> <!-- wrapper End -->
</body>
<script>
</script>
<script src="/project/resources/js/calendar.js"></script>
<script src="/project/resources/js/todoTools.js"></script>
<script>
$(function() {
	$(".calendar").on("click", ".calendarLeft", function() {
		todoList.list();
	});
	
	$(".calendar").on("click", ".calendarRight", function() {
		todoList.list();
	})
});
</script>
</html>
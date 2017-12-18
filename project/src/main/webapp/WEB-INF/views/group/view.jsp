<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>그룹 메인</title>
	
</head>
<body>
<%@ include file="../common/header.jsp" %>
	<div id="wrapper">
		<section>
			<div class="container subContent">
				<h3>목표</h3>
				<hr><br>
				<div class="todoContainer">
					<div class="todoCalendar">
						<div class="calendar"></div>
					</div>
					<div class="switchRight">▶</div>
					<div class="todoList mobileShow">
						<ul></ul>
						<hr class="line">
						<div class="todoContent">
							<table>
								<tr>
									<td>이름: </td>
									<td>
										<input type="text" name="doName" readonly>
<!-- 										<button class="renameTodo">저장</button> -->
									</td>
								</tr>
								<tr>
									<td>일시: </td>
									<td><input type="checkbox" name="doAllDay" readonly>하루종일<td>
								</tr>
								<tr>
									<td>시작: </td>
									<td><input type="date" name="doWhen" readonly></td>
								</tr>
								<tr>
									<td>시작시간: </td>
									<td><input type="time" name="doWhenTime" readonly></td>
								</tr>
								<tr>
									<td>종료: </td>
									<td><input type="date" name="doEnd" readonly></td>
								</tr>
								<tr>
									<td>종료시간: </td>
									<td><input type="time" name="doEndTime" readonly></td>
								</tr>
								<tr>
									<td>색깔: </td>
									<td><input type="color" name="color" value="#73AD21" readonly></td>
								</tr>
								<tr>
									<td>메모</td>
									<td><textarea class="memo" readonly></textarea></td>
								</tr>
							</table>
						</div>
					</div>
					<div class="switchLeft mobileShow">◀</div>
				</div>
				<div class="clear"></div>
			</div>
		</section>
		<%@ include file="../common/footer.jsp" %>
	</div> <!-- wrapper End -->
</body>
<script src="/project/resources/js/calendar.js"></script>
<script src="/project/resources/js/todoTools.js"></script>
</html>
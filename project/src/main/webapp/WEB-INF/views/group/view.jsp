<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>그룹 메인</title>
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<style>
	#todoList, #todoCalendar, .todoContent {
		float: left;
	}
	.todoContent {
		border: 1px solid black;
		margin-top: 30px;
		margin-left: 50px;
	}
	</style>
</head>
<body>
<%@ include file="../common/header.jsp" %>
	<div id="wrapper">
		<section>
		<div class="container subContent">
			내용<br>
			git싫엉<br>
			<div class="tabs">
				<ul>
					<li class="tabCurrent"><a href="#todoList">목록</a></li>
					<li><a href="#todoCalendar">달력</a></li>
				</ul>
				<div class="clear"></div>
				<div id="todoList" class="tabContent tabCurrent">
					기본 목록
					<div class="todoList">
						<ul></ul>
					</div>
				</div>
				<div id="todoCalendar" class="tabContent">
					<div class="todoCalendar">
						<div class="calendar"></div>
					</div>
				</div>
				<div class="todoContent">
					<table>
						<tr>
							<td>이름: </td>
							<td><input type="text" name="doName" readonly></td>
						</tr>
						<tr>
							<td>일시: </td>
							<td><input type="checkbox" name="doAllDay">하루종일<td>
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
				<div class="clear"></div>
			</div>
		</div>
		</section>
		<%@ include file="../common/footer.jsp" %>
	</div> <!-- wrapper End -->
</body>
<script	src="/project/resources/js/tabs.js"></script>
<script src="/project/resources/js/calendar.js"></script>
<script src="/project/resources/js/todoTools.js"></script>
</html>
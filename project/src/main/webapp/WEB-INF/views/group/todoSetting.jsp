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
// let changed = false;
// $(function() {
// 	changed = true;
// 	$(".tabs li").on("click", function(event) {
// 		if(changed) {
// 			event.stopImmediatePropagation();
// 			alert("you didn't save");
// 		}
// 	});
// });
</script>
<script src="/project/resources/js/tabs.js"></script>
<script src="/project/resources/js/todoTools.js"></script>
</html>
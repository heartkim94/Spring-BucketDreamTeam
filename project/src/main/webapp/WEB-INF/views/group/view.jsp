<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="/project/resources/css/group.css" >
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<style>
		.calendar {
			border-collapse: collapse;
		}
		.calendar td {
			border: 1px solid black;
			width: 100px;
			height: 100px;
		}
	</style>  
</head>
<body>
<%@ include file="../common/header.jsp" %>
	<div id="wrapper">
		<section>
			<%@ include file="asideMenu.jsp" %>
			<div class="groupMain">
				내용<br>
				asdsdaf<br>
				<table class="calendar">
					<thead>
						<tr>
							<th day="0">일</th>
							<th day="1">월</th>
							<th day="2">화</th>
							<th day="3">수</th>
							<th day="4">목</th>
							<th day="5">금</th>
							<th day="6">토</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				<script>
					let today = new Date();
					let year = today.getFullYear();
					let month= today.getMonth();
					let date = new Date(year, month, 1);
					date.setDate(1-date.getDay());
					console.log(date);
					do {
						let tr = $("<tr></tr>");
						$(".calendar tbody").append(tr);
						for(let i=0; i<7; i++) {
							let td = $("<td></td>");
							let day = date.getDate();
							$(td).text(day);
							$(tr).append(td);
							date.setDate(day + 1);
						}
					} while(month == date.getMonth());
				</script>
			</div>
			<%@ include file="asideApp.jsp" %>
			<div class="clear"></div>
		</section>
		<%@ include file="../common/footer.jsp" %>
	</div> <!-- wrapper End -->
</body>
</html>
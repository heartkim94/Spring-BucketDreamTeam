<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		.calendar {
			border-collapse: collapse;
		}
		.calendar td {
			border: 1px solid black;
			width: 70px;
			height: 70px;
		}
		.calendar td.notThisMonth {
			color: #ccc;
		}
	</style>
</head>
<body>
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
</body>
<script>
	let today = new Date();
	let year = today.getFullYear();
	let month= today.getMonth();
	let date = new Date(year, month, 1);
	date.setDate(1-date.getDay());
	console.log(date);
	do {
		let tr = $("<tr/>");
		$(".calendar tbody").append(tr);
		for(let i=0; i<7; i++) {
			let td = $("<td/>");
			let li = $("<li/>", {
				class: "date",
				date: date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate(),
				text: date.getDate()
			});
			if(date.getMonth()!=month) {
				li.addClass("notThisMonth");
			}
			
			let day = date.getDate();
			
// 			$(td).text(day);
// 			if(date.getMonth()!=month) {
// 				td.addClass("notThisMonth");
// 			}
			
// 			td = $("<td><ul/></td>")
// 			$(tr).append(td);
// 			$(td).children("ul").append(li);
			$(tr).append($("<td/>").append($("<ul/>").append(li)));
			date.setDate(day + 1);
		}
	} while(month == date.getMonth());
</script>
</html>
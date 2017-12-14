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
		}
		
		.calendar .notThisMonth {
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
	$(function() {
		let today = new Date();
		let calendar = newCalendar(today.getFullYear(), today.getMonth());
		$(calendar).insertAfter($(".calendar:first"));
		$(".calendar:first").remove();
	});
	function newCalendar(year, month) {
		let str =
			"<table>"
				+"<thead>"
					+"<tr>"
						+"<th>일</th>"
						+"<th>월</th>"
						+"<th>화</th>"
						+"<th>수</th>"
						+"<th>목</th>"
						+"<th>금</th>"
						+"<th>토</th>"
					+"</tr>"
				+"</thead>"
				+"<tbody></tbody>"
			+"</table>";
		let calendar = $(str);
		$(calendar).addClass("calendar");
		
		let date = new Date(year, month, 1);
		date.setDate(1-date.getDay());
		do {
			let tr = $("<tr/>");
			$(calendar).find("tbody").append(tr);
			for(let i=0; i<7; i++) {
				let str =
					"<td>"
						+ "<span class='date'>"+date.getDate() +"</span>"
					+"</td>";
				let td = $(str);
				
				if(date.getMonth() != month) {
					$(td).addClass("notThisMonth");
				}
				$(tr).append(td);
				date.setDate(1+date.getDate());
			}
		} while(month == date.getMonth());
		return calendar;
	}
</script>
</html>
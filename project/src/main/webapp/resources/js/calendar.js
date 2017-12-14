$(function() {
	let head = $("head");
	let link = $("<link/>", {
		cssId: "calendar",
		rel: "stylesheet",
		type: "text/css",
		href: "/project/resources/css/calendar.css",
		medial: "all"
	});
	$(head).append(link);
	
	$(".calendar").each(function(index, item) {
		let year = $(".calendar").attr("year");
		let month = $(".calendar").attr("month");
		
		if(year==undefined || month==undefined) {
			let today = new Date();
			year = today.getFullYear();
			month = today.getMonth()+1;
		}
		let calendar = newCalendar(year, month-1);
		$(this).append(calendar);
	});
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
	// $(calendar).addClass("calendar");
	
	let date = new Date(year, month, 1);
	date.setDate(1-date.getDay());
	do {
		let tr = $("<tr/>");
		$(calendar).find("tbody").append(tr);
		for(let i=0; i<7; i++) {
			let dateStr = $.datepicker.formatDate('yy-mm-dd', date);
			let str =
				"<td>"
					+ "<span class='date' date='"+dateStr+"'>"
						+date.getDate()
					+"</span>"
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
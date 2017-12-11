$(function() {
	let head = $("head");
	let link = $("<link/>", {
		cssId: "tabs",
		rel: "stylesheet",
		type: "text/css",
		href: "/project/resources/css/tabs.css",
		medial: "all"
	});
	$(head).append(link);
	
	
	$(".tabs li").on("click", function(event) {
		 event.preventDefault();
		
		let id = $(this).children("a").attr("href");
		
		// tabs li
		$(".tabs .tabCurrent").removeClass("tabCurrent");
		$(this).addClass("tabCurrent");
		
		// tabContent
		$(".tabContent.tabCurrent").removeClass("tabCurrent");
		let test = $(id+".tabContent").addClass("tabCurrent");
	})
});
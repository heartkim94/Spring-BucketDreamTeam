$(document).ready(function() {
	// 상단으로 바로가기 버튼
	let btnTop = $('#btnTop');

	btnTop.click(function() {
		$('html, body').animate({
			'scrollTop' : '0'
		}, 100);
		// ie에서 작동하기 위해서는 html로 선택해야 함.
	});

	btnTop.hover(function() {
		$(this).css('background-color', '#222');
	}, function() {
		$(this).css('background-color', '#777');
	});

	$(window).scroll(function() {

		let pos = $(this).scrollTop();

		if (pos >= 95) {
			btnTop.css("display", "inline-block");
			btnTop.stop(true).animate({
				'opacity' : '0.8'
			}, 200);

		} else {
			btnTop.stop(true).animate({
				'opacity' : '0'
			}, 200);
			btnTop.css("display", "none");
		}
	});
}); 
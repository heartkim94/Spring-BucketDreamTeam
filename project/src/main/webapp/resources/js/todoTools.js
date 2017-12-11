$(function() {
	// todo 선택
	$(".todoList").on("click", "li", function() {
		selectTodo(this);
	});
	
	// doName 저장
	$(".todoList").on("blur", "input:text", function() {
		let doName = $(this).val();
		$("<sapn/>", {text: doName}).insertAfter($(this));
		$(this).remove();
	});
	
	// 엔터 이벤트
	$(".todoList").on("keyup", "input:text", function(event) {
		if(event.keyCode == 13) {
			$(this).blur();
		}
	});
	
	
	// 그룹 접기
	$(".todoList").on("click", ".fold", function() {
		selectTodo($(this).parent());
		let depth = $(".selected").attr("depth");
		let next = $(".selected").nextAll().filter(function() {
			return $(this).attr("depth") <= depth;
		}).first();
		
		let nextUntil = $(".selected").nextUntil(next);
		let folded = $("<div/>", { class: "folded" });
		$(folded).insertAfter(".selected");
		$(folded).append(nextUntil);
		
		$("<button/>", {class: "unfold", text: "펼치기"}).insertAfter(this);
		$(this).remove();
	});
	
	// 그룹 펼치기
	$(".todoList").on("click", ".unfold", function() {
		selectTodo($(this).parent());
		let folded = $(".selected").next(".folded");
		let children = $(folded).children();
		
		$(children).insertAfter($(".selected"));
		$(folded).remove();
		
		$("<button/>", {class: "fold", text: "접기"}).insertAfter(this);
		$(this).remove();
	});
	
	
	// move up todo
	$(".moveUpTodo").on("click", function() {
		if($(".selected").exist()) {
			let depth = $(".selected").attr("depth");
			let prev = $(".selected").prevAll().filter(function() {
				return $(this).attr("depth") <= depth;
			}).first();
			let next = $(".selected").nextAll().filter(function() {
				return $(this).attr("depth") <= depth;
			}).first();
			
			if($(prev).attr("depth")==depth) {
				let nextUntil = $(".selected").nextUntil(next);
				$(".selected").insertBefore(prev);
				$(nextUntil).insertAfter($(".selected"));
			}
		}
	});
	
	// move down todo
	$(".moveDownTodo").on("click", function() {
		let depth = $(".selected").attr("depth");
		let next = $(".selected").nextAll().filter(function() {
			return $(this).attr("depth") <= depth;
		}).first();
		
		if($(next).attr("depth") == depth) {
			let selected = $(".selected");
			selectTodo(next);
			$(".moveUpTodo").click();
			selectTodo(selected);
		}
	});
	
	$(".moveRightTodo").on("click", function() {
		let depth = $(".selected").attr("depth")*1;		// *1 -- convert string to number
		let prev = $(".selected").prevAll().filter(function() {
			return $(this).attr("depth") <= depth;
		}).first();
		let next = $(".selected").nextAll().filter(function() {
			return $(this).attr("depth") <= depth; 
		}).first();
		
		if($(prev).attr("depth")==depth) {
			let selected = $(".selected");
			$(prev).children(".unfold").click();	// 그룹 접혀있으면 펼치기
			selectTodo(selected);
			
			// 하위 todo 포함해서 depth 1 증가
			$(selected).nextUntil(next).each(function(index, item) {
				addDepthBy(item, 1);
			});
			addDepthBy(selected, 1);
			
			// parent에 접기 버튼 없을 시 추가
			if(!$(prev).children(".fold").exist()) {
				$("<button/>", {class: "fold", text: "접기"})
						.insertAfter($(prev).children(".doName"));
			}
		}
	});
	
	$(".moveLeftTodo").on("click", function() {
		let depth = $(".selected").attr("depth")*1;
		let prev = $(".selected").prevAll().filter(function() {
			return $(this).attr("depth") < depth;
		}).first();
		let next = $(".selected").nextAll().filter(function() {
			return $(this).attr("depth") <= depth;
		}).first();
		
		if($(prev).exist()) {
			let selected = $(".selected");
			let nextUntil = $(selected).nextUntil(next);
			
			// selected 및 하위 todo를 parent 위로 이동
			$(selected).insertBefore(prev);
			$(nextUntil).insertAfter(selected);
			
			// selected 및 하위 todo depth 1 감소
			$(nextUntil).each(function(index, item) {
				addDepthBy(item, -1);
			});
			addDepthBy(selected, -1);
			
			// moveDown 버튼 클릭
			$(".moveDownTodo").click();
			
			// prev의 하위 그룹 없을 시 fold 버튼 삭제
			next = $(prev).nextAll().filter(function() {
				return $(this).attr("depth") <= $(prev).attr("depth");
			}).first();
			nextUntil = $(prev).nextUntil(next);
			if(nextUntil.length == 0) {
				$(prev).children(".fold").remove();
			}
		}
	});
	
	
	// todo doName 변경
	$(".renameTodo").on("click", function() {
		if($(".selected").exist()) {
			let doName = $(".selected .doName");
			let input = $("<input/>", {type: "text", name: "doName"});
			
			$(input).insertAfter($(doName));
			$(input).focus();
			$(input).val($(doName).text());
			$(doName).remove();
		}
	});
	
	// todo 추가
	$(".addTodo").on("click", function() {
		let item = $("<li/>", {doNum: null, depth: 0});
		let checkBox = $("<input/>", {type: "checkbox", name: "done"});
		let input = $("<input/>", {type: "text", name: "doName"});
		
		$(item).append(checkBox)
		$(item).append(input);
		$(".todoList ul").append(item);
		selectTodo(item);
		$(input).focus();
		$(input).val("새 목표");
	});
	
	
	// save all changes
	$(".saveBtn").on("click", function() {
		let todoList = $(".todoList li");
		let data = [];
		let parentNum = [null];
		let pos = 1;
		let path = [0];
		let prevDepth = null;
		let prevDoNum = null;
		let groupNum = $(".groupInfo .groupNum").text();
		for(let i=0; i<todoList.length; i++) {
			
			if($(todoList[i]).attr("depth") == prevDepth) {
				pos += 1;
			} else if($(todoList[i]).attr("depth") > prevDepth) {
				parentNum.push(prevDoNum);
				path.push(pos);
				pos = 1;
			} else if($(todoList[i]).attr("depth") < prevDepth) {
				parentNum.pop();
				pos = path.pop()+1;
			}
			
			data.push({
				doNum: $(todoList[i]).attr("doNum"),
				doName: $(todoList[i]).children(".doName").text(),
				done: $(todoList[i]).children("[name=done]").is(":checked"),
				parentNum: parentNum[parentNum.length-1],
				path: path.join(".") +"."+ pos,
				pos: pos,
				depth: $(todoList[i]).attr("depth"),
				groupNum: groupNum
			});
			prevDepth = $(todoList[i]).attr("depth");
			prevDoNum = $(todoList[i]).attr("doNum");
		}
		
		// update 요청
		$.ajax({
			url: "updateTodoList",
			type: "POST",
//			dataType: "json",
			contentType: "application/json",
			data: JSON.stringify(data),
			success: function(data) {
				console.log(data);
			},
			error: function(xhr) {
				alert("error html = "+xhr.statusText);
			}
		});
	});
	
});

jQuery.fn.exist = function() {
	return this.length > 0;
}
function selectTodo(selected) {
	$(".selected").removeClass("selected");
	$(selected).addClass("selected");
}
function addDepthBy(item, amount) {
	let depth = $(item).attr("depth") *1;
	$(item).attr("depth", depth+amount);
	$(item).css("margin-left", 25*(depth+amount));
}
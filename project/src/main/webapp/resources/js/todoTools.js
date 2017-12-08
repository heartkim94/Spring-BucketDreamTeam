$(function() {
	// 엔터 이벤트 등록
	
	
	
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
	
	
	// move up todo
	$(".moveUpTodo").on("click", function() {
		if($(".selected").exist()) {
			let depth = $(".selected").attr("depth");
			let prev = null;
			let next = null;
			let prevAll = $(".selected").prevAll();
			let nextAll = $(".selected").nextAll();
			
			// find prev element to swap position
			for(let i=0; i<prevAll.length; i++) {
				if($(prevAll[i]).attr("depth") < depth) {
					break;
				} else if($(prevAll[i]).attr("depth") == depth) {
					prev = prevAll[i];
					break;
				}
			}
			// find next element that is not children
			
			if(prev!=null) {
				let nextUntil = $(".selected").nextUntil(next);
				$(".selected").insertBefore(prev);
				if(nextAll.length > 0) {
					$(nextUntil).insertAfter($(".selected"));
				}
			}
		}
	});
	
	// move down todo
	$(".moveDownTodo").on("click", function() {
		let depth = $(".selected").attr("depth");
		let nextAll = $(".selected").nextAll();
		
		for(let i=0; i<nextAll.length; i++) {
			if($(nextAll[i]).attr("depth") < depth) {
				break;
			} else if($(nextAll[i]).attr("depth") == depth) {
				let selected = $(".selected");
				selectTodo(nextAll[i]);
				 $(".moveUpTodo").click();
				 selectTodo(selected);
				break;
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
		$(".todoList").append(item);
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
				path.pop();
				pos = 1;
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
			contentType: false,
			processData: false,
			data: {
				todoList: data
			},
			success: function(data) {
				console.log(data);
			},
			error: function(xhr) {
				alert("error html = "+xhr.statusText);
			}
		});
	});
	
});

function selectTodo(selected) {
	$(".selected").removeClass("selected");
	$(selected).addClass("selected");
}
jQuery.fn.exist = function() {
	return this.length > 0;
}
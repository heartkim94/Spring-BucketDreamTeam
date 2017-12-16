var isFirst;
$(function() {
	isFirst = (isFirst == undefined);
	if(!isFirst) { return; }
	
	// todo 선택
	$(".todoList > ul").on("click", "li", function() {
//		selectTodo(this);
		todoList.select($(this).attr("doNum"));
	});
	
	$(".todoCalendar").on("click", ".todo", function() {
		let doNum = $(this).attr("doNum");
		todoList.select(doNum);
	});
	
	
	// 그룹 접기
	$(".todoList").on("click", ".fold", function() {
		let doNum = $(this).parent().attr("doNum");
		let selected = todoList.find(function(todo) {
			return todo.doNum == doNum;
		})
		selected.isFolded = true;
		todoList.list($(".selected").attr("doNum"));
	});
	
	// 그룹 펼치기
	$(".todoList").on("click", ".unfold", function() {
		let doNum = $(this).parent().attr("doNum");
		let selected = todoList.find(function(todo) {
			return todo.doNum == doNum;
		})
		selected.isFolded = false;
		todoList.list($(".selected").attr("doNum"));
	});
	
	
	// move up todo
	$(".moveUpTodo").on("click", function() {
		if($(".selected").exist()) {
			let doNum = $(".selected").attr("doNum");
			let selected = todoList.get(doNum)
			let prev = todoList.getPrev(doNum);
			
			if(prev!=undefined) {
				selected.pos += -1;
				prev.pos += 1;
				todoList.changed = true;
			}
			
			if(todoList.changed) {
				todoList.orderByPos();
				todoList.list(doNum);
			}
		}
	});
	
	// move down todo
	$(".moveDownTodo").on("click", function() {
		let doNum = $(".selected").attr("doNum");
		let selected = todoList.get(doNum);
		let next = todoList.getNext(doNum);
		
		if(next!=undefined) {
			selected.pos += 1;
			next.pos += -1;
			todoList.changed = true;
		}
		
		if(todoList.changed) {
			todoList.orderByPos();
			todoList.list(doNum);
		}
	});
	
	$(".moveRightTodo").on("click", function() {
		if($(".selected").exist()) {
			let doNum = $(".selected").attr("doNum");
			let selected = todoList.get(doNum);
			let prev = todoList.getPrev(doNum);
			
			console.log(prev);
			if(prev!=null) {
				todoList.getNextAll(doNum).map(function(todo) {
					todo.pos += -1;
				});
				
				selected.parentNum = prev.doNum;
				selected.pos = todoList.getSub(prev.doNum).length;
				selected.depth += 1;
				
				todoList.getSubAll(doNum).map(function(todo) {
					todo.depth += 1; 
				})
				
				todoList.orderByPos();
				todoList.list(doNum);
			}
		}
	});
	
	$(".moveLeftTodo").on("click", function() {
		if($(".selected").exist()) {
			let doNum = $(".selected").attr("doNum");
			let selected = todoList.get(doNum);
			let parent = todoList.getParent(doNum);
			
			if(parent != undefined) {
				todoList.getNextAll(doNum).map(function(todo) {
					todo.pos += -1;
				});
				
				todoList.getNextAll(parent.doNum).map(function(todo) {
					todo.pos += 1;
				});
				
				selected.parentNum = parent.parentNum;
				selected.pos = parent.pos + 1;
				selected.depth += -1;
				
				todoList.getSubAll(doNum).map(function(todo) {
					todo.depth += -1; 
				})
				
				todoList.orderByPos();
				todoList.list(doNum);
			}
		}
	});
	
	
	// todo 추가
	$(".addTodo").on("click", function() {
		let min = todoList.reduce(function(res, item) {
			if(res.doNum < item.doNum) { return res; }
			else { return item; }
		});
		if(min.doNum > 0) { min = 0; }
		else { min = min.doNum; }
		let pos = todoList.getSub(0).length+1;
		
		let todo = new Todo({
			doNum: min-1,
			doName: "새 목표",
			doAllDay: "true",
			parentNum: 0,
			depth: 0,
			pos: pos,
		});
		todoList.push(todo);
		todo.path = todoList.getPathOf(todo.doNum);
		
		todoList.list();
		todoList.select(todo.doNum);
	});
	
	$(".deleteTodo").on("click", function() {
		if($(".selected").exist()) {
			let doNum = $(".selected").attr("doNum");
			let subs = todoList.getSubAll(doNum);
			
			let nextAll = todoList.getNextAll(doNum);
			for(let i=0; i<nextAll.length; i++) {
				nextAll[i].pos += -1;
			}
			
			todoList.delete(doNum);
			for(let i=0; i<subs.length; i++) {
				todoList.delete(subs[i].doNum);
			}
			
			todoList.orderByPos;
			todoList.list();
		}
	})
	
	
	// doName 변경
	$(".todoContent [name=doName]").on("change", function() {
		let doNum = $(".selected").attr("doNum");
		let todo = todoList.get(doNum);
		let doName = $(".todoContent [name=doName]").val();
		
		todo.doName = doName;
		todoList.list(doNum);
	});
	

	$(".todoContent input:text, .todoContent").on("keyup", function(event) {
		if(event.keyCode == 13) {		// 엔터 이벤트 -- blur event
			$(this).blur();
		}
	});
	// show todoList -- for test
	$(window).on("keyup", function(event) {
		if(event.keyCode == 192) {
			todoList.show();	// '~' key
		}
	});
	
	$(".todoList > ul").on("change", "[name=done]", function() {
		let doNum = $(this).parent().attr("doNum");
		let todo = todoList.get(doNum);
		todo.done = $(this).prop("checked");
	});
	
	$(".todoContent [name=doAllDay]").change(function() {
		if($(".selected").exist()) {
			let doNum =$(".selected").attr("doNum");
			let todo = todoList.get(doNum);
			todo.doAllDay = $(this).prop("checked");
			
			if($(this).prop("checked")) {
				$(".todoContent [type=time]").prop("readonly", true)
											 .val("");
			} else {
				$(".todoContent [type=time]").prop("readonly", false);
				$(".todoContent [name=doWhenTime]").val(todo.doWhenTime);
				$(".todoContent [name=doEndTime]").val(todo.doEndTime);
			}
		}
	})
	$(".todoContent [type=date]").change(function() {
		if($(".selected").exist()) {
			let doNum = $(".selected").attr("doNum");
			let todo = todoList.get(doNum);
			let name = $(this).attr("name");
			todo[name] = this.value;
			todoList.list(doNum);
		}
	});
	$(".todoContent [name=color]").change(function() {
		if($(".selected").exist()) {
			let doNum = $(".selected").attr("doNum");
			let todo = todoList.get(doNum);
			todo.color = $(this).val();
			todoList.list(doNum);
		}
	});
	
	$(".todoContent .memo").on("change", function() {
		if($(".selected").exist()) {
			let doNum = $(".selected").attr("doNum");
			let todo = todoList.get(doNum);
			todo.memo = $(this).val();
		}
	});
	
	
	// save all changes
	$(".saveBtn").on("click", function() {
		todoList.orderByPos();
		todoList.list();
		let updateList = [];
		let deleteList = [];
		for(let i=0; i<todoList.length; i++) {
			let todo = Object.assign({}, todoList[i]);
			if(todo.doNum<0) {
				todo.doNum = 0;
			}
						
			if(!todo.doWhen) {
				todo.doWhen = null;
				todo.doWhenTime = null;
			}
			
			if(!todo.doEnd) {
				todo.doEnd = null;
				todo.doEndTime = null;
			}
			
			updateList.push(todo);
		}
		for(let i=0; i<todoList.deleteList.length; i++) {
			deleteList.push(todoList.deleteList[i].doNum);
		}
		
		
		// update 요청
		$.ajax({
			url: "updateTodoList",
			type: "POST",
//			dataType: "json",
			contentType: "application/json",
			data: JSON.stringify({
				todoList: updateList,
				deleteList: deleteList
			}),
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
//	let doNum = $(selected).attr("doNum");
	$(".selected").removeClass("selected");
//	$("[doNum="+doNum+"]").addClass("selected");
	$(selected).addClass("selected");
}
function addDepthBy(item, amount) {
	let depth = $(item).attr("depth") *1;
	$(item).attr("depth", depth+amount);
	$(item).css("margin-left", 25*(depth+amount));
}

function Todo(todo) {		// *1: convert string to int
	this.doNum = todo.doNum *1;
	this.doName = todo.doName;
	this.doWhen = todo.doWhen;
	this.doWhenTime = todo.doWhenTime;
	this.doEnd = todo.doEnd;
	this.doEndTime = todo.doEndTime;
	this.doAllDay = (todo.doAllDay == "true");
	this.color = todo.color;
	this.done = (todo.done == "true");
	this.memo = todo.memo;
	this.parentNum = todo.parentNum *1;
	this.path = todo.path;
	this.pos = todo.pos *1;
	this.depth = todo.depth *1;
	this.groupNum = todo.groupNum *1;
	this.userNum = todo.userNum *1;
	
	this.isFolded = false;
}
function TodoList() {
	this.deleteList = [];
	this.changed = false;
	this.isFirstListing = true;
}
TodoList.prototype = new Array;
if(TodoList.prototype.find == undefined) {
	TodoList.prototype.find = function(func) {
		for(let i=0; i<this.length; i++) {
			if(func(this[i], i)) {
				return this[i];
			}
		}
	}
}
TodoList.prototype.select = function(doNum) {
	$(".selected").removeClass("selected");
	$(".todoList li[doNum="+doNum+"]").addClass("selected");
	
	// 선택한 todo의 정보를 .todoContent에 표시함
	let todo = this.get(doNum);
	$(".todoContent [name=doName]").val(todo.doName);
	$(".todoContent [name=doAllDay]").prop("checked", todo.doAllDay);
	$(".todoContent [name=doWhen]").val(todo.doWhen);
	$(".todoContent [name=doEnd]").val(todo.doEnd);
	if(todo.doAllDay) {
		$("todoContent [type=time]").prop("readonly", true)
									.val("");
	} else {
		$(".todoContent [type=time]").prop("readonly", false);
		$(".todoContent [name=doWhenTime]").val(todo.doWhenTime);
		$(".todoContent [name=doEndTime]").val(todo.doEndTime);
	}
	if(todo.color) {
		$(".todoContent [name=color]").val(todo.color);
	}
	$(".todoContent .memo").val(todo.memo);
}
TodoList.prototype.list = function(doNum) {
	let self = this;
	let foldAt = null;
	$(".todoList > ul").each(function(index, item) {
		$(item).empty();	// div.todoList > ul 초기화
		for(let i=0; i<self.length; i++) {
			let li = $("<li/>");
			$(li).attr("doNum", self[i].doNum);
			$(li).attr("depth", self[i].depth);
			if(self.isFirstListing && self[i].parentNum < 0) {
				self[i].parentNum = self[i-1].doNum;
			}
			if(self[i].doNum == doNum) {	// 선택된 li 처리
				$(li).addClass("selected");
			}
//			$(li).css("margin-left", self[i].depth * 15);	// margin-left 설정
			if(self[i].depth > 0) {
				let indent = $("<span/>", { class: "indent"});
				$(indent).css("margin-left", self[i].depth*10);
				$(li).append(indent);
			}
			
			// 체크박스
			let done = $("<input/>", { type: "checkbox", name: "done" });
			if(self[i].done) {
				$(done).attr("checked", true);
			}
			$(li).append(done);
			
			// doName text
			$(li).append($("<span/>", { class: "doName", text: self[i].doName }));
			
			// button .unfold / .fold
			if(i < self.length-1 && self[i].depth < self[i+1].depth) {
				if(self[i].isFolded) {
					$(li).append($("<button/>", { class: "unfold", text: "펼치기" }));
					if(!self[i].path.includes(foldAt)) {
						foldAt = self[i].path;
					}
				} else {
					$(li).append($("<button/>", { class: "fold", text: "접기" }));
				}
			}
			
			// fold 됐으면 숨김
			if(self[i].path.indexOf(foldAt) >= 0 && self[i].path != foldAt) {
				$(li).addClass("folded");
			}
			
			$(item).append(li);
		}
	}); // end -- todoList
	this.isFirstListing = false;
	
	// todoCalendar
	$(".todoCalendar .todo").remove();
	for(let i=0; i<this.length; i++) {
		if(this[i].doWhen) {
			let todoDate = new Date(this[i].doWhen);
			
			let li = $(".todoCalendar .date").filter(function(index, item) {
				let date = $(item).attr("date");
				return (self.checkDate(self[i].doNum, date));
			});
			
			if(li) {
				let todo = $("<div/>", {
					class: "todo",
					doNum: this[i].doNum,
					text: this[i].doName,
				});
				if(!this[i].color) {
					this[i].color = $(".todoContent [name=color]").val();
				}
				$(todo).css("background", this[i].color);
				$(todo).insertAfter(li);
			}
		}
	}
}
TodoList.prototype.getSub = function(doNum) {
	let subs = this.filter(function(todo) {
		return todo.parentNum == doNum;
	});
	
	return subs;
}
TodoList.prototype.getSubAll = function(doNum) {
	let subs = this.filter(function(todo) {
		return todo.parentNum == doNum;
	});
	
	for(let i in subs) {
		subs = subs.concat(this.getSubAll(subs[i].doNum));
	}
	
	return subs;
}
TodoList.prototype.orderByPos = function() {
	for(let i=0; i<this.length; i++) {
		this[i].path = this.getPathOf(this[i].doNum);
	}
	this.sort(function(a, b) {
		return a.path.localeCompare(b.path);
	});
	
}
TodoList.prototype.getPathOf = function(doNum) {
	let todo;
	let path = [];
	
	while(1) {
		todo = this.find(function(todo) {
			return todo.doNum == doNum;
		});
		if(todo==undefined) break;
		path.push(todo.pos);
		doNum = todo.parentNum;
	}
	path.push(0);
	return path.reverse().join(".");
}
TodoList.prototype.show = function() {
	for(let i=0; i<this.length; i++) {
		let todo = this[i];
		console.log(i, todo.path, todo);
	}
}
TodoList.prototype.get = function(doNum) {
	return this.find(function(todo) {
		return todo.doNum == doNum;
	});
}
TodoList.prototype.getPrev = function(doNum) {
	let todo = this.get(doNum);
	return this.find(function(prev) {
		return prev.parentNum == todo.parentNum && prev.pos == todo.pos-1;
	})
}
TodoList.prototype.getPrevAll = function(doNum) {
	let todo = this.get(doNum);
	return this.filter(function(prev) {
		return prev.parentNum == todo.parentNum && prev.pos < todo.pos;
	})
}
TodoList.prototype.getNext = function(doNum) {
	let todo = this.get(doNum);
	return this.find(function(next) {
		return next.parentNum == todo.parentNum && next.pos == todo.pos+1;
	})
}
TodoList.prototype.getNextAll = function(doNum) {
	let todo = this.get(doNum);
	return this.filter(function(next) {
		return next.parentNum == todo.parentNum && next.pos > todo.pos;
	})
}
TodoList.prototype.getParent = function(doNum) {
	let todo = this.get(doNum);
	return parent = this.find(function(parent) {
		return parent.doNum == todo.parentNum;
	});
}
TodoList.prototype.delete = function(doNum) {
	let todo = this.get(doNum);
	let index = this.indexOf(todo);
	this.splice(index, 1);
	this.deleteList.push(todo);
}
TodoList.prototype.checkDate = function(doNum, date) {
	let todo = this.get(doNum);
	if(todo.doWhen && todo.doEnd) {
		if(date >= todo.doWhen && date <= todo.doEnd) { return true; }
	}
	if(todo.doWhen) {
		if(date == todo.doWhen) { return true; }
	}
	return false;
}
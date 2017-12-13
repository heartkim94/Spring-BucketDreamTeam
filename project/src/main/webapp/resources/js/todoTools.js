var isFirst;
$(function() {
	isFirst = (isFirst == undefined);
	if(!isFirst) { console.log("canceled"); return; }
	
	// todo 선택
	$(".todoList").on("click", "li", function() {
//		selectTodo(this);
		todoList.select($(this).attr("doNum"));
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
	
	
	// todo doName 변경
	$(".renameTodo").on("click", function() {
		if($(".selected").exist()) {
			let doName = $(".tabCurrent .selected .doName");
			let input = $("<input/>", {type: "text", name: "doName"});
			console.log(doName);
			
			$(input).insertAfter($(doName));
			$(input).focus();
			$(input).val($(doName).text());
			$(doName).remove();
		}
	});
	
	// doName 저장
	$(".todoList").on("blur", "input:text", function() {
		let doName = $(this).val();
//		$("<sapn/>", { class: "doName", text: doName }).insertAfter($(this));
//		$(this).remove();
		let doNum = $(this).parent().attr("doNum");
		todoList.get(doNum).doName = doName;
		todoList.list(doNum);
	});
	

	$(".todoList").on("keyup", "input:text", function(event) {
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
			doAllDay: "true",
			parentNum: 0,
			depth: 0,
			pos: pos,
			userId: "${id}"
		});
		todoList.push(todo);
		todo.path = todoList.getPathOf(todo.doNum);
		
		let item = $("<li/>", {doNum: todo.doNum, depth: todo.depth});
		let checkBox = $("<input/>", {type: "checkbox", name: "done"});
		let input = $("<input/>", {type: "text", name: "doName"});
		
		$(item).append(checkBox)
		$(item).append(input);
		$(".todoList ul").append(item);
		selectTodo(item);
		$(input).focus();
		$(input).val("새 목표");
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
	
	
	// save all changes
	$(".saveBtn").on("click", function() {
		todoList.orderByPos();
		todoList.list();
		let _todoList = [];
		let deleteList = [];
		for(let i=0; i<todoList.length; i++) {
			if(todoList[i].doNum<0) {
				todoList[i].doNum = 0;
			}
			_todoList.push(todoList[i]);
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
				todoList: _todoList,
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
	// end -- todoList
	
	// todoCalendar
	// end -- todoCalendar
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
	this.done = (todo.done == "true");
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
	this.userId;
	this.changed = false;
}
TodoList.prototype = new Array;
TodoList.prototype.select = function(doNum) {
	$(".selected").removeClass("selected");
	$(".todoList li[doNum="+doNum+"]").addClass("selected");
}
TodoList.prototype.list = function(doNum = null) {
	let self = this;
	let foldAt = null;
	$(".todoList > ul").each(function(index, item) {
		$(item).empty();	// div.todoList > ul 초기화
		for(let i=0; i<self.length; i++) {
			let li = $("<li/>");
			$(li).attr("doNum", self[i].doNum);
			$(li).attr("depth", self[i].depth);
			if(self[i].parentNum < 0) {
				self[i].parentNum = self[i-1].doNum;
			}
			if(self[i].doNum == doNum) {	// 선택된 li 처리
				$(li).addClass("selected");
			}
			$(li).css("margin-left", self[i].depth * 15);	// margin-left 설정
			
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
			if(self[i].path.includes(foldAt) && self[i].path != foldAt) {
				$(li).addClass("folded");
			}
			
			$(item).append(li);
		}
	}); // end -- todoList
	
	// todoCalendar
	for(let i=0; i<todoList.length; i++) {
		if(todoList[i].doWhen) {
			console.log(todoList[i].doWhen);
			let date = new Date(todoList[i].doWhen);
			console.log(date);
			let year = date.getFullYear();
			let month = date.getMonth();
			let day = date.getDate();
			console.log(year, month+1, day);
			let today = new Date();
			if(month == today.getMonth()) {
				let td = $(".calendar td").filter(function(index, item) {
					return ($(item).children("ul").text() == day);
				});
				if(td) {
					$(td).append($("<span/>", { class: "todo", text: todoList[i].doName }));
				}
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>채팅방</title>
	<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.0.4/socket.io.js"></script>
	<style>
		.canvasContainer, .canvasList {
			float: left;
		}
		.chatroom, .mainCanvas {
			float: right;
		}
		.paint {
			border: 1px solid black;
		}
		.canvasList li {
			background: #ccc;
		}
		.chatLog {
			overflow: scroll;
			width:300px;
			height:400px;
		}
		div.clear {
			clear: both;
		}
		.canvasList {
			margin:0;
			padding:0 10px 0 0;
			list-style-type: none;
		}
	</style>
</head>
<body>
	<div id="wrapper">
		<section>
			
			<div class="canvasContainer" style="display:none">
				<ul class="canvasList">
					<li class="myCanvas">my canvas</li>
				</ul>
				<div class="mainCanvas">
					<canvas class="paint" width="300" height="400"></canvas>
					<div class="paintTools">
						<button class="pen">Pen</button>
						<button class="eraser">Eraser</button>
						<button class="clear">Clear</button>
						<button class="undo">Undo</button>
						<button class="redo">Redo</button>
					</div>
				</div>
				<div class="clear"></div>
			</div>
			<div class="chatroom">
				<div class="chatLog">
					<div class="insertPoint"></div>
				</div>
				<div>
					<input type="text" name="message">
					<button class="send">전송</button>
				</div>
				<div>
					<button class="paintBtn">그림판</button>
					<a href="chatrooms"><button class="leave">나가기</button></a>
				</div>
			</div>
		</section>
	</div> <!-- wrapper End -->
</body>
<script>
let ctx;
let paint;
let socket;

$(function() {
	paint = new Paint();
	// socket
	socket = io.connect("http://210.119.12.240:50000");
	socket.emit("join", {		// 채팅방 참가 요청
		roomNum: "${roomNum}",
		userId: "${id}",
		sessionId: "${pageContext.session.id}",
		paint: paint.getImage()
	})
	socket.on("join", function(data) {
		$("li.myCanvas").attr("paintNum", data.paintNum);
		$(".paint").attr("paintNum", data.paintNum);
		// msg 로그 표시
		for(let i in data.log) {
			insertMessage(data.log[i]);
		}
		if(data.paint!=undefined) {
			paint.setImage(data.paint);
			paint.steps[0] = data.paint;
		}
		// paintList 표시
		for(let i in data.paintList) {
			if(data.paintList[i].paintNum != data.paintNum) {
				let paint = data.paintList[i];
				let str = "<li class='canvas' paintNum='" + paint.paintNum + "'>"
							+ paint.userId
						+ "</li>";
				let item = $(str);
				$(item).on("click", switchPaint);
				$(".canvasList").append(item);
			}
		}
	});
	
	$(".leave").on("click", function() {	// 나가기 버튼 클릭시
		if($(".canvasContainer").css("display")!="none") {  // 창 크기 원래대로 변경
			$(".paintBtn").click();
		}
		socket.emit("leave", {		// 채팅 서버에 나가기 알림
			userId: "${id}",
			sessionId: "${pageContext.session.id}"
		});
	});
	socket.on("sendAll", function(data) {
		switch(data.type) {
		case "msg":							// 메세지를 chatLog에 입력
			insertMessage(data);
			scrollToBottom();
			break;
		case "paint":
			let myPaintNum = $(".myCanvas").attr("paintNum");
			let paintNum = $(".paint").attr("paintNum");
			if(data.paintNum == paintNum
			&& data.paintNum != myPaintNum) {
				paint.setImage(data.paint);
			}
			break;
		}
	});
	
	$(".send").on("click", function() {		// 메세지를 서버로 전송
		let msg = $("input:text").val();
		socket.emit("send", {
			roomNum: "${roomNum}",
			userId: "${id}",
			sessionId: "${pageContext.session.id}",
			type: "msg",
			msg: msg
		});
	});
	
	
	// paint event handler mapping
	let canvas = $(".paint")[0];
	ctx = canvas.getContext('2d');
	$(".paint").on("mousedown", function(event) {
		paint.onMouseDown(event);
	});
	$(".paint").on("mousemove", function(event) {
		paint.onMouseMove(event);
	});
	$(window).on("mouseup", function(event) {
		paint.onMouseUp(event);
	});
	
	
	// paint buttons
	$(".paintBtn").on("click", function() {
		if($(".canvasContainer").css("display")=="none") {
			// 그림판 열기
			let d = (320*2 + 100) - document.body.clientWidth;
			window.resizeBy(d, 0);
			window.moveBy(-d, 0);
			$(".canvasContainer").css("display", "");
		} else {
			// 그림판 닫기
			let d = 320 - document.body.clientWidth;
			$(".canvasContainer").css("display", "none");
			window.resizeBy(d, 0);
			window.moveBy(-d, 0);
		}
	});
	$(".paintTools .pen").on("click", function() {
		paint.penMode();
	});
	$(".paintTools .eraser").on("click", function() {
		paint.removeMode();
	});
	$(".paintTools .clear").on("click", function() {
		if(paint.isMyPaint) {
			paint.clear();
			paint.send();
		}
	})
	$(".undo").on("click", function() {
		if(paint.isMyPaint) {
			paint.undo();
			paint.send();
		}
	});
	
	$(".redo").on("click", function() {
		if(paint.isMyPaint) {
			paint.redo();
			paint.send();
		}
	});
	
	// switch paint
	$(".canvasList li").on("click", switchPaint);
	socket.on("switchPaint", function(data) {
		let myPaintNum = $(".myCanvas").attr("paintNum");
		if(myPaintNum == data.paintNum) {
			paint.isMyPaint = true;
		} else {
			paint.isMyPaint = false;
		}
		$(".paint").attr("paintNum", data.paintNum);
		paint.setImage(data.paint);
	});
});


function insertMessage(data) {
	let str = "<div class='log'>"+data.userId+": "+data.msg+"</div>";
	$(str).insertBefore($(".insertPoint"));
}

function scrollToBottom() {
	let logBox = $(".chatLog")[0]
	let scrollTop = $(logBox).scrollTop();
	let scrollHeight = logBox.scrollHeight;
	let outerHeight = $(logBox).outerHeight();
	if(scrollHeight - scrollTop > outerHeight) {
		$(logBox).scrollTop(scrollHeight - outerHeight);
	}
}

const DRAW = 0;
const REMOVE = 1;
function Paint() {
	this.mode = DRAW;
	this.clicked = false;
	this.isMyPaint = true;
	this.step = -1;
	this.steps = [];
	this.push();
}
// Paint event handler
Paint.prototype.onMouseDown = function(event) {
	if(!this.isMyPaint) { return; }
	let x, y;
	
	let offset = $(".paint").offset();
	x = event.pageX - offset.left;
	y = event.pageY - offset.top;
	
	switch(this.mode) {
	case DRAW:
		ctx.beginPath();
		ctx.moveTo(x, y);
		break;
	case REMOVE:
		break;
	}
    this.clicked = true;
    console.log("click: ", x, y);
}
Paint.prototype.onMouseMove = function(event) {
	if(!this.clicked || !this.isMyPaint) { return; }
	let x, y;
	
	let offset = $(".paint").offset();
	x = event.pageX - offset.left;
	y = event.pageY - offset.top;
	
	switch(this.mode) {
	case DRAW:
		ctx.lineTo(x, y);
		ctx.stroke();
		break;
	case REMOVE:
		ctx.clearRect(x, y, 10, 10);
		break;
	}
}
Paint.prototype.onMouseUp = function(event) {
	if(!this.clicked || !this.isMyPaint) { return; }
	this.clicked = false;
	console.log("up");
	this.push();
	this.send();
}
// Paint step functions for undo/redo
Paint.prototype.push = function() {
	let dataUrl = $(".paint")[0].toDataURL();
	this.step += 1;
	if(this.step < this.steps.length) {
		this.steps[this.step] = dataUrl;
	} else {
		this.steps.push(dataUrl);
	}
}
Paint.prototype.undo = function() {
	if(this.step > 0) {
		this.step += -1;
		console.log(this.step);
		this.setImage(this.steps[this.step]);
	}
}
Paint.prototype.redo = function() {
	if(this.step < this.steps.length-1) {
		this.step += 1;
		
		this.setImage(this.steps[this.step]); 
	}
}
// brush select functions
Paint.prototype.penMode = function() {
	this.mode = DRAW;
}
Paint.prototype.removeMode = function() {
	this.mode = REMOVE;
}
Paint.prototype.clear = function() {
	ctx.clearRect(0, 0, $(".paint").width(), $(".paint").height());
	this.push();
}
Paint.prototype.setImage = function(dataUrl) {
	let pic = new Image();
	pic.src = dataUrl;
	ctx.clearRect(0, 0, $(".paint").width(), $(".paint").height());
	pic.onload = function() { ctx.drawImage(pic, 0, 0); }
}
Paint.prototype.getImage = function() {
	return this.steps[this.step];
}
Paint.prototype.send = function() {
	// let dataUrl = $(".paint")[0].toDataURL();
	let dataUrl = this.steps[this.step];
	socket.emit("send", {
		roomNum: "${roomNum}",
		userId: "${id}",
		sessionId: "${pageContext.session.id}",
		type: "paint",
		paintNum: $(".paint").attr("paintNum"),
		paint: dataUrl
	});
}

function switchPaint() {
	let paintNum = $(this).attr("paintNum");
	socket.emit("switchPaint", {
		roomNum: "${roomNum}",
		paintNum: paintNum
	});
}
</script>
</html>
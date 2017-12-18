<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport"
		content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
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
		/* alert box */
		.alertBox {
			position: fixed;
			border-radius: 15px;
			border: 1px solid #ccc;
			box-shadow: 0 1px #ccc;
			padding: 20px 30px;
		}
		.alertBox .btns {
			position: relative;
			height: 40px;
		}
		.alertBox .ok {
			position: absolute;
			right: 0;
			bottom: 0;
			margin-top: 10px;
			border-radius: 5px;
			border: 1px solid #ccc;
			color: #ffffff;
			background: #507BE8;
			padding: 5px;
		}
		.paintTools button {
			padding: 2px 5px;
			margin: 1px 3px;
			font-size: 15px;
			background: #B2EBF4;
			width: 50px;
			box-sizing: border-box;
			border: 1px solid;
			border-collapse: collapse;
		}
		.paintTools button:hover {
			color: gray;
		}
	</style>
</head>
<body>
	<div id="wrapper">
		<section>
			<div class="alertBox" style="display: none">
				<div class="text">잘못된 요청입니다.</div>
				<div class="btns">
					<div class="ok">확인</div>
				</div>
			</div>
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
					<div class="chatroomBtnDiv"></div>
				</div>
				<div class="clear"></div>
			</div>
			<div class="chatroomContainer">
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
			</div>
		</section>
	</div> <!-- wrapper End -->
</body>
<script>
let windowWidth = 320;
let windowHeight = 500;
let gap = 100;
let ctx;
let paint;
let socket;

$(function() {
	// 사이즈 조절
	if(document.body.clientWidth != windowWidth
	|| document.body.clientHeight != windowHeight) {
		let dw = windowWidth - document.body.clientWidth;
		let dh = windowHeight - document.body.clientHeight;
		window.resizeBy(dw, dh);
		window.moveBy(-dw, 0);
	}
	
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
	
	socket.on("joinFail", function(data) {
		console.log(data);
// 		alert("잘못된 요청입니다.");
		console.log($(".alertBox").position());
		$(".alertBox").center();
		console.log($(".alertBox").position());
		$(".alertBox").css("display", "");
		// $("button.leave").click();
	});
	$(".alertBox .ok").on("click", function() {
		$("button.leave").click();
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
	if(screen.width > 660) {
		$(".paintBtn").on("click", function() {
			if($(".canvasContainer").css("display")=="none") {
				// 그림판 열기
				let d = (windowWidth*2 + gap) - document.body.clientWidth;
				window.resizeBy(d, 0);
				window.moveBy(-d, 0);
				$(".canvasContainer").css("display", "");
			} else {
				// 그림판 닫기
				let d = windowWidth - document.body.clientWidth;
				$(".canvasContainer").css("display", "none");
				window.resizeBy(d, 0);
				window.moveBy(-d, 0);
			}
		});
	} else {
		$(".paintBtn").on("click", function() {
			// 그림판으로 전환
			$(".canvasContainer").css("display", "");
			$(".chatroomContainer").css("display", "none");
			// 채팅창으로 전환 버튼 붙이기
			let html = "<button class='chatroomBtn'>채팅창</button>";
			$(".chatroomBtnDiv").html(html);
			
			// 채팅창으로 전환
			$(".chatroomBtn").on("click", function(){
				$(".canvasContainer").css("display", "none");
				$(".chatroomContainer").css("display", "");
			});
		});
	}
	
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

jQuery.fn.center = function() {
	let top = ($("body").height() - $(this).outerHeight()) / 2;
	let left = ($("body").width() - $(this).outerWidth()) / 2
	this.css("position", "fixed");
	this.css("top", (top > 0 ? top : 0)+"px");
	this.css("left", (left > 0 ? left : 0)+"px");
	console.log("centered: ", $(this).position());
}

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
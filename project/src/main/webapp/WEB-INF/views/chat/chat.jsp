<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
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
		.clear {
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
						<button>Pen</button>
						<button>Eraser</button>
						<button class="undo">Undo</button>
						<button class="redo">Redo</button>
					</div>
				</div>
				<div class="claer"></div>
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
	
	// socket
	socket = io.connect("http://210.119.12.240:50000");
	socket.emit("join", {		// 채팅방 참가 요청
		roomNum: "${roomNum}",
		userId: "${id}",
		sessionId: "${pageContext.session.id}"
	})
	socket.on("join", function(data) {
		for(let i in data.log) {
			insertMessage(data.log[i]);
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
		case "path":
			let points = data.path.points;
			for(let i=0; i<points.length; i++) {
				if(i==0) {
					ctx.beginPath();
					ctx.moveTo(points[i].x, points[i].y);
				} else if(i==points.length-1) {
					ctx.stroke();
				} else {
					ctx.lineTo(points[i].x, points[i].y);
				}
			}
		}
	});
	
	$(".send").on("click", function() {		// 메세지를 서버로 전송
		let msg = $("input:text").val();
		socket.emit("send", {
			roomNum: "${roomNum}",
			id: "${id}",
			type: "msg",
			msg: msg
		});
	});
	
	
	// canvas
	paint = new Paint();
	let pathList = [];
	let path = null;
	let started = false;
	let canvas = $(".paint")[0];
	ctx = canvas.getContext('2d');
	$(".paint").on("mousedown", function(event) {
		let x, y;
		
		let offset = $(canvas).offset();
		x = event.pageX - offset.left;
		y = event.pageY - offset.top;
		
		ctx.beginPath();
		ctx.moveTo(x, y);
	    started = true;
	    console.log("click: ", x, y);
	    path = new Path();
	    path.add(x, y);
	    pathList.push(path);
	});
	$(".paint").on("mousemove", function(event) {
		if(!started) { return; }
		let x, y;
		
		let offset = $(canvas).offset();
		x = event.pageX - offset.left;
		y = event.pageY - offset.top;
		
		ctx.lineTo(x, y);
		ctx.stroke();
		path.add(x, y);
	});
	$(window).on("mouseup", function(event) {
		if(!started) { return; }
		started = false;
		console.log("up");
		let dataUrl = $(".paint")[0].toDataURL();
		socket.emit("send", {
			roomNum: "${roomNum}",
			id: "${id}",
			type: "paint",
			image: dataUrl
		});
		paint.push(dataUrl);
	})
	
	
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
	
	$(".undo").on("click", function() {
		paint.undo();
	});
});


function Path() {
	this.points = [];
}
Path.prototype.add = function(x, y) {
	this.points.push({x: x, y: y});
}
Path.prototype.get = function(i) {
	return this.points[i];
}
Path.prototype.size = function() {
	return this.points.length;
}

function insertMessage(data) {
	let str = "<div class='log'>"+data.id+": "+data.msg+"</div>";
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

function Paint() {
	this.step = -1;
	this.steps = [];
}
Paint.prototype.push = function(dataUrl) {
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
		let pic = new Image();
		pic.src = this.steps[this.step];
		
		ctx.clearRect(0, 0, $(".paint").width(), $(".paint").height());
		pic.onload = function() { ctx.drawImage(pic, 0, 0); }
	}
}
Paint.prototype.redo = function() {
	if(this.step < this.steps.length-1) {
		this.step += 1;
		let pic = new Image();
		pic.src = this.steps[this.step];
		
		ctx.clearRect(0, 0, $(".paint").width(), $(".paint").height());
		pic.onload = function() { ctx.drawImage(pic, 0, 0); } 
	}
}
</script>
</html>
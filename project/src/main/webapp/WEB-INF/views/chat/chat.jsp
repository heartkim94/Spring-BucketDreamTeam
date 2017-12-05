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
</head>
<body>
	<div id="wrapper">
		<section>
			<div class="canvas">
				<canvas class="imaegView" width="400" height="300"></canvas>
			</div>
			<div class="chatroom">
				<div class="chatLog">
					<div class="insertPoint"></div>
				</div>
				<input type="text" name="message">
				<button class="send">전송</button>
				<a href="chatrooms"><button>나가기</button></a>
			</div>
		</section>
	</div> <!-- wrapper End -->
</body>
<script>
// drawing
$(function() {
	let started = false;
	$("imageView").on("mousemove", function(event) {
		let x, y;
		
		if(event.layerX || event.layerX==0) {
			x = event.layerX;
			y = event.layerY;
		} else if(event.offsetX || event.layerX==0) {
			x = event.offsetX;
			y = event.offsetY;
		}
		
		if(!started) {
			context.beginPath();
			context.moveTo(x, y);
			started = true;
		} else {
			context.lineTo(x, y);
			context.stroke();
		}
		console.log(x, y);
	});
});
// socket
$(function() {
	let socket = io.connect("http://210.119.12.240:50000");
	socket.emit("join", {
		roomNum: "${roomNum}",
		userId: "${id}",
		sessionId: "${pageContext.session.id}"
	})
	socket.on("join", function(data) {
		if(data.result=="fail") {
			location.href="chat?roomNum="+data.roomNum;
		}
	})
	socket.on("sendAll", function(data) {
		let str = "<div class='log'>"+data.id+": "+data.msg+"</div>";
		$(str).insertBefore($(".insertPoint"));
	});
	
	$(".send").on("click", function() {
		let msg = $("input:text").val();
		socket.emit("send", {
			roomNum: "${roomNum}",
			id: "${id}",
			msg: msg
		});
	});
});
</script>
</html>
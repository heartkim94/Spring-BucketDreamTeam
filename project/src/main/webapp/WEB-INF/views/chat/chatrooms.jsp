<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>채팅방 목록</title>
	<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.0.4/socket.io.js"></script>
</head>
<body>
	<div id="wrapper">
		<section>
				<ul class="chatroomList">
				</ul>
				<button class="newRoom">새로운 채팅방 만들기</button>
		</section>
	</div> <!-- wrapper End -->
</body>
<script>
$(function() {
	let socket = io.connect("http://210.119.12.240:50000");
	socket.emit("getRoomList", {groupNum: "${groupNum}"});
	socket.on("getRoomList", function(data) {
		console.log(data);
		let list = $(".chatroomList").html("");
		for(let i in data.roomList) {
			console.log(data.roomList[i]);
			let roomName = data.roomList[i].roomName;
			let roomNum = data.roomList[i].roomNum;
			let str = "<li><a href='chat?roomNum="+roomNum+"'>"+roomName+"</a></li>";
			$(list).append($(str));
		}
	});
	
	$(".newRoom").on("click", function() {
		socket.emit("newRoom", {
			groupNum: "${groupNum}",
			roomName: "채팅방",
		});
	});
	socket.on("newRoom", function(data) {
		location.href = "chat?roomNum="+data.roomNum;
	});
});
</script>
</html>
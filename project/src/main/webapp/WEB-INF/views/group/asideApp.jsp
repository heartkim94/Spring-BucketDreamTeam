<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<aside class="groupApp">
		<ul>
			<li>기타 기능</li>
			<li>
				<div class="chatRoomList">
					채팅방
				</div>
			</li>
		</ul>
	</aside>
</body>
<script>
$(function() {
	$(".chatRoomList").on("click", function() {
		window.open("chatrooms", "main.do", "width=300, height=400");
	});
});
</script>
</html>
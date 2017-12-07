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
			<li>
				<input type="button" value="그룹 없애기" onclick="document.location.href='deleteGroup?groupNum=${groupNum}'" id="deleteGroup">
			</li>
		</ul>
	</aside>
</body>
<script>
$(function() {
	$(".chatRoomList").on("click", function() {
		window.open("chatrooms", "main", "width=320, height=500");
	});
});
</script>
</html>
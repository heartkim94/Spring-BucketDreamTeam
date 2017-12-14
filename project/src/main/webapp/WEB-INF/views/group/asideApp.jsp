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
			<c:if test="${id == group.groupOwnerId || id == 'admin'}">
				<li>
					<input type="button" id="deleteGroup" value="그룹 없애기" onclick="document.location.href='deleteGroup?groupNum=${groupNum}'">
				</li>
			</c:if>
<!-- 			<li> -->
<!-- 				<input type="button" id="joinGroup" value="그룹 가입" onclick="document.location.href='#'"> -->
<!-- 			</li> -->
<%-- 			<c:forEach items="${memberList}" var="memberId"> --%>
<%-- 				<c:if test="${id == memberId}"> --%>
<%-- 					${"#joinGroup"}.remove(); --%>
<%-- 				</c:if> --%>
<%-- 			</c:forEach> --%>
			<div id="groupIO"></div>
		</ul>
	</aside>
</body>
<script>
$(function() {
	$(".chatRoomList").on("click", function() {
		window.open("chatrooms", "main", "width=320, height=500");
	});
});

$(document).ready(function(data) {
	let isGroupMember=false;
	let html = "<article class='groupIO'>";
	let memberList = "${memberList}".replace("[","").replace("]","").split(", ");
	
	$.each(memberList, function(index, item) {
		if("${id}" == item) { isGroupMember=true; }
	});
	if(!isGroupMember) {
		html += "<li><input type='button' id='joinGroup' value='그룹 가입' onclick='document.location.href=\"#\"'></li>";
	} else {
		html += "<li><input type='button' id='leaveGroup' value='그룹 탈퇴' onclick='document.location.href=\"#\"'></li>";
	}
	html += "</article>";
	$("#groupIO").html(html);
});
</script>
</html>
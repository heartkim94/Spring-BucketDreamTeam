<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		.groupMenu .profile {
			width: 100%;
		}
	</style>
</head>
<body>
	<c:if test="${groupNum != null}">
		<aside class="groupMenu">
			<div class="groupInfo">
				<ul>
					<li>
						<a href="view">
							<img class="profile" src="/project/displayFile?fileName=${group.profileImg}">
						</a>
					</li>
					<li>${group.groupName}</li>
					<li><div class="chatRoomList">채팅방</div></li>
				<c:if test="${id == group.groupOwnerId || id == 'admin'}">
					<li><a href="todoSetting">목표 설정</a></li>
				<li><a href="boardSetting">게시판 설정</a><li>
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
			</div>
			<hr>
			<ul>
				<li><a href="list?boardNum=0&pageNum=1">전체글보기</a><li>
				<c:forEach var="board" items="${boardList}">
					<li><a href="list?boardNum=${board.boardNum}&pageNum=1">${board.boardName}</a></li>
				</c:forEach>
			</ul>
		</aside>
	</c:if>
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
		html += "<li><input type='button' id='joinGroup' value='그룹 가입' onclick='document.location.href=\"joinGroup?groupNum=${groupNum}\"'></li>";
	} else {
		html += "<li><input type='button' id='leaveGroup' value='그룹 탈퇴' onclick='document.location.href=\"leaveGroup?groupNum=${groupNum}\"'></li>";
	}
	html += "</article>";
	$("#groupIO").html(html);
});
</script>
</html>
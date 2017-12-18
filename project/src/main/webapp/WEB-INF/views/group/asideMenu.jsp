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
		a.view {
			width: 150px;
			display: block;
			margin: 10px auto;
		}
		.groupInfo {
			text-align: center;
		}
		.groupInfo h2 {
			padding: 10px;
		    overflow: hidden;
		    white-space: nowrap;
		    text-overflow: ellipsis;
		}
		.settingArea {
			overflow: hidden;
		}
		.settingArea li {
			width: 33.33%;
			float: left;
			box-sizing: border-box;
			text-align: center;
		    vertical-align: top;
		    margin-bottom: 10px;
		    background-size: 30px;
		    background-repeat: no-repeat;
		    background-position: 50%;
		    font-size: 12px;
		}
		.settingArea li:nth-child(1) {
		    background-image: url(/project/resources/img/goalSettingIcon.png);
		}
		.settingArea li:nth-child(2) {
		    background-image: url(/project/resources/img/boardSettingIcon.png);
		}
		.settingArea li:nth-child(3) {
		    background-image: url(/project/resources/img/groupDelIcon.png);
		    border-right: none;
		}
		.settingArea li a {
			padding-top: 50px;
			border-right: 1px solid #e0e0e0;
		    display: block;
		    width: 100%;
		    
		} 
		
		.groupInfo ol {
			overflow: hidden;
   	 		width: 100%;
		}
		.groupInfo ol li {
			float: left;
		    width: 49%;
		    box-sizing: border-box;
		    text-align: center;
		    vertical-align: top;
		    margin-bottom: 10px;
		    padding: 20px;
		    border: 1px solid #e0e0e0;
		}
		li.chattingBtn {
		 	margin-right: 2%;
		}
		.chattingBtn a, .totalArticleViewBtn a {
			display: block;
			width: 100%;
			cursor: pointer;
		}
		#groupIO input {
			width: 100%;
		    display: block;
		    color: #fff;
		    background: #5c5b65;
		    cursor: pointer;
		    outline: none;
		    border: none;
		    padding: 10px;
		}
		
		.groupBoardList {
		    display: block;
    		padding: 15px;
    		background-color: #e9e9e9;
		}
		#groupBoardList {
			margin-bottom: 10px;
		}
		#groupBoardList ul {
			display: none;
		}
		#groupBoardList li {
			padding: 5px 0;
		}
		#groupBoardList li:hover {
			background-color: #e0e0e0;
		}
		#groupBoardList li a {
			display: block;
   	 		margin-left: 15px;
		}
	</style>
</head>
<body>
	<c:if test="${groupNum != null}">
		<aside class="groupMenu">
			<div class="groupInfo">
				<h2>${group.groupName}</h2>
				<div>
					<a href="view" class="view">
						<img class="profile" src="/project/displayFile?fileName=${group.profileImg}">
					</a>
				</div>
				<ul class="settingArea">
				<c:if test="${id == group.groupOwnerId || id == 'admin'}">
					<li><a href="todoSetting">목표 설정</a></li>
					<li><a href="boardSetting">게시판 설정</a></li>
					<li>
						<a id="deleteGroup" value="그룹 없애기" onclick="document.location.href='deleteGroup?groupNum=${groupNum}'">그룹 삭제</a>
					</li>
				</c:if>
				</ul>
				<ol>
					<li class="totalArticleViewBtn"><a href="list?boardNum=0&pageNum=1">전체글보기</a></li>			
					<li class="chattingBtn"><a class="chatRoomList">채팅방 접속</a></li>
				</ol>
				<ul>
<!-- 					<li><a class="chatRoomList">채팅방</a></li> -->
	<!-- 			<li> -->
	<!-- 				<input type="button" id="joinGroup" value="그룹 가입" onclick="document.location.href='#'"> -->
	<!-- 			</li> -->
	<%-- 			<c:forEach items="${memberList}" var="memberId"> --%>
	<%-- 				<c:if test="${id == memberId}"> --%>
	<%-- 					${"#joinGroup"}.remove(); --%>
	<%-- 				</c:if> --%>
	<%-- 			</c:forEach> --%>
					<div id="groupBoardList">
						<a href="#" class="groupBoardList"><span>그룹 게시판 목록 ▼</span></a>
						<ul>
						<c:forEach var="board" items="${boardList}">
							<li><a href="list?boardNum=${board.boardNum}&pageNum=1">${board.boardName}</a></li>
						</c:forEach>
						</ul>
					</div>
					<div id="groupIO"></div>
				</ul>
			</div>
			
		</aside>
	</c:if>
</body>
<script>
$(function() {
	$(".chatRoomList").on("click", function() {
		window.open("chatrooms", "main", "width=320, height=500");
	});
	
	$(".groupBoardList").on("click", function(event){
		event.preventDefault();
		console.log("띠용");
		$("#groupBoardList ul").slideToggle();
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
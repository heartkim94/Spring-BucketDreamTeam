<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Home</title>
	<style>
		.group, .newGroup {
			border: 1px solid black;
			width: 200px;
			height: 200px;
			cursor: pointer;
			float: left;
		}
		.clear {
			clear: both;
		}
	</style>
</head>

<body>

	<div id="wrapper">
	
		<%@ include file="../header.jsp" %>
		<section>
			<div>
				<center>
					<p>로그인 하면 나오는 그룹메인페이지 입니다</p>
					<form action="/project/logout.do" method="post">
					 	<!-- <input type="button" value="로그아웃">  -->  
					 	<p>${id}님 환영합니다</p>
					 	<a href="/project/mypage.do">회원정보수정</a><br>
					 	<a href="/project/myInfoDelForm.do">회원탈퇴</a><br>
						<button id="logout">로그아웃</button> <!-- 버튼태그가 폼태그 안에 선언되었을때는 무조건 submit한다  -->
					</form>
				</center>
			</div>
			<div class="myGroupContainer">
				내 그룹
				<div class="myGroup">
					<div class="newGroup">
						그룹추가하기
					</div>
					<c:forEach var="group" items="${groupList}">
						<div class="group" groupNum="${group.groupNum}">
							프로필이미지<br>
							${group.groupName}<br>
							멤버:${group.memberCount}명
						</div>
					</c:forEach>
					<div class="clear"></div>
				</div> <!-- myGroup End -->
				<div class="clear"></div>
			</div> <!-- myGroupContainer End -->
			<hr>
			<div class="groupListContainer">
				그룹목록
				<div class="groupList">
					<c:forEach begin="1" end="10" step="1" var="i">
						<div class="group">
							프로필이미지<br>
							예시그룹${i}<br>
							멤버:${i}명
						</div>
					</c:forEach>
					<div class="clear"></div>
				</div> <!-- groupList End -->
			</div> <!-- groupListContainer End -->
		</section>
		<%@ include file="../footer.jsp" %>
	
	</div> <!-- wrapper End -->
</body>
<script>
$(function() {
	$(".newGroup").on("click", function() {
		location.href = "new.do";
	});
	$(".group").on("click", function() {
		location.href = $(this).attr("groupNum")+"/view.do";
	});
});
</script>
</html>

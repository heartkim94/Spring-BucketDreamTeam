<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Home</title>
	<style>
		.group, .newGroup {
/* 			border: 1px solid black; */
			margin: 20px;
			width: 200px;
			height: 250px;
			cursor: pointer;
			float: left;
		}
		.clear {
			clear: both;
		}
		.group img {
			width: 200px;
			height: 200px;
		}
	</style>
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	
</head>

<body>
	<%@ include file="../common/header.jsp" %>
	<div id="wrapper">
		<section>
			<div class="container groupContent">
				<div class="myGroupContainer">
					내 그룹
					<div class="myGroup">
						<div class="newGroup" style="border:1px solid">
							그룹추가하기
						</div>
						<c:forEach var="myGroup" items="${myGroupList}">
							<div class="group" groupNum="${myGroup.groupNum}">
								<img src="/project/resources/img/흐엉.jpg" alt="프로필 이미지 없음"><br>
								${myGroup.groupName}<br>
								멤버:${myGroup.memberCount}명
							</div>
						</c:forEach>
						<div class="clear"></div>
					</div> <!-- myGroup End -->
<!-- 					<div class="clear"></div> -->
				</div> <!-- myGroupContainer End -->
				<hr>
				<div class="groupListContainer">
					그룹목록
					<div class="groupList">
						<c:forEach var="group" items="${groupList}">
							<div class="group" groupNum="${group.groupNum}">
								<img src="/project/resources/img/흐엉.jpg" alt="프로필 이미지 없음"><br>
								${group.groupName}<br>
								멤버:${group.memberCount}명
							</div>
						</c:forEach>
						<div class="clear"></div>
					</div> <!-- groupList End -->
				</div> <!-- groupListContainer End -->
			</div>
		</section>
		<%@ include file="../common/footer.jsp" %>
	
	</div> <!-- wrapper End -->
</body>
<script>
$(function() {
	$(".newGroup").on("click", function() {
		location.href = "new";
	});
	$(".group").on("click", function() {
		let groupNum = $(this).attr("groupNum");
		location.href = "/project/"+groupNum+"/view";
	});
});
</script>
</html>

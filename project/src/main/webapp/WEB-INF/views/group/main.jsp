<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Home</title>
	
	
</head>

<body>
	<%@ include file="../common/header.jsp" %>
	<div id="wrapper">
		<section>
			<div class="container groupContent">
				<div class="myGroupContainer">
					<h4>내 그룹</h4>
					<div class="myGroup">
						<div class="newGroup">
							<div class="cover">
								<span class="plusIcon"></span>
							</div>
							<div class="groupName">
								<span>그룹 만들기</span>
							</div>
						</div>
						<c:forEach var="myGroup" items="${myGroupList}">
							<div class="group" groupNum="${myGroup.groupNum}">
								<div class="cover">
									<img src="${myGroup.profileImg}" alt="프로필 이미지 없음">
								</div>
								<div class="groupName">
									<span>${myGroup.groupName}</span><br><br>
									<span>멤버:${myGroup.memberCount}명</span>
								</div>
							</div>
						</c:forEach>
						<div class="clear"></div>
					</div> <!-- myGroup End -->
<!-- 					<div class="clear"></div> -->
				</div> <!-- myGroupContainer End -->
				<hr>
				<div class="groupListContainer">
					<h4>공개 그룹</h4>
					<div class="groupList">
						<c:forEach var="group" items="${groupList}">
							<div class="group" groupNum="${group.groupNum}">
								<div class="cover">
									<img src="${group.profileImg}" alt="프로필 이미지 없음">
								</div>
								<div class="groupName">
									<span>${group.groupName}</span><br><br>
									<span>멤버:${group.memberCount}명</span>
								</div>
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
<style>
	.myGroupContainer, .groupListContainer {
	    padding: 37px 0 15px;
	    border-bottom: 1px solid #eee;
	}
	.groupListContainer {
		border: 0;
	}
	.group, .newGroup {
		margin: 20px;
		width: 200px;
		height: 200px;
		cursor: pointer;
		float: left;
		box-sizing: border-box;
		overflow: hidden;
	    box-shadow: 0 1px 2px 0 #999;
	}
	.group:hover, .newGroup:hover {
		box-shadow: 0 2px 4px 0 #999;
		padding-bottom: 2px;
	}
	.cover {
		overflow: hidden;
	}
	.newGroup .cover {
		position: relative;
		padding-top: 70px;
		text-align: center;
		box-sizing: border-box;
	}
	.group .cover {
		position: relative;
		box-sizing: border-box;
		height: 60%;
	}
	.cover > img {
		position: absolute;
	    margin: auto;
	    top: 0;
	    bottom: 0;
	    border-radius: 0;
	    height: auto;
	    width: 100%;
	}
	.groupName {
	    padding-top: 10px;
    	text-align: center;
    	position: relative;
	    height: 40%;
	    padding: 9px 12px 14px;
	    background-color: #fff;
	    box-sizing: border-box;
	    white-space: nowrap;
		text-overflow: ellipsis;
    	overflow: hidden;
	}
	span.plusIcon {
		display: inline-block;
		width: 50px;
		height: 50px;
		border-radius: 50px;
		background-color: #e0e0e0;
		background-image: url("/project/resources/img/plusIcon.png");
		background-size: 50px;
		background-repeat: no-repeat;
	}
	.clear {
		clear: both;
	}
	
	@media (max-width: 1024px) {
		div.groupContent{
			width: 768px;
		}
	}
	@media (max-width: 768px) {
		div.groupContent{
			width: 560px;
		}
	}
	@media (max-width: 560px) {
		div.groupContent{
			width: 100%;
		}
		.group, .newGroup {
			margin: 5%;
			width: 40%;
			height: 160px;
		}
	}
</style>

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
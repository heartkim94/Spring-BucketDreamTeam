<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		.boardList {
			width:300px;
			border: 1px solid black;
		}
	</style>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/header.jsp" %>
		<section>
			<div class="container settingContainer">
				<h3>목표</h3>
				<hr><br>
				<div class="doListContainer">
					<ul>
						<c:forEach var="todo" items="${doList}">
							<li doNum="${todo.doNum}" style="margin-left: ${25*todo.depth}">
								<input type="checkbox" name="done"> ${todo.doName}
								<c:if test="${todo.doWhen!=null}">
									!! ${todo.doWhen} <c:if test="${!todo.doAllDay}">${todo.doWhenTime}</c:if> !!
								</c:if>
							</li>
							<c:set var="lastPath" value="${todo.path}"/>
						</c:forEach>
					</ul>
				</div>
				<br>
				<h3>게시판 목록</h3>
				<hr>
				<div class="boardList">
					<ul>
						<c:forEach var="board" items="${boardList}">
							<li boardNum="${board.boardNum}">
								<name>${board.boardName}</name>
								<button class="rename">이름변경</button>
								<button class="saveName">저장</button>
								<button class="remove">삭제</button>
							<li>
						</c:forEach>
					</ul>
					<br>
					<button class="newBoard">새로만들기</button>
				</div>
				<br>
				<button onclick="location.href='view'">완료</button>
			</div>
		</section>
		<%@ include file="../common/footer.jsp" %>
	</div> <!-- wrapper End -->
</body>
<script>
$(function() {
	$(".saveName").css("display", "none");
	
	$(".rename").on("click", function() {
		rename($(this));
	});
	
	$(".saveName").on("click", function() {
		saveName($(this));
	});
	
	$(".remove").on("click", function() {
		remove($(this));
	});
	
	$(".newBoard").on("click", function() {
		newBoard();
	});
});

function rename(self) {
	let boardName = $(self).prev().text();
	let boardNum = $(self).parent().attr("boardNum");
	$(self).prev().remove();
	let str = "<input type='text' name='boardName' id='newName' value='"+boardName+"'>";
	$(str).insertBefore($(self));
	$(self).css("display", "none");
	$(self).next().css("display", "");
	$(self).prev().focus();
}

function saveName(self) {
	let input = $(self).parent().children("input");
	let renameBtn = $(self).parent().children(".rename");
	let boardNum = $(self).parent().attr("boardNum");
	let boardName = $(input).val();
	let str = "<name>"+boardName+"</name>";
	$(input).remove();
	$(str).insertBefore($(renameBtn));
	$(renameBtn).css("display", "");
	$(self).css("display", "none");
	
	$.ajax({
		url: "renameBoard",
		type: "POST",
		data: {
			boardNum: boardNum,
			boardName: boardName
		},
		success: function(data) {
			console.log(data);
		},
		error: function(xhr) {
			alert("error html = "+xhr.statusText);
		}
	});
}

function remove(self) {
	let board = $(self).parent();
	let boardNum = $(board).attr("boardNum");
	$.ajax({
		url: "deleteBoard",
		type: "POST",
		data: {
			boardNum: boardNum
		},
		success: function(data) {
			$(board).remove();
		},
		error: function(xhr) {
			alert("error html = "+xhr.statusText);
		}
	});
}

function newBoard() {
	$.ajax({
		url: "newBoard",
		type: "POST",
		data: {
			boardName: "Board"
		},
		success: function(data) {
			let newBoard = $(".boardList li:first").clone();
			$(newBoard).attr("boardNum", data);
			$(newBoard).insertAfter($(".boardList li:last"));
			$(newBoard).children("name").text("Board");
			$(newBoard).children(".rename").on("click", function() {
				rename($(this));
			});
			$(newBoard).children(".saveName").on("click", function() {
				saveName($(this));
			});
			$(newBoard).children(".remove").on("click", function() {
				remove($(this));
			});
		},
		error: function(xhr) {
			alert("error html = "+xhr.status);
		}
	});
}
</script>
</html>
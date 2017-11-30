<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		.boardList {
			border: 1px solid black;
		}
	</style>
</head>
<body>
	<div id="wrapper">
		<%@ include file="./../header.jsp" %>
		<section>
			<div class="settingContainer">
				게시판 목록
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
					<hr>
					<br>
					<button onclick="location.href='view.do'">완료</button>
				</div>
			</div>
		</section>
		<%@ include file="./../footer.jsp" %>
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
		url: "renameBoard.do",
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
		url: "deleteBoard.do",
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
		url: "newBoard.do",
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
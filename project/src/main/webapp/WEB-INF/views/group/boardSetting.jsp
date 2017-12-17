<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>그룹 게시판 관리</title>
	<style>
		.boardContainer {
			margin-top: 30px;
		}
		.boardList {
			float: left;
			width:300px;
			border: 1px solid black;
		}
		.boardList .selected {
			background: #ccc;
		}
		.boardContent {
			float: left;
			margin-left: 40px;
		}
		.clear {
			clear: both;
		}
	</style>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/header.jsp" %>
		<section>
			<%@ include file="asideMenu.jsp" %>
			<div class="container subContent">
				<h3>게시판 목록</h3>
				<div class="boardContainer">
					<div class="boardList">
						<ul>
							<c:forEach var="board" items="${boardList}">
								<li boardNum="${board.boardNum}">
									<span class="boardName">${board.boardName}</span>
								<li>
							</c:forEach>
						</ul>
						<br>
						<button class="newBoard">새로만들기</button>
					</div>
					<div class="boardContent">
						<table>
							<tr>
								<td>이름: </td>
								<td><input type="text" name="boardName"></td>
							</tr>
							<c:if test="${groupNum == -1}">
								<tr>
									<td>형태: </td>
									<td>
										<input type="radio" name="view"
											value="/WEB-INF/views/common/list.jsp"> 게시판형
										<input type="radio" name="view"
											value="/WEB-INF/views/common/listAcrd.jsp"> 리스트형
									</td>
								</tr>
							</c:if>
							<tr>
								<td></td>
								<td>
									<button class="newBoard">새로만들기</button>
									<button class="deleteBoard">삭제</button>
								</td>
							</tr>
						</table>
					</div>
					<div class="clear"></div>
					<br>
					<button onclick="location.href='view'">완료</button>
				</div>
			</div>
		</section>
		<%@ include file="../common/footer.jsp" %>
	</div> <!-- wrapper End -->
</body>
<script>
jQuery.fn.exist = function() {
	return this.length > 0;
}
$(function() {
	$(".boardList").on("click", "li", function() {
		$(".selected").removeClass("selected");
		$(this).addClass("selected");
		
		let boardName = $(this).find(".boardName").text();
		$(".boardContent [name=boardName]").val(boardName);
	});
	
	$(".boardContent [name=boardName]").on("change", function() {
		if($(".selected").exist()) {
			let boardName = $(this).val();
			let boardNum = $(".selected").attr("boardNum");
			$(".selected").find(".boardName").text(boardName);
			
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
	});
	
	$(".deleteBoard").on("click", function() {
		if($(".selected").exist()) {
			let boardNum = $(".selected").attr("boardNum");
			
			$.ajax({
				url: "deleteBoard",
				type: "POST",
				data: {
					boardNum: boardNum
				},
				success: function(data) {
					$(".selected").remove();
				},
				error: function(xhr) {
					alert("error html = "+xhr.statusText);
				}
			});
		}
	});
	
	$(".newBoard").on("click", function() {
		let view = $(".boardContent [name=view]:checked").val();
		$.ajax({
			url: "newBoard",
			type: "POST",
			data: {
				boardName: "Board",
				view: view
			},
			success: function(data) {
				let str =
					"<li>"
						+"<span class='boardName'>Board</span>"
					+"</li>";
				let newBoard = $(str);
				$(newBoard).attr("boardNum", data);
				$(newBoard).insertAfter($(".boardList li:last"));
				$(newBoard).click();
			},
			error: function(xhr) {
				alert("error html = "+xhr.status);
			}
		});
	});
	
	$(".boardContent [name=view]").on("change", function() {
		console.log($(".boardContent [name=view]:checked").val());
	});
});
</script>
</html>
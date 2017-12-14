<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="/project/resources/css/group.css" >
	<style>
		#todoList .todoContainer {
			display: flex;
		}
		#todoList .todoList {
			border: 1px solid black;
			flex: 1;
		}
		#todoList .todoList .selected {
			background: #ccc;
		}
		#todoList .todoList input[type=text] {
			border: 1px solid black;
		}
		#todoList .todoTools {
			border: 1px solid black;
			fles: 1;
		}
		#todoList .folded {
			display: none;
		}
		#todoList .line {
			border:0.5px solid black
		}
	</style>
</head>
<body>
	<div class="todoContainer">
		<div class="todoList">
			<ul>
			</ul>
			<hr class="line">
			<span>
				<button class="moveUpTodo">▲</button>
				<button class="moveDownTodo">▼</button>
				<button class="moveLeftTodo">◀</button>
				<button class="moveRightTodo">▶</button>
			</span>
		</div>
		<div class="todoTools">
			<ul>
				<li><button class="renameTodo">이름 변경</button><li>
				<li><button class="addTodo">목표 추가</button></li>
				<li><button class="deleteTodo">목표 제거</button></li>
				<li><button>test</button></li>
			</ul>
		</div>
	</div>
</body>
<script src="/project/resources/js/todoTools.js"></script>
</html>
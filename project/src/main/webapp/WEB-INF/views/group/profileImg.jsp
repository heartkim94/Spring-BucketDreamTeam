<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<title>그룹 메인 설정</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
	<script>
	function previewFile() {
		let preview = document.querySelector('img');
		let file = document.querySelector('input[type=file]').files[0];
		let reader = new FileReader();
		
		$("#holder").remove();
		
		reader.onloadend = function () {
			preview.src = reader.result;
		}
		if (file) {
			reader.readAsDataURL(file);
		} else {
			preview.src = "";
		}
	}
	</script>
	<style>
		input {
			display: inline-block;
		    margin: 0 0 0 15px;
		    padding: 5px 30px;
		    color: #fff;
		    font-weight: 500;
		    font-size: 14px;
		    border-radius: 2px;
		    background: #5c5b65;
		    cursor: pointer;
		 	outline: none;
		 	border: none;
		}
		input[value="설정 완료"] {
			background-color: #fff;
			border: 1px solid #e0e0e0;
			box-sizing: border-box;
			color: #111;
		}
		input[type="file"] {
			background-color: #fff;
			color: #999;
		}
	</style>
</head>
<body>
<div align="center">
	<form method="post" action="profileImg" enctype="multipart/form-data">
		<h3>그룹 메인 이미지 설정</h3>
<!-- 		<input type="hidden" name="" value=""> -->
		
		그룹 프로필 사진:<br>
		<input type="file" id="profileImg" name="profileImg" onchange="previewFile()"><br>
		<img src="" width="200" height="150" alt="Image Preview" style="margin: 50px 0"><br>
		<p id="holder" style="color:gray">
			※ 이미지 권장 사이즈 : 200x150<br>
			※ 이미지 제한 크기 : 200KB<br>
			※ 설정하지 않을 경우 기본 이미지로 표시됩니다.
		</p>
		<br><br>
		<input type="submit" value="결정">
		<input type="button" value="설정 완료" onclick="javascript:self.close()">
	</form>
</div>
</body>
</html>
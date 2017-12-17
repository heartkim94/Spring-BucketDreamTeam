<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
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
</head>
<body>
	<form method="post" action="profileImg" enctype="multipart/form-data">
		<h3>그룹 메인 설정</h3>
		<hr>
<!-- 		<input type="hidden" name="" value=""> -->
		
		그룹 프로필 사진: &nbsp;<input type="file" id="profileImg" name="profileImg" onchange="previewFile()"><br>
		<img src="" width="200" height="200" alt="Image Preview"><br>
		<span id="holder" style="color:gray">
			※ 이미지 권장 크기 200x200<br>
			※ 설정하지 않을 경우 기본 이미지로 표시됩니다.
		</span>
		<br><br>
		<input type="submit" value="결정">
		<input type="button" value="설정 완료" onclick="javascript:self.close()">
	</form>
</body>
</html>
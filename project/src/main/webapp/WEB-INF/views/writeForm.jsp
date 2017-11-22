<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>새글등록</title>
<style>
* {
	margin: 0;
	padding: 0;
}
#wrapper {
	width: 1024px;
	height: auto;
	margin: 0 auto;
	overflow: hidden;
	border: 1px solid black;
	box-sizing: border-box;
}

section {
	width: 100%;
	height: auto;
	overflow: hidden;
}
aside {
	float: left;
	width: 20%;
	min-height: 400px;
	background-color: skyblue;
}
article {
	float: right;
	width: 80%;
	background-color: pink;
	padding-left: 5%;
	box-sizing: border-box;
}
article nav {
	position: relative;
	width: 100%;
	height: 70px;
	border-bottom: 1px solid #e9e9e9;
}
article nav h1, span {
	position: absolute;
	bottom: 10px;
}
article nav span {
	right: 0px;
}
article > div {
	float: right;
	width: 100%;
	border: 1px solid blue;
	box-sizing: border-box;
}
.writeFormWrap {
	width: 100%;
}
.writeFormWrap table {
	width: 100%;
}
.writeFormWrap th, td {
	padding: 5px 10px;
	box-sizing: border-box;
}
.writeFormWrap th {
	background-color: orange;
	width: 20%;
	text-align: left;
}
textarea {
	width: 100%;
	height: 300px;
}
.btnConfirm {
	margin: 20px 0;
	text-align: center;
}

</style>
</head>
<body>
<div id="wrapper">

	<header><jsp:include page="header.jsp"/> </header>
	<section>
		<aside>
			<ul>
				<li><a href="#">NOTICE</a>
				<li><a href="#">Q&A</a>
				<li><a href="#">FAQ</a>
			</ul>
		</aside>
		<article>
			<div>
				<nav>
					<h1>Q&A</h1>
					<span>home > community > qna</span>
				</nav>
				<form action="#" method="post">
					<!-- 글쓰기 영역 전체 감쌈 -->
					<div class="writeFormWrap"> 
		<!-- 			<input type="hidden" name="id" value="#" /> 작성자 id -->
						<table border="1" cellpadding="0" cellspacing="0">
							<tr>
								<th><label for="title">제목</label></th>
								<td align="left"><input type="text" name="title" id="title"/></td>
							</tr>
							<tr>
								<th>작성자</th>
								<td align="left">작성자이름</td>
							</tr>
							<tr>
								<th><label for="content">내용</label></th>
								<td align="left"><textarea id="content" style="resize: none;" name="content" cols="40" rows="10"></textarea></td>
							</tr>
							<tr>
							 	<th>
							 		파일 첨부
							 		<a href="#" title="파일 첨부 열기">▼</a>
							 	</th>
								<td>
									<div class="fForm">
										<a href="#" class="fileUpBtn" >파일열기</a>
										<input type="file" style="display: none;" />
									</div>
									<div class="UploadList"></div>
								</td>
							</tr>
						</table>
					</div>
					<!-- 글 작성 버튼 영역 -->
					<div class="btnConfirm">
						<input type="submit" value="작성 완료" class="submitBtn" />
						<a href="#" >취소</a><!-- 클릭시 리스트 페이지로 이동 -->
					</div>
				</form>
				<hr>
				<a href="/project/home">글 목록 바로가기</a>
			</div>
		</article>
	</section>
	<footer><jsp:include page="footer.jsp"/> </footer>

</div> <!-- wrapper End -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	$(function(){
		$(".fileUpBtn").on("click", function(e){
			e.preventDefault();
			$("input[type=file]").click();
		});
	});
</script>
 
</body>
</html>
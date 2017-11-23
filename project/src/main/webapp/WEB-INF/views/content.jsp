<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
<link href="resources/style.css" rel="stylesheet" type="text/css">
<style>


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

.writeFormWrap {
	width: 100%;
}
.writeFormWrap table {
	width: 100%;
	border-collapse: collapse;
	border-spacing: 0;
}
.writeFormWrap th, td {
	background-color: transparent;
	padding: 5px 10px;
	box-sizing: border-box;
}
.writeFormWrap th {
	background-color: #f5f8f9;
	width: 15%;
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

.uploadListWrap {
	display: none;
	margin-top: 10px;
	width: 100%;
	height: auto;
	background-color: #fff;
	border: 1px solid #bfbfbf;
	box-sizing: border-box;
}
.upListHead {
	width: 100%;
	height: 20px;
	border-bottom: 1px solid #bfbfbf;
}
.upListView {
	width: 100%;
	height: 90px;
}
</style>
</head>
<body>
<div id="wrapper">

	<jsp:include page="header.jsp"/>
	<section>
		<jsp:include page="aside.jsp"/>
		<article>
			<div>
				<nav>
					<h1>NOTICE</h1>
					<span>home > community > notice</span>
				</nav>
				<div>
					<form action="update.do" method="post">
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
								 	<th style="vertical-align: top;">
								 		파일 첨부
								 		<a href="#" title="파일 첨부 열기" class="openFList">▼</a>
								 	</th>
									<td>
										<div class="fForm">
											<a href="#" class="fileUpBtn" >파일열기</a>
											<input type="file" style="display: none;" />
										</div>
										<div class="uploadListWrap">
											<div class="upListHead"></div>
											<div class="upListView"></div>
										</div>
									</td>
								</tr>
							</table>
						</div>
						<!-- 글 작성 버튼 영역 -->
						<div class="btnConfirm">
							<input type="submit" value="작성 완료" class="submitBtn" />
							<a href="/project/notice.do" >취소</a><!-- 클릭시 리스트 페이지로 이동 -->
						</div>
					</form>
				</div>
			</div>
		</article>
	</section>
	<jsp:include page="footer.jsp"/>

</div> <!-- wrapper End -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 
</body>
</html>
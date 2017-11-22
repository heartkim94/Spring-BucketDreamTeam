<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>새글등록</title>
</head>
<body>
<%@ include file="header.jsp" %>
	<center>
		<h1>글 등록</h1>
		<a href="logout.do">Log_out</a>
		<hr>
		<form action="#" method="post">
			<!-- 글쓰기 영역 전체 감쌈 -->
			<div class="writeFormWrap"> 
<!-- 			<input type="hidden" name="id" value="#" /> 작성자 id -->
				<table border="1" cellpadding="0" cellspacing="0">
					<tr>
						<th bgcolor="orange" width="70">제목</th>
						<td align="left"><input type="text" name="title" /></td>
					</tr>
					<tr>
						<th bgcolor="orange" width="70">작성자</th>
						<td align="left"><input type="text" name="writer" size="10" /></td>
					</tr>
					<tr>
						<th bgcolor="orange">내용</th>
						<td align="left"><textarea name="content" cols="40" rows="10"></textarea></td>
					</tr>
					<tr>
					 	<th bgcolor="orange">파일 추가</th>
						<td align="left">
							<input type="file" />
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
		<a href="#">글 목록 바로가기</a>
	</center>
<%@ include file="footer.jsp" %>
</body>
</html>
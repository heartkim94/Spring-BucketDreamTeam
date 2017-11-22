<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<title>공지사항</title>
<link href="resources/style.css" rel="stylesheet" type="text/css">
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
</head>

<body>
	<%@ include file="header.jsp"%>
	<%@ include file="aside.jsp"%>
	
	<div class="section">
		<table width="700">
			<tr>
				<td align="right"><a href="write.bbs">글쓰기</a></td>
			</tr>
		</table>
		<table border="1" width="700" cellpadding="2" cellspacing="2">
			<tr height="30">
				<td align="center" width="50">번 호</td>
				<td align="center" width="250">제 목</td>
				<td align="center" width="100">작성자</td>
				<td align="center" width="150">작성일</td>
				<td align="center" width="50">조 회</td>
			</tr>
	
			<c:forEach var="article" items="${articleList}">
				<tr height="30">
					<td align="center" width="50"><c:out value="${article.articleNum}" /></td>
					<td width="250">
						<c:if test="${article.depth > 0}">
							<img src="images/image3.png" width="${10 * article.depth}" height="16">
							<img src="images/cut.gif">
						</c:if>
						<c:if test="${article.depth == 0}">
							<img src="images/image3.png" width="0" height="16">
						</c:if>
						<a href="content.bbs?articleNum=${article.articleNum}&pageNum=${pageNum}&fileStatus=${article.fileStatus}">
							${article.title}
							<c:if test="${article.commentCount!=0}">
								<span style="color: red">(${article.commentCount})</span>
							</c:if>
						</a>
						<c:if test="${article.hit >= 20}">
							<img src="images/image3.png" border="0" height="16">
						</c:if>
					</td>
					<td align="center" width="100">${article.id}</td>
					<td align="center" width="150">${article.writeDate}</td>
					<td align="center" width="50">${article.hit}</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="5" align="center" height="40">${pageCode}</td>
			</tr>
		</table>
	</div>
	
	<%@ include file="footer.jsp"%>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
</body>
</html>
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
<script>
	$(function() {
		let articleBox = null;
		$(".titleBox").on("click", function() {
			let titleRow = $(this).parent();
			let articleNum = $(this).attr("articleNum");
			$.ajax({
				url: "getFaqArticle.do",
				type: "post",
				data: {
					articleNum: articleNum
				},
				success: function(data) {
					let str = "<tr><td class='articleBox' articleNum='"+articleNum+"'>"
							+ data.content
							+ "</td></tr>";
					if(articleBox!=null) {
						$(articleBox).remove();
					}
					articleBox = $(str);
					$(articleBox).insertAfter(titleRow);
				},
				error: function(xhr) {
					alert("error html = "+xhr.statusText);
				}
			});
		});
	});
</script>
</head>

<body>
	<%@ include file="../header.jsp"%>
	<%@ include file="/WEB-INF/views/aside.jsp"%>
	<div class="section">
		<c:if test="${isAdmin}">
			<table width="700">
				<tr>
					<td align="right"><a href="writeFaqFrom.do">글쓰기</a></td>
				</tr>
			</table>
		</c:if>
		<table border="1" width="700" cellpadding="2" cellspacing="2">
			<tr height="30">
				<td align="center" width="250">제 목</td>
			</tr>
	
			<c:forEach var="article" items="${articleList}">
				<tr height="30">
					<td class="titleBox" align="center" width="50" articleNum="${article.articleNum}" style="cursor:pointer">
						${article.title}
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="5" align="center" height="40">${pageCode}</td>
			</tr>
		</table>
	</div>
	
	<%@ include file="../footer.jsp"%>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
</body>
</html>
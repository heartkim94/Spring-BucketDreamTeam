<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<title>공지사항</title>
<link href="/project/resources/css/style.css" rel="stylesheet" type="text/css">
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
	$(function() {
		let articleBox = null;
		let preArticle = null;
		$(".titleBox").on("click", function() {
			let titleRow = $(this).parent();
			let articleNum = $(this).attr("articleNum");
			$.ajax({
				url: "content.do",
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
					if(preArticle!=articleNum) {
						$(articleBox).insertAfter(titleRow);
						preArticle = articleNum;
					} else {
						preArticle = null;
					}
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
<div id="wrapper">
	<%@ include file="../header.jsp"%>
	<section>
		<div class="subContent">
			<c:if test="${isAdmin}">
				<table width="100%">
					<tr>
						<td align="right"><a href="write.do?boardNum=${boardNum}">글쓰기</a></td>
					</tr>
				</table>
			</c:if>
			<table border="1" width="100%" cellpadding="2" cellspacing="2">
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
	</section>
	
	<%@ include file="../footer.jsp"%>
</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
</body>
</html>
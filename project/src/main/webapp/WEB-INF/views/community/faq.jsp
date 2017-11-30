<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<title>공지사항</title>
<!-- <link href="/project/resources/css/style.css" rel="stylesheet" type="text/css"> -->
<style>
	.faqTable tbody th {
		cursor: pointer;
	}
	.faqTable tbody th:hover button {
		color: orange;
	}
	
</style>
</head>

<body>
<div id="wrapper">
	<%@ include file="../header.jsp"%>
	<section>
		<div class="subContent">
			<table class="faqTable">
				<thead>
					<tr>
						<th align="center" width="250">제 목</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="article" items="${articleList}">
						<tr>
							<th class="titleBox"  articleNum="${article.articleNum}">
								<button><span>Q: </span>${article.title}</button>
							</th>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="btnArea">
				<c:if test="${isAdmin}">
					<td align="right"><a href="write.do?boardNum=${boardNum}">글쓰기</a></td>
				</c:if>
			</div>
			<div class="pageNav">${pageCode}</div>
		</div>
	</section>
	
	<%@ include file="../footer.jsp"%>
</div>
</body>
<script>
$(function() {
	let articleBox = null;
	let preArticle = null;
	$(".titleBox").on("click", function() {
		let titleRow = $(this).parent();
		let articleNum = $(this).attr("articleNum");
		let fileStatus = $(this).attr("fileStatus");
		$.ajax({
			url: "content.do",
			type: "post",
			data: {
				boardNum: "${boardNum}",
				articleNum: articleNum,
				fileStatus: fileStatus
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
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<title>공지사항</title>

<style>
	.acrdTable tbody th {
		cursor: pointer;
	}
	.acrdTable tbody th:hover button {
		color: orange;
	}
	.acrdTable {
	border-top: 2px solid #444547
	}
	.acrdTable th, td {
		padding: 10px 20px 10px 50px;
		border-bottom: 1px solid #e1e1e1;
	}
	.acrdTable tbody th, td {
		position: relative;
	    overflow: hidden;
	    text-align: left;
	}
	.acrdTable tbody th button{
	    color: #333;
		font-weight: bold;
		text-align: left;
	}
	.acrdTable tbody span{
	    left: 20px;
	    top: 10px;
	}
	td.articleBox { 
	    background: #f7f7f7;
	   	color: #555;
	}
	.acrdTable button {
	    margin: 0;
	    padding: 0;
	    border: 0;
	    font: inherit;
	    color: inherit;
	    background: transparent;
	    overflow: visible;
	    cursor: pointer;
	    line-height: 1;
	    outline: none;
		}
</style>
</head>

<body>
	<section>
		<div class="subContent">
			<table class="acrdTable">
				<thead>
					<tr>
						<th align="center" width="250">제 목</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="article" items="${articleList}">
						<tr>
							<th class="titleBox"  articleNum="${article.articleNum}" fileStatus="${article.fileStatus}">
								<button><span>Q: </span>${article.title}</button>
							</th>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<%@ include file="listBtn.jsp" %>
			<div class="pageNav">${pageCode}</div>
		</div>
	</section>
</body>
<script>
$(function() {
	let articleBox = null;
	let preArticle = null;
	$(".titleBox").on("click", function() {
		let titleRow = $(this).parent();
		let articleNum = $(this).attr("articleNum");
		let fileStatus = $(this).attr("fileStatus");
		console.log(articleNum+", "+fileStatus);
		$.ajax({
			url: "content",
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
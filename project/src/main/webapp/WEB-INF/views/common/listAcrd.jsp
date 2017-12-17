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
	    position: relative;
	    font-size: 16px;
	    padding: 15px 55px 15px 100px;
	    margin: 0;
		border-bottom: 1px solid #e1e1e1;
		overflow: hidden;
	    text-align: left;
	}
	.acrdTable tbody th button{
	    color: #333;
		font-weight: bold;
		text-align: left;
		position: relative;
	    margin: 0;
	    padding: 0;
	    border: 0;
	    font: inherit;
	    background: transparent;
	    overflow: visible;
	    cursor: pointer;
	    line-height: 1;
	    outline: none;
	}
	td.articleBox { 
	    background: #f7f7f7;
	   	color: #555;
	   	/* 글 개행 표현 */
   	    white-space: pre-line;
	}
	.acrdTable button {
		
	}
	.acrdTable span {
	    position: absolute;
	    top: 15px;
	    left: 0px;
	    width: 100px;
	    text-align: center;
	    color: #999;
	    font-size: 12px
	}
	i {
		position: absolute;
	    top: 15px;
	    right: 5%;
	    display: block;
	    width: 18px;
	    height: 15px;
	    background-image: url(/project/resources/img/downArrow.png);
	    background-position: bottom;
	    background-repeat: no-repeat;
	    background-size: 15px;
	    font-size: 0;
	}
	
	@media (max-width: 1024px) {
		section .container {
			width: 100%;
		}
		div.subContent {
			padding-left: 3%;
			padding-right: 3%;
		}
    }
    @media (max-width: 560px) {
    	.acrdTable span {
    		display: none;
    	}
    	.acrdTable th, td {
    		padding-left: 5%;
    	}
    	div.subContent {
			padding-left: 1%;
			padding-right: 1%;
		}
	}
    
</style>
</head>

<body>
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
						<span>${article.articleNum }</span>
						<button>${article.title}</button>
						<i class="downArrow">a</i> 
					</th>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<%@ include file="listBtn.jsp" %>
	<div class="pageNav">${pageCode}</div>
</body>
<script>
$(function() {
	let articleBox = null;
	let preArticle = null;
	$(".titleBox").on("click", function() {
		let titleRow = $(this).parent();
		let articleNum = $(this).attr("articleNum");
		let fileStatus = $(this).attr("fileStatus");
		let arrow = $(this).children().hasClass("downArrow");
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
// 					$(arrow).css("background-image", "url(/project/resources/img/toTop.png)");
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
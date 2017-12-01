<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<title>공지사항</title>
<!-- <link href="/project/resources/css/style.css" rel="stylesheet" type="text/css"> -->
<!-- <script src="//code.jquery.com/jquery-3.2.1.min.js"></script> -->
<style>
	
</style>
</head>
<body>
	<section>
		<div class="subContent">
			<%@ include file="listSearch.jsp" %>
		    ${totalCount}개의 게시물이 있습니다.
		    
			<table class="listTable" style=TABLE-layout:fixed>
				<thead>
					<tr>
						<th class="numTh">번 호</th>
						<th>제 목</th>
						<th class="fileTh">첨부파일</th>
						<th class="idTh">작성자</th>
						<th class="dateTh">작성일</th>
						<th class="hitTh">조 회</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="article" items="${articleList}">
						<tr>
							<td><c:out value="${article.articleNum}" /></td>
							<td class="alignL">
								<c:if test="${article.depth > 0}">
									<img src="/project/resources/img/icon_reply.gif" style="margin-left:${10 * article.depth}">
									<img src="">RE: 
								</c:if>
								<c:if test="${article.depth == 0}">
									<img src="" width="0" height="16">
								</c:if>
								<a href="content.do?boardNum=${boardNum}&articleNum=${article.articleNum}&pageNum=${pageNum}&fileStatus=${article.fileStatus}">
									${article.title}
									<c:if test="${article.commentCount!=0}">
										<span style="color: red">(${article.commentCount})</span>
									</c:if>
								</a>
								<c:if test="${article.hit >= 20}">
									<span class="hit">hit!</span>
								</c:if>
							</td>
							
							<td>
								<c:if test="${article.fileStatus == 1 }">
								파일있음
								</c:if>
							</td>
							
							<td>${article.id}</td>
							<td>${article.writeDate}</td>
							<td>${article.hit}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<%@ include file="listBtn.jsp" %>
			<div class="pageNav">${pageCode}</div>
		</div>
	</section>
</body>
</html>
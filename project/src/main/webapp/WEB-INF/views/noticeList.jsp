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
<div id="wrapper">
	<%@ include file="header.jsp" %>
	<section>
		<div class="subContent">
			<!-- 검색시작 -->
			<form action="#" method="get">
				<div class="searchBox">
					<select name="searchCondition">
						<c:forEach items="${conditionMap }" var="option">
							<option value="${option.value }">${option.key }</option>
						</c:forEach>
					</select>
					<input name="searchKeyword" type="text">
					<input type="submit" value="검색"> 
				</div>
			</form>
			<!-- 검색종료 -->
			<table class="listTable">
				<thead>
					<tr>
						<th>번 호</th>
						<th>제 목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조 회</th>
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
							<td>${article.id}</td>
							<td>${article.writeDate}</td>
							<td>${article.hit}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="btnArea">
				<c:if test="${boardNum == 1 || boardNum == 3 }">
					<c:if test="${isAdmin}">
						<td><a href="write.do?boardNum=${boardNum}">글쓰기</a></td>
					</c:if>
				</c:if>
				<c:if test="${boardNum == 2 }">
					<td><a href="write.do?boardNum=${boardNum}">글쓰기</a></td>
				</c:if>
			</div>
			<div class="pageNav">${pageCode}</div>
		</div>
	</section>
	
	<%@ include file="footer.jsp" %>
</div>
<!-- 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> -->
</body>
</html>
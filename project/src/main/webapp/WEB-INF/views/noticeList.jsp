<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<title>공지사항</title>
<link rel="stylesheet" href="/project/resources/css/style.css">
<!-- <script src="//code.jquery.com/jquery-3.2.1.min.js"></script> -->
<style>
	
	.hit {
		position: relative;
		bottom: 0;
		color: orange;
		animation-name: hitAniAction;
		animation-duration: 0.5s;
		animation-timing-function: linear;
		animation-iteration-count: infinite;
	}
	@keyframes hitAniAction {
		0%{
			font-weight: normal;
		}
		100%{
 			font-weight: bolder;
		}
	}

</style>
</head>
<body>
<div id="wrapper">
	<%@ include file="header.jsp" %>
	<section>
		<div class="subContent">
			<c:if test="${isAdmin}">
			<table width="100%">
				<tr>
					<td align="right"><a href="write.do?boardNum=${boardNum}">글쓰기</a></td>
				</tr>
			</table>
			</c:if>
			
			<!-- 검색시작 -->
			<form action="#" method="get">
				<table border="1" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td align="right">
							<select name="searchCondition">
								<c:forEach items="${conditionMap }" var="option">
									<option value="${option.value }">${option.key }</option>
								</c:forEach>
							</select>
							<input name="searchKeyword" type="text">
							<input type="submit" value="검색"> 
						</td>
					</tr>
				</table>
			</form>
			<!-- 검색종료 -->
			<table border="1" width="100%" cellpadding="2" cellspacing="2">
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
	</section>
	
	<%@ include file="footer.jsp" %>
</div>
<!-- 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> -->
</body>
</html>
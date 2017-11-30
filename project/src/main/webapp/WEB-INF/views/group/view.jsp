<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		.groupMenu, .groupMain, .groupApp {
			height: 70%;
			float: left;
			border: 1px solid black;
		}
		.groupMenu {
			width: 15%;
		}
		.groupMain {
			width: 60%;
		}
		.groupApp {
			width: 15%;
		}
		.clear {
			clear: both;
		}
	</style>
</head>
<body>
	<div id="wrapper">
		<%@ include file="./../header.jsp" %>
		<section>
			<%@ include file="aside.jsp" %>
			<div class="groupMain">
				내용<br>
				asdsdaf<br>
				<c:if test="${articleList!=null}">
					<table width="100%">
						<tr>
							<td align="right"><a href="write.do?boardNum=${boardNum}">글쓰기</a></td>
						</tr>
					</table>
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
				</c:if>
			</div>
			<aside class="groupApp">기타 기능</aside>
			<div class="clear"></div>
		</section>
		<%@ include file="./../footer.jsp" %>
	</div> <!-- wrapper End -->
</body>
</html>
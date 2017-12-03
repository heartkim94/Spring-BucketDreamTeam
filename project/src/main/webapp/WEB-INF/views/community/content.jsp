<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>글 상세 보기</title>
<style>
.contentTable {
/* 	border: 1px solid black; */
}
.contentTable th {
	border-bottom: 1px solid #e1e1e1;
	border-right: 1px solid #e1e1e1;
	background-color: #e9e9e9;
}
.contentTable tr:last-child {
	height: 400px;
}
.btnConfirm {
/* 	margin: 20px 0; */
	padding-top: 20px;
	text-align: center;
	overflow: hidden;
}
.btnConfirm li {
	float: right;
	margin-right: 5px;
	box-sizing: border-box; 
}
input {
	padding: 8px;
	border: 0;
	background-color: #f2f5f9;
	letter-spacing: -0.1em;
	cursor: pointer;
}

/* comment */
.commentArea {
	text-align: center;
}
#commentContent{
	width: 100%;
	height: 100px;
}
</style>
</head>
<body>
	<div id="wrapper">

		<%@ include file="../common/header.jsp" %>
		<section> 
			<div class="container subContent">
				<nav>
					<h1>NOTICE</h1>
					<span>home > community > notice</span> 
				</nav>
				<div>
					<table class="contentTable">
						<tr>
							<th>제목 :</th>
							<td>${article.title}</td>
						</tr>
						<tr>
							<th>작성자: </th>
							<td>${article.id }</td>
						</tr>
						<tr>
							<th>작성일: </th>
							<td>${article.writeDate }</td>
						</tr>
						<tr>
							<th>조회: </th>
							<td>${article.hit }</td>
						</tr>
						
						<tr>
							<th>다운로드</th>
							<td>
								<c:if test="${article.fileStatus !=0 }">
									<c:if test="${fileList!=null}">
										<ul>
											<c:forEach var="storedFname" items="${fileList}">
												<li>
													<a href="/bbs/download.bbs?storedFname=${storedFname}">${storedFname.substring(storedFname.indexOf("_")+1)}</a>
												</li>
											</c:forEach>
										</ul>
									</c:if>
								</c:if>
							</td>
						</tr>
						<tr>
							<th>내용: </th>
							<td colspan="4"><xmp>${article.content}</xmp></td>
						</tr>
					</table>
					<form action="reply.do" method="get">
						<input type="hidden" name="boardNum" value="${boardNum}">
						<input type="hidden" name="pageNum" value="${pageNum}">
						<input type="hidden" name="depth" value="${article.depth}">
				    	<input type="hidden" name="pos" value="${article.pos}">
				   	 	<input type="hidden" name="groupId" value="${article.groupId}">
				   		<c:if test="${id !=null}">
					    	<ul class="btnConfirm">
								<li><input type="button" value="목록으로" onclick="document.location.href='list.do?boardNum=${boardNum}&pageNum=${pageNum}'"></li>
								<c:choose>
									<c:when test="${id == article.id}">
										<li><input type="button" value="삭제하기" onclick="document.location.href='delete.do?boardNum=${boardNum}&articleNum=${article.articleNum}&pageNum=${pageNum}&fileStatus=${article.fileStatus}'"></li>
										<li><input type="button" value="수정하기" onclick="document.location.href='updateForm.bbs?boardNum=${boardNum}&articleNum=${article.articleNum}&pageNum=${pageNum}&fileStatus=${article.fileStatus}'"></li>
										<li><input type="submit" value="답글달기"></li>
									</c:when>
									<c:otherwise>
										<c:if test="${isAdmin }">
											<li><input type="button" value="삭제하기" onclick="document.location.href='delete.do?boardNum=${boardNum}&articleNum=${article.articleNum}&pageNum=${pageNum}&fileStatus=${article.fileStatus}'"></li>
											<li><input type="button" value="수정하기" disabled="disabled"></li>
											<li><input type="submit" value="답글달기" ></li>
										</c:if>
										<c:if test="${!isAdmin }">
											<li><input type="button" value="삭제하기" disabled="disabled"></li>
											<li><input type="button" value="수정하기" disabled="disabled"></li>
											<li><input type="submit" value="답글달기" ></li>
										</c:if>
									</c:otherwise>
								</c:choose>
							</ul>
				  		</c:if>
						<c:if test="${id ==null}">
							<ul class="btnConfirm">
								<li><input type="button" value="목록으로" onclick="document.location.href='list.do?boardNum=${boardNum}&pageNum=${pageNum}'"></li>
								<li><input type="button" value="삭제하기" disabled="disabled"></li>
								<li><input type="button" value="수정하기" disabled="disabled"></li>
								<li><input type="submit" value="답글달기"disabled="disabled"></li>
							</ul>
						</c:if>
<!-- 								<tr> -->
<!-- 									<td colspan="4"> -->
<!-- 										<textarea rows="5" cols="70" id="commentContent"></textarea><br><br>  -->
<%-- 										<c:if test="${id ==null}"> --%>
<!-- 											<input type="button" value="comment 쓰기" disabled="disabled"> -->
<%-- 										</c:if>  --%>
<%-- 										<c:if test="${id !=null}"> --%>
<!-- 											<input type="button" value="comment 쓰기" id="commentWrite"> -->
<%-- 										</c:if>  --%>
<%-- 										<input type="button" value="comment 읽기(${article.commentCount })" onclick="getComment(1,event)" id="commentRead"> --%>
<!-- 									</td> -->
<!-- 								</tr> -->
						</table>
					</form>
					<div class="commentArea">	
						<table class="commentTable">
							<tr>
								<th>내용: </th>
								<td><textarea id="commentContent"></textarea></td>
							</tr>
						</table>
						<c:if test="${id ==null}">
							<input type="button" value="comment 쓰기" disabled="disabled">
						</c:if> 
						<c:if test="${id !=null}">
							<input type="button" value="comment 쓰기" id="commentWrite">
						</c:if> 
					</div>			
	
<!-- 					<form> -->
<!-- 						<div> -->
<!-- 							<div id="showComment" align="center"></div> -->
<!-- 							<input type="hidden" id="commPageNum" value="1"> -->
<!-- 						</div> -->
<!-- 					</form> -->
				</div> <!-- contentTable end -->
			</div> <!-- container end -->
		</section>
		<%@ include file="../common/footer.jsp" %>

	</div>
	<!-- wrapper End -->

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

</body>
</html>
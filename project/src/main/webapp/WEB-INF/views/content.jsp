<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>글 상세 보기</title>
<style>


.btnConfirm {
	margin: 20px 0;
	text-align: center;
}

input.submitBtn {
	padding: 8px;
	border: 0;
	background-color: orange;
	color: #fff;
	letter-spacing: -0.1em;
	cursor: pointer;
}

.cancelBtn {
	display: inline-block;
	padding: 7px;
	border: 1px solid #ccc;
	background: #fafafa;
	color: #000;
	text-decoration: none;
	vertical-align: middle;
}


</style>
</head>
<body>
	<div id="wrapper">

		<%@ include file="header.jsp" %>
		<section> 
			<%@ include file="aside.jsp" %>
			<div class="subContent">
				<nav>
				<h1>NOTICE</h1>
				<span>home > community > notice</span> </nav>
				<div>
					<form action="update.do" method="post">
						<input type="hidden" name="pageNum" value="${pageNum}">
						<input type="hidden" name="depth" value="${article.depth}">
						<!--     계층형 쿼리 사용을 위해서 부모글의 글 번호가 답글의 groupId가 되어야 함 -->
						<input type="hidden" name="groupId" value="${article.articleNum}">
						<table border="1" width="500" align="center">
							<tr>
								<td>글쓴이 :</td>
								<td>${article.id}</td>
								<td>조회수 :</td>
								<td>${article.hit}</td>
							</tr>
							<tr>
								<td>제목 :</td>
								<td>${article.title}</td>
								<td>날짜 :</td>
								<td>${article.writeDate}</td>
							</tr>
<!-- 							<tr> -->
<!-- 								<td colspan="2">다운로드</td> -->
<!-- 								<td colspan="2"> -->
<%-- 									<c:if test="${article.fileStatus !=0 }"> --%>
<%-- 										<c:if test="${fileList!=null}"> --%>
<!-- 											<ul> -->
<%-- 												<c:forEach var="storedFname" items="${fileList}"> --%>
<!-- 													<li> -->
<%-- 														<a href="/bbs/download.bbs?storedFname=${storedFname}">${storedFname.substring(storedFname.indexOf("_")+1)}</a> --%>
<!-- 													</li> -->
<%-- 												</c:forEach> --%>
<!-- 											</ul> -->
<%-- 										</c:if> --%>
<%-- 									</c:if> --%>
<!-- 								</td> -->
<!-- 							</tr> -->
							<tr>
								<td colspan="4"><xmp>${article.content}</xmp></td>
							</tr>
	
							<tr>
								<c:if test="${id !=null}">
									<td colspan="4" align="right">
										<c:if test="${id ==article.id}">
											<input type="button" value="수정하기" onclick="document.location.href='updateForm.bbs?articleNum=${article.articleNum}&pageNum=${pageNum}&fileStatus=${article.fileStatus}'">
											<input type="button" value="삭제하기" onclick="document.location.href='delete.bbs?articleNum=${article.articleNum}&pageNum=${pageNum}&fileStatus=${article.fileStatus}'">
										</c:if> 
										<c:if test="${id !=article.id}">
											<input type="button" value="수정하기" disabled="disabled">
											<input type="button" value="삭제하기" disabled="disabled">
										</c:if> 
										<input type="button" value="목록으로" onclick="document.location.href='noticeList.do?pageNum=${pageNum}'">
									</td>
								</c:if>
	
								<c:if test="${id ==null}">
									<td colspan="4" align="right">
										<input type="button" value="수정하기" disabled="disabled"> 
										<input type="button" value="삭제하기" disabled="disabled"> 
										<input type="button" value="목록으로" onclick="document.location.href='noticeList.do?pageNum=${pageNum}'">
									</td>
								</c:if>
							</tr>
<!-- 							<tr> -->
<!-- 								<td colspan="4"> -->
<!-- 									<textarea rows="5" cols="70" id="commentContent"></textarea><br><br>  -->
<%-- 									<c:if test="${id ==null}"> --%>
<!-- 										<input type="button" value="comment 쓰기" disabled="disabled"> -->
<%-- 									</c:if>  --%>
<%-- 									<c:if test="${id !=null}"> --%>
<!-- 										<input type="button" value="comment 쓰기" id="commentWrite"> -->
<%-- 									</c:if>  --%>
<%-- 									<input type="button" value="comment 읽기(${article.commentCount })" onclick="getComment(1,event)" id="commentRead"> --%>
<!-- 								</td> -->
<!-- 							</tr> -->
						</table>
						<div class="btnConfirm">
							<input type="submit" value="작성 완료" class="submitBtn" /> 
							<a href="/project/notice.do?pageNum=${pageNum}">취소</a>
						</div>
					</form>
	
<!-- 					<form> -->
<!-- 						<div> -->
<!-- 							<div id="showComment" align="center"></div> -->
<!-- 							<input type="hidden" id="commPageNum" value="1"> -->
<!-- 						</div> -->
<!-- 					</form> -->
				</div>
			</div>
		</section>
		<%@ include file="footer.jsp" %>

	</div>
	<!-- wrapper End -->

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

</body>
</html>
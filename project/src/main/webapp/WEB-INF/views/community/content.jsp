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
						
<!-- 						<tr> -->
<!-- 							<th>다운로드</th> -->
<!-- 							<td> -->
<%-- 								<c:if test="${article.fileStatus !=0 }"> --%>
<%-- 									<c:if test="${fileList!=null}"> --%>
<!-- 										<ul> -->
<%-- 											<c:forEach var="storedFname" items="${fileList}"> --%>
<!-- 												<li> -->
<%-- 													<a href="/project/download.do?storedFname=${storedFname}">${storedFname.substring(storedFname.indexOf("_")+1)}</a> --%>
<!-- 												</li> -->
<%-- 											</c:forEach> --%>
<!-- 										</ul> -->
<%-- 									</c:if> --%>
<%-- 								</c:if> --%>
<!-- 							</td> -->
<!-- 						</tr> -->
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
										<li><input type="button" value="수정하기" onclick="document.location.href='update.do?boardNum=${boardNum}&articleNum=${article.articleNum}&pageNum=${pageNum}&fileStatus=${article.fileStatus}'"></li>
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
						<input type="button" value="comment 읽기(${article.commentCount })" onclick="getComment(1,event)" id="commentRead">
					</div>			
	
					<form>
						<div>
							<div id="showComment" align="center"></div>
							<input type="hidden" id="commPageNum" value="1">
						</div>
					</form>
				</div> <!-- contentTable end -->
			</div> <!-- container end -->
		</section>
		<%@ include file="../common/footer.jsp" %>

	</div>
	<!-- wrapper End -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	$.ajaxSetup({
		type: "POST",
		async : "true",
		dataType : "json",
		error : function(xhr){
			alert("error html = "+ xhr.statusText);
		}
	});
	$(document).ready(function() {
		$("#commentWrite").on('click', function() {
			$.ajax({
				url : "/project/commentWrite.do",
				// data{}에서는 EL을 ""로 감싸야함....그외에는 그냥 사용
				data : {
					id : "${id}",
					commentContent : $('#commentContent').val(),
					articleNum : "${article.articleNum}",
					boardNum : "${boardNum}" 
				},
				success : function(data) {
					if (data.result == 1) {
						alert("comment가 정상적으로 입력되었습니다.")
						$("#commentContent").val("");
						showHtml(data.commentList, 1);
					}
				},

			}); // ajax end
		});
	});
	function showHtml(data, commPageNum){
		var html = "<table border='1' width='100%' align='center'>";
		$.each(data, function(index,item){
			html +="<tr>";
			html +="<td>"+(index+1)+"</td>";
			html +="<td>"+item.id+"</td>";
			html +="<td>"+item.commentContent+"</td>";
			html +="<td>"+item.commentDate+"</td>";					
			html +="<td>"+item.articleNum+"</td>";					
			html +="</tr>";					
		});		
		html +="</table>";
		commPageNum = parseInt(commPageNum);
		if("${article.commentCount}" > commPageNum * 10){
			nextPageNum = commPageNum+1;
			html +="<br /><input type='button' onclick='getComment(nextPageNum,event)' value='다음comment보기'><br>";
			$("#showComment").html(html);	
			$("#commentContent").val("");
			$("#commentContent").focus();
		}
	}
	function getComment(commPageNum, event){
		event.preventDefault();
		$ajax({
			url : "/project/commentRead.do",
			data: {
				articleNum : "${article.articleNum}",
				commentRow: commPageNum * 10
			}, 
			success: function(data){
				showHtml(data, commPageNum, event);
			}
		});
	}
</script>	
</body>
</html>
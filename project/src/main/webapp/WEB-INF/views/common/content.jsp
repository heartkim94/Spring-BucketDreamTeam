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
.commentList > div {
	padding: 5px;
	border: 1px solid blue;
}
.commentList ul {
	overflow: hidden;
	display:inline-block;
}
.commentList ul li {
	float: left;
	border: 1px solid black;
}
article.commentList input {
	color: red;
}
</style>
</head>
<body>
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
<%-- 													<a href="/project/download?storedFname=${storedFname}">${storedFname.substring(storedFname.indexOf("_")+1)}</a> --%>
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
	<form action="reply" method="get">
		<input type="hidden" name="boardNum" value="${boardNum}">
		<input type="hidden" name="pageNum" value="${pageNum}">
		<input type="hidden" name="depth" value="${article.depth}">
    	<input type="hidden" name="pos" value="${article.pos}">
   	 	<input type="hidden" name="groupId" value="${article.groupId}">
   		<c:if test="${id !=null}">
	    	<ul class="btnConfirm">
				<li><input type="button" value="목록으로" onclick="document.location.href='list?boardNum=${boardNum}&pageNum=${pageNum}'"></li>
				<c:choose>
					<c:when test="${id == article.id}">
						<li><input type="button" value="삭제하기" onclick="document.location.href='delete?boardNum=${boardNum}&articleNum=${article.articleNum}&pageNum=${pageNum}&fileStatus=${article.fileStatus}'"></li>
						<li><input type="button" value="수정하기" onclick="document.location.href='update?boardNum=${boardNum}&articleNum=${article.articleNum}&pageNum=${pageNum}&fileStatus=${article.fileStatus}'"></li>
						<li><input type="submit" value="답글달기"></li>
					</c:when>
					<c:otherwise>
						<c:if test="${isAdmin }">
							<li><input type="button" value="삭제하기" onclick="document.location.href='delete?boardNum=${boardNum}&articleNum=${article.articleNum}&pageNum=${pageNum}&fileStatus=${article.fileStatus}'"></li>
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
				<li><input type="button" value="목록으로" onclick="document.location.href='list?boardNum=${boardNum}&pageNum=${pageNum}'"></li>
				<li><input type="button" value="삭제하기" disabled="disabled"></li>
				<li><input type="button" value="수정하기" disabled="disabled"></li>
				<li><input type="submit" value="답글달기"disabled="disabled"></li>
			</ul>
		</c:if>
		</table>
	</form>
	<!-- 코멘트 -->
	<div class="commentArea">
		<p>전체 코멘트: <span style="color: blue">(${article.commentCount})</span></p>
		<!-- 코멘트 쓰기 영역 -->
		<div style="margin-bottom: 10px;">
			
			<table class="commentTable">
				<tr>
					<th>내용: </th>
					<td><textarea id="commentContent" name="contents"></textarea></td>
				</tr>
			</table>
			<c:if test="${id ==null}">
				<input type="button" value="comment 쓰기" disabled="disabled">
			</c:if> 
			<c:if test="${id !=null}">
				<input type="button" value="comment 쓰기" id="commentWrite">
			</c:if> 
<%-- 			<input type="button" value="comment 읽기(${article.commentCount })" onclick="getComment(1,event)" id="commentRead"> --%>
		</div>
		<!-- 코멘트 리스트 -->
		<div style="width: 100%; min-height: 100px; padding: 20px;">
			<div id="showComment" align="center"></div>
			<input type="hidden" id="commPageNum" value="1">
		</div>
		
	</div>			
	
</div> <!-- contentTable end -->
</body>
<script>
	let replyArea = null;
	
	$.ajaxSetup({
		type: "POST",
		async : "true",
		dataType : "json",
		error : function(xhr){
			alert("error html = "+ xhr.statusText);
		}
	});
	$(document).ready(function(data) {
		// 댓글 목록 
		$.ajax({
			url : "/project/commentList",
			data : {
				articleNum : "${article.articleNum}",
				boardNum : "${boardNum}", 
// 				commentRow : commPageNum * 10
			},
			success : function(data) {
				showHtml(data, 1);
			},
		}); // ajax end		
		
		// 댓글 쓰기
		$("#commentWrite").on('click', function() {
			if($('#commentContent').val() == ""){
				alert("내용을 입력하세요");
				return;
			}
			$.ajax({
				url : "/project/commentWrite",
				data : {
					id : "${id}",
					commentContent : $('#commentContent').val(),
					articleNum : "${article.articleNum}",
					boardNum : "${boardNum}" 
				},
				success : function(data) {
					if (data.result == 1) {
						$("#commentContent").val("");
						showHtml(data.commentList, 1);
					}
				},
			}); // ajax end
		}); // 댓글 쓰기 끝
		
	});
	
	function showHtml(data, commPageNum){
		console.log(data);
		var html = "<article class='commentList'>";
		$.each(data, function(index,item){
			html +="<div class='comment' commentNum='"+item.commentNum+"'>";
			html +="<div class='commentInfo'><ul>";
			html +="<li>"+(index+1)+"</li>";
			html +="<li>"+item.id+"</li>";
			html +="<li>"+item.commentDate+"</li>";
// 			html +="<li>"+item.articleNum+"</li>";
			html +="</ul></div>";	
			html +="<p>"+item.commentContent+"</p>";
			html +="<ul>";
			html +="<li class='btnReComment'><a href='#' onclick='openReplyArea(event,"+item.commentNum+", this)'>답변</a></li>";
			html +="<li><a href='#' onclick=''>수정</a></li>";
			html +="<li><a href='#' onclick='deleteComment(event)'>삭제</a></li>";
			html +="</ul>";
			html +="</div>";	
		});		
		html +="</article>";
		commPageNum = parseInt(commPageNum);
		if("${article.commentCount}" > commPageNum * 10){
			nextPageNum = commPageNum+1;
			html +="<br /><input type='button' onclick='getComment(nextPageNum,event)' value='다음comment보기'><br>";
		}
		$("#showComment").html(html);	
		$("#commentContent").val("");
		$("#commentContent").focus();
	}
	
	function getComment(commPageNum, event){
		event.preventDefault();
		$.ajax({
			url : "/project/commentRead",
			data: {
				articleNum : "${article.articleNum}",
				boardNum : "${boardNum}",
				commentRow: commPageNum * 10
			}, 
			success: function(data){
				showHtml(data, commPageNum);
			}
		});
	}
	
	function openReplyArea(event, parentNum, self){
		console.log(self);
		event.preventDefault();
// 		console.log(parentNum);
		if(replyArea!=null) {
			$(replyArea).remove();
		}
		replyArea = $(".commentTable").parent().clone();
// 		let ul = $(".btnReComment").parent();
// 		ul.append(replyArea);
		$(".comment[commentNum="+parentNum+"]").append($(replyArea));
		$("article.commentList input").attr({
			value: "답변 달기",
			onclick: "replyComment(event, this)"
		});
	}
	
	function replyComment(event, self){
		event.preventDefault();
		console.log(this);
		$.ajax({
			url : "/project/replyComment",
			data : {
				
			},
			success : {
				
			}
		});
	}

	function updateComment(event){
		event.preventDefault();
		$ajax({
			url : "/project/updateComment",
			data : {
				
			},
			success : {
				
			}
		});
	}
	
	function deleteComment(event){
		event.preventDefault();
		console.log('삭제버튼 클릭')
// 		$ajax({
// 			url : "/project/deleteComment",
// 			data : {
				
// 			},
// 			success : {
				
// 			}
// 		});
	}
	
</script>
</html>
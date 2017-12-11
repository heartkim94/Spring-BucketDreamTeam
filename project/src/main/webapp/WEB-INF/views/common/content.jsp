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
.commentList > div.comment {
	padding: 15px 0;
	border-bottom: 1px solid #e2e2e2;
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
.commentContent {
	font-size: 14px;
	line-height: 18px;
}

.commentArea > div.commTableWrap {
	border: 1px solid #b3b3b3;
	margin: 10px 0;
}
textarea {
	box-sizing: border-box;
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
	<hr>
	<!-- 코멘트 -->
	<div class="commentArea">
		<p>전체 코멘트: <span style='color: blue'>(${article.commentCount})</span></p>
		<!-- 코멘트 쓰기 영역 -->
		<div class="commTableWrap">
			
			<table class="commentTable">
				<tr>
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
		<div style="width: 100%; min-height: 100px; padding: 20px 0;">
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
		
		getComments(data);
		
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
	function getComments(data){
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
	}
	function showHtml(data, commPageNum){
// 		console.log(data);
		let html = "<article class='commentList'>";
		$.each(data, function(index,item){
			html +="<div class='comment' commentNum='"+item.commentNum
					+"' depth='"+item.depth
					+"' style='margin-left:"+ (20*item.depth) +"px'>";
			html +="<div class='commentInfo'><ul>";
			html +="<li>번호: "+item.commentNum+"</li>";
			html +="<li>작성자: "+item.id+"</li>";
			html +="<li>작성일: "+item.commentDate+"</li>";
			html +="<li>글번호: "+item.articleNum+"</li>";
			html +="<li>depth: "+item.depth+"</li>";
			html +="</ul></div>";	
			html +="<p class='commentContent' >"+item.commentContent+"</p>";
			html +="<ul class='btn'>";
// 			html +="<li><a href='#' onclick='openReplyArea(event,"+item.commentNum+", this)'>답변</a></li>";
// 			html +="<li><a href='#' onclick='openUpdateArea(event, this)'>수정</a></li>";
// 			html +="<li><a href='#' onclick='deleteComment(event,"+item.commentNum+", this)'>삭제</a></li>";
			html +="<li><a href='#' class='replyComment')'>답변</a></li>";
			html +="<li><a href='#' class='updateComment'>수정</a></li>";
			html +="<li><a href='#' class='deleteComment')'>삭제</a></li>";
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
	
	// 답변 버튼 클릭
	$("#showComment").on("click", ".replyComment", function(event) {
		event.preventDefault();
		let comment = $(this).parents(".comment");
		let commentNum = $(comment).attr("commentNum");
		let commentContent = $(comment).children(".commentContent").text();
		console.log(commentNum, commentContent);
		if(replyArea!=null) {
			$(replyArea).remove();
		}
		replyArea = $(".commentTable").parent().clone();
		comment.append($(replyArea));
		$("article.commentList input").attr({
			value: "답변 달기",
			"class": "replyBtn",
		});
		$("article.commentList textarea").attr({
			"class": "replyTextarea",
		});
	});
	// 답변 ajax
	$("#showComment").on("click", ".replyBtn", function(event){
		event.preventDefault();
		let comment = $(this).parents(".comment");
		let commentNum = $(comment).attr("commentNum");
		let commentContent = $(comment).find(".replyTextarea").val();
		let depth = $(comment).attr("depth");
// 		newRow.append($(comment));
		$.ajax({
			url : "/project/replyComment",
			data: {
				id : "${id}",
				commentContent : $('.replyTextarea').val(),
				articleNum : "${article.articleNum}",
				boardNum : "${boardNum}", 
				commentNum: commentNum,
				parentNum: commentNum,
				depth: depth
			},
			success: function(data){
				$(comment).children(".commTableWrap").remove();
				let newRow = comment.clone();
				if (data.result == 1) {
					$("#commentContent").val("");
					$(comment).append($(newRow));
					showHtml(data.commentList, 1);
				}
			}
		});
	})
	
	// 수정 버튼 클릭
	$("#showComment").on("click", ".updateComment", function(event) {
		event.preventDefault();
		let comment = $(this).parents(".comment");
		let commentNum = $(comment).attr("commentNum");
		let commentContent = $(comment).children(".commentContent").text();
		console.log(commentNum, commentContent);
		if(replyArea!=null) {
			$(replyArea).remove();
		}
		replyArea = $(".commentTable").parent().clone();
		comment.append($(replyArea));
	 	comment.find($('textarea')).addClass("inTextarea");
		comment.find($('textarea')).val(commentContent);
		$("article.commentList input").attr({
			value: "글 수정",
			"class": "updateBtn",
			
		});
	});
	// 글 수정 ajax
	$("#showComment").on("click", ".updateBtn", function(event){
		console.log("updateBtn Click!"); 
		let comment = $(this).parents(".comment");
		let commentNum = $(comment).attr("commentNum");
		let commentContent = $(comment).find(".inTextarea").val();
		console.log("번호"+commentNum+", 내용: "+commentContent);
		$.ajax({
			url : "/project/updateComment",
			data: {
				id : "${id}",
				commentNum: commentNum,
				commentContent : commentContent,
			},
			success: function(data){
				$(comment).children(".commentContent").text(commentContent);
				$(replyArea).remove();
			}
		});
	});
	// 삭제버튼 클릭
	$("#showComment").on("click", ".deleteComment", function(event) {
		event.preventDefault();
		alert('글이 삭제됩니다.');
		let comment = $(this).parents(".comment");
		let commentNum = $(comment).attr("commentNum");
		let commentContent = $(comment).children(".commentContent").text();
		console.log(commentNum, commentContent);
		$.ajax({
			url : "/project/deleteComment",
			data: {
				articleNum : "${article.articleNum}",
				boardNum : "${boardNum}",
				commentNum : commentNum
			},
			success: function(data){
				showHtml(data, 1);
			}
		});
	});
	
	
	function replyComment(event, parentNum, self){
		event.preventDefault();
		$.ajax({
			url : "/project/replyComment",
			data: {
				id : "${id}",
				commentContent : $("textarea[commentNum]'"+parentNum+"']").val(),
				boardNum : "${boardNum}",
				articleNum : "${article.articleNum}"
			},
			success: function(data){
				alert(commentContent);
			}
		}); 
		console.log(this);
	}
	
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>글 상세 보기</title>
<style>

textarea {
	resize: none;
	
}
.contentTable {
	clear: both;
    position: relative;
    width: 100%;
    overflow: hidden;
    border-top: 2px solid #444547;
}
.title {
	margin: 0;
    padding: 15px 0 15px 20px;
    text-align: left;
    background: #fff;
    font-size: 15px;
    border-bottom: solid 1px #d0d4d7;
    position: relative;
}
.title p {
    position: absolute;
    right: 20px;
    top: 10px;
    border: 0;
}
.mobileView {
	display: none;	
}
.title span {
	margin: 0 3px 0 8px;
}
.contentTable dl {
	clear: both;
    overflow: hidden;
    padding: 10px 20px;
    border-bottom: 1px solid #e1e1e1;
}
.contentTable dl dt {
	float: left;
    margin-right: 20px;
    text-align: center;
}
.contentTable dl dd {
    float: left;
    width: 80%;
    overflow: hidden;
}
.content {
	clear: both;
    overflow: hidden;
    padding: 20px 16px;
    border-bottom: 1px solid #e1e1e1;
    white-space: pre-line;
    min-height: 300px;
}
.fileDown {
	overflow: hidden;
    border-top: 1px solid #ddd;
    margin-top: 20px;
	padding: 5px 0;
    font-size: 14px;
    border-bottom: 1px solid #e2e2e2;
    background-color: #f7f7f7;
}
.fileDown dl {
	border-bottom: 0;
}
.fileDown p {
	white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    padding-top: 10px;
}
.fileDown p:first-child {
	padding-top: 0;
}



.contentTable table {
	table-layout:fixed
}
.contentTable th {
	border-bottom: 1px solid #e1e1e1;
	border-right: 1px solid #e1e1e1;
	background-color: #e9e9e9;
}
.contentTable tr:last-child {
	height: 40px;
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
/* 	text-align: center; */
	margin-top: 50px;
}
#commentContent{
	width: 100%;
	height: 100px;
} 
div.comment {
	padding: 15px 0;
	overflow: hidden;
	border-bottom: 1px dotted black;
}
.commentList ul {
	overflow: hidden;
	display:inline-block;
}
.commentList ul li {
	float: left;
}
.btn {
	float: right;
	display: block;
}
.commentContent {
	font-size: 14px;
	line-height: 18px;
	text-align: left;
	padding: 10px 0;
	white-space: pre-line;
	text-overflow: ellipsis;
    overflow: hidden;
    word-wrap: break-word;
}
.commentArea > div.commTableWrap {
	margin: 10px 0;
	overflow: hidden;
}
div.commTableWrap input {
	float: right;
}
#showComment {
    overflow: hidden;  
    padding: 15px 15px 0;
    border-top: 2px solid #444547;
    background: #f7f7f8;
}
.commentInfo {
	overflow: hidden;
}
.commentInfo ul, img {
	float: left;
}
.commentBtn {
	overflow: hidden;
}
.commentBtn ul {
	float: right;
}



textarea {
	box-sizing: border-box;
}


@media (max-width: 1024px) {
	div.subContent {
		width: 100%;
	}
}
@media (max-width: 560px) {
	div.subContent {
		padding-left: 3%;
		padding-right: 3%;
	}
	.contentTable dl dd {
	    width: 60%;
	}
	.title > p {
		display: none;
	}
	.mobileView {
		display: block;
		text-align: right;
	    padding: 10px 20px;
	    border-bottom: 1px solid #e1e1e1;
	}
	.btnConfirm li {
 		width: 23%;
	    display: initial;
 	}
}

</style>
</head>
<body>
<div class="contentTable">
	<h1 class="title">
		${article.title}
		<p>
			<span>작성일</span>${article.writeDate}
			<span>조회</span>${article.hit}
		</p>
	</h1>
	<p class="mobileView">
		<span>작성일</span>${article.writeDate}
		<span>조회</span>${article.hit}
	</p>
	<dl>
		<dt>작성자</dt>
		<c:if test="${article.id == '' }">
			<dd>Guest</dd>
		</c:if>
		<c:if test="${artidle.id != '' }">
			<dd>${article.id}</dd>
		</c:if>
	</dl>
	<div class="content">
		<p>${article.content}</p>
	</div>
	<div class="fileDown">
		<dl>
			<dt>다운로드</dt>
			<c:if test="${article.fileStatus !=0}">
				<c:if test="${fileList!=null}">
					<dd>
						<c:forEach var="file" items="${fileList}">
							<p>
								<a href="/project/community/download?fileNum=${file.fileNum}&storedFname=${file.storedFname}">${file.storedFname.substring(file.storedFname.indexOf("_")+1)}</a>
							</p>
						</c:forEach>
					</dd>
				</c:if> 
			</c:if>
		</dl>
	</div>
	<div class="btnArea">
		<form action="reply" method="get">
		<input type="hidden" name="boardNum" value="${boardNum}">
		<input type="hidden" name="pageNum" value="${pageNum}">
		<input type="hidden" name="depth" value="${article.depth}">
    	<input type="hidden" name="pos" value="${article.pos}">
   	 	<input type="hidden" name="groupId" value="${article.groupId}">
   	 	<input type="hidden" name="fileNum" value="${file.fileNum}">
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
							<li><input type="button" value="수정하기" disabled="disabled" style="cursor:default"></li>
							<li><input type="submit" value="답글달기" ></li>
						</c:if>
						<c:if test="${!isAdmin }">
							<li><input type="button" value="삭제하기" disabled="disabled" style="cursor:default"></li>
							<li><input type="button" value="수정하기" disabled="disabled" style="cursor:default"></li>
							<li><input type="submit" value="답글달기" ></li>
						</c:if>
					</c:otherwise>
				</c:choose>
			</ul>
  		</c:if>
		<c:if test="${id ==null}">
			<ul class="btnConfirm">
				<li><input type="button" value="목록으로" onclick="document.location.href='list?boardNum=${boardNum}&pageNum=${pageNum}'"></li>
				<li><input type="button" value="삭제하기" disabled="disabled" style="cursor:default"></li>
				<li><input type="button" value="수정하기" disabled="disabled" style="cursor:default"></li>
				<li><input type="submit" value="답글달기"disabled="disabled" style="cursor:default"></li>
			</ul>
		</c:if>
	</form>
	</div>
	<!-- 코멘트 -->
	<div class="commentArea">
		<p>전체 코멘트: <span id="commentCount" style='color: blue'>(${article.commentCount})</span></p>
		<!-- 코멘트 쓰기 영역 -->
		<div class="commTableWrap">
			<table class="commentTable">
				<tr>
					<td><textarea id="commentContent" name="commentContent"></textarea></td>
				</tr>
			</table>
			<c:if test="${id ==null}">
				<input type="button" value="comment 쓰기" disabled="disabled">
			</c:if>
			<c:if test="${id !=null}">
				<input type="button" value="comment 쓰기" id="commentWrite">
			</c:if>
		</div>
		<!-- 코멘트 리스트 -->
<%-- 		<input type="button" value="comment 읽기(${article.commentCount })" onclick="getComment(1,event)" id="commentRead"> --%>
<%-- 		<c:if test="${article.commentCount > 0 }">  --%>
			<div style="width: 100%; min-height: 100px; padding: 20px 0;">
				<div id="showComment" align="center"></div>
				<input type="hidden" id="commPageNum" value="1">
			</div>
<%-- 		</c:if> --%>
<%-- 		<c:if test="${article.commentCount == 0 }">  --%>
			<div style="width: 100%; min-height: 100px; padding: 20px 0;">
				<div id="noComment" align="center">등록된 댓글이 없습니다</div>
			</div>
<%-- 		</c:if> --%>
	</div> <!-- commentArea end -->
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
		$("#commentCount").text("("+data.length+")");	// 전체 코멘트 수 갱신
		if(data.length > 0) {		// 댓글이 있으면 #showComment 보이게 하기
			$("#showComment").parent().css("display", "");
			$("#noComment").parent().css("display", "none");
		} else {					// 댓글이 없으면 #noComment 보이게 하기
			$("#showComment").parent().css("display", "none");
			$("#noComment").parent().css("display", "");
		}
		
		let html = "<article class='commentList'>";
		let id = "${id}";
		$.each(data, function(index,item) {
			html +="<div class='comment' commentNum='"+item.commentNum
					+"' depth='"+item.depth
					+"' style='margin-left:"+ (20*item.depth) +"px'>";
			html +="<div class='commentInfo'>";
			if(item.depth > 0) { html += "<img src='/project/resources/img/icon_reply.png' style='margin-right: 5px;'>"; }
			html +="<ul>";
			html +="<li>작성자: "+item.id+"&nbsp;|&nbsp;</li>";
			html +="<li>작성일: "+item.commentDate+"</li>";
			html +="</ul></div>";
			html +="<p class='commentContent'>"+item.commentContent+"</p>";
			html +="<ul class='btn'>";
			html +="<li><a href='#' class='replyComment')'>답변</a>&nbsp;|&nbsp;</li>";
			if(id == item.id) {
				html +="<li><a href='#' class='updateComment'>수정</a>&nbsp;|&nbsp;</li>";
				html +="<li><a href='#' class='deleteComment')'>삭제</a></li>";
			} else {
				html +="<li><span style='color:#BDBDBD; cursor:default;'>수정</span>&nbsp;|&nbsp;</li>";
				html +="<li><span style='color:#BDBDBD; cursor:default;')'>삭제</span></li>";
			}
			html +="</ul></div>";
		});
		html +="</article>";
		commPageNum = parseInt(commPageNum);
		if("${article.commentCount}" > commPageNum * 10) {
			nextPageNum = commPageNum+1;
			html +="<br><input type='button' onclick='getComment(nextPageNum,event)' value='다음comment보기'><br>";
		}
		$("#showComment").html(html);
		$("#commentContent").val("");
// 		$("#commentContent").focus();
	}
	
	function getComment(commPageNum, event) {
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
// 				$(comment).children(".commTableWrap").remove();
// 				let newRow = comment.clone();
				if (data.result == 1) {
// 					$("#commentContent").val("");
// 					$(comment).append($(newRow));
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
	// 수정 ajax
	$("#showComment").on("click", ".updateBtn", function(event){
		let comment = $(this).parents(".comment");
		let commentNum = $(comment).attr("commentNum");
		let commentContent = $(comment).find(".inTextarea").val();
		$.ajax({
			url : "/project/updateComment",
			data: {
				commentNum: commentNum,
				commentContent : commentContent,
			},
			success: function(data){
				if(commentContent == ""){
					alert("내용을 입력하세요");
					return;
				}else {
					$(comment).children(".commentContent").text(commentContent);
					$(replyArea).remove();
				}
			}
		});
	});
	
	// 삭제 버튼 클릭 + ajax
	$("#showComment").on("click", ".deleteComment", function(event) {
		event.preventDefault();
		let comment = $(this).parents(".comment");
		let commentNum = $(comment).attr("commentNum");
// 		let commentContent = $(comment).children(".commentContent").text();
		let cf = confirm("정말로 지우시겠습니까?");
		if(cf == true){
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
		}else {
			return;
		}
	});
	
	
// 	function replyComment(event, parentNum, self){
// 		event.preventDefault();
// 		$.ajax({
// 			url : "/project/replyComment",
// 			data: {
// 				id : "${id}",
// 				commentContent : $("textarea[commentNum]'"+parentNum+"']").val(),
// 				boardNum : "${boardNum}",
// 				articleNum : "${article.articleNum}"
// 			},
// 			success: function(data){
// 				alert(commentContent);
// 			}
// 		}); 
// 		console.log(this);
// 	}
	
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 상세 보기</title>
<link href="<c:url value='/resources/bootstrap-3.3.7/css/bootstrap.min.css'/>" rel="stylesheet">
<style>
    #contentForm {
      width: 100%;
      margin: 0 auto;
      padding-top: 5%;
    }
 
    .table > thead > tr > th, .table > tbody > tr > th {
      background-color: #e6ecff;
      text-align: center;
    }
    .commentInfo ul li {
    	display:inline;    
    	padding:0 30px; 
    }
    
    .btnComment li { 
    	display:inline; /* 세로나열을 가로나열로 변경 */ 
    	border-left:1px solid #999; /* 각 메뉴의 왼쪽에 "|" 표시(분류 표시) */ 
    	font:bold 12px Dotum; /* 폰트 설정 - 12px의 돋움체 굵은 글씨로 표시 */ 
    	padding:0 5px; /* 각 메뉴 간격 */ 
    }
    .btnComment li:first-child {
    	border-left:none; /* 메뉴 분류중 제일 왼쪽의 "|"는 삭제 */
    }       
</style>
</head>
<body>
	<form action="reply" method="get">
		<div id="contentForm">	
			<input type="hidden" name="boardNum" value="${boardNum}">
			<input type="hidden" name="pageNum" value="${pageNum}">
			<input type="hidden" name="depth" value="${article.depth}">
    		<input type="hidden" name="pos" value="${article.pos}">
   	 		<input type="hidden" name="groupId" value="${article.groupId}">
				
			<div>
          <table class="table table-striped table-bordered">
          <thead>
            <tr>
              <th>작성자</th>
              <td>${article.id}</td>
              <th>조회수</th>
              <td>${article.hit}</td>
            </tr>
            <tr>
              <th>제목</th>
              <td>${article.title}</td>
              <th>날짜</th>
              <td>${article.writeDate}</td>
            </tr>
          </thead>
          <tbody>
            <tr height="200" valign="top">
              <td colspan="4">${article.content}</td>
            </tr>
          </tbody>
        </table>
         
          <div id="btns" class="btn-group btn-group-sm" role="group" aria-label="...">
          <c:if test="${id != null}">
          		<input type="button" value="목록으로" class="btn btn-default" onclick="document.location.href='list?boardNum=${boardNum}&pageNum=${pageNum}'">
		        <c:choose>   
		            <c:when test="${id == article.id}">
		            	<input type="button" value="삭제하기" class="btn btn-default" onclick="document.location.href='delete?boardNum=${boardNum}&articleNum=${article.articleNum}&pageNum=${pageNum}&fileStatus=${article.fileStatus}'">
						<input type="button" value="수정하기" class="btn btn-default" onclick="document.location.href='update?boardNum=${boardNum}&articleNum=${article.articleNum}&pageNum=${pageNum}&fileStatus=${article.fileStatus}'">
						<input type="submit" value="답글달기" class="btn btn-default">
		            </c:when>
		            <c:otherwise>
			            <c:if test="${isAdmin }">
							<input type="button" class="btn btn-default" value="삭제하기" onclick="document.location.href='delete?boardNum=${boardNum}&articleNum=${article.articleNum}&pageNum=${pageNum}&fileStatus=${article.fileStatus}'">
							<input type="button" class="btn btn-default" value="수정하기" disabled="disabled">
							<input type="submit" class="btn btn-default" value="답글달기" >
						</c:if>
						<c:if test="${!isAdmin }">
							<input type="button" class="btn btn-default" value="삭제하기" disabled="disabled">
							<input type="button" class="btn btn-default" value="수정하기" disabled="disabled">
							<input type="submit" class="btn btn-default" value="답글달기" >
						</c:if>
					</c:otherwise>
				</c:choose>
          </c:if>
          <c:if test="${id == null}">
	            <input type="submit" class="btn btn-default" value="답글달기" disabled="disabled">
	            <input type="button" class="btn btn-default" value="수정하기" disabled="disabled">
	            <input type="button" class="btn btn-default" value="삭제하기" disabled="disabled">
	          	<input type="button" class="btn btn-default" value="목록으로" onclick="document.location.href='list?boardNum=${boardNum}&pageNum=${pageNum}'">
          </c:if>
        </div>
        <table id="commentTable" class="table table-condensed"></table>
        <div class="input-group" role="group" aria-label="..." style="margin-top: 10px; width: 100%;">
		    <p>전체 코멘트: <span style="color: blue">(${article.commentCount})</span></p>
		    <textarea class="form-control" rows="3" id="commentContent" placeholder="댓글을 입력하세요." style="width: 100%;" ></textarea>
		    <div class="btn-group btn-group-sm" role="group" aria-label="...">
		        <c:if test="${id == null}">
		            <input type="button" class="btn btn-default" value="댓글 쓰기" disabled="disabled">
		        </c:if>
		        <c:if test="${id != null}">
		            <input type="button" class="btn btn-default" value="댓글 쓰기" id="commentWrite">
		        </c:if>
		    </div>
		</div>
		 
		<!-- Comment 태그 추가 -->
		<div class="input-group" role="group" aria-label="..." style="margin-top: 10px; width: 100%;">
<!-- 		    <div id="showComment" style="text-align: center;"></div> -->
			<div id="showComment"></div>
		</div>


        </div>
		</div>
	</form>
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
			html +="<li>"+item.commentContent+"</li>";
			html +="<li>"+item.commentDate+"</li>";
// 			html +="<li>"+item.articleNum+"</li>";
			html +="</ul></div>";	
// 			html +="<p>"+item.commentContent+"</p>";
			html +="<ul class='btnComment'>";
			html +="<li class='btnReComment'><a href='#' onclick='openReplyArea(event,"+item.commentNum+", this)'>답변</a></li>";
			html +="<li><a href='#' onclick=''>수정</a></li>";
			html +="<li><a href='#' onclick='deleteComment(event,"+item.commentNum+", this)'>삭제</a></li>";
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
			onclick: "replyComment(event,"+item.commentNum+", this)"
		});
	}
	
	function replyComment(event, parentNum, self){
		event.preventDefault();
		$.ajax({
			url : "/project/replyComment",
			data : {
				id : "${id}",
				commentContent : $("textarea[commentNum]'"+parentNum+"']").val(),
				boardNum : "${boardNum}",
				articleNum : "${article.articleNum}"
			},
			success : function(data){
				alert(commentContent);
			}
		}); 
		console.log(this);
	}

	function updateComment(event){
		event.preventDefault();
		$.ajax({
			url : "/project/updateComment",
			data : {
				
			},
			success : {
				
			}
		});
	}
	
	function deleteComment(event, self){
		event.preventDefault();
		console.log('삭제버튼 클릭');
		console.log(self);
		$.ajax({
			url : "/project/deleteComment",
			data : {
				articleNum : "${article.articleNum}",
				boardNum : "${boardNum}",
				commentNum : self
			},
			success : function(data){
				showHtml(data, 1);
			}
		});
	}
	
</script>
</html>
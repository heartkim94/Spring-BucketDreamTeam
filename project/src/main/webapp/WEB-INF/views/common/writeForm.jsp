<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>글 쓰기</title>

</head>
<body>
<div>
	<form action="${action}" method="post">
		<!-- 글쓰기 영역 전체 감쌈 -->
		<div class="writeFormWrap"> 
			<input type="hidden" name="boardNum" value="${boardNum}">
			<c:if test="${action eq 'update'}">
				<input type="hidden" name="articleNum" value="${articleNum}">
				<input type="hidden" name="fileStatus" value="${fileStatus }">
				<input type="hidden" name="fileCount" value="${fileCount }">
			</c:if>
			<c:if test="${action eq 'reply'}">
				<input type="hidden" name="groupId" value="${groupId}">
				<input type="hidden" name="pos" value="${pos}">
				<input type="hidden" name="depth" value="${depth}">
			</c:if>
			<input type="hidden" name="pageNum" value="${pageNum}">
			<input type="hidden" name="id" value="${id}" /> <!-- 작성자 id -->
			<table>
				<tr>
					<th><label for="title">제목</label></th>
					<td align="left"><input type="text" name="title" id="title" value="${title}"/></td>
				</tr>
				<tr>
					<th>작성자</th>
					<c:if test="${id != null}">
						<td align="left">${id}</td> <!-- 작성자 id -->
					</c:if>
					<c:if test="${id == null}">
						<td align="left">Guest</td> <!-- 게스트 id -->
					</c:if>
				</tr>
				<tr>
					<th><label for="content">내용</label></th>
					<td align="left"><textarea id="content" style="resize: none;" name="content">${content}</textarea></td>
				</tr>
				<!-- 파일첨부영역 -->
				<!-- faq 글쓰기 할 때는 필요없음 -->
				<c:if test="${boardNum!=3}">
					<tr>
					 	<th style="vertical-align: top;">
					 		파일 첨부
<!-- 							 		<a href="#" title="파일 첨부 열기" class="openFList">▼</a> -->
					 	</th>
						<td>  
							<div class="uploadListWrap">
								<div class="upListHead">
									업로드 파일명 
								</div>
								<div class="fileDrop" placeholder="여기에 파일을 드래그하세요."></div>
							</div>
							<input type="button" class="allDelete" value="모두 삭제">
						</td>
					</tr>
<!-- 					<tr> -->
<!-- 						<th style="vertical-align: top;"> -->
<!-- 					 		파일 첨부 -->
<!-- <!-- 							 		<a href="#" title="파일 첨부 열기" class="openFList">▼</a> --> 
<!-- 					 	</th> -->
<!-- 					 	<td> -->
<!-- 					 		<input type="file"  name="fname" multiple="multiple" /> -->
<!-- 					 	</td> -->
<!-- 					</tr> -->
				</c:if> 
				<!-- 글 수정시 등장 -->
				<c:if test="${action eq 'update'}">
					<tr>
						<td>첨부된화일 :</td>
						<td>
							<c:if test="${fileList!=null}">
								<ul id="delGroup">
									<c:forEach var="file" items="${fileList}">
										<li>${file.storedFname.substring(file.storedFname.indexOf("_")+1)}<!-- 화면에 보이는 originFname임 -->
											<input type="button" deleteFileName="${file.storedFname}" value="삭제"
											class="delFile">
										</li>
									</c:forEach>
								</ul>
							</c:if>
						</td>
					</tr>
				</c:if>
			</table>
		</div>
		<!-- 글 작성 버튼 영역 -->
		<div class="btnConfirm">
			<button class="submitBtn">
					<b>작성완료</b>
			</button>
<!-- 			<input type="submit" value="작성 완료" class="submitBtn" /> -->
			<a href="list?boardNum=${boardNum}&pageNum=1" class="cancelBtn">취소</a><!-- 클릭시 리스트 페이지로 이동 -->
		</div>
	</form>
</div>
<script src="/project/resources/js/uploadAjax.js"></script> 
<!-- 글 수정 시 기존에 업로드 된 파일 삭제 여부 기능 -->
<script>
	// 기존의 파일을 삭제할 때 
	$(document).ready(function() {
		//		id 값으로 읽어 올려면 하나만 선택되어짐..클래스 사용
		$(".delFile").on("click", function() {
			alert($(this)
					.attr("deleteFileName"));
			// 		storedFname이 원래 있던 속성이 아니므로 아래처럼 하면 못읽어옴
			// 		var storedFname=$(this).prop("deleteFileName");			
			var storedFname = $(this).attr(
					"deleteFileName");
			$(this).parent().remove();
			let deleteFileName = "<input type='hidden' name='deleteFileName' value='"+storedFname+"'>";
			$(deleteFileName).appendTo("form");
		});
	});
</script>
 
</body>
</html>
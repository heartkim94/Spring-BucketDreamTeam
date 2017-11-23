<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>새글등록</title>
<style>


.writeFormWrap {
	width: 100%;
}
.writeFormWrap table {
	width: 100%;
	border-collapse: collapse;
	border-spacing: 0;
}
.writeFormWrap th, td {
	background-color: transparent;
	padding: 5px 10px;
	box-sizing: border-box;
}
.writeFormWrap th {
	width: 120px;
    padding: 7px 13px;
    border: 1px solid #e9e9e9;
    border-left: 0;
    background: #f5f8f9;
    text-align: left;
}
.writeFormWrap td {
	padding: 7px 10px;
    border-top: 1px solid #e9e9e9;
    border-bottom: 1px solid #e9e9e9;
    background: transparent;
}
input, textarea {
	border: 1px solid #e4eaec;
    background: #f7f7f7;
    color: #000;
    vertical-align: middle;
    line-height: 2em;
}
textarea {
	width: 100%;
	height: 300px;
}
.btnConfirm {
	margin: 20px 0;
	text-align: center;
}
input.submitBtn {
	padding: 8px;
    border: 0;
    background: orange;
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
.uploadListWrap {
	display: none;
	margin-top: 10px;
	width: 100%;
	height: auto;
	background-color: #fff;
	border: 1px solid #bfbfbf;
	box-sizing: border-box;
}
.upListHead {
	width: 100%;
	height: 20px;
	border-bottom: 1px solid #bfbfbf;
}
.upListView {
	width: 100%;
	height: 90px;
}
</style>
</head>
<body>
<div id="wrapper">

	<jsp:include page="header.jsp"/>
	<section>
		<jsp:include page="aside.jsp"/>
		<div class="subContent">
			<nav>
				<h1>NOTICE</h1>
				<span>home > community > notice</span>
			</nav>
			<div>
				<form action="write.do" method="post">
					<!-- 글쓰기 영역 전체 감쌈 -->
					<div class="writeFormWrap"> 
		<!-- 			<input type="hidden" name="id" value="#" /> 작성자 id -->
						<table>
							<tr>
								<th><label for="title">제목</label></th>
								<td align="left"><input type="text" name="title" id="title"/></td>
							</tr>
							<tr>
								<th>작성자</th>
								<td align="left">${user.name }</td>
							</tr>
							<tr>
								<th><label for="content">내용</label></th>
								<td align="left"><textarea id="content" style="resize: none;" name="content" cols="40" rows="10"></textarea></td>
							</tr>
							<tr>
							 	<th style="vertical-align: top;">
							 		파일 첨부
							 		<a href="#" title="파일 첨부 열기" class="openFList">▼</a>
							 	</th>
								<td>
									<div class="fForm">
										<a href="#" class="fileUpBtn" >파일열기</a>
										<input type="file" style="display: none;" />
									</div>
									<div class="uploadListWrap">
										<div class="upListHead"></div>
										<div class="upListView"></div>
									</div>
								</td>
							</tr>
						</table>
					</div>
					<!-- 글 작성 버튼 영역 -->
					<div class="btnConfirm">
						<input type="submit" value="작성 완료" class="submitBtn" />
						<a href="/project/notice.do" class="cancelBtn">취소</a><!-- 클릭시 리스트 페이지로 이동 -->
					</div>
				</form>
			</div>
		</div>
	</section>
	<jsp:include page="footer.jsp"/>

</div> <!-- wrapper End -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	$(function(){
		$(".openFList").on("click", function(e){
			e.preventDefault();
			$(".uploadListWrap").toggle();
			if($(".uploadListWrap").css('display') == 'block'){
				$(".openFList").text('▲');
			}else {
				$(".openFList").text('▼');
			}
		});
		
		$(".fileUpBtn").on("click", function(e){
			e.preventDefault();
			$("input[type=file]").click();
		});
	});
</script>
 
</body>
</html>
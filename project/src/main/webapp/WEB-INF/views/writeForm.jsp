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
	display: block;
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
.fileDrop:before {
	content: attr(placeholder);
}
.fileDrop {
	width: 100%;
	min-height: 90px;
	height: auto;
}
.allDelete {
	cursor: pointer;
	padding: 8px;
    border: 0;
    background: #E83F38;
    font-size: 14px;
    color: #fff;
    letter-spacing: -0.1em;
}
.human {
	cursor: pointer;
	color: red;
}
</style>
</head>
<body>
<div id="wrapper">

	<%@ include file="header.jsp" %>
	<section>
<%-- 		<%@ include file="aside.jsp" %> --%>
		<div class="subContent">
			<nav>
				<h1>NOTICE</h1>
				<span>home > community > notice</span>
			</nav>
			<div>
				<form action="write.do" method="post">
					<!-- 글쓰기 영역 전체 감쌈 -->
					<div class="writeFormWrap"> 
						<input type="hidden" name="boardNum" value="${boardNum}">
						<input type="hidden" name="id" value="${id}" /> <!-- 작성자 id -->
						<table>
							<tr>
								<th><label for="title">제목</label></th>
								<td align="left"><input type="text" name="title" id="title"/></td>
							</tr>
							<tr>
								<th>작성자</th>
								<td align="left">${id}</td>
							</tr>
							<tr>
								<th><label for="content">내용</label></th>
								<td align="left"><textarea id="content" style="resize: none;" name="content" cols="40" rows="10"></textarea></td>
							</tr>
							<!-- 파일첨부영역 -->
							<!-- faq 글쓰기 할 때는 필요없음 -->
							<c:if test="${boardNum == 1 || boardNum == 2 }">
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
											<div class="fileDrop" placeholder="여기에 파일을 드래그하세요.">
												
											</div>
										</div>
										<input type="button" class="allDelete" value="모두 삭제">
									</td>
								</tr>
							</c:if>
						</table>
					</div>
					<!-- 글 작성 버튼 영역 -->
					<div class="btnConfirm">
						<input type="submit" value="작성 완료" class="submitBtn" />
						<a href="list.do?boardNum=${boardNum}&pageNum=1" class="cancelBtn">취소</a><!-- 클릭시 리스트 페이지로 이동 -->
					</div>
				</form>
			</div>
		</div>
	</section>
	<%@ include file="footer.jsp" %>

</div> <!-- wrapper End -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	$(function(){
		/* 화살표 누름 동작 */
// 		$(".openFList").on("click", function(e){
// 			e.preventDefault();
// 			$(".uploadListWrap").toggle();
// 			if($(".uploadListWrap").css('display') == 'block'){
// 				$(".openFList").text('▲');
// 			}else {
// 				$(".openFList").text('▼');
// 			}
// 		});
		
		$(".fileDrop").on("dragenter dragover", function(e){
			e.preventDefault();
		});
		$(".fileDrop").on("drop", function(e){
			e.preventDefault();
			
			$(".fileDrop").removeAttr("placeholder");
			
			let files = e.originalEvent.dataTransfer.files;
			let formData = new FormData();
			$.each(files,function(index,item){
				formData.append("multiFile", item);
			});	
			$.ajax({
				  url: '/project/uploadAjax.do',
				  data: formData,
//					  복수개를 업로드시 
				  dataType:'json',		  
				  processData: false,
				  contentType: false,
				  type: 'POST',
				  success: function(data){
					  var str ="";				 
// 					  alert(data);				  
					  $.each(data,function(index, fileName){					  					 
						  if(checkImageType(fileName)){						 
							  str ="<div><img src='/project/displayFile.do?fileName="+fileName+"'/>"	
								  +"<small class='human' data-src='"+fileName+"'>&nbsp;삭제</small>"
//			 				 이미지 파일일 경우에는 이름에 s_ 가 포함되어있으므로 테이블에 바로 입력하면
//			 				 다운로드시 썸네일 파일을 다운로드 받게됨...이름에 s_ 제거하고 테이블에 입력
								  +"<input type='hidden' name='fileNames' value='"+getImageLink(fileName)+"'></div>";
						  }else{
						 	  str ="<div>"+ getOriginFname(fileName)
							  +"<small class='human' data-src='"+fileName+"'>&nbsp;삭제</small>"
							  +"<input type='hidden' name='fileNames' value='"+fileName+"'></div>";
						  }
						  $(".fileDrop").append(str);
					  });				 
				  },
				  error : function(xhr){
						alert("error html = " + xhr.statusText);
				  }			  
				});	//$.ajax END
				
			$(".fileDrop").on("click", "small", function(event){			
				let that = $(this);
				$.ajax({
					   url:"/project/deleteFile.do",
					   type:"post",
					   data: {
						   fileName:$(this).attr("data-src")
					   },
					   dataType:"text",		 
					   success:function(result){
						   if(result == 'deleted'){				   
							   that.parent("div").remove();
// 							   alert("삭제성공");
						   }
					   }
				});
			});
			//글쓰기 취소시에 업로드 되어있는 파일 삭제
			$(".cancelBtn").on("click", function(){	 
				allDeleteFiles();	
			});
			// 모두 삭제 버튼 클릭시 업로드 되어있는 파일 삭제
			$(".allDelete").on("click", function(){			
				allDeleteFiles();
			});

			function allDeleteFiles(){
				let files=[];
				$.each($(".human"),function(index,item){
//						files[index]=$(this).attr("data-src");
					files.push($(this).attr("data-src"));						
				});	
//				배열을 직렬화해서 전송함 
				jQuery.ajaxSettings.traditional = true;
				$.ajax({
					   url:"/project/deleteAllFiles.do",
					   type:"post",
					   data: {files: files},
					   dataType:"text",		  
					   success:function(result){
						   if(result == 'deleted'){
							   $(".fileDrop").children().remove();
// 							   alert("삭제성공");
						   }
					   }
				});
			}

			function checkImageType(fileName){	
//					/i는 대소문자 구분 하지 말라는 뜻임
				var pattern = /.jpg|.gif|.png/i;		
				return fileName.match(pattern);		
			}

			function getImageLink(fileName){
				if(!checkImageType(fileName)){
					return;
				}	
				var front = fileName.substr(0,12);
				var end = fileName.substr(14);			
				return front + end;	
			}

			function getOriginFname(fileName){
				if(checkImageType(fileName)){
					return;
				}
				
				var idx = fileName.indexOf("_") + 1 ;
				return fileName.substr(idx);	
			}
		}); // $(".fileDrop") END
	});
</script>
 
</body>
</html>
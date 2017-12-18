$(function(){
		$("form").on("submit", function(event) {
			event.stopPropagation();
			event.preventDefault();
			
			if($("[name=title]").val() == "") {
				alert("제목을 입력해주세요.");
				fr.title.focus();
				return false;
			}else if($("[name=content]").val().length==0) {
				alert("내용을 입력해주세요.");
				fr.content.focus();
				return false;
			}
			
			let files = [];
			$.each($("[name=storedFname]"), function(index, item) {
				let file = {
						storedFname: $(item).val(),
						fileLength: $(item).next("[name=fileLength]").val()
				}
				files.push(file);
			});
			let data = {
				boardNum: $("[name=boardNum]").val(),
				title: $("[name=title]").val(),
				articleNum: $("[name=articleNum]").val(),
				fileStatus: $("[name=fileStatus]").val(),
				fileCount: $("[name=fileCount]").val(),
				groupId: $("[name=groupId]").val(),
				pos: $("[name=pos]").val(),
				depth: $("[name=depth]").val(),
				pageNum: $("[name=pageNum]").val(),
				id: $("[name=id]").val(),
				title: $("[name=title]").val(),
				content: $("[name=content]").val(),
				files: files
			};
			
			$.ajax({
				url: $(this).attr("action"),
				type: "POST",
				contentType: "application/json",
				data: JSON.stringify(data),
				success: function(data) {
					console.log(data);
					console.log(location);
					let colon = data.indexOf(":");
					let link = data.slice(colon+1);
					console.log(link);
					location.href = "./"+link;
				},
				error: function(xhr) {
					alert("error html = "+xhr.statusText);
				}
			})
			
		});
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
				  url: '/project/uploadAjax',
				  data: formData,
//					  복수개를 업로드시 
				  dataType:'json',
				  processData: false,
				  contentType: false,
				  type: 'POST',
				  success: function(data) {
					  var str ="";
					  $.each(data, function(index, fileName) {
						  
						  if(checkImageType(fileName)) {
							  str ="<div><img src='/project/displayFile?fileName="+fileName+"'/>"
								  +"<small class='human' data-src='"+fileName+"'>&nbsp;삭제</small>"
//			 				 이미지 파일일 경우에는 이름에 s_ 가 포함되어있으므로 테이블에 바로 입력하면
//			 				 다운로드시 썸네일 파일을 다운로드 받게됨...이름에 s_ 제거하고 테이블에 입력
								  +"<input type='hidden' name='fileNames' value='"+getImageLink(fileName)+"'>"//</div>"
							  	  +"<input type='hidden' name='storedFname' value='"+getImageLink(fileName)+"'>"
							  	  +"<input type='hidden' name='fileLength' value='"+files[index].size+"'></div>"
						  } else {
						 	  str ="<div>"+ getOriginFname(fileName)
							  +"<small class='human' data-src='"+fileName+"'>&nbsp;삭제</small>"
							  +"<input type='hidden' name='fileNames' value='"+fileName+"'></div>";
						  }
						  $(".fileDrop").append(str);
					  });
				  },
				  error : function(xhr) {
						alert("error html = " + xhr.statusText);
				  }
				});	//$.ajax END
				
			$(".fileDrop").on("click", "small", function(event) {
				let that = $(this);
				$.ajax({
					   url:"/project/deleteFile",
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
					   url:"/project/deleteAllFiles",
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
				var pattern = /.jpg|.jpeg|.gif|.png/i;		
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
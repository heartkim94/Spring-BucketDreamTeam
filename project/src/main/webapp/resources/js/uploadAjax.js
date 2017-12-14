$(function(){
		
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
				alert(formData);
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
					  alert(data);
					  $.each(data, function(index, fileName) {
						  if(checkImageType(fileName)) {
							  str ="<div><img src='/project/displayFile?fileName="+fileName+"'/>"
								  +"<small class='human' data-src='"+fileName+"'>&nbsp;삭제</small>"
//			 				 이미지 파일일 경우에는 이름에 s_ 가 포함되어있으므로 테이블에 바로 입력하면
//			 				 다운로드시 썸네일 파일을 다운로드 받게됨...이름에 s_ 제거하고 테이블에 입력
								  +"<input type='hidden' name='fileNames' value='"+getImageLink(fileName)+"'></div>";
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
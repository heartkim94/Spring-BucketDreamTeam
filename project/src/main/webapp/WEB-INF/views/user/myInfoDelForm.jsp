<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	  <script src="//code.jquery.com/jquery-3.1.0.min.js"></script>
	  <title>회원탈퇴 페이지</title>
	  <!--부트스트랩-->
	  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
      <!-- 합쳐지고 최소화된 최신 CSS -->
	  <link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	  <link rel="stylesheet" href="./resources/css/submit.css">
	  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
      <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.css" rel="stylesheet">
	  <script>
		$(function(){
			$('#passCheckBtn').on("click", function sendit(event){
				event.preventDefault();
				event.stopPropagation();
				var returnVar = false;
				$.ajax({
					type:"POST",
					url:"/project/delPassCheck",
					data:{
						inputPass:$("#pass").val()
					},
					async:true,
					//dataType:"html",
					success:function(data) {
						if($("#pass").val()!="") {
							if(data==1) {
// 								alert('비밀번호를 잘못입력하셨습니다.');
								swal ( "확인" ,  "비밀번호를 잘못입력하셨습니다." ,  "error" )
								returnVar = false;
							}else if(data==2) {
								$("#passCheck").submit();
 								alert('회원탈퇴가 완료되었습니다');
								returnVar = true;
							}
						}else {
// 							alert('비밀번호를 입력해주십시오.');
							swal ( "확인" ,  "비밀번호를 입력해주십시오." ,  "error" )
							returnVar = false;
						}
					}
				});
				return returnVar;
			});
		});
		
	  </script>
    </head>
    <body>
<%--     	<%@ include file="../common/header.jsp" %> --%>
        <div class="container"><!-- 좌우측의 공간 확보 -->
 		<!-- 본문 들어가는 부분 -->
        <form class="form-horizontal" id="passCheck" role="form" method="post" action="/project/myInfoDel">
            <div align="center"><h1>회원 탈퇴</h1></div><br>
            
            <div class="" id="divPassword">
<!--                 <label for="password" class="col-lg-2 control-label">패스워드</label> -->
                <div >
                    <input type="password" class="form-control" id="pass" name="pass" data-rule-required="true" placeholder="패스워드" maxlength="30">
                </div> 
            </div><br><br>
             
            <div class="wrap">
  				<button class="button" id="passCheckBtn"><b>확인</b></button>
  				<a href="/project/home" class="button"><b>취소</b></a>
  				<a href="javascript:history.back()" class="button"><b>이전으로</b></a>
			</div><br><br>
        </form>
        <!--// 본문 들어가는 부분 -->
        </div>
<%--         <%@ include file="../common/footer.jsp" %> --%>
    </body>
    <style> 
    	.form-horizontal {
    		width: 1024px;
    		margin: 0 auto;
    	}
    	.form-horizontal .control-label {
    		text-align: left;
    	}
    	.container {
    		padding: 50px 0 30px 0;
    	}
    	@media (max-width: 1024px) {
    		.form-horizontal {
	    		width: 100%;
	    		margin: 0 auto;
	    	}
    	} 
    </style>
</html>
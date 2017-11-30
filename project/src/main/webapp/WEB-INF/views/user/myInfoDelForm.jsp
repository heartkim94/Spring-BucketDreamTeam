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
	  
	  <script>
		$(function(){
			$('#passCheckBtn').on("click", function sendit(event){
				event.preventDefault();
				event.stopPropagation();
				var returnVar = false;
				$.ajax({
					type:"POST",
					url:"/project/delPassCheck.do",
					data:{
						inputPass:$("#pass").val()
					},
					async:true,
					//dataType:"html",
					success:function(data) {
						if($("#pass").val()!="") {
							if(data==1) {
								alert('비밀번호를 잘못입력하셨습니다.');
								returnVar = false;
							}else if(data==2) {
								$("#passCheck").submit();
								alert('회원탈퇴가 완료되었습니다');
								returnVar = true;
							}
						}else {
							alert('비밀번호를 입력해주십시오.');
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
        <div class="container"><!-- 좌우측의 공간 확보 -->
			<%@ include file="../common/header.jsp" %>
            <!-- 모달창 -->
            <div class="modal fade" id="defaultModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">알림</h4>
                        </div>
                        <div class="modal-body">
                            <p class="modal-contents"></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
            <!--// 모달창 -->
                <!-- 본문 들어가는 부분 -->
                 
 
 
        <form class="form-horizontal" id="passCheck" role="form" method="post" action="/project/myInfoDel.do">
            <div align="center"><h1>회원 탈퇴</h1></div><br>
            
            <div class="form-group" id="divPassword">
                <label for="pass" class="col-lg-2 control-label">패스워드</label>
                <div class="col-lg-5">
                    <input type="password" class="form-control" id="pass" name="pass" data-rule-required="true" placeholder="패스워드" maxlength="30">
                </div>
            </div>
             
            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10">
                	<button id="passCheckBtn" class="btn btn-default" >회원탈퇴</button>
                </div>
            </div>
        </form>
         
        <script>
            $(function(){
                //모달을 전역변수로 선언
                var modalContents = $(".modal-contents");
                var modal = $("#defaultModal");
                 
                //------- 검사하여 상태를 class에 적용
                $('#pass').keyup(function(event){
                    
                    var divPassword = $('#divPassword');
                     
                    if($('#pass').val()==""){
                        divPassword.removeClass("has-success");
                        divPassword.addClass("has-error");
                    }else{
                        divPassword.removeClass("has-error");
                        divPassword.addClass("has-success");
                    }
                });
                 
                //------- validation 검사
                $("form").submit(function(event) {
                    var divPassword = $('#divPassword');
   
                    //패스워드 검사
                    if($('#pass').val()==""){
                        modalContents.text("패스워드를 입력하여 주시기 바랍니다.");
                        modal.modal('show');
                         
                        divPassword.removeClass("has-success");
                        divPassword.addClass("has-error");
                        $('#pass').focus();
                        return false;
                    }else{
                        divPassword.removeClass("has-error");
                        divPassword.addClass("has-success");
                    }
                });
            });
             
        </script>
                <!--// 본문 들어가는 부분 -->
            <hr/>
            <%@ include file="../common/footer.jsp" %>
        </div>
    </body>
</html>
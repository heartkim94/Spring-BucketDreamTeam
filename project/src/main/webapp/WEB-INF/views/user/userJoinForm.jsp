<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!--  <script src="//code.jquery.com/jquery-3.1.0.min.js"></script> -->
	  <!-- 합쳐지고 최소화된 최신 CSS -->
	  <link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	  <title>회원가입</title>
	  <link rel="stylesheet" href="./resources/css/submit.css">
	  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
      <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.css" rel="stylesheet">
    </head>
    <body>
    	<%@ include file="../common/header.jsp" %>
        <div class="container"><!-- 좌우측의 공간 확보 -->
		<!-- 부트스트랩 (header.jsp 위로두면 안먹음)-->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
       
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
        <form class="form-horizontal" role="form" method="post" action="/project/userInsert" onsubmit="return availability()">
          	<div align="center"><h1>회원 가입</h1></div><br>
          
            <div class="form-group" id="divId">
                <label for="id" class="col-lg-2 control-label">아이디</label>
                <div class="col-lg-5">
                    <input type="text" class="form-control onlyAlphabetAndNumber" id="id" name="id" data-rule-required="true" placeholder="알파벳, 언더스코어(_), 숫자만 입력 가능합니다." maxlength="30">
                </div>
                <div id="idcheck"></div>
            </div>
            <div class="form-group" id="divPassword">
                <label for="pass" class="col-lg-2 control-label">패스워드</label>
                <div class="col-lg-5">
                    <input type="password" class="form-control" id="pass" name="pass" data-rule-required="true" placeholder="패스워드" maxlength="30">
                </div>
            </div>
            <div class="form-group" id="divPasswordCheck">
                <label for="passCheck" class="col-lg-2 control-label">패스워드 확인</label>
                <div class="col-lg-5">
                    <input type="password" class="form-control" id="passCheck" data-rule-required="true" placeholder="패스워드 확인" maxlength="30">
                </div>
            </div>
            <div class="form-group" id="divName">
                <label for="name" class="col-lg-2 control-label">이름</label>
                <div class="col-lg-5">
                    <input type="text" class="form-control onlyHangul" id="name" name="name" data-rule-required="true" placeholder="한글만 입력 가능합니다." maxlength="15">
                </div>
            </div>
             
            <div class="form-group" id="divNickname">
                <label for="nickName" class="col-lg-2 control-label">닉네임</label>
                <div class="col-lg-5">
                    <input type="text" class="form-control" id="nickName" name="nickName" data-rule-required="true" placeholder="닉네임" maxlength="15">
                </div>
            </div>
             
            <div class="form-group" id="divEmail">
                <label for="inputEmail" class="col-lg-2 control-label">이메일</label>
                <div class="col-lg-5">
                    <input type="email" class="form-control" id="email" name="email" data-rule-required="true" placeholder="이메일" maxlength="40">
                </div>
                <div id="emailcheck"></div>
            </div>
            <div class="form-group" id="divPhoneNumber">
                <label for="inputPhoneNumber" class="col-lg-2 control-label">휴대폰 번호</label>
                <div class="col-lg-5">
<!--                     <input type="tel" class="form-control onlyNumber" id="phoneNumber" name="phoneNumber" data-rule-required="true" placeholder="-를 제외하고 숫자만 입력하세요." maxlength="11"> -->
              		<input type="tel" class="form-control onlyNumber" id="phoneNumber" name="phoneNumber" data-rule-required="true" placeholder="ex) 010-1111-1111" maxlength="13">
                </div>
            </div>
            <div class="form-group">
                <label for="inputGender" class="col-lg-2 control-label">성별</label>
                <div class="col-lg-5">
                	<input type="radio" id="gender" name="gender" value="M" checked>남자
					<input type="radio" id="gender" name="gender" value="F">여자
                </div>
            </div>

            <div class="wrap">
  				<button class="button"><b>확인</b></button>
		    </div><br><br>
        </form>
        <!--// 본문 들어가는 부분 -->
    </div> 
    	<hr/>
        <%@ include file="../common/footer.jsp" %>
    </body>
    <script>
            $(function(){
                //모달을 전역변수로 선언
                var modalContents = $(".modal-contents");
                var modal = $("#defaultModal");
                 
                $('.onlyAlphabetAndNumber').keyup(function(event){
                    if (!(event.keyCode >=37 && event.keyCode<=40)) {
                        var inputVal = $(this).val();
                        $(this).val($(this).val().replace(/[^_a-z0-9]/gi,'')); //_(underscore), 영어, 숫자만 가능
                    }
                });
                 
                $(".onlyHangul").keyup(function(event){
                    if (!(event.keyCode >=37 && event.keyCode<=40)) {
                        var inputVal = $(this).val();
                        $(this).val(inputVal.replace(/[a-z0-9]/gi,''));
                    }
                });
                
//                 $(".onlyNumber").keyup(function(event){ //기존 폰번호
//                     if (!(event.keyCode >=37 && event.keyCode<=40)) {
//                         var inputVal = $(this).val();
//                         $(this).val(inputVal.replace(/[^0-9]/gi,''));
//                     }
//                 });
                
                $(".onlyNumber").keyup(function(event){ // 숫자 + - 
                    if (!(event.keyCode >=37 && event.keyCode<=40)) {
                        var inputVal = $(this).val();
                        $(this).val(inputVal.replace(/^01[016789]-\d{3,4}-\d{4}$/gi,''));
                    }
                });
                 
                //------- 검사하여 상태를 class에 적용
                $('#id').keyup(function(event){
                     
                    var divId = $('#divId');
                     
                    if($('#id').val()==""){
                        divId.removeClass("has-success");
                        divId.addClass("has-error");
                    }else{
                        divId.removeClass("has-error");
                        divId.addClass("has-success");
                    }
                });
                 
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
                 
                $('#passCheck').keyup(function(event){
                     
                    var passwordCheck = $('#passCheck').val();
                    var password = $('#pass').val();
                    var divPasswordCheck = $('#divPasswordCheck');
                     
                    if((passwordCheck=="") || (password!=passwordCheck)){
                        divPasswordCheck.removeClass("has-success");
                        divPasswordCheck.addClass("has-error");
                    }else{
                        divPasswordCheck.removeClass("has-error");
                        divPasswordCheck.addClass("has-success");
                    }
                });
                 
                $('#name').keyup(function(event){
                     
                    var divName = $('#divName');
                     
                    if($.trim($('#name').val())==""){
                        divName.removeClass("has-success");
                        divName.addClass("has-error");
                    }else{
                        divName.removeClass("has-error");
                        divName.addClass("has-success");
                    }
                });
                 
                $('#nickName').keyup(function(event){
                     
                    var divNickname = $('#divNickname');
                     
                    if($.trim($('#nickName').val())==""){
                        divNickname.removeClass("has-success");
                        divNickname.addClass("has-error");
                    }else{
                        divNickname.removeClass("has-error");
                        divNickname.addClass("has-success");
                    }
                });
                 
                $('#email').keyup(function(event){
                     
                    var divEmail = $('#divEmail');
                     
                    if($.trim($('#email').val())==""){
                        divEmail.removeClass("has-success");
                        divEmail.addClass("has-error");
                    }else{
                        divEmail.removeClass("has-error");
                        divEmail.addClass("has-success");
                    }
                });
                 
                $('#phoneNumber').keyup(function(event){
                     
                    var divPhoneNumber = $('#divPhoneNumber');
                     
                    if($.trim($('#phoneNumber').val())==""){
                        divPhoneNumber.removeClass("has-success");
                        divPhoneNumber.addClass("has-error");
                    }else{
                        divPhoneNumber.removeClass("has-error");
                        divPhoneNumber.addClass("has-success");
                    }
                });
                 
                 
                //------- validation 검사
                
                $("form").submit(function(event) {
                    var divId = $('#divId');
                    var divPassword = $('#divPassword');
                    var divPasswordCheck = $('#divPasswordCheck');
//                     var divName = $('#divName');
//                     var divNickname = $('#divNickname');
                    var divEmail = $('#divEmail');
//                     var divPhoneNumber = $('#divPhoneNumber');
                     
                    //아이디 검사
                    if($('#id').val()=="") {
                        modalContents.text("아이디를 입력하여 주시기 바랍니다.");
                        modal.modal('show');
                         
                        divId.removeClass("has-success");
                        divId.addClass("has-error");
                        $('#id').focus();
                        return false;
                    }else{
                        divId.removeClass("has-error");
                        divId.addClass("has-success");
                    }
                    
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
                     
                    //패스워드 확인
                    if($('#passCheck').val()==""){
                        modalContents.text("패스워드 확인을 입력하여 주시기 바랍니다.");
                        modal.modal('show');
                         
                        divPasswordCheck.removeClass("has-success");
                        divPasswordCheck.addClass("has-error");
                        $('#passCheck').focus();
                        return false;
                    }else{
                        divPasswordCheck.removeClass("has-error");
                        divPasswordCheck.addClass("has-success");
                    }
                     
                    //패스워드 비교
                    if($('#pass').val()!=$('#passCheck').val() || $('#passCheck').val()==""){
                        modalContents.text("패스워드가 일치하지 않습니다.");
                        modal.modal('show');
                         
                        divPasswordCheck.removeClass("has-success");
                        divPasswordCheck.addClass("has-error");
                        $('#passCheck').focus();
                        return false;
                    }else{
                        divPasswordCheck.removeClass("has-error");
                        divPasswordCheck.addClass("has-success");
                    }
       
                    
                    /*
                    //이름
                    if($('#name').val()==""){
                        modalContents.text("이름을 입력하여 주시기 바랍니다.");
                        modal.modal('show');
                         
                        divName.removeClass("has-success");
                        divName.addClass("has-error");
                        $('#name').focus();
                        return false;
                    }else{
                        divName.removeClass("has-error");
                        divName.addClass("has-success");
                    }
                     
                    //닉네임
                    if($('#nickName').val()==""){
                        modalContents.text("닉네임을 입력하여 주시기 바랍니다.");
                        modal.modal('show');
                         
                        divNickname.removeClass("has-success");
                        divNickname.addClass("has-error");
                        $('#nickName').focus();
                        return false;
                    }else{
                        divNickname.removeClass("has-error");
                        divNickname.addClass("has-success");
                    }
                     

                     
                    //휴대폰 번호
                    if($('#phoneNumber').val()==""){
                        modalContents.text("휴대폰 번호를 입력하여 주시기 바랍니다.");
                        modal.modal('show');
                         
                        divPhoneNumber.removeClass("has-success");
                        divPhoneNumber.addClass("has-error");
                        $('#phoneNumber').focus();
                        return false;
                    }else{
                        divPhoneNumber.removeClass("has-error");
                        divPhoneNumber.addClass("has-success");
                    }  
                 	*/
                    //이메일
                    if($('#email').val()==""){
                        modalContents.text("이메일을 입력하여 주시기 바랍니다.");
                        modal.modal('show');
                         
                        divEmail.removeClass("has-success");
                        divEmail.addClass("has-error");
                        $('#email').focus();
                        return false;
                    }else{
                        divEmail.removeClass("has-error");
                        divEmail.addClass("has-success");
                    }
                });
                 
            });
             
        </script>

    <script>
	let idcheck = false;
	let emailcheck = false;
	$.ajaxSetup({
		type:"POST",
		async:true,
		dataType:"json",
		error:function(xhr){
			alert("error html="+xhr.statusText);
		}
	});
	
	$(function(){
		$("#id").on("blur",function(){
			$.ajax({
				url:"/project/joinIdCheck",
				data:{
					inputId:$("#id").val()
				},
				success:function(data){
					let html;
					if($("#id").val()!=""){
						if(data==1){
							html="<b>사용 가능한 아이디입니다.</b>"
							$("#idcheck").html(html).css("color","green");
							idcheck=true;
						}else{
							html="<b>중복된 아이디입니다.<b>";
							$("#idcheck").html(html).css("color","red");
							idcheck=false;
						}
					}else{
						html="<b>아이디를 입력해주세요.<b>";
						$("#idcheck").html(html).css("color","red");
						idcheck=false;
					}
				}
			});
		});
	});
	
	$(function(){
		$("#email").on("blur",function(){
			$.ajax({
				url:"/project/joinEmailCheck",
				data:{
					inputEmail:$("#email").val()
				},
				success:function(data){
					let html;
					if($("#email").val()!=""){
						if(data==1){
							html="<b>사용 가능한 이메일입니다.</b>"
							$("#emailcheck").html(html).css("color","green");
							emailcheck=true;
						}else{
							html="<b>중복된 이메일입니다.<b>";
							$("#emailcheck").html(html).css("color","red");
							emailcheck=false;
						}
					}else {
						html="<b>이메일을 입력해주세요.<b>";
						$("#emailcheck").html(html).css("color","red");
						emailcheck=false;
					}
				}
			});
		});
	});
	
	function availability(){
		if(idcheck==true && emailcheck==true && $('#pass').val()==$('#passCheck').val()){
//			alert("메일인증을 보냈습니다\n잠시만기다려주세요");
			swal("인증요청!", "메일을 확인해주세요!", "success");
			return true;
		}else if(!idcheck || !emailcheck){
			alert("확인해주세요");
			return false;
		}
	}
	</script>
</html>
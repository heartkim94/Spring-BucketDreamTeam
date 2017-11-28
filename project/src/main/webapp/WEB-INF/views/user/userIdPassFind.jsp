<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디/비밀번호 찾기</title>
<link rel="stylesheet" href="./resources/css/userIdPassFind.css">
<script src="//code.jquery.com/jquery-3.1.0.min.js"></script>
<script language="javascript">
	function id_search() {
		var f = document.id_f;
		$.ajax({
			url:"/project/joinEmailCheck.do", // 이메일 체크 재사용했음
			data:{
				inputEmail:$("#email").val()
			},
			success:function(data){
				if($("#email").val()!=""){
					if(data==1){
						alert("잘못된 email 입니다.");
			 			f.email.focus();
					}else {
						f.submit();
					}
				}else {
		 			alert("email을 입력해주세요.");
		 			f.email.focus();
				}
			}
		});
	}

	
// 	let idcheck = false;
// 	let emailcheck = false;
// 	function pw_search() {
// 		var f = document.pw_f;
// 		$.ajax({
// 			type:"POST",
// 			async:true,
// 			url:"/project/findIdEmailCheck.do", 
// 			data:{
// 				inputId:$("#id").val(),
// 				inputEmail:$("#email").val()
// 			},
// 			success:function(data){
// 				if($("#id").val()!="" && $("#email").val()!=""){
// 					if(data==1){
// 						alert("잘못된 ID 또는 EMAIL 입니다.");
// 			 			f.id.focus();
// 					}else {
// 						idcheck==true
// 						emailcheck==true
// 						f.submit();
// 					}
// 				}else {
// 		 			alert("ID또는 EMAIL을 입력해주세요.");
// 		 			f.id.focus();
// 				}
// 			}
// 		});
// 		$.ajax({
// 			url:"/project/joinEmailCheck.do", // 이메일 체크 재사용했음
// 			async:false,
// 			data:{
// 				inputEmail:$("#email").val()
// 			},
// 			success:function(data){
// 				if($("#email").val()!=""){
// 					if(data==1){
// 						alert("잘못된 EMAIL 입니다.");
// 			 			f.email.focus();
// 					}else {
// 						f.submit();
// 					}
// 				}else {
// 		 			alert("EMAIL을 입력해주세요.");
// 		 			f.email.focus();
// 				}
// 			}
// 		});
//	}
	
// 	function availability(){
// 		if(idcheck==true && emailcheck==true){
// 			alert("임시비밀번호를 전송하였습니다.");
// 			return true;
// 		}else if(!idcheck || !emailcheck){
// 			alert("확인해주세요");
// 			return false;
// 		}
// 	}
	
	
	
	function pw_search() {
		var f = document.pw_f;

		if(f.id.value=="") {
			alert("아이디를 입력해주세요.");
			f.id.focus();
			return;
		}
		if(f.email.value=="") {
			alert("email을 입력해주세요.");
			f.email.focus();
			return;
		}
		f.submit();
	}

</script>
</head>
<body>
<table width="450" class="grey12" border="0" cellspacing="0" cellpadding="0">
	<tbody>
	<tr>
		<td style="padding: 20px 0px 0px;">
			<table width="420" align="center" border="0" cellspacing="0" cellpadding="0">
				<tbody>
				<tr>
					<td style="padding:15px; border:2px solid rgb(204,204,204);">
						<form action="/project/userIdFind.do" name="id_f" id="id_f" method="post">
							<table width="380" border="0" cellspacing="0" cellpadding="0">
							<tbody>
							<tr>
								<td class="stitle">아이디 찾기</td>
							</tr>
							</tbody>
							</table>
							<table width="380" class="regtable" border="0" cellspacing="1">
							<tbody>
							<tr>
                				<td width="100" height="25" bgcolor="#f4f4f4">email</td>
               					<td>
               						<input type="text" name="email" id="email" tabindex="2"> 
                   				</td>
                   				<td align="center">
									<div class="bts">
										<a href="javascript:id_search();">
											<span style="width:80px;">아이디 찾기</span>
										</a>
									</div>
								</td>
                   			</tr>
							</tbody>
							</table>
						</form>
						
						<form action="/project/userPassFind.do" name="pw_f" id="pw_f" method="post" onsubmit="return availability()">
            				<table width="380" border="0" cellspacing="0" cellpadding="0">
			                <tbody>
             				<tr>
              			  	  <td class="stitle">비밀번호 찾기</TD>
              			  	</tr>
              			  	</tbody>
              			  	</table>
			                <table width="380" class="regtable" border="0" cellspacing="1">
		                    <tbody>
			                <tr>
               			   	    <td width="100" height="25" bgcolor="#f4f4f4">ID</td>
               				    <td width="130">
               				  	    <input type="text" name="id" id="id" tabindex="5"> 
                   			    </td>
	                            <td align="center" rowspan="2">
                 		       	    <div class="bts"> 
                 		       	 		<a tabindex="8" href="javascript:pw_search();">
                 		       	 			<span style="width: 80px;">비밀번호 찾기</span>
                 		       	 		</a>
                 		       	 	</div>
                 		       	 </td>
                 		    </tr>
			                <tr>
               					<td height="25" bgcolor="#f4f4f4">email</td>
			                    <td>
			                    	<input type="text" name="email" id="email" tabindex="6"> 
                   				</td>
                   			</tr>
                   			</tbody>
                   			</table>
                   		</form>
					</td>
				</tr>
				</tbody>
			</table>
			
			<table align="right" border="0" cellspacing="0" cellpadding="0">
       			<tbody>
        			<tr>
		  	          <td height="40" style="padding: 0px 13px 0px 0px;">
	      	            <div class="bts">
	      	            	<a href="javascript:self.close();">
	      	            		<span style="width: 50px;">닫기</span>
	      	            	</a>
	      	            </div>
	      	          </td>
	      	        </tr>
	      	    </tbody>
	      	</table>
		</td>
	</tr>
	</tbody>

</table>
</body>
</html>
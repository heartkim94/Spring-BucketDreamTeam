<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디/비밀번호 찾기</title>
<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-image: url();
}

 a.white12bold:link { font-size : 12px;  color : #ffffff;  text-decoration : none; font-weight: bold;  }
 a.white12bold:visited { font-size : 12px;  color : #ffffff;  text-decoration : none; font-weight: bold;  }
 a.white12bold:active { font-size : 12px;  color : #ffffff;  text-decoration : none; font-weight: bold; }
 a.white12bold:hover { font-size :12px;  color : #ffffff;  text-decoration : none; font-weight: bold;  }
 a.grey12:link { font-size : 12px;  color : #666666;  text-decoration : none;   }
 a.grey12:visited { font-size : 12px;  color : #666666;  text-decoration : none;   }
 a.grey12:active { font-size : 12px;  color : #666666;  text-decoration : none;  }
 a.grey12:hover { font-size :12px;  color : #666666;  text-decoration : none;   }
 
 
.white12bold {
	font-size: 12px;
	font-weight: bold;
	color: #ffffff;
	line-height: 17px;
}
.grey12 {
	font-size: 12px;
	color: #666666;
	line-height: 18px;
	font-weight:normal;
}
.stitle{height:15px; color:#666666; font-size:11px; font-family:Tahoma, Verdana, MalgunGothic,"돋움", "굴림"; font-weight:bold; border-bottom:2px solid #cccccc}
.regtable {border-top:1px solid #eaeaea; margin:0 0 20px 0}
.regtable td{border-bottom:1px solid #eaeaea; padding:0 10px; font-family:Tahoma, Verdana, MalgunGothic,"돋움", "굴림"; font-size:11px;}

.bts a{display:block; float:left; font-size:11px; font-family:Tahoma, Verdana, MalgunGothic,"돋움", "굴림"; color:#777; padding-left:6px; text-decoration:none; height:21px; cursor:pointer; margin-right:3px; overflow:hidden; margin:0 0 0 3px; text-align:center}
.bts a:hover{text-align:center}
.bts a span{display:block; float:left; line-height:180%; padding-right:6px; height:21px; overflow:hidden; text-align:center}
.bts a:hover span{color:#000; text-align:center}
</style>

<script language="javascript">
	function id_search() {
		var f = document.id_f;
		if(f.email.value=="") {
			alert("email을 입력해주세요.");
			f.email.focus();
			return;
		}
		f.submit();
	}
	
	function pw_search() {
		var f = document.pw_f;
		if(f.mem_id.value=="") {
			alert("아이디를 입력해주세요.");
			f.mem_id.focus();
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
                				<td height="25" bgcolor="#f4f4f4">email</td>
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
						
						<form action="pw_find_ok.php" name="pw_f" id="pw_f" method="post">
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
               				  	    <input type="text" name="mem_id" tabindex="5" id="mem_id" > 
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
			                    	<input name="email" tabindex="6" id="email" type="text"> 
                   				</td>
                   			</tr>
                   			</tbody>
                   			</table>
                   		</form>
					</td>
				</tr>
				</tbody>
			</table>
			
<!-- 			<table align="right" border="0" cellspacing="0" cellpadding="0"> -->
<!--        			<tbody> -->
<!--         			<tr> -->
<!-- 		  	          <td height="40" style="padding: 0px 13px 0px 0px;"> -->
<!-- 	      	            <div class="bts"> -->
<!-- 	      	            	<a href="javascript:self.close();"> -->
<!-- 	      	            		<span style="width: 50px;">닫기</span> -->
<!-- 	      	            	</a> -->
<!-- 	      	            </div> -->
<!-- 	      	          </td> -->
<!-- 	      	        </tr> -->
<!-- 	      	    </tbody> -->
<!-- 	      	</table> -->
		</td>
	</tr>
	</tbody>

</table>
</body>
</html>
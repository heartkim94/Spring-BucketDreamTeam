<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디를 찾았습니다</title>
<link rel="stylesheet" href="./resources/css/userIdPassFind.css">
<script src="//code.jquery.com/jquery-3.1.0.min.js"></script>
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
						<form action="#">
							<table width="380" border="0" cellspacing="0" cellpadding="0">
							<tbody>
							<tr>
								<td class="stitle">아이디를 찾았습니다!</td>
							</tr>
							</tbody>
							</table>
							<table width="380" class="regtable" border="0" cellspacing="1">
							<tbody>
							<tr>
                				<td width="100" height="25" bgcolor="#f4f4f4"><b>아이디</b></td>
               					<td>
               						<p><b>${myId}</b></p>
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
	      	            	<a href="javascript:history.go(-1)">
	      	            		<span style="width: 50px;">이전으로</span>
	      	            	</a>
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
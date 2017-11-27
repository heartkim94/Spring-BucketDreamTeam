<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디를 찾았습니다</title>
<script src="//code.jquery.com/jquery-3.1.0.min.js"></script>
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

</head>
<body>
		<form>
			<div>
				<p>아이디 : ${myId} 입니다.</p>
			</div>
		</form>
</body>
</html>
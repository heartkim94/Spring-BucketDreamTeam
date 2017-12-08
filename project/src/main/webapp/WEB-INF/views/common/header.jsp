<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTf-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<title>header</title>
<link rel="stylesheet" href="/project/resources/css/normalize.css">
<link rel="stylesheet" href="/project/resources/css/style.css">
<script src="/project/resources/js/prefixfree.min.js"></script>
<script src="//code.jquery.com/jquery-3.1.0.min.js"></script>
<style>
	/* 상단으로 이동 */
	#btnTop {
		position: fixed;
		right: 10px;
		bottom: 10px;
		width: 40px;
		height: 40px;
		font-size: 0;
		text-indent: -1000px;
		text-align: center;
		color: #fff;
		background: url('/project/resources/img/toTop.png') center center no-repeat #777;
		opacity: 0;
		border-radius: 20px;
		transition: 0.2s;
		cursor: pointer;
		z-index: 100;
	}

    * {
        margin:0;
        padding:0;
        font: 맑은고딕;
        text-decoration:none;
        letter-spacing:0px;
    }
    html {height:100%;}
 
    .wrap
    {
        width:100%;
        font-size:14px;
        font-weight:bold;
    }
 
    .menubar
    {
        width:1024px;
        margin: 0 auto;
        border:none;
        background: #1D375F;
        overflow: hidden;
    }
 
    .menuLogo
    {
        width:100px;
        float:left;
    }
 
    .menuItem
    {
        float:right;
    }
 
    .menubar ul
    {
        background: #1D375F;
        height:50px;
        list-style:none;
    }
 
    .menubar li
    {
        float:left;
    }
 
    .menubar a
    {
        color:#FFFFFF;
        display:block;
        font-weight:normal;
        line-height:49px;
        padding:1px 25px;
        text-align:center;
    }
 
    .menubar li a:hover,
    .menubar ul li:hover a {
        background: #636363;
        color:#FFFFFF;
    }
 
    .menubar li:hover ul
    {
        display:block;
    }
 
    .menubar li:hover li a
    {
        background:none;
    }
 
    .menubar li ul
    {
        background: #1D375F;
        display:none;
        height:auto;
        position:absolute;
        z-index:999;
    }
 
    .menubar li li a ,
    .menubar li li
    {
        background: #1D375F;
        display:block;
        float:none;
        min-width:135px;
    }
 
    .menubar li ul a
    {
        display:block;
        height:50px;
        font-size:12px;
        font-style:normal;
        padding:0px 10px 0px 15px;
        text-align:left;
    }
 
    .menubar li ul a:hover,
    .menubar li ul li:hover a{
        background: #636363;
        border:0px;
        color:#ffffff;
    }
    
/* 여기서부터 미디어쿼리 */    
    
#menu, #toggle { /* 체크박스 이름표와 체크박스 숨김*/
 	display:none; 
}
.wrap { 
	padding:0; margin:0;display:inline;
}
.wrap li {
	display:inline;
}
#contents {
	min-height: 200px; background: #D9E5FF;
}
/*
footer {
 	background-color:#EAEAEA; 
	font-size:13px;
}    
*/    
/* Android 버그 교정 */ 
body { 
  -webkit-animation: bugfix infinite 1s; 
}
@-webkit-keyframes bugfix { 
  from { padding: 0; } 
  to { padding: 0; } 
} 

@media screen and (max-width: 480px) { /* 화면 너비 480px 이하에서 적용 */
	.wrap { /* 메뉴 숨김 */
		display:none;
	}
	#toggle:checked + .wrap { /* 체크박스 선택하면 메뉴가 나타남*/
		display:block;
	} 
	.wrap .menubar .menuItem {
		display:block;
		width:100%;
		text-align:center;
		border-top:1px solid #ccc;
		padding: 4px;
	}
	#menu {
 		display:block;  
		text-align:center;
		background: url('/project/resources/img/menu.png'); 
		background-repeat: no-repeat;
		background-position:97% 10px;
		background-size: 24px 19px;
		font-size:20px; 
		font-weight:bold;
		padding:4px 3%;
	}
	footer .foot {
			width: 480px;
			padding: 15px 0;
			margin: 0 auto;
			text-align:center;
			color:#fff;
			clear: both;
	}
}
    
</style>

</head>
<body>
<header>
	<!-- 위로올라가기 버튼 -->
	<a id="btnTop"> 상단으로 이동 </a>
	<label for="toggle" id="menu" onclick>MENU</label>
	<input type="checkbox" id="toggle"/>
	<div class="wrap">
		<div class="menubar">
		<div class="menuLogo">
			<c:if test="${id != null}">
				<a href="/project/group/main">Dogether</a>
			</c:if>
			<c:if test="${id == null}">
				<a href="/project/home"><strong>Dogether</strong></a>
			</c:if>
		</div>

		<ul class="menuItem">
			<li><a href="#">About Us</a></li>
			<li><a href="#">Portfolio</a></li>
			<li><a href="#">Contact Us</a></li>
			<li>
				<c:if test="${id != null}">
					<a href="#" class="mypageBtn" >마이페이지</a>
					<ul class="mypageMenu">
						<li><a href="#">Action</a></li>
						<li><a href="/project/mypage">회원정보 수정</a></li>
						<li><a href="/project/myInfoDelForm">회원탈퇴</a></li>
						<li class="divider"></li>
						<li><a href="/project/logout">로그아웃</a></li>
					</ul>
				</c:if>
			</li>
		</ul>
		</div>
	</div>
</header>
</body>
<script>
// 상단으로 바로가기 버튼
$(document).ready(function() {

	let btnTop = $('#btnTop');

	btnTop.click(function() {
		$('html, body').animate({
			'scrollTop' : '0'
		}, 100);
		// ie에서 작동하기 위해서는 html로 선택해야 함.
	});

	btnTop.hover(function() {
		$(this).css('background-color', '#cd8f47');
	}, function() {
		$(this).css('background-color', '#777');
	});

	$(window).scroll(function() {

		let pos = $(this).scrollTop();

		if (pos >= 95) {
			btnTop.stop(true).animate({
				'opacity' : '0.8'
			}, 200);

		} else {
			btnTop.stop(true).animate({
				'opacity' : '0'
			}, 200);
		}
	});

}); 
</script>
<!-- 부트스트랩 (header.jsp 위로두면 안먹음)-->
<!-- 	 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>		 -->
</html>
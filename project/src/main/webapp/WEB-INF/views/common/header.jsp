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
<!-- <link rel="stylesheet" href="/project/resources/css/header.css"> -->
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="/project/resources/js/jquery-ui.js"></script>
<script src="/project/resources/js/prefixfree.min.js"></script>

 

<style>
	/* 상단으로 이동 버튼 */
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
	/* header normal style */
    header {
    	width: 100%;
	    background: #fff;
	    border-bottom: 1px solid #eee;
	    z-index: 999;
    }
    header .wrap {
   	    background: #fff;
   		padding: 30px 0 24px;
    }
    header .wrap .menubar {
    	width: 1024px;
    	margin: 0 auto;
    	position: relative;
    }
    .menuLogo {
    	display: inline-block;
    	margin-left: 5%;
    }
    .menuItem {
    	position: absolute;
	    right: 5%;
	    top: 50%;
	    transform: translateY(-50%);
	    display: inline-block;
	    float: right;
	    vertical-align: top;
    }
    .mypageMenu {
    	display: none;
    	position: absolute;
	    overflow: hidden;
	    right: 70px;
	    top: -10px;
	    width: 140px;
	    height: auto;
	    background: #fff;
	    border: 1px solid #e0e0e0;
    }
    /* .mypageBtnIcon은 반응형에서 동작 */
    .mypageBtnIcon {
    	display: none;
	    padding: 10px 7px;
    }
    .responseMypageMenu  li {
  			display: none;
  			float: left;
  			text-align: center;
  		}
    .mypageMenu > li:hover {
   	    background: #f1f1f2;
    }
    .mypageMenu a {
    	display: block;
	    padding: 8px 14px;
	    color: #333;
	    font-family: arial;
    }
    /* header response style */
    @media (max-width: 1024px) {
  		.mypageBtn {
  			font-size: 0;
  		}
  		.mypageBtnIcon {
  			display: inline-block;
  		}
  		.mypageBtnIcon img {
  			width: 20px;
  		}
  		header .wrap .menubar {
  			width: 100%;
  		}
  		.mypageMenu {
  			display: none;
  		}
  		.responseMypageMenu  li {
  			float: left;
  			text-align: center;
  			border-bottom: 1px solid #eee;
  		}
  		.responseMypageMenu  li:nth-child(1){
  			width: 40%;
  		}
  		.responseMypageMenu  li:nth-child(2), li:nth-child(3){
  			width: 30%;
  		}
  		.responseMypageMenu a {
  			display: block;
  			width: 100%;
/*   			height: 100%; */
  			padding: 20px 0;
  		}
    }
    
</style>

</head>
<body>
<header>
	<!-- 위로올라가기 버튼 -->
	<a id="btnTop"> 상단으로 이동 </a>
	
<!-- 	<label for="toggle" id="menu" onclick>MENU</label> -->
<!-- 	<input type="checkbox" id="toggle"/> -->
	<div class="wrap">
		<div class="menubar">
			<div class="menuLogo">
				<c:if test="${id != null}">
					<a href="/project/group/main"><h1>Dogether</h1></a>
				</c:if>
				<c:if test="${id == null}">
					<a href="/project/home"><h1>Dogether</h1></a>
				</c:if>
			</div>
			<ul class="menuItem">
				<li>
					<c:if test="${id != null}">
						<a href="#" class="mypageBtn">마이페이지</a>
						<a href="#" class="mypageBtnIcon">
							<img src="/project/resources/img/menuIcon.png" alt="menuIcon"/>  
						</a>
						<script>
							$(function(){
								// 헤더 마이페이지 버튼 클릭 시 토글효과
								$('.mypageBtn').on("click", function(event){
									event.preventDefault();
									$(".mypageMenu").slideToggle();
								});
								$('.mypageBtnIcon').on("click", function(event){
									event.preventDefault();
									let menu = $(".responseMypageMenu li");
									menu.fadeToggle();
								});
								
								$(window).resize(function(){
									let windowWidth = $(window).width();
									if(windowWidth > 1024){
										$(".responseMypageMenu").css("display", "none");
									}else {
										$(".responseMypageMenu").css("display", "block");
									}
									if(windowWidth <= 1024){
										$(".mypageMenu").css("display", "none");
									}
								});
								
							});
						</script>
						<ul class="mypageMenu">
							<li><a href="/project/mypage">회원정보 수정</a></li>
							<li><a href="/project/myInfoDelForm">회원탈퇴</a></li>
							<li><a href="/project/logout">로그아웃</a></li>
						</ul>
					</c:if>
				</li>
				<li>
					<c:if test="${id == null}">
						<a href="/project/userProvisionForm" class="headerJoinBtn">회원가입</a>
					</c:if>
				</li>
			</ul>
		</div>
		
	</div>
</header>
<!-- width:1024 이하일 때 display:block됨 -->
<ul class="responseMypageMenu">
	<li><a href="/project/mypage">회원정보 수정</a></li>
	<li><a href="/project/myInfoDelForm">회원탈퇴</a></li>
	<li><a href="/project/logout">로그아웃</a></li>
</ul>
</body>
<script>

$(document).ready(function() {
	// 상단으로 바로가기 버튼
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
	
	// $("#slider").nivoSlider();
	
	
}); 
</script>
</html>
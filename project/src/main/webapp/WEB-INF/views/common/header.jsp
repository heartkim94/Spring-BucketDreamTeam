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
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="/project/resources/js/jquery-ui.js"></script>
<script src="/project/resources/js/prefixfree.min.js"></script>

<style>
	/* 상단으로 이동 버튼 */
	#btnTop {
		position: fixed;
		right: 30px;
		bottom: 2px;
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
		z-index: 1000;
	}
	/* header normal style */
    header {
   		position: relative;
    	width: 100%;
	    background: #fff;
	    border-bottom: 1px solid #eee;
	    z-index: 999;
	    overflow: hidden;
    }
    .headerFixed {
    	position: fixed;
    }
    header .wrap {
   	    background: #fff;
   	    top: 0;
    }
    header .wrap .menubar {
    	width: 1024px;
    	margin: 0 auto;
    	position: relative;
    }
    .menuLogo, .menuItem {
    	display: inline-block;
    	margin-left: 5%;
    }
    .menuLogo {
    	float: left;
    	margin-left: 5%;
    }
    h1.logo {
    	font-size: 1em;
    	margin: 0;
    }
    .menuItem {
    	float: right;
    	margin-right: 5%;
    }
    a.mypageBtnIcon {
    	display: inline-block; 
 	    opacity: 0.5;
	    transition-duration: 0.5s;
    } 
    h1.logo, .mypageBtnIcon, .hdLoginBtn, .hdJoinBtn {
    	padding: 20px 0;
    }
    .hdLoginBtn, .hdJoinBtn {
    	display: inline-block;
    }
    .hdLoginBtn {
    	margin-right: 10px;
    }
     .mypageBtnIcon:hover {
     	transform: scale(1.4);
		opacity: 1;
     }
     .mypageBtnIcon img { 
   		width: 20px; 
   	 } 
   	 /* 사이드 메뉴바 */
   	 .sideMenuLayer {
   	 	display: none;
   	 	position: fixed;
   	 	top: 0;
   	 	right: 0;
   	 	width: 300px;
   	 	height: 100%;
   	 	display: none;
   	 	z-index: 999;
   	 	background-color: #eef0f3;
   	 }
   	 .sideMenuLayer > div {
   	 	width: 100%;
   	 	border-bottom: 1px solid #999;
   	 	margin: 0 auto;
   	 }
   	 .myInfo {
	    width: 100%;
	    height: 61px;
	    padding: 10px 15px 0 15px;
	    box-sizing: border-box;
	    border-bottom: 1px solid #999;
	    background-color: #e9e9e9;
	    z-index: 100;
	}
	a.pleaseJoin, .welcome {
		display:inline-block;
		padding: 10px;
	}
	.closeBtn {
   	 	display: block;
	    position: absolute;
	    top: 14px;
	    right: 8px;
	    width: 30px;
	    height: 30px;
	    text-align: center;
	    z-index: 999;
	    background-image: url("/project/resources/img/cancelIcon.png");
	    background-size: 30px;
	    background-repeat: no-repeat;
	    background-position: center;
	    font-size: 0;
   	 }
   	 .MypageMenu {
   	 	overflow: hidden;
   	 }
   	 .MypageMenu li {
   	 	float: left;
	    width: 49%;
	    box-sizing: border-box;
	    text-align: center;
	    vertical-align: top;
	    margin-bottom: 10px;
	    margin-right: 2%;
   	 }
   	 .MypageMenu li:last-child {
   	 	margin: 0;
   	 }
   	 .MypageMenu li:first-child a {
   	 	margin-right: 3%;
   	 	background-image: url("/project/resources/img/ModifyIcon.png");
   	 }
   	 .MypageMenu li:last-child  a {
   	 	background-image: url("/project/resources/img/logoutIcon.png");
   	 }
   	 .MypageMenu li a {
   		padding-top: 80px;
   	 	display: block;
   	 	width: 100%;
   	 	background-size: 30px;
   	 	background-repeat: no-repeat;
   	 	background-position: 50%;
   	 	font-size: 12px;
   	 }
    /* header response style */
     @media (max-width: 1024px) { 
  		
   		header .wrap .menubar { 
   			width: 100%; 
   		} 
   		/* 사이드 메뉴 */
/*    		.sideMenuLayer { */
/* 	   	 	display: none; */
/* 	   	 	position: fixed; */
/* 	   	 	top: 0; */
/* 	   	 	right: 0; */
/* 	   	 	width: 300px; */
/* 	   	 	height: 100%; */
/* 	   	 } */
/* 	   	 .sideMenuLayer > div { */
/* 	   	 	width: 100%; */
/* 	   	 } */
	   	 .MypageMenuWrap {
	   	 	width: 250px;
	   	 	margin: 0 auto;
	   	 }
     }
     @media (max-width: 768px) {
     
  	 }
     @media (max-width: 660px) {
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
					<a href="/project/group/main"><h1 class="logo">Dogether</h1></a>
				</c:if>
				<c:if test="${id == null}">
					<a href="/project/home"><h1 class="logo">Dogether</h1></a>
				</c:if>
			</div>
			<div class="menuItem">
				<c:if test="${id != null}">
					<a href="#" class="mypageBtnIcon" >
						<img src="/project/resources/img/menuIcon.png" alt="menuIcon"/>  
					</a>
				</c:if>
				<c:if test="${id == null}">
					<a href="/project/home" class="hdLoginBtn">로그인</a>
					<a href="/project/userProvisionForm" class="hdJoinBtn">회원가입</a>
				</c:if>
			</div> <!-- menuItem end -->
		</div> <!-- menubar end -->
		
		<div class="sideMenuLayer">
			<div>
				<div class="myInfo">
					<c:if test="${id == null}">
						<a href="userProvisionForm" class="pleaseJoin"><b>회원가입해 주세요</b></a>
					</c:if>
					<c:if test="${id != null}">
						<span class="welcome"><b>${id }</b>님 반갑습니다</span>
					</c:if>
					<a href="#" class="closeBtn">닫기</a>
				</div>
				<c:if test="${id != null }">
				<div class="MypageMenuWrap">
					<ul class="MypageMenu">
						<li><a href="/project/mypage">회원정보 수정</a></li>
<!-- 						<li><a href="/project/myInfoDelForm">회원탈퇴</a></li> -->
						<li><a href="/project/logout">로그아웃</a></li>
	<%-- 					<li><%@ include file="../group/asideMenu.jsp" %></li>  --%>
					</ul>
				</div>
				</c:if>
			</div>
		</div>
	</div> <!-- wrap end -->
	
</header>
</body>
<!-- 젤 위로 이동 하기 버튼 동작 -->
<script src="/project/resources/js/toTop.js"></script>
<script>
	$(function(){
		// 헤더 마이페이지 버튼 클릭 시 토글효과
		$('.mypageBtnIcon').on("click", function(event){
			event.preventDefault();
			let windowWh = $(window).width();
			let menu = $(".sideMenuLayer");
// 			if(windowWh <= 1024){
				if (menu.is(":visible") ) {
					menu.stop(true,true).hide("slide", { direction: "right" }, 200);
			    } else {
			    	menu.stop(true,true).show("slide", { direction: "right" }, 200);
			    	$("body, html").stop(true,true).animate({
			    		'position': 'absolute',
			    		'right': '200px'
			    	}, 200);
			    }
				$(".closeBtn").on("click", function(){
					$(".sideMenuLayer").stop(true,true).hide("slide", { direction: "right" }, 200);
				})
// 			}
// 			}else if(windowWh > 1024){
// 				if (menu.is(":visible") ) {
// 					menu.stop(true,true).hide("slide", { direction: "up" }, 200);
// 			    } else {
// 			    	menu.stop(true,true).show("slide", { direction: "up" }, 200);
// 			    }
// 				$(".closeBtn").on("click", function(e){
// 					e.preventDefault();
// 					$(".sideMenuLayer").stop(true,true).hide("slide", { direction: "up" }, 200);
// 				})
// 			}
		});
		// 스크롤 아래로 움직일 시 헤더 브라우저에 고정!
		let headerOffset = $('header').offset();
        $( window ).scroll( function() {
          if ( $( document ).scrollTop() > headerOffset.top ) {
        	  $('header').addClass('headerFixed');
          }
          else {
        	  $('header').removeClass('headerFixed');
          }
        });
        
	});
</script>
</html>
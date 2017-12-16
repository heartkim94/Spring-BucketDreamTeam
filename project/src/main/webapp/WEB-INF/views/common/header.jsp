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
     .mypageBtnIcon { 
     	display: inline-block; 
 	    padding: 10px 7px; 
 	    opacity: 0.5;
	    transition-duration: 0.5s;
     } 
     .mypageBtnIcon:hover {
     	transform: scale(1.4);
		opacity: 1;
     }
     .mypageBtnIcon img { 
   			width: 20px; 
   	 } 
   	 .sideMenuLayer {
   	 	position: fixed;
   	 	top: 0;
   	 	right: 0;
   	 	width: 200px;
   	 	height: 100%;
   	 	z-index: 999;
   	 	border: 1px solid black;
   	 	box-sizing: border-box;
   	 }
   	 .MypageMenu {
   	 	border: 1px solid red;
   	 	box-sizing: border-box;
   	 }
   	 .sideMenuLayer { 
      	display: none;
	    position: fixed;
	    top: 0;
	    width: 260px;
	    height: 100%;
	    z-index: 999;
	    font-size: 15px;
	    background: #333333;
	    color: white;
	}
	
    /* header response style */
    
     @media (max-width: 1024px) { 
  		
   		header .wrap .menubar { 
   			width: 100%; 
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
			<div class="menuItem">
				<a href="#" class="mypageBtnIcon" >
					<img src="/project/resources/img/menuIcon.png" alt="menuIcon"/>  
				</a>
			
<%-- 					<c:if test="${id == null}"> --%>
						
<%-- 					</c:if> --%>
			</div> <!-- menuItem end -->
		</div> <!-- menubar end -->
	</div> <!-- wrap end -->
</header>
<div class="sideMenuLayer">
	<ul class="MypageMenu">
		<li><a href="/project/userProvisionForm" class="headerJoinBtn">회원가입</a></li>
		<li><a href="/project/mypage">회원정보 수정</a></li>
		<li><a href="/project/myInfoDelForm">회원탈퇴</a></li>
		<li><a href="/project/logout">로그아웃</a></li>
		<%@ include file="../group/asideMenu.jsp" %> 
	</ul>
</div>
</body>
<!-- 젤 위로 이동 하기 버튼 동작 -->
<script src="/project/resources/js/toTop.js"></script>
<script>
	$(function(){
		// 헤더 마이페이지 버튼 클릭 시 토글효과
		$('.mypageBtnIcon').on("click", function(event){
			event.preventDefault();
			let menu = $(".sideMenuLayer");
// 			menu.animate({'width': 'toggle'});
			if (menu.is(":visible") ) {
				menu.stop(true,true).hide("slide", { direction: "right" }, 200);
		    } else {
		    	menu.stop(true,true).show("slide", { direction: "right" }, 200);
		    }
		});
		$(".sideMenuLayer").on("click", function(){
			$(".sideMenuLayer").stop(true,true).hide("slide", { direction: "right" }, 200);
		})
		
// 		$(window).resize(function(){
// 			let windowWidth = $(window).width();
// 			if(windowWidth > 1024){
// 				$(".responseMypageMenu").css("display", "none");
// 			}else {
// 				$(".responseMypageMenu").css("display", "block");
// 			}
// 		});
		
	});
</script>
</html>
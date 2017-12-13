<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>MAIN</title>
<!-- 	<link rel="stylesheet" href="./resources/css/login.css"> -->
	<link rel="stylesheet" href="resources/nivo/nivo-slider.css">
	<link rel="stylesheet" href="resources/nivo/default.css">
	<script src="//code.jquery.com/jquery-3.1.0.min.js"></script>
	<script>
	$(document).ready(function(){
		let Certify=${dbCertify};
		if(Certify == 0) {
			alert("회원가입 이메일 인증을 안하셨습니다.");
		}
		document.location.href="./";
	});
	</script>
	<!-- Link Swiper's CSS -->
<!--   	<link rel="stylesheet" href="resources/plugin/swiper.min.css"> -->
	<style>
	/* 슬라이더 스타일 */
/* 	.swiper-container { */
/*       width: 1600px; */
/*       height: 100%; */
/*     } */
/*     .swiper-slide { */
/*       background-position: center; */
/*        background-size: cover; */
/*        height: 600px; */
/*     }  */
    
	</style>
</head>

<body>
<div id="wrapper">
	<%@ include file="header.jsp" %>
	
	<section>
		<div class="container mainContent">
			<div class="contentRow contentRow1">
				<div class="intro">
					<img src="resources/img/흐엉.jpg" width="300" height="300" alt="홈페이지 소개 사진이나 글, 슬라이드"><br>
					<h1>Hello, world!</h1>
					<p>blah blah</p>
					<button type="button" onclick="alert('Coming Soon!!!')">Click!!</button>
				</div>
				<div class="centerLineWrap">
					<p class="centerLine"></p>
				</div>
				<div class="login">
					<div class="loginInner">
						<c:if test="${id == null}">
							<form action="/project/login" method="post" id="loginForm">
								<div>
									<div class="loginInfoInput">
										<input type="text" id="id" name="id" placeholder="아이디" required=""/><br>
										<input type="password" id="pass" name="pass" placeholder="비밀번호" required=""/><br>
									</div>
									<div class="loginBtn">
										<input type="submit" value="로그인"><br>
									</div>
								</div>
								<div class="searchJoin">
									<div class="joinContainer">
										<a href="javascript:void(window.open('/project/userIdPassFind', '_blank','width=450, height=270'))">ID / PW 찾기</a>
									</div>
										<!-- <a href="#">ID / PW 찾기</a> &nbsp; | &nbsp; <a href="userProvisionForm">회원가입</a> -->
									<div class="joinContainer">
										<a href="userProvisionForm">회원가입</a>
									</div>
								</div>
							</form>
						</c:if>
						<c:if test="${id != null}">
							<center>
								<form action="/project/logout" method="post">
								 	<p>${id}님 환영합니다</p>
								 	<a href="/project/mypage">회원정보수정</a><br>
								 	<a href="/project/myInfoDelForm">회원탈퇴</a><br>
									<button id="logout">로그아웃</button>
								</form>
							</center>
						</c:if>
					</div> 
				</div>
			</div>
			<div class="contentRow contentRow2">
				<div class="slider-wrapper theme-default">
					<div id="slider" class="">
						<img src="resources/img/slider1.png" />
						<img src="resources/img/slider2.png" />
						<img src="resources/img/slider3.png" />
					</div>
				</div>
<!-- 				 <div class="swiper-container"> -->
<!-- 				    <div class="swiper-wrapper"> -->
<!-- 				      	<div class="swiper-slide" style="background-image:url(resources/img/slider1.png)"></div> -->
<!-- 						<div class="swiper-slide" style="background-image:url(resources/img/slider2.png)"></div> -->
<!-- 						<div class="swiper-slide" style="background-image:url(resources/img/slider3.png)"></div> -->
<!-- 				    </div> -->
<!-- 				    Add Pagination     -->
<!-- 				    <div class="swiper-pagination swiper-pagination-white"></div> -->
<!-- 				    Add Arrows -->
<!-- 				    <div class="swiper-button-next swiper-button-white"></div> -->
<!-- 				    <div class="swiper-button-prev swiper-button-white"></div> -->
<!-- 				 </div> -->
			</div>
			<div class="contentRow contentRow3">
				<ul>
					<li>
						<p>목표가 비슷한 사람들과 그룹을 만드세요.</p>
					</li>
					<li>
						<P>그룹원들과 채팅을 통해 실시간으로 정보를 공유하세요.</P>
					</li>
					<li>
						<P>그룹원들과의 성과를 공유하세요.</P>
					</li>
				</ul>
			</div>
		</div>
	</section>
	
	<%@ include file="footer.jsp" %>
</div> <!-- wrapper End -->
</body>
<style>
		section .mainContent {
			width: 100%;
		}
		/* contentRow1 */
		.contentRow1 {
			width: 1024px;
			padding: 150px 0;
			background-color: #f8f6f3;
		}
		.centerLineWrap {
		    align-self: stretch;
		    display: flex;
		    justify-content: center;
		}
		.centerLine {
			width: 1px;
			margin: 50px 0;
			background-color: #e0e0e0;
		}
		/* 로그인 영역 */
		.loginInfoInput {
			display: block;
			overflow: hidden;
			margin-top: 15px;
		}
		.loginInfoInput input {
			padding: 18px 20px 18px;
		    width: 100%;
		    border: 1px solid #e0e0e0;
		    border-radius: 4px;
		    background: #f9fafc;
		    color: #666;
		    font-size: 12px;
		    line-height: 16px;
		    zoom: 1;
		    margin-top: 5px;
		    box-sizing: border-box;
		}
		.loginBtn {
			display: block;
			overflow: hidden;
			width: 100%;
			margin-top: 15px;
		}
		.loginBtn input[type="submit"] {
			width: 100%;
		    height: 100%;
		    border: 0;
		    background: #666;
		    color: #fff;
		    font-weight: 700;
		    font-size: 14px;
		    line-height: 55px\9;
		    padding: 18px 20px 18px;
		    cursor: pointer;
		    border-radius: 4px;
		}
		.loginBtn input[type="submit"]:hover {
			 background: #444;
			 transition: .2s background ease-in-out; 
		}
		.searchJoin {
 			padding: 10px 0; 
		}
		.loginInner {
			width: 360px;
			margin: 0 auto;
		}
		.joinContainer {
			display: block;
			margin-top: 5px;
		}
		.joinContainer a {
			font-size: 14px;
		    line-height: normal;
		    text-decoration: none;
		    text-align: center;
		    color: #fff;
		    background: #a9a9a9;
			display: block;
		    border: 0;
 		    border-radius: 4px; 
		    padding: 18px 20px 18px;
		}
		.joinContainer a:hover {
		    background: #a1a1a1;
		    transition: .2s background ease-in-out; 
	    }
			
		/* contentRow2 */
		/* slide */
		.slider-wrapper {
			width: 100%;
			margin: 0 auto;
		}
		
		/* contentRow3 */
		.contentRow3 {
			padding: 100px 0;
		}
		.contentRow3 ul {
			width: 1024px;
			margin: 0 auto;
		}
		.contentRow3 li {
			display: inline-block;
		    width: 330px;
		    padding-top: 180px;
		    text-align: center;
		    vertical-align: top;
		    background-position: 50% 49px;
		    background-repeat: no-repeat;
		    background-size: 100px;
		}
		.contentRow3 li:nth-child(1) {
		    background-image: url("resources/img/rowIcon1.png");
		}
		.contentRow3 li:nth-child(2) {
		    background-image: url("resources/img/rowIcon2.png");
		}
		.contentRow3 li:nth-child(3) {
		    background-image: url("resources/img/rowIcon3.png");
		}
		
		.contentRow3 p {
			font-size: 14px;
			letter-spacing: -.2px;
			padding-bottom: 20px;
		}
		/* response style */
		@media (max-width: 1024px) {
			/* contentRow3 */
			.contentRow3 {
				padding: 25px 0;
			}
			.contentRow3 ul {
				width: 100%;
			}
			.contentRow3 li {
				width: 100%;
			}
		}
		@media (max-width: 768px) {
	  		.contentRow1 {
	  			padding: 50px 0 !important;
	  			display: block !important;
	  		}
	  		.centerLine {
	  			margin: 25px 0 !important;
	  		}
  		}
		
		
	</style>
	<script src="resources/nivo/jquery.nivo.slider.js"></script>
	<!-- Swiper JS -->
<!--   	<script src="resources/plugin/swiper.min.js"></script> -->
<script>
		
	$(document).ready(function(){
// 		$("#slider").nivoSlider();
		if ("ontouchstart" in document.documentElement) {
		 
			$('#slider').nivoSlider({
			    effect: 'slideInLeft',
				animSpeed: 700,
				pauseTime: 4000
			});
	 
			$('a.nivo-nextNav').css('visibility', 'hidden');
			$('a.nivo-prevNav').css('visibility', 'hidden');
			
			var element = document.getElementById('slider');
			
			var hammertime = Hammer(element).on("swipeleft", function(event) {
				$('#slider img').attr("data-transition","slideInLeft");
				$('a.nivo-nextNav').trigger('click');
				return false; 
			});
				
			var hammertime = Hammer(element).on("swiperight", function(event) {
				$('#slider img').attr("data-transition","slideInRight");
                $('a.nivo-prevNav').trigger('click');
                $('#slider img').attr("data-transition","slideInLeft");
                return false;
			});
		 
			}
		 
			else {
				$('#slider').nivoSlider({
				    effect: 'fade',
					animSpeed: 700,
					pauseTime: 4000
				});
			}
    

		/* 슬라이더 효과 */
// 		var swiper = new Swiper('.swiper-container', {
// //	 	  autoHeight: true,
// 	      spaceBetween: 30,
// 	      centeredSlides: true,
// 	      loop: true,
// 	      resize: false,
// 	      calculateHeight:true,
// 	      autoplay: {
// 	        delay: 2500,
// 	        disableOnInteraction: false,
// 	      },
// 	      pagination: {
// 	        el: '.swiper-pagination',
// 	        clickable: true, 
// 	      },
// 	      navigation: {
// 	        nextEl: '.swiper-button-next',
// 	        prevEl: '.swiper-button-prev',
// 	      },
// 	    });
		
		
	});
	
</script>

</html>

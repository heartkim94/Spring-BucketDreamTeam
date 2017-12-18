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
	
	<style>
		.clsBannerScreen {
			overflow: hidden;
			position: relative;
/* 			height: 150px; */
/* 			width: 300px;  */
			cursor:pointer; 
			clear:both;
			margin: 0 auto;
		}
		.clsBannerScreen .images {
			position:absolute; 
			display:none; 
/* 			height: 150px; */
/* 			width: 300px;  */
		}

	</style>
	<script type="text/javascript" src="resources/js/jquery.banner.js"></script>
	<script type="text/javascript">
		$(function() {
			$("#image_list_1").jQBanner({	//롤링을 할 영역의 ID 값
				nWidth:300,					//영역의 width
				nHeight:300,				//영역의 height
				nCount:3,					//돌아갈 이미지 개수
				isActType:"up",				//움직일 방향 (left, right, up, down)
				nOrderNo:1,					//초기 이미지
				nDelay:2000					//롤링 시간 타임 (1000 = 1초)
				/*isBtnType:"li"*/			//라벨(버튼 타입) - 여기는 안쓰임
				}
			);
		});
	</script>
</head>

<body>
<div id="wrapper">
	<%@ include file="header.jsp" %>
	
	<section>
		<div class="container mainContent">
			<div class="contentRow contentRow1">
				<article>
<!-- 					<div class="intro"> -->
<!-- 						<img src="resources/img/흐엉.jpg" width="300" height="300" alt="홈페이지 소개 사진이나 글, 슬라이드"><br> -->
<!-- 						<h1>Hello, world!</h1> -->
<!-- 						<p>blah blah</p> -->
<!-- 						<button type="button" onclick="alert('Coming Soon!!!')">Click!!</button> -->
<!-- 					</div> -->
						<div class="intro">
							<div id="image_list_1">
								<div class="clsBannerScreen" > 
		 							<div class="images" style="display:block">  
										<img src="resources/img/111.jpg" /> 
		 							</div> 
		 							<div class="images">
		 								<br><br><br><br><br>
		 								<h1>함께 성공을 달성하세요.</h1> 
		 							</div> 
		 							<div class="images"> 
		 								<br><br><br><br><br><br>
		 								<h1>Dogether와 함께</h1> 
		 							</div> 
		 						</div> 
		 					</div>
		 				</div>
 					<p>&nbsp;</p>
 					<p>&nbsp;</p> 
						

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
					</article>
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
		div.contentRow1 {
			padding: 150px 0;
			background-color: #f8f6f3;
		}
		div.contentRow1 article {
			width: 1024px;
			margin: 0 auto;
			display: flex;
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
			margin-top: 5px;
			width: 49%;
			float: left;
		}
		.joinContainer:nth-child(1) {
			margin-right: 2%;
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
		.nivoSlider {
			box-shadow: none !important;
		}
		.nivoSlider img {
			max-height: 600px;
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
			div.contentRow1 article {
				width: 100%;
				display: block !important;
			}
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
	<script src="resources/nivo/hammer.min.js"></script>
<script>
	$(document).ready(function(){
		
		// 메인화면 접속시 아이디 입력창에 커서 위치
		$("#id").focus();
		
		$(window).load(function() {
			let Certify="${dbCertify}";
			if(Certify === "0") {
				alert("회원가입 이메일 인증을 안하셨습니다.");
				document.location.href="./";
			}
			alert("after ready load?");
		});
		
		if ("ontouchstart" in document.documentElement) {
		 
			$('#slider').nivoSlider({
			    effect: 'slideInLeft',
				animSpeed: 300,
				pauseTime: 2000
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
		 
		} else {
			$('#slider').nivoSlider({
			    effect: 'fade',
				animSpeed: 300,
				pauseTime: 2000
			});
		}
	});
</script>
</html>
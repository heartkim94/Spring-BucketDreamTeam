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
    * {
        margin:0;
        padding:0;
        border:0;
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
    </style>

</head>
<body>
<header>
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
<!-- 부트스트랩 (header.jsp 위로두면 안먹음)-->
<!-- 	 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>		 -->
</html>
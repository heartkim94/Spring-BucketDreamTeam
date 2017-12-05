<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<title>header</title>
	<link rel="stylesheet" href="/project/resources/css/normalize.css" >
	<link rel="stylesheet" href="/project/resources/css/style.css" >
	<link rel="stylesheet" href="/project/resources/css/header.css" >
	<script src="/project/resources/js/prefixfree.min.js"></script>
	<script src="//code.jquery.com/jquery-3.1.0.min.js"></script>
</head>

<body>
	<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
        <c:if test="${id != null}">
          	<a class="navbar-brand" href="/project/group/main.do">Dogether</a>
        </c:if>
        <c:if test="${id == null}">
			<a class="navbar-brand" href="/project/home.do"><strong>Dogether</strong></a>		
		</c:if>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      
      
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#">About Us</a></li>
        <li><a href="#">Portfolio</a></li>
        <li><a href="#">Contact Us</a></li>
        <li class="dropdown">
          <c:if test="${id != null}">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">마이페이지 <b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="#">Action</a></li>
       		<li><a href="/project/mypage.do">회원정보 수정</a></li>
			<li><a href="/project/myInfoDelForm.do">회원탈퇴</a></li>
            <li class="divider"></li>
            <li><a href="/project/logout.do">로그아웃</a></li>
          </ul>
          </c:if>
        </li>
        
        
        
      </ul>
    </div><!-- /.navbar-collapse -->
      </div><!-- /.container-collapse -->
  </nav>
	<hr>
</body>
	<!-- 부트스트랩 (header.jsp 위로두면 안먹음)-->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>		
</html>
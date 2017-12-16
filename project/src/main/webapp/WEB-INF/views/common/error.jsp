<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/project/resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<style>
	.errorPageContainer {
		position: fixed;
		width: 100%;
		height: 100%;
		background-color: #f8f6f3; 
	}
	.errorPageContainer div {
		position: absolute;
		top: 50%;
		left: 50%;
		width: 500px;
	    height: 500px;
	    text-align: center; 
	}
	.errorPageContainer div h1{
		font-size: 100px;
	}
	.errorPageContainer img {
		width: 300px;
		height: 300px;
	}
	 @media (max-width: 1024px) { 
	 	
     }
     @media (max-width: 560px) {
     	.errorPageContainer div {
     		width: 300px;
	    	height: 300px;
     	}
     	.errorPageContainer img {
			width: 150px;
			height: 150px;
		}
		.errorPageContainer div h1{
			font-size: 50px;
		}
     }
</style>
<title>error</title>
</head>
<body>
	<div class="errorPageContainer">
		<div>
			<article>
				<img src="resources/img/흐엉.jpg"alt="홈페이지 소개 사진이나 글, 슬라이드"><br>
			</article>
			<h1>{<c:out value="${msg1 }"/>}</h1>
			<p><c:out value="${msg }" /></p>
			<c:if test="${id != null}">
				<a href="/project/group/main">main으로</a>
			</c:if>
			<c:if test="${id == null}">
				<a href="/project/home">main으로</a>
			</c:if>
		</div>
	</div>
	<!-- wrapper End -->
</body>
<script>
	$(document).ready(function() { 
		size();
		position();
	});
	function size() {
		// 브라우저 크기에 맞춰 로딩화면 100% 맞추기
		let windowH = $(window).height();
		let log = $('.errorPageContainer');
		log.css('height', windowH);
	}
	
	/* 로딩화면 안 내용 영역 브라우저의 정 중앙에 맞추기 */
	function position() {
		let div = $('.errorPageContainer > div');
		let ht = div.height() / 2;
		let wt = div.width() / 2;
		console.log("width: "+wt);
		console.log("height: "+ht);
		div.css({
			'margin-top' : -ht,
			'margin-left' : -wt
		});
	}
</script>
</html>
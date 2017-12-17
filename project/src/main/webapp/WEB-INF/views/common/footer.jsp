<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>footer</title>
<script>
	$(function(){
		footerWidth();
		$(window).resize(function(){
			footerWidth();
			footerPosition();
		});
		footerPosition();
	})
	function footerWidth(){
		let windowWh = $(window).width();
		console.log(windowWh);
		if(windowWh >1024){
			$("footer").css({
				"position": "fixed",
				"bottom" : "0",
				"z-index" : "100"
			});
		}else {
			$("footer").css({
				"position": "relative",
			});
		}
	}
	function footerPosition(){
		if(${id != null}){
			$("footer").css({
				"position": "relative",
			});
		}
	}
</script>
<style>
/* 푸터 스타일 */
	footer {
		width: 100%;
	    background: rgba(0, 0, 0, 0.5);
	}
	
	footer .foot {
		width: 1024px;
		padding: 5px 0;
		margin: 0 auto;
		text-align: center;
		clear: both;
	    letter-spacing: 2px;
	    color: #fff;
	}
	.foot a {
		color: #fff;
	}
	footer a:hover {
		color: orange;
	}
	/* footer response style */
    @media (max-width: 1024px) {
  		footer .foot{
  			width: 100%;
  		}
    }
</style>
</head>
<body>
	<footer>
		<div class="foot">
			<div>
				<c:forEach var="board" items="${communityBoardList}"
					varStatus="status">
					<a href="/project/community/list?pageNum=1&boardNum=${board.boardNum}">
						<strong>${board.boardName}</strong>
					</a>
					<c:if test="${!status.last}">&nbsp;&nbsp;&nbsp;</c:if>
				</c:forEach>
			</div>
			<div>
				<p class="text-center">
					<small>Copyrightⓒ  2017 dogether All rights reserved.</small>
				</p>
			</div>
		</div>
	</footer>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="/project/resources/css/group.css" >
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<style>
		.calendar {
			border-collapse: collapse;
		}
		.calendar td {
			border: 1px solid black;
			width: 100px;
			height: 100px;
		}
	</style>
</head>
<body>
<%@ include file="../common/header.jsp" %>
	<div id="wrapper">
		<section>
			<div class="container groupContainer">
				<%@ include file="asideMenu.jsp" %>
				<div class="groupMain">
					내용<br>
					asdsdaf<br>
				</div>
				<%@ include file="asideApp.jsp" %>
				<div class="clear"></div>
			</div>
		</section>
		<%@ include file="../common/footer.jsp" %>
	</div> <!-- wrapper End -->
</body>
</html>
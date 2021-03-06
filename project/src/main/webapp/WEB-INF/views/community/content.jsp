<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>글 상세 보기</title>
</head>
<body>
	<div id="wrapper">

		<%@ include file="../common/header.jsp" %>
		<section> 
			<div class="container subContent">
				<nav>
					<c:if test="${boardNum == 1}">
						<h1>NOTICE</h1>
						<span>home > community > notice</span>
					</c:if>
					<c:if test="${boardNum == 2}">
						<h1>QnA</h1>
						<span>home > community > QnA</span>
					</c:if>
				</nav>
				<%@ include file="../common/content.jsp" %>
			</div>
		</section>
		<%@ include file="../common/footer.jsp" %>

	</div>
	<!-- wrapper End -->
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<nav>
		<c:if test="${boardNum == 1}">
			<h1>NOTICE</h1>
			<span>home > community > notice</span>
		</c:if>
		<c:if test="${boardNum == 2}">
			<h1>QnA</h1>
			<span>home > community > QnA</span>
		</c:if>
		<c:if test="${boardNum == 3}">
			<h1>FAQ</h1>
			<span>home > community > FAQ</span>
		</c:if>
	</nav>

</body>
</html>
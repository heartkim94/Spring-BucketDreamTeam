<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>새 그룹 만들기</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/header.jsp" %>
		<section>
			<div class="container">
				<form method="post" action="new" id="groupForm">
					<h3>그룹</h3>
					<hr>
					<input type="hidden" name="groupOwnerId" value="${id}">
					<input type="hidden" name="profileImg" value="${profileImg}">
					<label>이름: &nbsp;<input type="text" id="groupName" name="groupName"></label><br>
					<label>분류: &nbsp;
						<select name="catNum" form="groupForm">
							<c:forEach var="cat" items="${catList}">
								<option value="${cat.catNum}">
									<c:if test="${cat.parentNum!=0}">&nbsp;  </c:if>
									${cat.catName}
								</option>
							</c:forEach>
						</select>
					</label><br>
					<label><a href="javascript:void(window.open('/project/group/profileImg', '_blank','width=350, height=460'))">그룹 메인 설정</a></label><br>
					<h3>목표</h3>
					<hr>
					<a href="javascript:void(window.open('/project/group/goalSettingForm', '_blank','width=450, height=300'))">목표 설정</a>
					<!--menubar, status, resizable, titlebar, location, top, left -->
					<br><br>
					<input type="submit" value="만들기">
				</form>
			</div>
		</section>
		<%@ include file="../common/footer.jsp" %>
	</div> <!-- wrapper End -->
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>새 그룹 만들기</title>
<!-- 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/header.jsp" %>
		<section>
			<div class="container">
				<div class="makeGroup">
					<form method="post" action="new" id="groupForm">
						<h3>그룹 만들기</h3>
						<input type="hidden" name="groupOwnerId" value="${id}">
						<input type="hidden" name="profileImg" value="${profileImg}">
						<div class="inputGroupName">
							<label class="nameLabel" for="groupName">이름: </label>
							<input type="text" id="groupName" name="groupName" placeholder="group이름 입력" />
						</div>
						<div class="kind">
							<label>분류: &nbsp;
								<select name="catNum" form="groupForm">
									<c:forEach var="cat" items="${catList}">
										<option value="${cat.catNum}">
										<c:if test="${cat.parentNum!=0}">&nbsp;  </c:if>
										${cat.catName}
									</option>
									</c:forEach>
								</select>
							</label>
						</div>
						<div class="profileImg">
							<label>
								<a href="javascript:void(window.open('/project/group/profileImg', '_blank','width=350, height=510'))">그룹 메인 설정</a>
							</label>
						</div>
<!-- 						<h3>목표</h3> -->
<!-- 						<hr> -->
<!-- 						<a href="javascript:void(window.open('/project/group/goalSettingForm', '_blank','width=450, height=300'))">목표 설정</a> -->
<!-- 						menubar, status, resizable, titlebar, location, top, left -->
<!-- 						<br><br> -->
						<div class="btnArea">
							<input type="submit" value="만들기">
							<a href="/project/home" class="cancelBtn"><span>취소</span></a>
						</div>
					</form>
				</div>
			</div>
		</section>
		<%@ include file="../common/footer.jsp" %>
	</div> <!-- wrapper End -->
</body>
<style>
	#groupForm h3 {
		padding-bottom: 20px;
	}
	.makeGroup {
		width: 800px;
		margin: 0 auto;
		padding: 100px 0;
	}
	.nameLabel {
		overflow: hidden;
	    position: absolute;
	    height: 1px;
	    width: 1px;
	}
	.inputGroupName, .kind, .profileImg {
		width: 100%;
		height: 50px;
		margin-bottom: 20px;
		text-align: center;
	}
	input#groupName {
	    position: relative;
	    width: 100%;
	    height: 100%;
	    border: none;
	    padding: 0;
	    background: 0 0;
	    line-height: 54px;
	    border-bottom: 1px solid #ccc;
	    font-size: 30px;
	    font-weight: 400;
	    color: #333;
	}
	.kind {
		padding: 0 0 50px 0;
	}
	.profileImg a {
	    width: 100%;
	    height: 100%;
	    background-color: #5c5b65;
	    color: #fff;
	    display: block;
	    line-height: 3;
	    overflow: hidden;
	}
	.btnArea {
		width: 100%;
		text-align: center;
    	padding: 20px 0;
	}
	input[value="만들기"], a.cancelBtn {
		display: inline-block;
	    margin: 0 0 0 15px;
	    padding: 5px 30px;
	    color: #fff;
	    font-weight: 500;
	    font-size: 14px;
	    border-radius: 2px;
	    background: #5c5b65;
	    cursor: pointer;
	 	outline: none;
	 	border: none;
	}
	a.cancelBtn {
		background-color: #fff;
		border: 1px solid #e0e0e0;
		box-sizing: border-box;
		color: #111;
	}
	footer {
		position: fixed !important;
		bottom: 0;
	}
	
	 @media (max-width: 1024px) { 
	 	section .container {
	 		width: 100%;
	 	}
     }
     @media (max-width: 768px) {
     	.makeGroup {
     		width: 100%;
     	}
  	 }
     @media (max-width: 660px) {
     }
</style>
</html>
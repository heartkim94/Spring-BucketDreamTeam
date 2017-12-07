<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>목표 설정</title>
	<style >
		
	</style>
	<link rel="stylesheet" href="/project/resources/css/group.css">
	<script src="//code.jquery.com/jquery-3.1.0.min.js"></script>
	<script>
		function setGoal(){
			let f = document.goalSettingForm;
			if($("#goal").val() == ""){
				alert("목표를 입력해주세요");
			}else{
				alert("목표 : "+$("#goal").val());
				//
				f.submit();
			}
		}
	
// 		function temp() {
// 			$.ajax({
// 				url:"project/group/setGoal",
// 				data:{
					
// 				},
// 				success:function(data){
					
// 				}
// 			});
// 		}
	</script>
</head>
<body>
	<div class="wrapper">
		<section>
			<h3>목표 설정</h3>
			<hr>
			<form action="setGoal" method="post" name="goalSettingForm" id="goalSettingForm">
				<div class="setGoalWrap">
					<input type="hidden" name="" value="">
					
					<table>
						<tr>
							<td>목표를 text로 설정 : </td>
							<td><input type="text" name="goal" id="goal"></td>
						</tr>
						<tr>
							<td>기한을 date로 설정 : </td>
							<td><input type="date" name="deadline" id="deadline"></td>
						</tr>
						<tr>
							<td align="right" colspan="2">
								<a href="javascript:setGoal();">확인</a>
								<a href="javascript:self.close();">취소</a>
						<!--	<button type="submit" onclick="javascript:setGoal();">확인</button> -->
						<!--	<button type="reset" onclick="javascript:self.close();">취소</button> -->
							</td>
						</tr>
					</table>
				</div>
			</form>
		</section>
	</div>
</body>
</html>
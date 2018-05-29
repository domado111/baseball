<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
		<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
		<style type="text/css">
			body{
				font-family: 'Nanum Gothic', sans-serif;
			}
			a{
				text-decoration: none;
			}
		</style>
	</head>
	<body>
		<div class="w3-container w3-center w3-padding w3-text-white" style="height: 60px; background-color: rgba(255,255,255,0.3);">
			<div class="w3-bar">
				<div class="w3-bar-item"><a href="manager">회원 관리</a></div>
				<div class="w3-bar-item"><a href="stats">데이터 통계</a></div>				
				<button class="w3-button w3-round w3-orange w3-hover-amber w3-text-white w3-hover-text-white" onclick="location.href='logout'">로그아웃</button>				
			</div>			
		</div>
	</body>
</html>
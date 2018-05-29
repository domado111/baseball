<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/table.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/sakura.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/btn.css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/sakura.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/btn.js"></script>
<title>관리자/접속 데이터</title>
</head>
<body>
	<canvas id="sakura"></canvas>
	<jsp:include page="header.jsp" />
	<c:if test="${dateList eq 'noData'}">
		<div align="center">
			<span style="color: white;"><b>게임 데이터가 없습니다.</b></span>
		</div>
	</c:if>
	<c:if test="${dateList ne 'noData'}">
		<div align="center">
			<span style="color: white"><b>"2018-00-00" 형식으로 입력해주세요</b></span>
			<form action="stats" method="get">
				<input type="text" name="date"> <input
					class="w3-button w3-red" type="submit" value="입력">
			</form>
			<h2>일별 게임 실행 수(7일)</h2>
			<img src='<%=request.getContextPath()%>/rimg/dailyData.jpg'>

		</div>
		<div style="padding-top: 10px">
			<table align="center"
				class="w3-table w3-border w3-bordered w3-centered"
				style="width: 900px;">
				<tr>
					<td class="w3-red" style="width: 80px">날짜</td>
					<c:forEach var="dates" items="${dateList}">
						<td>${dates}</td>
					</c:forEach>
				</tr>
				<tr>
					<td class="w3-red" style="width: 80px">값</td>
					<c:forEach var="values" items="${countList}">
						<td>${values}</td>
					</c:forEach>
				</tr>
			</table>
		</div>
	</c:if>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

</head>
<body>
<div align="center" style="padding:50px">
	 <p class="w3-xxlarge w3-lobster">Game Over</p>
	<table class="w3-table w3-bordered w3-centered" style="width:300px">
		<tr>
			<td>name</td><td>승패</td><td>point</td>
		</tr>
		<tr>
			<td><b>${winner }</b></td>
            <td><span style="color:red"><b>WIN</b></span></td>
            <td><span style="color:orange"><b>+${point }</b></span></td>
		</tr>
		<c:forEach var="loser" items="${loseList}"  >
		<tr>
			<td><b>${loser }</b></td>
            <td><span style="color:blue"><b>LOSE</b></span></td>
            <td><span style="color:orange"><b>+100</b></span></td>
		</tr>
		</c:forEach>
	</table>
</div>

</body>
</html>
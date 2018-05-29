<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<c:forEach var="user" items="${users }">
	<div class="w3-row w3-padding">
		<div class="w3-cell-row">
			<div class="w3-cell w3-left">
				${user.nickname }
			</div>
			<div class="w3-cell w3-right">
				<input type="button" class="w3-button w3-orange w3-text-white w3-hover-text-white w3-hover-amber w3-round" id="btn${user.user_num}" value="친구 요청" onclick="addFriend('${user.id}','${user.user_num}')" />
			</div>	
		</div>
	</div>
</c:forEach>
</body>
</html>
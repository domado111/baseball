<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
		<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/table.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/sakura.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/btn.css">
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/sakura.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/btn.js"></script>
		<script type="text/javascript">			
			function leave(id) {
				if(confirm("정말 삭제하겠습니까?")){
					deleteUser(id);
					alert("삭제되었습니다.");
				}else{					
					
				}
			}
			
			function update(formnum) {
				document.getElementById(formnum).submit();
			}
			
			function deleteUser(id) {
				location.href='delete?id='+id;
			}
			
			function cancle(formnum,usernum) {
				document.getElementById(formnum).reset();
				document.getElementById(usernum).style.display='none';
			}
		</script>
		<title>관리자/회원 목록</title>
	</head>
	<body>
		<canvas id="sakura"></canvas>
		<jsp:include page="header.jsp" />
		<div class="w3-container" style="margin: 50px 250px;">
			<div class="w3-center w3-padding-32">
				<span class="w3-large w3-text-white">회원 관리(${count })</span>
			</div>
			<div class="tbl-header">				
				 <table cellpadding="0" cellspacing="0" border="0">
					<thead>
						<tr>
							<th>아이디</th>
							<th>닉네임</th>
							<th>이메일</th>
							<th>게임 전적</th>
							<th>포인트</th>
							<th>가입일</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="tbl-content">
				<table cellpadding="0" cellspacing="0" border="0">			
					<tbody>
						<c:if test="${users.isEmpty() }">등록된 회원이 없습니다.</c:if>
						<c:if test="${!users.isEmpty() }">
							<c:forEach var="user" items="${users }" varStatus="status">								
								<tr class="w3-hover-orange" onclick="document.getElementById('user${status.count}').style.display='block'" style="cursor: pointer;" >
									<td>${user.id }</td>
									<td>${user.nickname }</td>
									<td>${user.email }</td>
									<td>${user.win_count }승 ${user.lose_count }패</td>
									<td>${user.point }</td>
									<td>${user.reg_date }</td>									
								</tr>								
								<div id="user${status.count }" class="w3-modal">
									<div class="w3-modal-content" style="width: 500px;">
										<div class="w3-container" style="background-color: #2E2E2E;">
											<form action="update" method="post" id="updateForm${status.count }">
												<div class="w3-section">
													<label class="w3-left w3-text-orange">아이디</label>										
													<div class="w3-cell-row">														
														<input type="text" name="id" value="${user.id }" class="w3-input w3-border w3-round w3-grey" readonly required />														
													</div>
												</div>	
												<div class="w3-section">
													<label class="w3-left w3-text-orange">닉네임</label>
													<div class="w3-cell-row">
														<input type="text" name="nickname" value="${user.nickname }" class="w3-input w3-border w3-round" required />
													</div>
												</div>
												<div class="w3-section">
													<label class="w3-left w3-text-orange">이메일</label>
													<div class="w3-cell-row">
														<input type="text" name="email" value="${user.email }" class="w3-input w3-border w3-round" required />														
													</div>
												</div>
												<div class="w3-section">
													<label class="w3-left w3-text-orange">게임 전적</label>
													<div class="w3-cell-row">														
														<div class="w3-cell">														
															<input type="text" name="win_count" value="${user.win_count }" class="w3-input w3-border w3-round" required />
														</div>
														<div class="w3-cell">
															<input type="text" name="lose_count" value="${user.lose_count }" class="w3-input w3-border w3-round" required />
														</div>													
													</div>
												</div>
												<div class="w3-section">
												<label class="w3-left w3-text-orange">포인트</label>
													<div class="w3-cell-row">
														<input type="text" name="point" value="${user.point }" class="w3-input w3-border w3-round" required />																													
													</div>
												</div>
												<div class="w3-section">
													<div class="w3-row">				
														<div class="button_base b05_3d_roll" onclick="update('updateForm${status.count}')" style="margin-top: 30px;">											
															<div>회원 정보 수정</div>
															<div>회원 정보 수정</div>
														</div>
													</div>
													<div class="w3-row">				
														<div class="button_base b05_3d_roll" onclick="leave('${user.id }')" style="margin-top: 30px;">											
															<div>회원 삭제</div>
															<div>회원 삭제</div>
														</div>
													</div>
													<div class="w3-row">	
														<div class="button_base b05_3d_roll" onclick="cancle('updateForm${status.count}','user${status.count }')" style="margin-top: 30px;">
															<div>취소</div>
															<div>취소</div>
														</div>
													</div>
												</div>
											</form>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</body>	
</html>
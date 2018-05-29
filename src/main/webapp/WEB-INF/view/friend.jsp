<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>		
	</head>
	<body>
		<div class="w3-row w3-round w3-center w3-text-white" style="min-height: 470px; max-height: 470px; overflow: auto;">		
			<div class="w3-row w3-border-grey">
				<div class="w3-panel">
					<span class="w3-row w3-large">수신한 친구 요청</span>
					<c:if test="${receive.isEmpty() }">
						<span class="w3-row">친구 요청 받지 않음</span>
					</c:if>
					<c:if test="${!receive.isEmpty() }">
					<div class="w3-section">
						<c:forEach var="friend" items="${receive }">
							<form action="friend/confirm" method="post">
								<div class="w3-row w3-margin-top" style="border-bottom: 1px solid grey;">
									<span class="w3-left">${friend.nickname }</span>
									<div class="w3-right">
										<div>
											<input type="hidden" name="friendid" value="${friend.id }" />
											<input type="submit" class="" value="수락" />
											<input type="button" onclick="location.href='friend/reject?friendid=${friend.id}'" value="거절" />
										</div>
									</div>
								</div>
							</form>
						</c:forEach>
					</div>
					</c:if>
				</div>
				
				
				<div class="w3-panel">
					<span class="w3-row w3-large">친구 요청 전송</span>
					<c:if test="${send.isEmpty() }">
						<span class="w3-row">전송한 친구 요청 없음</span>
					</c:if>
					<c:if test="${!send.isEmpty() }">
						<c:forEach var="friend" items="${send }">
							<form action="friend/cancle" method="post">
								<div class="w3-row w3-margin-top" style="border-bottom: 1px solid grey;">
									<span class="w3-left">${friend.nickname }</span>
									<div class="w3-right">
										<input type="hidden" name="friendid" value="${friend.id }" />
										<input type="submit" value="요청 취소" />
									</div>
								</div>
							</form>
						</c:forEach>
					</c:if>							
				</div>
				<div class="w3-panel">
					<span class="w3-row w3-large">친구 목록</span>
					<c:if test="${friendlist.isEmpty() }">
						등록된 친구 없음
					</c:if>
					<c:if test="${!friendlist.isEmpty() }">
						<div class="w3-section">
							<c:forEach var="friend" items="${friendlist }">
								<div class="w3-row w3-margin-top" style="border-bottom: 1px solid grey;">	
									<div class="w3-left" >									
										<div class="w3-row">
											<span class="">${friend.nickname }</span>
										</div>										
										<c:if test="${friend.status==0 }">
											<div class="w3-row">
												<span class="w3-cell-middle w3-text-red">오프라인</span>
											</div>
										</c:if>
										<c:if test="${friend.status==1 }">											
											<div class="w3-row">
												<span class="w3-cell-middle w3-text-green">온라인</span>
											</div>
										</c:if>
										<c:if test="${friend.status==2 }">											
											<div class="w3-row">
												<span class="w3-cell-middle w3-text-yellow">게임 중</span>
											</div>
										</c:if>							
									</div>										
									<div class="w3-right">											
										<form action="friend/group">
											<div class="w3-padding-16">
												<input type="hidden" name="usernum" value="${friend.user_num }" />	
												<input type="submit" class="" value="그룹 초대"/>
											</div>
										</form>											
									</div>
								</div>
							</c:forEach>
						</div>								
					</c:if>
				</div>					
			</div>			
		</div>
	</body>
</html>
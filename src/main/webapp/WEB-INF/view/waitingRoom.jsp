<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
		<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/btn.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/bg.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/tab.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/table.css">
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/httpRequest.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/bg.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/tab.js"></script>		
		<style type="text/css">
			body{
				font-family: 'Nanum Gothic', sans-serif;
				background: #3E92A3;
			}
			::-webkit-scrollbar {
				width: 8px; 
				height: 0px; 
				border:0;
			}		
			::-webkit-scrollbar-track {
				background: #fff;
				-webkit-border-radius: 0px;
				border-radius:0px;
			}		
			::-webkit-scrollbar-thumb {
				height: 2px; 
				width: 50px; 
				background: orange; 
				-webkit-border-radius: 0px; 
				border-radius: 0px;
			}	
		</style>		
		<script type="text/javascript">
			function toList(id) {				
				var params = "id=" + encodeURIComponent(id);
				sendRequest("friend/list", params, fromList, "POST");
				var x = document.getElementById("list");
				  if (x.className.indexOf("w3-show") == -1) {
				      x.className += " w3-show";
				  } else { 
				      x.className = x.className.replace(" w3-show", "");
				  }
			}
	
			function fromList() {
				if (httpRequest.readyState == 4) {
					if (httpRequest.status == 200) {
						document.getElementById("friend").innerHTML = httpRequest.responseText;
					}
				}
			}
			
			function toInfo(id) {				
				var params = "id=" + encodeURIComponent(id);
				sendRequest("user/info", params, fromInfo, "POST");
			}
	
			function fromInfo() {
				if (httpRequest.readyState == 4) {
					if (httpRequest.status == 200) {
						openInfo();
						document.getElementById("userinfo").innerHTML = httpRequest.responseText;
					}
				}
			}
			function leave(id) {
				if(confirm("정말 탈퇴하시겠습니까?")){					
					deleteUser(id);
				}
			}
			
			function checkNick() {
				inputnick=document.getElementById('nickname').value;
				var params = "nickname=" + encodeURIComponent(inputnick);
				sendRequest("user/checknick", params, checkResult, "GET");
				
				function checkResult() {				
					if (httpRequest.readyState == 4) {
						if (httpRequest.status == 200) {
							var data = httpRequest.responseText;
							
							if(inputnick==""){
								document.getElementById('nickname').style.backgroundColor="white";
								document.getElementById('updatebtn').style.pointerEvents = "auto";
							} else if(data=="1"){								
								document.getElementById('nickname').style.backgroundColor="red";
								document.getElementById('updatebtn').style.pointerEvents = "none";
							} else if(data=="0"){
								document.getElementById('nickname').style.backgroundColor="green";
								document.getElementById('updatebtn').style.pointerEvents = "auto";
							}
						}
					}
				}
			}
			
			function checkEmail() {
				inputemail = document.getElementById('email').value;
				var params = "email=" + encodeURIComponent(inputemail);
				sendRequest("user/checkemail", params, checkResult, "GET");
				
				function checkResult() {				
					if (httpRequest.readyState == 4) {
						if (httpRequest.status == 200) {
							var data = httpRequest.responseText;
							
							if(inputemail==""){
								document.getElementById('email').style.backgroundColor="white";
								document.getElementById('updatebtn').style.pointerEvents = "auto";
							} else if(data=="1"){								
								document.getElementById('email').style.backgroundColor="red";
								document.getElementById('updatebtn').style.pointerEvents = "none";
							} else if(data=="0"){
								document.getElementById('email').style.backgroundColor="green";
								document.getElementById('updatebtn').style.pointerEvents = "auto";
							}
						}
					}
				}
			}
						
			function checkPwd() {
				inputpwd=document.getElementById('password').value;
				inputconfirm = document.getElementById('confirmpassword').value;
				
				if(inputconfirm=="" || inputpwd != inputconfirm){
					document.getElementById('confirmpassword').style.backgroundColor="red";
					document.getElementById('updatebtn').style.pointerEvents = "none";
				} else if(inputpwd == inputconfirm) {
					document.getElementById('confirmpassword').style.backgroundColor="green";
					document.getElementById('updatebtn').style.pointerEvents = "auto";
				} else if(inputpwd=="" || (inputpwd=="" && inputconfirm=="")){
					document.getElementById('confirmpassword').style.backgroundColor="white";
					document.getElementById('updatebtn').style.pointerEvents = "auto";
				}
			}
			
			function gameStart() {
				setTimeout(() => {
					location.href="<%=request.getContextPath()%>/game/play";
				}, 1500);
				var x = document.getElementById("gamebtn");
				x.value="입장 중";
				if (x.className.indexOf("w3-spin") == -1) {
				    x.className += " w3-spin";
				} else { 
				    x.className = x.className.replace(" w3-spin", "");
				}
			}
			
			function friendSearch() {
				input=document.getElementById('search').value;
				var params = "nickname=" + encodeURIComponent(input);
				sendRequest("friend/search", params, searchResult, "GET");
				
				function searchResult() {				
					if (httpRequest.readyState == 4) {
						if (httpRequest.status == 200) {
							var data = httpRequest.responseText;
							
							document.getElementById('searchresult').innerHTML = data;
						}
					}
				}
			}
			
			function addFriend(friendid,friendnum) {
				var params = "id=" + encodeURIComponent(friendid);
				sendRequest("friend/addFriend", params, addResult, "GET");
				
				function addResult() {
					if (httpRequest.readyState == 4) {
						if (httpRequest.status == 200) {
							var data = httpRequest.responseText;
							
							if(data=="success"){
								document.getElementById('btn'+friendnum).value="요청 완료";
								document.getElementById('btn'+friendnum).style.backgroundColor="grey";
								document.getElementById('btn'+friendnum).disabled="disabled";
							}
						}
					}
				}
			}
			
			function openSearch() {
				document.getElementById('friendsearch').style.display='block';
			}			
			function closeSearch() {
				document.getElementById('friendsearch').style.display='none';
				document.getElementById('searchresult').innerHTML = "";
				document.getElementById('search').value="";
			}
			
			function openInfo() {
				document.getElementById('userinfo').style.display='block';
			}			
			function closeInfo() {
				document.getElementById('userinfo').style.display='none';
			}
			
			
			
			function openMyInfo() {
				document.getElementById('myinfo').style.display='block'
			}
			
			function pointCheck() {
				var point=document.getElementById("point").value;
					
				if(point < 10000){
					
					return 0;
				}
				return 1;
			}
			
			function update() {
				nick = document.getElementById("nickname").value;
				pwd = document.getElementById("password").value;
				if(pointCheck()== 0){					
					var params = "nickname=" + encodeURIComponent(nick);
					sendRequest("user/changenickCheck", params, nickResult, "GET");
					
					function nickResult() {
						if (httpRequest.readyState == 4) {
							if (httpRequest.status == 200) {
								var data = httpRequest.responseText;
								
								if(data=="change"){
									alert("닉네임 변경에 필요한 게임 포인트가 부족합니다.");
									document.getElementById("nickname").style.backgroundColor="white";									
									document.getElementById('updateForm').reset();
								} else if(data=="notchange"){									
									document.getElementById('updateForm').submit();
									alert("정보가 변경되었습니다.");
								}
							}
						}
					}					
				} else if(pointCheck() == 1){					
					document.getElementById('updateForm').submit();
					alert("정보가 변경되었습니다.");
				}				
			}
			
			function deleteUser(id) {
				location.href='user/delete?id='+id;
			}
			
			function cancle() {
				document.getElementById('confirmpassword').style.backgroundColor="white";
				document.getElementById('nickname').style.backgroundColor="white";
				document.getElementById('email').style.backgroundColor="white";
				document.getElementById('updateForm').reset();
				document.getElementById('myinfo').style.display='none';
			}
			
			var webSocket = new WebSocket('ws://211.238.142.37:8080<%=request.getContextPath()%>/waitingRoom?nickname='+encodeURIComponent('${nickname}')
					+"&id="+encodeURIComponent('${id}'));

			webSocket.onerror = function(event) {onError(event)};
			webSocket.onmessage = function(event) {onMessage(event)};

			function onMessage(event) {
				if (event.data.includes("@online@")){
					var strArray=event.data.split('#');
					//strArray[0]:키 strArray[1]:전체유저 nickname strArray[2]:전체 유저 수  strArray[3]: 전체 유저 id
		    		document.getElementById("ucount").innerHTML=strArray[2];
					
					
					var userArray=strArray[1].split(':');
					var idArray=strArray[3].split(':');
					//userArray[0]:키(list) userArray[1]:nickname ...
					//idarray[0]:키(list) idArray[1]:id..
					document.getElementById("onlineList").innerHTML="";
					for(var i=1;i<userArray.length;i++){
						document.getElementById("onlineList").innerHTML+="<div class='w3-row' onclick='toInfo("+'"'+idArray[i]+'"'+")' style='cursor: pointer;'>"+userArray[i]+"</div>";
		    		}
					

				}else{
					document.getElementById("chat").innerHTML += "<div class='w3-text-black w3-row'>"+event.data+"</div>";
					document.getElementById("chat").scrollTop=document.getElementById('chat').scrollHeight;
				}
				
			}

			function onError(event) {alert(event.data);}

			function send() {				
				webSocket.send(document.getElementById('inputMessage').value);
				document.getElementById('inputMessage').value = "";
			}
		</script>
		<title>대기실</title>
	</head>
	<body>
		<canvas id="snow"></canvas>
		<div class="w3-container" style="background-color: #2E2E2E; margin: 70px 300px; padding-top: 20px;">
			<div class="w3-row">
				<div class="w3-cell-row w3-padding">
					<div class="w3-cell w3-third w3-center w3-text-black">
						<div class="w3-row w3-round-large w3-padding-16" style="background-color: #DFE0D4; height: 100px;">
							<div class="w3-row">
								${user.nickname }
							</div>
							<div class="w3-row">
								${user.win_count }승 / ${user.lose_count }패
							</div>
							<div class="w3-row">
								${user.point } point
							</div>
						</div>
					</div>
					<div class="w3-cell w3-third w3-center">
						<div class="w3-row w3-padding-16">
							<div class="page">
								<button class="fun-btn" id="gamebtn" onclick="gameStart()" >게임 시작</button>							
							</div>
						</div>
					</div>
					<div class="w3-cell w3-third w3-center w3-text-white">
						<div class="w3-row w3-round-large" style="background-color: #DFE0D4; height: 100px; padding: 25px 0;">
							<div class="w3-cell-row">
								<div class="w3-cell">
									<div class="button-container-1">
										<span class="mas">개인정보 수정</span>
									    <button type="button" class="w3-round" onclick="openMyInfo()" >개인정보 수정</button>
									</div>
									<div id="myinfo" class="w3-modal" style="padding-top: 80px;">
									    <div class="w3-modal-content" style="width: 500px;">
											<div class="w3-container" style="background-color: #2E2E2E;">
												<form action="user/update" method="post" id="updateForm">
													<div class="w3-section">
														<label class="w3-left w3-text-orange">아이디</label>										
														<div class="w3-cell-row">														
															<input type="text" name="id" value="${user.id }" class="w3-input w3-border w3-round w3-grey" readonly required />														
														</div>
													</div>	
													<div class="w3-section">
														<label class="w3-left w3-text-orange">닉네임<span class="w3-text-red w3-small">(변경시 1만포인트 차감)</span></label>
														<div class="w3-cell-row">
															<input type="text" name="nickname" id="nickname" value="${user.nickname }" class="w3-input w3-border w3-round" oninput="checkNick()" required />
														</div>
													</div>
													<div class="w3-section">
														<label class="w3-left w3-text-orange">비밀번호 변경</label>
														<div class="w3-cell-row">
															<input type="password" name="password" id="password" class="w3-input w3-border w3-round" oninput="checkPwd()" required />
														</div>
													</div>
													<div class="w3-section">
														<label class="w3-left w3-text-orange">비밀번호 확인</label>
														<div class="w3-cell-row">
															<input type="password" id="confirmpassword" class="w3-input w3-border w3-round" oninput="checkPwd()" required />														
														</div>
													</div>
													<div class="w3-section">
														<label class="w3-left w3-text-orange">이메일</label>
														<div class="w3-cell-row">
															<input type="text" name="email" id="email" value="${user.email }" class="w3-input w3-border w3-round" oninput="checkEmail()" required />														
														</div>
													</div>
													<div class="w3-section">
														<label class="w3-left w3-text-orange">게임 전적</label>
														<div class="w3-cell-row">														
															<div class="w3-cell">
																<input type="text" name="win_count" value="${user.win_count }" class="w3-input w3-border w3-round w3-grey" readOnly required />
															</div>
															<div class="w3-cell">
																<span>승</span>
															</div>
															<div class="w3-cell">
																<input type="text" name="lose_count" value="${user.lose_count }" class="w3-input w3-border w3-round w3-grey" readOnly required />
															</div>
															<div class="w3-cell">
																<span>패</span>
															</div>
														</div>
													</div>
													<div class="w3-section">
													<label class="w3-left w3-text-orange">포인트</label>
														<div class="w3-cell-row">
															<div class="w3-cell">
																<input type="text" name="point" id="point" value="${user.point }" class="w3-input w3-border w3-round w3-grey" readOnly required />
															</div>																												
														</div>
													</div>
													<div class="w3-section">
														<div class="w3-row">				
															<div class="button_base b05_3d_roll" id="updatebtn" onclick="update()" style="margin-top: 30px;">											
																<div>회원 정보 수정</div>
																<div>회원 정보 수정</div>
															</div>
														</div>
														<div class="w3-row">				
															<div class="button_base b05_3d_roll" onclick="leave('${user.id}')" style="margin-top: 30px;">											
																<div>회원 탈퇴</div>
																<div>회원 탈퇴</div>
															</div>
														</div>
														<div class="w3-row">	
															<div class="button_base b05_3d_roll" onclick="cancle()" style="margin-top: 30px;">
																<div>취소</div>
																<div>취소</div>
															</div>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
								<div class="w3-cell">
									<div class="button-container-1">
										<span class="mas">로그아웃</span>
									    <button type="button" class="w3-round" onclick="location.href='user/logout'" >로그아웃</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="w3-row">
				<div class="w3-cell-row w3-margin-top">
					<div class="w3-cell w3-quarter w3-center w3-padding-large w3-text-white" style="height: 650px;">
						<div class="w3-margin-top w3-round-large" style="background-color: #DFE0D4; height: 600px;">
							<div class="w3-row w3-padding-16" style="background-color: #323232;">
								<span class="w3-large w3-text-white">랭킹</span>
							</div>
							<div class="tbl-header w3-grey">
								<table cellpadding="0" cellspacing="0" border="0">
									<thead>
										<tr>
											<th style="padding: 12px 0; color: white;"></th>
											<th style="padding: 12px 0; color: white;">닉네임</th>
											<th style="padding: 12px 0; color: white;">포인트</th>
											<th style="padding: 12px 5px; color: white;">전적</th>
										</tr>
									</thead>
								</table>
							</div>
							<div class="tbl-content" style="height: 500px;">
							<c:forEach varStatus="ranknum" var="rank" items="${rank }">							
								<table class="w3-hover-orange w3-text-hover-white" onclick="toInfo('${rank.id}')" cellpadding="0" cellspacing="0" border="0" style="cursor: pointer;">
									<tbody>								
										<tr>
											<td class="w3-text-black" style="padding: 15px 20px;">${ranknum.count }</td>
											<td class="w3-text-black" style="padding: 10px 0;">${rank.nickname }</td>
											<td class="w3-text-black" style="padding: 10px 0;">${rank.point } pt</td>
											<td class="w3-text-black" style="padding: 10px 5px;">${rank.win_count } 승</td>
										</tr>
									</tbody>
								</table>							
							</c:forEach>
							</div>							
						</div>							
					</div>
					<div class="w3-cell w3-half w3-padding-large w3-margin-top" style="height: 650px;">
						<div class="w3-container w3-padding-16 w3-margin-bottom w3-round-large w3-left" id="chat" style="background-color: #DFE0D4; height: 530px; width: 560px; overflow: auto; word-wrap: break-word;"></div>
						<div class="w3-row">
							<div class="w3-cell-row w3-round-large">
								<div class="w3-cell">
									<input type="text" class="w3-input w3-round" id="inputMessage" size="51" onKeypress="javascript:if(event.keyCode==13) {send()}" style="background-color: #DFE0D4;" />
								</div>
								<div class="w3-cell">
									<input type="submit" class="btn-3d yellow" value="입력" onclick="send()" style="padding: 6px 20px; font-size: 15px;"/>
								</div>
							</div>
						</div>						
					</div>
					<div class="w3-cell w3-quarter w3-center w3-padding-large w3-text-white" style="height: 650px;">
						<div class="w3-row w3-margin-top w3-round-large" style="background-color: #DFE0D4; height: 600px;">							
							<ul class="tabs">
								<li class="tab-link current w3-half" data-tab="tab-1">
									<span>대기실(<b id="ucount"></b>)</span>
								</li>
								<li class="tab-link w3-half" data-tab="tab-2" onclick="toList('${id}')" >
									<span>친구(<b id="fcount">${friendcount }</b>)</span>
								</li>
							</ul>								 
							<div id="tab-1" class="tab-content current" style="height: 562px; overflow: auto; word-wrap: break-word;">
								<div id="onlineList" class="w3-container w3-left"></div>
								<div id="userinfo" class="w3-modal"></div>
							</div>
							<div id="tab-2" class="tab-content" style="overflow: auto; word-wrap: break-word;">
								<div id="list">
									<div id="friend" class="w3-row"></div>
									<div class="w3-row w3-cell-row">
										<div class="w3-padding-large">
											<div class="w3-container">
												<button onclick="openSearch()" class="simple_btn w3-round">친구 추가</button>
												<div id="friendsearch" class="w3-modal">
												    <div class="w3-modal-content" style="width: 400px; background-color: #2E2E2E;">
														<div class="w3-container  w3-center w3-padding">
															<div class="w3-row">
																<div class="w3-bar">
																	<div class="w3-bar-item">
																		<input type="text" class="w3-input" id="search" name="nickname" placeholder="닉네임 검색" onkeypress="javascript:if(event.keyCode==13) {friendSearch()}" />
																	</div>
																	<div class="w3-bar-item">
																		<input type="submit" class="w3-button w3-orange w3-hover-amber w3-text-white w3-hover-text-white w3-round" value="친구 찾기" onclick="friendSearch()" />
																	</div>
																</div>															        
															</div>
															<div class="w3-row" id="searchresult" style="height: 500px; overflow: auto;"></div>
															<div class="w3-row w3-margin">
																<button class="w3-button w3-orange w3-hover-amber w3-text-white w3-hover-text-white w3-round" onclick="closeSearch()" >창 닫기</button>
															</div>
														</div>	
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>							
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
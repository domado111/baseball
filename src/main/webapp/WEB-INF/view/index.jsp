<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
		<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/btn.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/form.css">
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/httpRequest.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/btn.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/index.js"></script>
		<style type="text/css">
			body{
				font-family: 'Nanum Gothic', sans-serif;
				background-image: url("img/intro.gif") ;
				background-repeat: no-repeat;
				background-size: cover;
				background-position: center;
				background-attachment: fixed;
			}
		</style>
		<script type="text/javascript">
			var inputid = "";
			var inputnick = "";
			var inputpwd = "";
			var inputconfirm = "";
			var inputemail = "";
			var idresult=0;
			var nickresult=0;
			var emailresult=0;
			var pwdresult=0;
			
			function checkID() {
				inputid=document.getElementById('id').value;
				var params = "id=" + encodeURIComponent(inputid);
				sendRequest("user/checkid", params, checkResult, "GET");
				
				function checkResult() {				
					if (httpRequest.readyState == 4) {
						if (httpRequest.status == 200) {
							var data = httpRequest.responseText;
							
							if(inputid==""){
								document.getElementById('id').style.backgroundColor="white";
								idresult=0;
							} else if(data=="1"){								
								document.getElementById('id').style.backgroundColor="red";
								idresult=0;
							} else if(data=="0"){
								document.getElementById('id').style.backgroundColor="green";
								idresult=1;
							}
						}
					}
					result();
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
								nickresult=0;								
							} else if(data=="1"){								
								document.getElementById('nickname').style.backgroundColor="red";
								nickresult=0;								
							} else if(data=="0"){
								document.getElementById('nickname').style.backgroundColor="green";
								nickresult=1;								
							}
						}
					}
					result();
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
								emailresult=0;								

							} else if(data=="1"){								
								document.getElementById('email').style.backgroundColor="red";
								emailresult=0;								
							} else if(data=="0"){
								document.getElementById('email').style.backgroundColor="green";
								emailresult=1;								
							}
						}
					}
					result();
				}
			}
						
			function checkPwd() {
				inputpwd=document.getElementById('password').value;
				inputconfirm = document.getElementById('confirmpassword').value;
				
				if(inputconfirm=="" || inputpwd != inputconfirm){
					document.getElementById('confirmpassword').style.backgroundColor="red";
					pwdresult=0;

				} else if(inputpwd == inputconfirm) {
					document.getElementById('confirmpassword').style.backgroundColor="green";
					pwdresult=1;
				} else if(inputpwd=="" || (inputpwd=="" && inputconfirm=="")){
					document.getElementById('confirmpassword').style.backgroundColor="white";
					pwdresult=0;

				}
				
				result();
			}
			
			function result() {
				if(idresult == 1 && pwdresult == 1 && nickresult == 1 && emailresult == 1){
					document.getElementById('signupbtn').style.pointerEvents = "auto";
				} else {
					document.getElementById('signupbtn').style.pointerEvents = "none";
				}
			}
			
			function loginCheck() {
				loginid = document.getElementById('loginid').value;
				loginpwd = document.getElementById('loginpwd').value;
				var params = "id=" + encodeURIComponent(loginid)+"&pwd=" + encodeURIComponent(loginpwd);
				sendRequest("user/login", params, checkResult, "GET");
				
				function checkResult() {
					if (httpRequest.readyState == 4) {
						if (httpRequest.status == 200) {
							var data = httpRequest.responseText;
							
							if(data=="loginfail"){
								alert("아이디나 비밀번호가 맞지 않습니다.");
							} else if(data=="loginsuccess") {
								window.location.href="waitingroom";
							} else if(data=="adminlogin") {
								window.location.href="admin/manager";
							}
						}
					}
				}
	
			}
			
			function findid() {
				valinick = document.getElementById('valinick').value;
				valiemail = document.getElementById('valiemail1').value;
				var params = "nickname=" + encodeURIComponent(valinick)+"&email=" + encodeURIComponent(valiemail);
				sendRequest("user/findcheck", params, findResult, "GET");
				
				function findResult() {
					if (httpRequest.readyState == 4) {
						if (httpRequest.status == 200) {
							var data = httpRequest.responseText;
							
							if(data == "1"){
								var params = "&email=" + encodeURIComponent(valiemail);
								sendRequest("user/findid", params, findResult1, "GET");
								
								function findResult1() {
									if (httpRequest.readyState == 4) {
										if (httpRequest.status == 200) {
											var data = httpRequest.responseText;
											
											alert(data);
										}
									}
								}
							} else if (data == "0"){
								alert("다시 한번 확인해주세요.");
							}
						}
					}
				}
			}
			
			function findpwd() {
				valiid = document.getElementById('valiid').value;
				valiemail = document.getElementById('valiemail2').value;
				var params = "id=" + encodeURIComponent(valiid)+"&email=" + encodeURIComponent(valiemail);
				sendRequest("user/findpwd", params, findResult, "GET");
				
				function findResult() {
					if (httpRequest.readyState == 4) {
						if (httpRequest.status == 200) {
							var data = httpRequest.responseText;
							
							if(data == "1"){
								var pwd = prompt("새로운 비밀번호를 입력하세요.");
								var repwd = prompt("비밀번호를 다시 한번 입력하세요.");
								
								if(pwd == repwd){
									var params = "id=" + encodeURIComponent(valiid)+"&pwd=" + encodeURIComponent(pwd);
									sendRequest("user/updatepwd", params, updateResult, "GET");
									
									function updateResult() {
										if (httpRequest.readyState == 4) {
											if (httpRequest.status == 200) {
												var result = httpRequest.responseText;
												
												if(result == "success"){
													alert("비밀번호가 변경되었습니다.");
													location.reload();
												}
											}
										}
									}
								} else if (pwd == null || repwd == null){
									alert("비밀번호가 없습니다.");
								} else{
									alert("비밀번호가 일치하지 않습니다.");
								}
							} else if (data == "0"){
								alert("다시 한번 확인해주세요.");
							}
						}
					}
				}
			}
		</script>
		<title>메인</title>
	</head>
	<body>
		<div class="w3-container" style="margin-top: 150px;">
			<div class="w3-row w3-center">
				<div class="w3-row">
					<img src="img/title.png"/>
				</div>
			</div>
			<div class="w3-row w3-center" style="margin-top: 100px;">
				<div class="w3-row">
					<button class="btn-3d yellow" onclick="openLogin()" style="width: 300px;" >로그인</button>					
				</div>
				<div class="w3-row">
					<button class="btn-3d yellow" onclick="openSignup()" style="width: 300px;" >회원가입</button>					
				</div>
			</div>
		</div>
		
		<div id="login" class="w3-modal" style="padding-top: 200px;">
			<div class="w3-modal-content" style="width: 500px;">
				<div class="w3-container" style="background-color: #2E2E2E;">
					<form action="user/loginCheck" id="loginForm" method="post">
						<div class="w3-section">
							<div class="w3-cell-row">
								<div class="w3-cell">												
									<div class="question">
										<input type="text" name="id" id="loginid" class="w3-input w3-border w3-round" required />
										<label class="w3-left">아이디</label>
									</div>												
								</div>
							</div>
						</div>
						<div class="w3-section">										
							<div class="w3-cell-row">
								<div class="w3-cell">												
									<div class="question">						
										<input type="password" name="pwd" id="loginpwd" class="w3-input w3-border w3-round" required />
										<label class="w3-left">비밀번호</label>
									</div>													
								</div>
							</div>
						</div>
						<div class="w3-section">
							<div class="w3-cell-row w3-center">
								<div class="w3-cell">
									<div class="w3-button w3-border-0 w3-text-white w3-hover-none w3-hover-text-orange" onclick="idFind()" >아이디 찾기</div>									
								</div>
								<div class="w3-cell">
									<div class="w3-button w3-border-0 w3-text-white w3-hover-none w3-hover-text-orange" onclick="pwdFind()" >비밀번호 찾기</div>
								</div>
							</div>
						</div>	
						<div class="w3-section">
							<div class="w3-row">				
								<div class="button_base b05_3d_roll" onclick="loginCheck()" style="margin-top: 30px;">											
									<div>로그인</div>
									<div>로그인</div>
								</div>
							</div>
							<div class="w3-row">				
								<div class="button_base b05_3d_roll" onclick="openSignup()" style="margin-top: 30px;">											
									<div>회원가입</div>
									<div>회원가입</div>
								</div>
							</div>
							<div class="w3-row">	
								<div class="button_base b05_3d_roll" onclick="closeLogin()" style="margin-top: 30px;">
									<div>취소</div>
									<div>취소</div>
								</div>
							</div>
						</div>													
					</form>		
				</div>					
			</div>
		</div>
		
		<div id="signup" class="w3-modal">
			<div class="w3-modal-content" style="width: 500px;">
				<div class="w3-container" style="background-color: #2E2E2E;">
					<form action="user/signup" method="post" id="signupForm">
						<div class="w3-section">										
							<div class="w3-cell-row">
								<div class="question">
									<input type="text" name="id" id="id" class="w3-input w3-border w3-round" oninput="checkID()" required />
									<label class="w3-left">아이디</label>
								</div>	
							</div>
						</div>
						<div class="w3-section">
							<div class="w3-cell-row">
								<div class="question">
									<input type="text" name="nickname" id="nickname" class="w3-input w3-border w3-round" oninput="checkNick()" required />
									<label class="w3-left">닉네임</label>
								</div>	
							</div>
						</div>
						<div class="w3-section">
							<div class="w3-cell-row">
								<div class="question">
									<input type="password" name="password" id="password" class="w3-input w3-border w3-round" oninput="checkPwd()" required />
									<label class="w3-left">비밀번호</label>
								</div>	
							</div>
						</div>
						<div class="w3-section">
							<div class="w3-cell-row">
								<div class="question">
									<input type="password" name="confirmPassword" id="confirmpassword" class="w3-input w3-border w3-round" oninput="checkPwd()" required />
									<label class="w3-left">비밀번호 확인</label>
								</div>	
							</div>
						</div>
						<div class="w3-section">
							<div class="w3-cell-row">
								<div class="question">
									<input type="text" name="email" id="email" class="w3-input w3-border w3-round" oninput="checkEmail()" required />
									<label class="w3-left">이메일</label>
								</div>
							</div>
						</div>
						<div class="w3-section">
							<div class="w3-row">				
								<div class="button_base b05_3d_roll" id="signupbtn" onclick="goSignup()" style="margin-top: 30px; pointer-events: none;">											
									<div>회원가입</div>
									<div>회원가입</div>
								</div>
							</div>
							<div class="w3-row">	
								<div class="button_base b05_3d_roll" onclick="closeSignup()" style="margin-top: 30px;">
									<div>취소</div>
									<div>취소</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		
		<div id="idfind" class="w3-modal" style="padding-top: 200px;">
			<div class="w3-modal-content" style="width: 500px;">
				<div class="w3-container" style="background-color: #2E2E2E;">
					<form action="user/idfind" id="idfindForm" method="post">
						<div class="w3-row w3-center">
							<span class="w3-text-white">아이디 찾기</span>
						</div>
						<div class="question">
							<input type="text" name="nickname" id="valinick" class="w3-input w3-border w3-round" required />
							<label class="w3-left">닉네임</label>
						</div>
						<div class="question">
							<input type="text" name="email" id="valiemail1" class="w3-input w3-border w3-round" required />
							<label class="w3-left">이메일</label>
						</div>
						<div class="w3-margin-top w3-center">
							<div class="w3-bar">
								<div class="w3-bar-item">
									<button type="button" onclick="findid()" class="btn-3d yellow" style="padding: 10px 50px; font-size: 15px;">확인</button>
								</div>
								<div class="w3-bar-item">
									<div class="btn-3d yellow" onclick="idClose()" style="padding: 10px 50px; font-size: 15px;">취소</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>

		<div id="pwdfind" class="w3-modal" style="padding-top: 200px;">
			<div class="w3-modal-content" style="width: 500px;">
				<div class="w3-container" style="background-color: #2E2E2E;">					
					<form action="user/pwdfind" id="pwdfindForm" method="post">
						<div class="w3-row w3-center">
							<span class="w3-text-white">비밀번호 찾기</span>
						</div>
						<div class="question">
							<input type="text" name="id" id="valiid" class="w3-input w3-border w3-round" required />
							<label class="w3-left">아이디</label>
						</div>
						<div class="question">
							<input type="text" name="email" id="valiemail2" class="w3-input w3-border w3-round" required />
							<label class="w3-left">이메일</label>
						</div>
						<div class="w3-margin-top w3-center">
							<div class="w3-bar">
								<div class="w3-bar-item">
									<button type="button" onclick="findpwd()" class="btn-3d yellow" style="padding: 10px 50px; font-size: 15px;">확인</button>
								</div>
								<div class="w3-bar-item">
									<div class="btn-3d yellow" onclick="pwdClose()" style="padding: 10px 50px; font-size: 15px;">취소</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>	
</html>
function openLogin() {
	document.getElementById('login').style.display='block';
}
function closeLogin() {
	document.getElementById('login').style.display='none';
	document.getElementById('loginForm').reset();
}
function openSignup() {
	document.getElementById('signup').style.display='block';
	document.getElementById('login').style.display='none';
}			
function closeSignup() {
	document.getElementById('signup').style.display='none';
	location.reload();
	document.getElementById('signupForm').reset();
}
function idFind() {
	document.getElementById('idfind').style.display='block';
	document.getElementById('login').style.display='none';
}
function idClose() {
	document.getElementById('idfind').style.display='none';
	document.getElementById('login').style.display='block';
	document.getElementById('idfindForm').reset();
}
function pwdFind() {
	document.getElementById('pwdfind').style.display='block';
	document.getElementById('login').style.display='none';
}
function pwdClose() {
	document.getElementById('pwdfind').style.display='none';
	document.getElementById('login').style.display='block';
	document.getElementById('pwdfindForm').reset();
}
function goSignup() {
	alert("회원가입되었습니다.");
	document.getElementById("signupForm").submit();
}
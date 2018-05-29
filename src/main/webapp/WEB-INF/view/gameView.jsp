<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>게임방</title>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/httpRequest.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/bg.js" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/js/bg.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/bg.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
<style type="text/css">
	body{
		background-color: #3E92A3;
		font-family: 'Nanum Gothic', sans-serif;
	} 
	.w3-lobster {
    font-family: "Lobster", serif;
	}
</style>
</head>
<body>
<canvas id="snow"></canvas>
<div>
	<table align="center" style="border:1px solid black; width:900px; height:700px; margin-top: 50px" background="<%=request.getContextPath() %>/roomSource/gameRoomimage.png">
	<tr>
		<td colspan="6" align="right"  style="padding-top: 10px; padding-right:20px">
		<div id="totalNumber" style="text-shadow:1px 1px 0 #444;font-weight:bold;color:white"></div>	
		<div style="padding-top: 10px">
			<input class="w3-button w3-yellow" type="button" value="도움말" style="width:100px;font-weight:bold" 
			onclick="document.getElementById('help').style.display='block'">
			
			<div id="help" class="w3-modal" >
			    <div class="w3-modal-content" style="width:600px">
			      <div class="w3-container">
			        <span onclick="document.getElementById('help').style.display='none'" class="w3-button w3-display-topright">&times;</span>
			        <p align="center" style="font-weight: bold;font-size: 15pt;padding:10px">게임 이용방법</p>
			        <div align="left" style="margin:0 auto; padding-bottom:30px;padding-left:10px">
			        <ul >
			        	<li>4명 모두 준비완료가 되었을 때 자동으로 게임을 시작합니다.</li>
						<li>게임창 위 입력란에 각 자리가 <b>중복되지 않는 4자리 수</b>를 입력합니다.</li>
						<li>정답을 맞추면 포인트를 얻고, 게임이 종료됩니다.</li>
						<li>포인트는 정답을 맞추기 까지 입력횟수에 따라 다르게 지급됩니다.</li>
						<li>한번에 맞출 때 : 1000point 2~5회: 500point</li>
						<li>6~10회: 400point 11회~: 300point, 패배: 100point </li>
			        </ul>
			        </div>
			      </div>
			 	</div>
			</div>
			

			<input class="w3-button w3-yellow" id="roomout" type="button" value="방나가기" style="width:100px;font-weight:bold" 
				onclick="gameRoomOut()" >
		</div>
		</td>
	</tr>
	<tr>
		<td id="image1" style="width:200px;padding-top: 10px" align="center"><img src="<%=request.getContextPath() %>/roomSource/waiting.gif"></td>
		<td id="image2" style="width:200px;padding-top: 10px" align="center"><img src="<%=request.getContextPath() %>/roomSource/waiting.gif"></td>
		<td id="image3" style="width:200px;padding-top: 10px" align="center"><img src="<%=request.getContextPath() %>/roomSource/waiting.gif"></td>
		<td id="image4" style="width:200px;padding-top: 10px" align="center"><img src="<%=request.getContextPath() %>/roomSource/waiting.gif"></td>
	</tr>
	<tr>
		<td id="player1" align="center" style="text-shadow:1px 1px 0 #444;font-weight:bold;color:white">대 기 중</td>
		<td id="player2" align="center" style="text-shadow:1px 1px 0 #444;font-weight:bold;color:white">대 기 중</td>
		<td id="player3" align="center" style="text-shadow:1px 1px 0 #444;font-weight:bold;color:white">대 기 중</td>
		<td id="player4" align="center" style="text-shadow:1px 1px 0 #444;font-weight:bold;color:white">대 기 중</td>
	</tr>

	<tr>
		<td colspan="2" rowspan="2" style="padding-left:20px">
			<!-- 채팅창 -->
		<div style="align-text: center;" >
			<div class="w3-purple" style="width:400px;border: 1px solid grey;padding-left: 10px;font-size: 10pt">채팅</div>
			<div class="w3-pale-blue" id="messageWindow"
				style="width: 400px; height: 300px; border: 1px solid grey; overflow: auto;word-wrap: break-word;" ></div>
			<br /> 
			<div style="vertical-align:middle">
	
				<input id="inputMessage" type="text" style="width:320px;" onKeypress="javascript:if(event.keyCode==13) {send()}"/>
				 <input class="w3-button w3-yellow" style="font-weight:bold" type="submit" value="보내기" onclick="send()" />
			</div>
		</div>
	
		</td>
		<td colspan="2" style="padding-right:20px ; text-align: right">
			<input id="gameStart" class="w3-button w3-red" style="font-weight:bold" type="button" value="준비완료" onclick="gameReady()">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span style="text-shadow:1px 1px 0 #444;font-weight:bold;color:white ;">정 답 : </span>
			<input id="gameMessage" type="text" 
				style="width:100px;" onKeypress="javascript:if(event.keyCode==13) {sendAnswer()}" disabled="disabled"/>
			 <input id="gameSend" class="w3-button w3-yellow" style="font-weight:bold ;align-content: right" type="submit" value="보내기" onclick="sendAnswer()" disabled="disabled"/>
		</td>
	</tr>
	<tr>
		<td colspan="2" style="padding-bottom: 20px; align:right;padding-left:23px">
			<div class="w3-purple" style="width:400px;border: 1px solid grey;padding-left: 10px;font-size: 10pt">게임판</div>
			<div class="w3-pale-red" id="gameWindow" style="width: 400px; height: 300px; border: 1px solid grey; overflow: auto;"></div>
		</td>
		
	</tr>

</table>
</div>
	<!-- 게임 결과 모달 -->
<div id="gameResult" class="w3-modal" style="display:none">
   <div class="w3-modal-content w3-animate-opacity w3-card-4" style=" width:500px">
      <header class="w3-container w3-teal"> 
        <span onclick="document.getElementById('gameResult').style.display='none'" class="w3-button w3-display-topright">&times;</span>
        <h5>게임 결과</h5>
      </header>
      <div id="resultGameBoard" class="w3-container" align="center" style="padding:50px"> 
         <p class="w3-xxlarge w3-lobster">Game Over</p>
	<table class="w3-table w3-bordered w3-centered" style="width:300px">
		<tr>
			<td>name</td><td>승패</td><td>point</td>
		</tr>
		<tr>
			<td><b id="winnerId"></b></td>
			<td><span style="color:red"><b>WIN</b></span></td>
            <td><span style="color:orange"><b id="winnerPoint"></b></span></td>
		</tr>
		<tr >
			<td><b id="loser1"></b></td>
            <td><span style="color:blue"><b id="loser1L"></b></span></td>
            <td><span style="color:orange"><b id="loser1Point"></b></span></td>
		</tr>
		<tr>
			<td><b id="loser2"></b></td>
            <td><span style="color:blue"><b id="loser2L"></b></span></td>
            <td><span style="color:orange"><b id="loser2Point"></b></span></td>
		</tr>
		<tr>
			<td><b id="loser3"></b></td>
            <td><span style="color:blue"><b id="loser3L"></b></span></td>
            <td><span style="color:orange"><b id="loser3Point"></b></span></td>
		</tr>
	</table>
      </div>
      <div class="w3-center" style="padding:10px">
      	<button class="w3-button w3-black" onclick="document.getElementById('gameResult').style.display='none'">확인</button>
      </div>
    </div>
 </div>
	
	
</body>
<script type="text/javascript" >
	//준비 ajax
	function gameReady(){
		var params="ready=true&roomName="+encodeURIComponent('${group}')+"&id="+encodeURIComponent('${name}');
		sendRequest("ready",params,readyOK,"POST");

	}
	function readyOK(){
		if(httpRequest.readyState==4){
			if(httpRequest.status==200){
				document.getElementById('gameStart').disabled=true;
				if(httpRequest.responseText=='ok'){
					webSocket.send('@ok@#@');	
					webSocket.send('@o@n@game@');				

				}else{
					webSocket.send('@ready@#@');
				}
			}
		}
	}
	
	
	//webSocket
	  var textarea = document.getElementById("messageWindow");
	    var webSocket = new WebSocket(
	        	    'ws://211.238.142.37:8080<%=request.getContextPath()%>/webGroup?name='
	        	    		+encodeURIComponent('${name}')+'&group='+encodeURIComponent('${group}')
	       );
	    var inputMessage = document.getElementById('inputMessage');
	    
	    webSocket.onerror = function(event) {    onError(event)   };
	    webSocket.onopen = function(event) {    onOpen(event)    };
	    webSocket.onmessage = function(event) {   onMessage(event) };
	  
	    function onMessage(event) {
	    	if (event.data.includes("@@@@@zxc")){
	    		var strArray=event.data.split(':');
	    		document.getElementById("totalNumber").innerHTML='현재 접속 인원 : '+strArray[2];
	    	}else if(event.data.includes("@n@a@m@e@")){
	    		var strArray=event.data.split(':');
	    		
	    		for(var i=2;i<strArray.length;i++){
	    			document.getElementById("player"+(i-1)).innerHTML=strArray[i];
	    			document.getElementById("image"+(i-1)).innerHTML='<img src="<%=request.getContextPath() %>/roomSource/userin.gif">';
	    		}
	    		for(var i=5;i>=strArray.length;i--){
	    			document.getElementById("player"+(i-1)).innerHTML='대기중';
	    			document.getElementById("image"+(i-1)).innerHTML='<img src="<%=request.getContextPath() %>/roomSource/waiting.gif">';
	    		}
	    	}else if(event.data.includes('@ready@#@')){
	    		var strArray=event.data.split(':');
	    		for(var i=1;i<strArray.length;i++){
	    			if(strArray[i]=='true'){
		    			document.getElementById("image"+i).innerHTML='<img src="<%=request.getContextPath() %>/roomSource/userready.gif">';

	    			}else{
		    			document.getElementById("image"+i).innerHTML='<img src="<%=request.getContextPath() %>/roomSource/userin.gif">';
	    			}
	    			
	    		}
	    		for(var i=4;i>=strArray.length;i--){
	    			document.getElementById("image"+i).innerHTML='<img src="<%=request.getContextPath() %>/roomSource/waiting.gif">';

	    		}


	    	}else if(event.data.includes('@o@n@game@')){
	    		var strArray=event.data.split(':');
	    		for(var i=1;i<strArray.length;i++){
	    			if(strArray[i]=='true'){
		    			document.getElementById("image"+i).innerHTML='<img src="<%=request.getContextPath() %>/roomSource/userstart.gif">';

	    			} else{
		    			document.getElementById("image"+i).innerHTML='<img src="<%=request.getContextPath() %>/roomSource/userout.gif">';
	    			}
	    			 
	    		}
	    		 for(var i=4;i>=strArray.length;i--){
	    			document.getElementById("image"+i).innerHTML='<img src="<%=request.getContextPath() %>/roomSource/userout.gif">';

	    		}
	    		
				
	    	}else if(event.data.includes('@e@n@d@')){
	    		var strArray=event.data.split(':');
	    		for(var i=1;i<strArray.length;i++){
	    			if(strArray[i]=='true'){
		    			document.getElementById("image"+i).innerHTML='<img src="<%=request.getContextPath() %>/roomSource/gameOver.png">';

	    			}else if(strArray[i]=='winner'){
		    			document.getElementById("image"+i).innerHTML='<img src="<%=request.getContextPath() %>/roomSource/winner.gif">';
	    				
	    			}else{
		    			document.getElementById("image"+i).innerHTML='<img src="<%=request.getContextPath() %>/roomSource/userout.gif">';
	    			}
	    			 
	    		}
	    		 for(var i=4;i>=strArray.length;i--){
	    			document.getElementById("image"+i).innerHTML='<img src="<%=request.getContextPath() %>/roomSource/userout.gif">';

	    		}
	    		
	    		//resultBoard();
     			//document.getElementById('gameResult').style.display='block';
	    		 
	    		 
	    	}else if(event.data.includes('@result@board@')){
	    		//작업해서 결과창 뿌려줌
	    		var strArray=event.data.split('#');
	    		//strArray[0]-키 strArray[1]-시작유저 strArray[2]-종료유저 strArray[3]-게임포인트 
	    		//strArray[4]-게임winner
	    		var num=1;
	    		var startUserArray=strArray[1].split(':');
	    		//startUserArray[0]:id...
	    		
	    		for(var i=0;i<startUserArray.length;i++){
	    			if(strArray[2].includes(startUserArray[i]) && startUserArray[i]!=strArray[4]){
	    				//startUser==종료유저이면서 winner가 아닐 때
	    				document.getElementById("loser"+num).innerHTML=startUserArray[i];
	    				document.getElementById("loser"+num+"L").innerHTML="LOSE";
	    				document.getElementById("loser"+num+"Point").innerHTML="+100"
	    				num++;
	    			}else if(startUserArray[i]==strArray[4]){//startUser==winner일 때
	    				document.getElementById("winnerId").innerHTML=strArray[4];
	    	    		document.getElementById("winnerPoint").innerHTML=strArray[3];
	    			}else{ //탈주자
	    				document.getElementById("loser"+num).innerHTML=startUserArray[i];
	    				document.getElementById("loser"+num+"L").innerHTML="<span style='color:black'>OUT</span>";
	    				document.getElementById("loser"+num+"Point").innerHTML="+0"
	    				num++;
	    			}
	    		}
     			document.getElementById('gameResult').style.display='block';

	
	    	}else if(event.data.includes('@ok@#@')){
	    		document.getElementById("gameWindow").innerHTML += '<div style="font-weight:bold;color:red">'
	        		+'게임 시작!!!' + '</div><div>4자리수의 중복되지 않은 숫자를 입력해주세요<br>(각 자리는 1~9사이의 수)<div><br>';
	        		
		    	document.getElementById("gameWindow").scrollTop=textarea.scrollHeight;   
				document.getElementById('gameMessage').disabled=false;
				document.getElementById('gameSend').disabled=false;
				
				
				
	    	} else if(event.data.includes('a!n!s!@')){
	    		var strArray=event.data.split('@');
	    		//strArray[0]=키 strArray[1]=유저 strArray[2]=답 strArray[3]=결과 strArray[4]=turnCount
	    		document.getElementById("gameWindow").innerHTML +="<div>"+strArray[1]+": "+strArray[2]
	    				+' <font color="blue"><b>'+strArray[3]+"</b>"+"(턴 : "+strArray[4]+")</font></div>";
	    				

	    		if(strArray[3].includes('!')){
	    			document.getElementById("gameWindow").innerHTML +=
	    				'<div style="font-weight:bold;color:red">WINNER :'+strArray[1]+"님 축하합니다</div>"+
	    				'<div>게임이 종료되었습니다.<br>방 나가기 후 새로운 게임을 찾아주세요</div>';
	    				
	    			document.getElementById('gameMessage').disabled=true;
					document.getElementById('gameSend').disabled=true;
					
					webSocket.send('@e@n@d@');
	    				
	    		}
  		
	    		document.getElementById("gameWindow").scrollTop=document.getElementById("gameWindow").scrollHeight;   
	    		
	    	}else{
	    		textarea.innerHTML += "<div>"
	        		+event.data + "</div>";
	        
	             textarea.scrollTop=textarea.scrollHeight;
	    	}
	    
	    }
	    
	    
	    function onOpen(event) {
	       textarea.innerHTML += "게임에 입장하셨습니다!"+"<br>";
	    }
	    function onError(event) {     alert(event.data);   }
	    function send() {
	        webSocket.send(inputMessage.value);
			inputMessage.value = "";
		}
	    function sendAnswer() {
	    	var gMessage=gameMessage.value;
	    	if(isNaN(gMessage)==true){
	    		alert("숫자를 입력해주세요.");
	    		gameMessage.value = "";
	    	}else if(gMessage.includes(0)){
	    		alert("0은 포함되지 않습니다.");
	    		gameMessage.value = "";
	    	}
	    	else if(gMessage.length!=4){
	    		alert("4자리의 숫자가 아닙니다.");
	    		gameMessage.value = "";
	    	}else{
	    		var check=false;
	    		
	    		for(var i=0;i<4;i++){
	    			var input=gMessage.charAt(i);
	    			var gMessageCheck=gMessage.replace(new RegExp(input,'gi'),"");
	    			if(gMessageCheck.length<3){
	    	    		check=true;   	    		
	    	    		break;
	    			}
	    		}
	    		
	    		if(check==true){
    				alert("중복된 수가 있습니다.");
    	    		gameMessage.value = "";
	    		}else{
	    	        webSocket.send("@a@n@s@:"+gameMessage.value);
	    	        gameMessage.value = "";
	    		}
	    		
	    	}
		}
	    
	    function gameRoomOut() {
	    	setTimeout(() => {
				location.href="<%=request.getContextPath()%>/waitingroom";
			}, 1500);
			var x = document.getElementById("roomout");
			x.value='나가는 중';
			if (x.className.indexOf("w3-spin") == -1) {
			    x.className += " w3-spin";
			} else { 
			    x.className = x.className.replace(" w3-spin", "");
			}
		}
</script>
</html>
var httpRequest = null;
function sendRequest(url, params, callback, method){
		httpRequest = new XMLHttpRequest();   
		var httpMethod = method?method:'GET'; /*='GET'  */
		if(httpMethod!='GET' && httpMethod !='POST'){
			httpMethod='GET';
		}
		
		var httpParams = (params==null || params =='')?null:params; 
		var httpUrl = url;                            /* 포스트 방식일때 url */
		if(httpMethod=='GET' && httpParams !=null){
			httpUrl=httpUrl+"?"+httpParams;           /* 겟 방식일때 url */
		}
		
		httpRequest.open(httpMethod,httpUrl, true);
		httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		httpRequest.onreadystatechange=callback;
		httpRequest.send(httpMethod=='POST'?httpParams:null);
		
//		var run = function(){
//			  var req = new XMLHttpRequest();
//			  req.timeout = 5000;
//			  req.open(httpMethod,httpUrl, true);
//			  req.send();
//			}
//		setInterval(run, 3000);
	}
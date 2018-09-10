<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1" name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login Page</title>
<link rel="stylesheet" href="assets/css/background.css?version=1">
<link rel="stylesheet" href="assets/css/form1.css?version=1">

<style>

#cms{
	height: 400px;
	background: url("assets/img/icon/logo.png") no-repeat bottom center;
	position: relative;
}

</style>


<script language="javascript">
	function check(e,p)
	{
		//alert(e);
		//alert(p);
		xmlHttp = GetXmlHttpObject();
		//alert(xmlHttp);
		var url = "loginCheck.jsp?email="+e+"&pass="+p;
		//alert(url);
		xmlHttp.open("GET",url,true);
		xmlHttp.onreadystatechange = stateChanged
		xmlHttp.send(null);
		return false;
	}
	
	function stateChanged()
	{
		var showdata = xmlHttp.responseText;
		if(showdata.trim() == 'OK')
		{
			document.getElementById("show").innerHTML="<font class=\"reply\">User Verified, redirecting to home page...</font>";
			window.setTimeout(function(){
			document.login.submit();}, 2000);
		}
		else
		{	
			document.getElementById("show").innerHTML=showdata;
		}
	}
	function GetXmlHttpObject()
	{
		var xmlHttp=null;
		try
		{
			//Firefox, Opera 8.0+, Safari
			xmlHttp = new XMLHttpRequest();
		}
		catch(e)
		{
			//Internet Explorer
			try
			{
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			}
			//Google Chrome
			catch(e)
			{
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		return xmlHttp;
	}
</script>
</head>
<body>
<center>
<div id="cms"></div>
<div class="formCont">
<h4>Enter Login Credentials</h4>
	<form name="login" method=post action="home" onsubmit="return check(nm.value,psd.value)">
		<input type=text name=nm placeholder="Email Id" autofocus><br><br>
		<input type=password name=psd placeholder="Password" "><br><br>
		<div id="show"></div>
		<input type=submit id="login" value="Let me in">
	</form>
	<%@include file="googleSingleSignOn.jsp" %>
	<form action="signUp">
		<p>Don't have an account?<input type=submit value="Allot a new account"></p>
	</form>
</div>
</center>
</body>
</html>
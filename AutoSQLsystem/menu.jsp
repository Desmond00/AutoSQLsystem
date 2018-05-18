<html>
	<head>
		<link rel="stylesheet" href="css/menu.css">
		<link href="css/background.css" type="text/css" rel="stylesheet">

		<script language="javascript">
			window.onload = check();
			function check()
			{
				//alert("here");
				xmlHttp = GetXmlHttpObject();
				//alert(xmlHttp);
				var url = "userValidate.jsp";
				xmlHttp.open("GET",url,true);
				xmlHttp.onreadystatechange = showHide
				xmlHttp.send(null);
			}

			function showHide()
			{
				var data = xmlHttp.responseText;
				//alert(data);
				if(data.trim() == "none")
				{
					document.getElementById("logout").style.display = "none";
					//alert("no user");
				}
				else if(data != "")
				{
					document.getElementById("login").style.display = "none";
					document.getElementById("signup").style.display = "none";
					document.getElementById("showMenu").innerHTML = data;
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
		<a href="home"><img class="logo" src="img/icon/CMS.png" alt="icon missing"></a>
		<br><br>
		<div class="buttonCont">
			<div id="showMenu">
				<a class="button" id="login"  href="login">Login</a>
    			<a class="button" id="signup" href="signUp">Sign up</a>
				<a class="button" id="about" href="about">About</a>
			</div>
		</div>
	</center>
	<h3>Generate SQL automatically</h3>
</body>
</html>
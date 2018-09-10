<html>
	<head>
		<link rel="shortcut icon" href="assets/img/icon/title.ico" />
		<link rel="stylesheet" href="assets/css/menu.css">
		<%-- <link href="assets/css/background.css" type="text/css" rel="stylesheet"> --%>

		<script>
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

	<header>
	<div style="text-align:center">
		<div id="menuContent">
			<a href="home"><img class="logo" src="assets/img/icon/ASQLS.png" alt="icon missing"></a>
			<br><br>
			<div class="buttonCont">
				<div id="showMenu">
					<a class="button" id="login"  href="login">Login</a>&nbsp;
					<a class="button" id="signup" href="signUp">Sign up</a>&nbsp;
					<a class="button" id="about" href="about">About</a>
				</div>
			</div>
			<br>	
		</div>
	</div>
	<hr>
	</header>
</html>

<style>
	body{
		margin: 0;
	}
	header{
		background: #E2EA98;  /* fallback for old browsers */
		background: -webkit-linear-gradient(to right, #ABA993, #E2EA98, #ABA993);  /* Chrome 10-25, Safari 5.1-6 */
		background: linear-gradient(to right, #ABA993, #E2EA98, #ABA993); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
		display: fixed!important;
	}
</style>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SignUp page</title>
<link rel="stylesheet" href="css/background.css?version=1">
<link rel="stylesheet" href="css/form1.css?version=1">

<style>

#cms{
	height: 400px;
	background: url("img/icon/logo.png") no-repeat center center;
	position: relative;
}

</style>


<script language="javascript">
var chk=0;
var f = 0;
	function check(e)
	{
		var flag=0;
		var em = e;
		if(e == "")
		{
			chk = 1;
			flag=1;
			if(f == 1)
			{
				//alert("here");
				document.getElementById("show").style.display = "none";	
			}
			document.getElementById("email1").style.display = "block";
			document.getElementById("email1").innerHTML="<font class=\"reply\">You can't leave this field empty</font>";
		}
		else
		{
			var atpos = em.indexOf("@");
		    var dotpos = em.lastIndexOf(".");
    		if (atpos<1 || dotpos<atpos+2 || dotpos+2>=em.length) {
				flag=1;
				chk=1;
				document.getElementById("show").style.display = "none";
				document.getElementById("email1").style.display = "block";
				document.getElementById("email1").innerHTML="<font class=\"reply\">Enter emailID in valid format</font>"
		    }
		}
		if(flag == 0)
		{
			document.getElementById("email1").style.display = "none";
			//alert(e);
			xmlHttp = GetXmlHttpObject();
			//alert(xmlHttp);
			var url = "signupCheck.jsp?email="+e;
			//alert(url);
			xmlHttp.open("GET",url,true);
			xmlHttp.onreadystatechange = stateChanged
			xmlHttp.send(null);
			return false;
		}
	}
	
	function stateChanged()
	{
		var showdata = xmlHttp.responseText;
		//alert(showdata);
		if(showdata.trim() == 'np')
		{
			chk=2;
			document.signup.psd.focus();
			document.getElementById("show").style.display = "none";
			/*document.getElementById("show").innerHTML="<font class=\"reply\">User Verified, redirecting to home page...</font>";
			window.setTimeout(function(){
			document.login.submit();}, 2000);*/
		}
		else if(showdata != "")
		{
			f=1;chk=1;
			document.signup.email.value = "";
			document.signup.email.focus();
			document.getElementById("show").style.display = "block";
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
	
	function checkp1(p)
	{
		if(p == "")
			{
			document.getElementById("psd1").style.display = "block";
			document.getElementById("psd1").innerHTML="<font class=\"reply\">You can't leave this field empty</font>";
			chk = 1;			
			}
		else
			{
			
			document.getElementById("psd1").style.display = "none";
			chk=2;			
			}
	}
	
	function checkp2(p1,p2)
	{
		if(p2 == "")
		{
			chk = 1;
			document.getElementById("psd2").style.display = "block";
			document.getElementById("psd2").innerHTML="<font class=\"reply\">You can't leave this field empty</font>";
			checkp1(p1);
		}
		else if(p1 != p2)
			{
			chk = 1;		
			document.getElementById("psd2").style.display = "block";
			document.getElementById("psd2").innerHTML="<font class=\"reply\">These passwords don't match</font>"
			}
		else
			{
			chk = 2;			
			document.getElementById("psd2").style.display = "none";
			}
	}
	
	function checknm(nm)
	{
		if(nm == "")
			{
			chk = 1;	
			document.getElementById("nm1").style.display = "block";
			document.getElementById("nm1").innerHTML="<font class=\"reply\">You can't leave this field empty</font>";
			}
		else if(!isNaN(nm))
			{
			chk = 1;
			document.getElementById("nm1").style.display = "block";
			document.getElementById("nm1").innerHTML="<font class=\"reply\">This field should not contain only digit</font>";
			}
		else
			{
			document.getElementById("nm1").style.display = "none";
			chk = 2;
			}
	}
	
	function checkph(ph)
	{
		if(ph == "")
			{
			chk = 1;			
			document.getElementById("phnNo1").style.display = "block";
			document.getElementById("phnNo1").innerHTML="<font class=\"reply\">You can't leave this field empty</font>";
			}
		else if(isNaN(ph))
			{
			chk = 1;			
			document.getElementById("phnNo1").style.display = "block";
			document.getElementById("phnNo1").innerHTML="<font class=\"reply\">This field should not contain any alphabet</font>";
			}
		else
			{
			document.getElementById("phnNo1").style.display = "none";
			chk = 2;
			}
	}
	
	function fullCheck()
	{
		if(chk == 2)
			{
			document.getElementById("show").style.display = "block";			
			document.getElementById("show").innerHTML = "<font class=\"reply\">Everything is OK, ready to submit</font>"
			var email,pass,name,phno;
			email = document.signup.email.value;
			//alert(email);
			pass = document.signup.psd.value;
			//alert(pass);
			name = document.signup.nm.value;
			//alert(name);
			phno = document.signup.phnNo.value;
			//alert(phno);
			xmlHttp = GetXmlHttpObject();
			var url = "signupSubmit.jsp?email="+email+"&pass="+pass+"&name="+name+"&phno="+phno;
			xmlHttp.open("GET",url,true);
			xmlHttp.onreadystatechange = stateChanged2
			xmlHttp.send(null);
			return false;
			}
		else if(chk == 1)
			{
			document.getElementById("show").style.display = "block";
			document.getElementById("show").innerHTML = "<font class=\"reply\">Something is wrong, check every field carefully</font>"
			}
		else if(chk == 0)
			{
			document.getElementById("show").style.display = "block";
			document.getElementById("show").innerHTML = "<font class=\"reply\">Hey, fill up the fields</font>"
			}
		return false;
	}
	
	function stateChanged2()
	{
		var data = xmlHttp.responseText;
		//alert(data);
		if(data.trim() == 'error')
		{
			document.getElementById("show").style.display = "block";
			document.getElementById("show").innerHTML= "<font class=\"reply\">Some error occurred try again after some time</font>";
		}
		else if(data != "")
		{
			document.getElementById("show").style.display = "block";
			document.getElementById("show").innerHTML=data;
			window.setTimeout(function(){
			document.signup.submit();}, 2000);
		}
	}
	
</script>
</head>
<body>
<center>
<div id="cms"></div>
<div class="formCont">
<h4>Enter Valid Credentials to register</h4>
	<form name="signup" method=post action="login" onsubmit="return fullCheck()">
		<input type=text name=email placeholder="Email Id" onblur="check(this.value)"><br>
		<div id="email1"></div>
        <input type=password name=psd placeholder="Password" onblur="checkp1(this.value)"><br>
        <div id="psd1"></div>
        <input type=password name=confpsd placeholder="Confirm Password" onblur="checkp2(psd.value,this.value)"><br>
        <div id="psd2"></div>
        <input type=text name=nm placeholder="Name" onblur="checknm(this.value)"><br>
        <div id="nm1"></div>
        <input type=text name=phnNo placeholder="Phone number" onblur="checkph(this.value)"><br>
        <div id="phnNo1"></div>
		<div id="show"></div>
		<input type=submit id="signup" value="Sign UP">
	</form>
</div>
</center>
</body>
</html>
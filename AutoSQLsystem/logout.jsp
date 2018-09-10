<head>
	<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
	<meta name="google-signin-client_id" content="149933181936-16fkr7tggmu2nu829mjdt2ef3j6r8gg4.apps.googleusercontent.com">
	<link rel="stylesheet" href="assets/css/background.css">
    <link rel="stylesheet" href="assets/css/form1.css">
</head>
<%
    session.removeAttribute("user");
	session.removeAttribute("email");
	Cookie ck[] = request.getCookies();
	if(ck != null)
	{
		for(int i=0;i<ck.length;i++)
		{
			if(ck[i].getName().equals("count"))
			{
				ck[i].setMaxAge(0);
				response.addCookie(ck[i]);
			}
		}
	}
	if(session.getAttribute("userImage") == null) {
		response.sendRedirect("home");
	}
	else {
		session.removeAttribute("user");
		session.removeAttribute("email");
		session.removeAttribute("userImage");
%>

<body>
	<div class="g-signin2" style="display:none;" data-onsuccess="onSignIn" id="myP"></div>
	<br>
	<font class=reply style="display:block; text-align:center; position:relative;">Signing you out...</font>
</body>
<script>
	
	function onSignIn(){
		gapi.auth2.getAuthInstance().signOut();
		window.location.href = "http://localhost:12345/AutoSQLsystem"
	}

</script>

<%-- <%
    response.sendRedirect("/AutoSQLsystem/home");
%> --%>
<%
	}
%>
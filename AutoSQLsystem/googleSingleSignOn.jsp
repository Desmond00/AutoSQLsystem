<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<meta name="google-signin-client_id" content="149933181936-16fkr7tggmu2nu829mjdt2ef3j6r8gg4.apps.googleusercontent.com">
</head>

 

<body>
<form name="googleLogin" method=post action=googleLogin>
	<div class="g-signin2" data-onsuccess="onSignIn" id="myP"></div>
	<div id="data"></div>
</form>
<script type="text/javascript">
			function onSignIn(googleUser) {

				var profile = googleUser.getBasicProfile();
				  var userImageURL=profile.getImageUrl();
				  var userName=profile.getName();
				  var userEmail=profile.getEmail();
				  document.getElementById("data").innerHTML = 
					  '<input type=hidden name=userName id=userName value=\"'+userName+'\">'+
					  '<input type=hidden name=userEmail id=userEmail value='+userEmail+'>'+
					  '<input type=hidden name=userImageURL id=userImageURL value='+userImageURL+'>';
				  document.getElementById("show").innerHTML="<font class=\"reply\">User Verified, redirecting to home page...</font>";
					window.setTimeout(function(){
					document.googleLogin.submit();}, 2000);
			}
</script>
</body>
</html>
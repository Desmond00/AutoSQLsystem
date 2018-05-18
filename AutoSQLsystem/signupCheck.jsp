<jsp:useBean id="ob" class="user.signupCheck" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="ob"/>
<%
	int t = ob.check();
	if(t == 1)
		out.println("<font class=\"reply\">emailID already exists</font>");
	else if(t == 0)
		out.println("np");
%>
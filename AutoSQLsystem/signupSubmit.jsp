<jsp:useBean id="ob" class="user.signupSubmit" scope="page"/>
<jsp:setProperty name="ob" property="*"/>
<%
	try{
    int t = ob.confirm();
    if(t>0)
        out.println("<font class=\"reply\">Registration successful, redirecting to login page...</font>");
    else
        out.println("error");
	}
	catch(Exception e){}
%>
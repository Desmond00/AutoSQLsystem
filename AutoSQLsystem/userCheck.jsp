<%
    String email = (String)session.getAttribute("email");
    if(email == null)
    {
        response.sendRedirect("error");
    }
%>
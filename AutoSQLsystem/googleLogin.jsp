<%
    session.setAttribute("user",request.getParameter("userName"));
    session.setAttribute("email",request.getParameter("userEmail"));
    session.setAttribute("userImage",request.getParameter("userImageURL"));
    System.out.println(request.getParameter("userEmail"));
    response.sendRedirect("home");
%>
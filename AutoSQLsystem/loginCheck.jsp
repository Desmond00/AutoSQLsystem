<%@ include file="connect.jsp"%>
<%
	try{
		PreparedStatement ps = con.prepareStatement("select name from sqlusers where email=? and password=?");
		ps.setString(1,request.getParameter("email"));
		ps.setString(2,request.getParameter("pass"));
		ResultSet rs = ps.executeQuery();
		if(rs.next())
		{
			session.setAttribute("user",rs.getString("name"));
			session.setAttribute("email",request.getParameter("email"));
			out.println("OK");
		}
		else
		{
			out.println("<font class=\"reply\">emailID and password does not match</font>");
		}
		con.close();
	}
	catch(Exception e){out.println(e);}
 %>
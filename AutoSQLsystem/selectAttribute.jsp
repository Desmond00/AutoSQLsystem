<%@include file="connect.jsp"%>
<%@include file="menu.jsp"%>
<%@include file="userCheck.jsp"%>
<%
        String tableName = request.getParameter("tableName").toUpperCase();
        if(tableName != null)
        {
	            //now fetching table attributes from database
	            System.out.println("table name :"+tableName);
	            PreparedStatement ps1 = con.prepareStatement("select * from "+tableName);
	            ResultSet rs = ps1.executeQuery();
	            String attributes[] = new String[100];
	            String types[] = new String[100];
	            attributes[0] = types[0] = "all";
	            int count=1;
	            while(rs.next())
	            {
	                attributes[count] = rs.getString(1);
	                types[count] = rs.getString(2);
	                ++count;
	            }
	            session.setAttribute("atr",attributes);
	            session.setAttribute("tp",types);
	            int i;
%>


<html>
    <head>
        <link rel="stylesheet" href="assets/css/background.css">
        <link rel="stylesheet" href="assets/css/form.css">
        <link rel="stylesheet" href="assets/css/checkBox.css">
        <script src="assets/js/jquery-3.2.1.js"></script>
        <script src="assets/js/checkbox.js"></script>
    </head>
    <body>
        <form name="attributeForm" action="" method="post" onsubmit="return confirm();">
        <p>
            Table name:
            <%out.println(tableName);%>
            <br>
            Select table attributes:<br>
                <input type="hidden" name="tbname" value=<%=tableName%>>
                <br>
                <label class="container">
                <input type=checkbox name="all" value="all" onchange="all1(this)">all
                <span class="checkmark"></span><br>
                </label>
            <%
                for(i=1;i<count;i++)
                {
            %>
                <label class="container">
                        <input type=checkbox name=attribute value=<%=attributes[i]%> onchange="tap(this)"><%=attributes[i]%>(<%=types[i]%>)
                        <span class="checkmark"></span><br>
                </label>
            <%  }%>
            <div style="text-align:center">
                <div id="error"></div>
                <input type=submit value="Confirm Selection">
            </div>
        </p>
        </form>
    </body>
</html>


<%
		}
		else
		{
			out.println("<font class=reply style=\"display: inline; text-align:center;\">No table exists in your account</font>");
		}
%>
<script>
	function confirm()
	{
	    if(count > 0)
	    {
	        document.attributeForm.action="operations";
	        return true;
	    }
	    else
	    {
	        document.getElementById("error").innerHTML = "<font class=\"reply\">@@FIRST SELECT THE ATTRIBUTES</font>";
	        return false;
	    }
	}
</script>
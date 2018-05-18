<%@include file="connect.jsp"%>
<%
    session.setAttribute("email","user@gmail.com");
%>
<%
        //fetched table name from server according to user session stored email id  
        String email = (String)session.getAttribute("email");
        PreparedStatement ps = con.prepareStatement("select tbname from users where email=?");
        ps.setString(1,email);
        ResultSet rs = ps.executeQuery();
        rs.next();
        String table = rs.getString(1);
        
        //now fetching table attributes from database
        PreparedStatement ps1 = con.prepareStatement("select * from "+table);
        rs = ps1.executeQuery();
        String attributes[] = new String[20];
        String types[] = new String[20];
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
        <link rel="stylesheet" href="css/background.css">
        <link rel="stylesheet" href="css/form.css?version=4">
        <link rel="stylesheet" href="css/checkBox.css">
        <script src="js/jquery-3.2.1.js"></script>
        <script src="js/design.js"></script>
    </head>
    <body>
        <form name="attributeForm" action="" method="post" onsubmit="return confirm();">
        <p>
                Table name:
                <%out.println(table);%>
                <br>
                Table attributes to select:<br>
                    <input type="hidden" name="tbname" value=<%=table%>>
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
            <center>
                <div id="error"></div>
                <input type=submit value="confirmSelection">
            </center>
        </p>
        </form>
    </body>
</html>
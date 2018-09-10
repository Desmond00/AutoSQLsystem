<jsp:useBean id="table" class="user.TableDetails" scope="page"/>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap" %>
<%@include file="connect.jsp"%>
<%@include file="menu.jsp"%>
<%@include file="userCheck.jsp"%>

<head>
    <link rel="stylesheet" href="assets/css/background.css">
    <link rel="stylesheet" href="assets/css/form1.css">
</head>
<%
        //fetched table name from server according to user session stored email id 
        if(email != null)
        {	
        	//fetched table name from server according to user session stored email id
            LinkedHashMap<String, String> tableNames = table.getCreatedTableList(email);
            if(tableNames.size() != 0){
            
%>


<html>
    <head>
        <link rel="stylesheet" href="assets/css/checkBox.css">
        <script src="assets/js/jquery-3.2.1.js"></script>
        <script src="assets/js/checkbox.js"></script>
    </head>
    <body>
        <form name="attributeForm" action="" method="post" onsubmit="return confirm();">
        <p>
            <br>
            Select table:<br>
                <br>
            <%
                for(Map.Entry<String, String> entry: tableNames.entrySet())
                {
            %>
                <label class="container">
                        <input type=checkbox name=tableName value=<%=entry.getValue()+entry.getKey()%> onchange="tap(this)"><%=entry.getValue()%>
                        <span class="checkmark"></span><br>
                </label>
            <%  }%>
            <div style="text-align:center">
                <div id="error"></div>
                <input type=submit value="confirmSelection">
            </div>
        </p>
        </form>
    </body>
</html>


<%
            }
            else 
			out.println("<font class=reply style=\"display: block; text-align:center;\">No table exists in your account</font>");
		}
		else
		{
			out.println("<font class=reply style=\"display: inline; text-align:center;\">Email does not exist</font>");
		}
%>
<script>

function confirm()
{
    if(count > 0)
    {
        document.attributeForm.action="viewTable";
        return true;
    }
    else
    {
        document.getElementById("error").innerHTML = "<font class=\"reply\">@@FIRST SELECT THE ATTRIBUTES</font>";
        return false;
    }
}

</script>
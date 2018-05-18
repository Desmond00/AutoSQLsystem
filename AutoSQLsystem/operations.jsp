<%
    String attribute = request.getParameter("all");
    %><script><%
    out.println("var attribute=\""+attribute+"\";");
    if(attribute != null)
        out.println("var attribute=\""+attribute+"\";");
    String attributes1[] = new String[10];
    int i;

    if(attribute == null)//if all is not selected
    {
        //then getting the selected attributes in a javaScript array
        String attributes[] = request.getParameterValues("attribute");
        System.arraycopy(attributes,0,attributes1,0,attributes.length);
    }

    String DBattributes[] = (String[])session.getAttribute("atr");
    String DBtypes[] = (String[])session.getAttribute("tp");
    String table = request.getParameter("tbname");


    //passing the attributes of the whole table from JSP to javascript
    
        out.println("var attributes=[");
        for(i=0;DBattributes[i+1]!=null;i++)
        {
            out.println("\""+DBattributes[i]+"\",");
        }
        out.println("\""+DBattributes[i]+"\"];");


    //passing the types from JSP to javascript
    out.println("var types=[");
    for(i=0;DBtypes[i+1]!=null;i++)
    {
        out.println("\""+DBtypes[i]+"\",");
    }
    out.println("\""+DBtypes[i]+"\"];");

    //passing selected attributes from jsp to javascript
    if(attribute == null)
    {
        out.println("var Sattr=[");
        for(i=0;attributes1[i+1]!=null;i++)
        {
            out.println("\""+attributes1[i]+"\",");
        }
        out.println("\""+attributes1[i]+"\"];");
    }

    //passing the table name in database from JSP to javascript
    %>var table = <%out.println("\""+table+"\"");%></script>

<html>
    <head>
        <link rel="stylesheet" href="css/background.css?version=1">
        <link rel="stylesheet" href="css/form.css">
        <link rel="stylesheet" href="css/checkBox.css">
        <link rel="stylesheet" href="css/options.css">
        <link rel="stylesheet" href="css/button.css">
        <script src="js/jquery-3.2.1.js"></script>
        <script src="js/design.js"></script>
        <script src="js/operations.js"></script>
    </head>
    <body>
    <center>
        <p>
            Selected attributes:<br>
        <%
            if(attribute != null)
                out.println(1+">&nbsp&nbspall");
            else
            {
                for(i=0;attributes1[i]!=null;i++)
                    out.println((i+1)+">&nbsp&nbsp"+attributes1[i]+"<br>");
            }
        %>
        <form name="whereFrm">
            <div id="head">Select for where clause</div><br>
            <table>
                <tr>
                    <td>
                    <div class="select">
                        <select name="whereAtr" id="whereAtr" >
                            <option disabled=disabled>Choose attribute for where clause</option>
                            <%
                                for(i=1;DBattributes[i]!=null;i++)
                                    out.println("<option value=\""+DBattributes[i]+"\">"+DBattributes[i]+"</option>");
                            %>
                        </select>
                    </div>
                    </td>
                    <td>
                    <div class="select">
                        <select name="whereOpr" id="whereOpr" onchange="output()">
                            <option disabled=disabled>Choose arithmetic operator</option>
                            <option value="=">=</option>
                            <option value=">">></option>
                            <option value="<"><</option>
                            <option value=">=">>=</option>
                            <option value="<="><=</option>
                            <option value="<>"><></option>
                        </select>
                    </div>
                    </td>
                    <td>
                        <input type=text name="whereVal" id="whereVal" placeholder="Enter value to check or match">
                    </td>
                </tr>
            </table>
            <br><a class="button" id="show" href="#" onclick="output()" >Show Query</a><br><br>
            <!--
            <div id="head">Select Operations</div><br>
            <div class="select">
                <select name="slct" id="slct" onchange="output(this.value)">
                    <option disabled=disabled>Choose an option</option>
                    <option value="distinct">distinct</option>
                    <option value="min">min</option>
                    <option value="max">max</option>
                    <option value="avg">avg</option>
                    <option value="count">count</option>
                    <option value="sum">sum</option>
                </select>
            </div>
            -->
            <div id="error"></div>
            <textarea name="query" id="query" disabled="disable"></textarea>
        </form>
    </center>
    </body>
</html>

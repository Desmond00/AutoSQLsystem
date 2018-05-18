<html>
    <head>
        <title>DatabaseCreation</title>
        <script>
            function showTable(table)
            {
                //alert(table);
                if(table=="")
                {
                    document.getElementById("error").innerHTML="<font color=red>Enter table name</font>";
                }    
                else
                {
                    document.getElementById("error").style.display = "none";
                    document.getElementById("table").innerHTML = table;
                    document.getElementById("tb").style.display = "block";
                    document.getElementById("tableName").disabled = true;

                }
            }

            function attribute(no)
            {
                document.createDB.action="createDB.jsp?flag=1";
            }
        </script>
    </head>
    <body>
            <div class="formCont">
                <form name="createDB" method="pos" action="">
                    <center>
                        <h4>Create Database</h4>
                        Table Name<input type=text name="tableName" id="tableName" onblur="showTable(this.value)"><br>
                        <div id="error"></div><br>
                        Attributes
                        <select name=attributes id="attribute" onblur="attribute(this.value)">
                            <option disabled="disabled">Select no of attributes</option>
                            <%int i;
                            for(i=1;i<=10;i++){%>
                            <option value=<%=i%>><%=i%></option>
                            <%}%><br><br>
                        </select>
                    </center>
                </form>    
            </div>
    </body>
</html>
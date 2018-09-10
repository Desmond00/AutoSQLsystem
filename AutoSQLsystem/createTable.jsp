<%@include file="menu.jsp"%>
<%@include file="userCheck.jsp"%>
<%@include file="createTableLimitCheck.jsp"%>
<html>
    <head>
        <script src="assets/js/table.js"></script>
        <script src="assets/js/tableDataCheck.js"></script>
    </head>
    <body>
        <form name="tableAttributes" method=post action="insertColumnData" onsubmit="return fullCheck();">
        <center>
            <p>Table Name : <input type=text name="tableName" id="tableName"><br>
            Enter the number of columns of the table:
            <div class="select"> 
            <select id="columns" name="columns" onblur="showFields()">
                <option value="1">ONE</option>
                <option value="2">TWO</option>
                <option value="3">THREE</option>
                <option value="4">FOUR</option>
                <option value="5">FIVE</option>
                <option value="6">SIX</option>
                <option value="7">SEVEN</option>
                <option value="8">EIGHT</option>
                <option value="9">NINE</option>
                <option value="10">TEN</option>
            </select>
            </div>
            <br>
            <br>
            <table id="heads" class="table" style="display: none;">
                <tr>
                    <td>COLUMN NUMBER </td>
                    <td>COLUMN NAME </td>
                    <td>COLUMN TYPE </td>
                </tr>
            </table>
            <div id="tableNameError"></div>
            <div id="dataError"></div>
            <div id="button"></div>
            <%
                String message = request.getParameter("message");
                if(message != "" && message != " " && message != null)
                    out.println("<font class=reply>"+message+"</font>");
            %>
            </p>
        </center>
        </form>
    </body>
</html>
<% }
%>

<jsp:useBean id="insertData" class="user.stored" scope="page"/>

<%
    String message = "";
    String tableName = (String)request.getParameter("tableName");
    int AttributeNumbers= Integer.parseInt(request.getParameter("columns"));
    String names[] = new String[AttributeNumbers+1];
    String types[] = new String[AttributeNumbers+1];
    int i;
    for(i=1;i<=AttributeNumbers;i++)
    {
        names[i] = (String)request.getParameter("name"+i);
        types[i] = (String)request.getParameter("type"+i);
    }
    insertData.setNos(AttributeNumbers);
    insertData.setTableName(tableName);
    insertData.setAttributes(names);
    insertData.setTypes(types);
    insertData.setEmail((String)session.getAttribute("email"));
    if(insertData.createTable() == 1)
    {
        if(insertData.insertIntoTable() == 1)
            message = tableName+" table created successfully, use it from <a class=button id=show href=workWithCreatedTable>here</a>";
    }
    else
        message = "Error in table creation";
    response.sendRedirect("createTable?message="+message);
%>
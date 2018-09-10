<%@include file="connect.jsp"%>
<link rel="stylesheet" href="assets/css/background.css?version=1">
<link rel="stylesheet" href="assets/css/form.css?version=2">
<link rel="stylesheet" href="assets/css/options.css?version=1">
<link rel="stylesheet" href="assets/css/button.css">
<%

    String userEmail = (String)session.getAttribute("email");
    PreparedStatement ps = con.prepareStatement("select count(*) from createdtables where email='"+userEmail+"'");
    ResultSet rs = ps.executeQuery();
    int tableNo=0;
    if(rs.next()) {
        tableNo = rs.getInt(1);
    }
    if(tableNo >= 5) {
        out.println("<font class=reply style=\"display:block; position:relative; text-align:center\">No further tables can be created using this account, please <a class=button href=deletCreatedTables> delete table(s)</a> to create new</font>");
    }
    else {
%>
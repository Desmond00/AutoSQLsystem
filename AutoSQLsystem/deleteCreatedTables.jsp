<%@include file="connect.jsp"%>
<link rel="stylesheet" href="assets/css/background.css?version=1">
<link rel="stylesheet" href="assets/css/form.css?version=2">
<link rel="stylesheet" href="assets/css/options.css?version=1">
<link rel="stylesheet" href="assets/css/button.css">
<link rel="stylesheet" href="assets/css/checkBox.css">
<script src="assets/js/jquery-3.2.1.js"></script>
<script src="assets/js/checkbox.js"></script>


<%
    String userEmail = (String)session.getAttribute("email");
    PreparedStatement ps = con.prepareStatement("select count(*) from createdtables where email='"+userEmail+"'");
    ResultSet rs = ps.executeQuery();
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

%>
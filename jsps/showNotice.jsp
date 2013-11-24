<!DOCTYPE html>
<!-- This file displays the notice of the group when selected from the GroupInfo page -->
<html>
<head>
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
</head>

<body> 
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@include file="add_header.jsp"%>
<div id="container">
    <p class="homePage">Go back to <A class="homePage" href=<%=encodeHomePage%>>Home Page</a></p>
    <div id="subContainer" style="width:300px">
    <%@include file="db_login.jsp"%>
    <%
    String encodeGroup = response.encodeURL("GroupInfo.jsp");
    String group_name = request.getParameter("group");
    String notice = "No notices";
    String sql = ("select gl.notice from group_lists gl, groups g " +
                  "where gl.group_id=g.group_id and " +
                  "g.group_name='" + group_name + "' " +
                  "and gl.friend_id='" + session_user + "'");

    Statement stmt = conn.createStatement();
    ResultSet noticeSet = stmt.executeQuery(sql);

    if (noticeSet.next()) {
        String val = noticeSet.getString(1);
        if (val != null) 
            notice = val;
    } %>
    Notice: <%=notice%>
    <a id='buttonstyle' href='<%=encodeGroup%>'>Go back to group page</a>
    <%@include file="db_logout.jsp"%>
    </div>
</div>
</body>
</html>

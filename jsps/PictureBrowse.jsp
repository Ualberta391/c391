<html>
<head>
<title>Photo List</title>
<link rel='stylesheet' type='text/css' href='mystyle.css'>
<%@include file="db_login.jsp"%>
<%
    List<String> valid_ids = new ArrayList<String>(); // For all images
    List<String> top_ids = new ArrayList<String>(); // For the top 5 images

    String encodeUpload = response.encodeURL("UploadImage.jsp");
    String encodeDisplay1 = response.encodeURL("DisplayImage.jsp");    
    String encodeGet1 = response.encodeURL("GetOnePic");

    String username = String.valueOf(session.getAttribute("username"));
    String pic_id = "";
    String owner_name = "";
    String sql = "";
    int permitted = 0;
    boolean is_friend = false;
    int top_count = 0;
    int last_count = 0;

    // Get all photos that are able to be seen by the current user
    Statement photo_id_stmt = conn.createStatement();
    Statement access_control_stmt = conn.createStatement();
    ResultSet ids_rset = photo_id_stmt.executeQuery("select photo_id from images");
    while (ids_rset.next()) {
        is_friend = false;
        pic_id = ids_rset.getObject(1).toString();
        sql = "select owner_name, permitted from images where photo_id=" + pic_id;
        ResultSet ctrl_rset = access_control_stmt.executeQuery(sql);
        if (ctrl_rset.next()) {
            owner_name = ctrl_rset.getString(1);
            permitted = ctrl_rset.getInt(2);
        }
        
        sql = "select friend_id from group_lists where group_id=" + permitted;
        ResultSet rset3 = access_control_stmt.executeQuery(sql);
        while (rset3.next()) {
            if (rset3.getString(1).equals(username))
                is_friend = true;
        }
        if (owner_name.equals(username) || permitted == 1 || username.equals("admin") || is_friend)
            valid_ids.add(pic_id);
    }
    photo_id_stmt.close();
    access_control_stmt.close();

    // Get the top 5 photos that are able to be seen by the current user
    Statement top_pics_stmt = conn.createStatement();
    sql = ("select photo_id, count(photo_id) from picture_hits group by " +
           "photo_id order by count(photo_id) desc");
    ResultSet top_pics_rset = top_pics_stmt.executeQuery(sql);
    while (top_count < 5 && top_pics_rset.next())  {
        pic_id = top_pics_rset.getString(1);
        if (valid_ids.contains(pic_id)) {
            top_ids.add(pic_id);
            last_count = top_pics_rset.getInt(2);
            top_count += 1;
        }
    }

    // In case of a tie, display all tied images
    while (top_pics_rset.next()) {
        pic_id = top_pics_rset.getString(1);
        if (top_pics_rset.getInt(2) == last_count) { 
            if (valid_ids.contains(pic_id))
                top_ids.add(pic_id);
        } else {
            break;
        }
    }
%>
<%@ page import="java.sql.*, java.text.*, java.util.*" %>
<%@include file="db_logout.jsp"%>
</head>
<body>
    <div id='header'>
    <p>&nbsp;</p>
    <% if (request.getSession(false).getAttribute("username") != null) {
           out.println("<p id='username'>You are logged in as "+username+"</p>");

           String encode = response.encodeURL("logout.jsp");
           out.println("<A id='signout' href='"+response.encodeURL (encode)+"'>(Logout)</a>");
       } else {
           response.sendRedirect("main.jsp");
       }
       String encodeHomePage = response.encodeURL("home.jsp");
    %>
    </div>

<div id="container">
<p class='homePage'>Go back to <A class='homePage' href='<%= encodeHomePage %>'>Home Page</a></p>
<center>
<h3> Top 5 Images </h3>
<% for (String top_id : top_ids) {
     // Encode DisplayImage.jsp link
    String encodeDisplay2 = encodeDisplay1+"?id="+top_id;
    out.println("<a href='"+encodeDisplay2+"'>");

    // Encode the GetOnePic servlet
    String encodeGet2 = encodeGet1+"?"+top_id;
    out.println("<img src='"+encodeGet2+"'></a>");
    }
%>
<h3> All Images </h3>
<% for (String p_id : valid_ids) { 
    // Encode DisplayImage.jsp link
    String encodeDisplay2 = encodeDisplay1+"?id="+p_id;
    out.println("<a href='"+encodeDisplay2+"'>");

    // Encode the GetOnePic servlet
    String encodeGet2 = encodeGet1+"?"+p_id;
    out.println("<img src='"+encodeGet2+"'></a>");
    }
%>
<form action="<%= encodeUpload %>">
<input type="submit" value="Add More Photos">
</form>
</center>
</div>
</body>
</html>

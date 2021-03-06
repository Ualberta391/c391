<!-- Creates a header at the top of the JSP page for logging out.
     This is extracted out to the addHeader.jsp module to reduce
     code duplication.
-->
<div id="header">
    <p>&nbsp;</p>
<%  
    //If there is such attribute as username, this means the user entered 
    //this page through correct navigation (logging in) and is 
    //supposed to be here.
    String session_user = "";
    if(request.getSession(false).getAttribute("username") != null) {
        session_user = String.valueOf(session.getAttribute("username"));
        String encode = response.encodeURL("/proj1/user_management/logout.jsp"); 
        String encode2 = response.encodeURL("/proj1/util/userdoc.jsp"); %>
        <p id='username'>You are logged in as <%= session_user %></p>
        <a id='signout' href='<%= response.encodeUrl(encode) %>'>(Logout)</a>
        <a id='userdoc' href='<%= response.encodeUrl(encode2) %>'>Help Menu</a>
 <% } else {
        //If user entered this page without logging in or after logging out, 
        //redirect user back to main.jsp
        response.sendRedirect("/proj1/user_management/main.jsp");
    }
    //Encode the homePage link
    String encodeHomePage = response.encodeURL("/proj1/home.jsp");
%>
</div>

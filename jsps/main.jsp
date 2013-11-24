<!DOCTYPE html>
<html>
<head>
<title>Main</title>
<link rel="stylesheet" type="text/css" href="mystyle.css">
<!--Code from http://jsfiddle.net/viralpatel/nSjy7/ -->
<script>
    function isNumberKey(evt){
        var charCode = (evt.which)? evt.which : event.keyCode
        if(charCode>31 && (charCode < 48 || charCode > 57))
            return false;
        return true;
    }
</script>
</head>
<body>
    <div id = "header">
        <marquee behavior="scroll" direction="left"><b><h1>CMPUT 391</h1></b></marquee>
        <marquee behavior="scroll" direction="left"><h4>Creators: Scott Vig, Valerie Sawyer, Zhan Yap</h4></marquee>
    </div>
    
    <div id="container">
        <div id="register">
            <form NAME="RegisterForm" ACTION="register.jsp" METHOD="post">
                <Fieldset>
                <legend>Sign Up</legend>
                <TABLE>
                    <TR VALIGN=TOP ALIGN=LEFT>
                        <TD><B>Username:</B></TD>
                        <TD><INPUT TYPE="text" NAME="username" MAXLENGTH="24" VALUE="Username"><BR></TD>
                    </TR>
                    <TR VALIGN=TOP ALIGN=LEFT>
                        <TD><B>Password:</B></TD>
                        <TD><INPUT TYPE="password" NAME="password" MAXLENGTH="24" VALUE="Password"></TD>
                    </TR>
                    <TR VALIGN=TOP ALIGN=LEFT>
                        <TD><B>First Name:</B></TD>
                        <TD><INPUT TYPE="text" NAME="first" MAXLENGTH="24" VALUE="First Name"></TD>
                    </TR>
                    <TR VALIGN=TOP ALIGN=LEFT>
                        <TD><B>Last Name:</B></TD>
                        <TD><INPUT TYPE="text" NAME="last" MAXLENGTH="24" VALUE="Last Name"></TD>
                    </TR>
                    <TR VALIGN=TOP ALIGN=LEFT>
                        <TD><B>Address:</B></TD>
                        <TD><INPUT TYPE="text" NAME="address" MAXLENGTH="128" VALUE="Address"></TD>
                    </TR>
                    <TR VALIGN=TOP ALIGN=LEFT>
                        <TD><B>Email:</B></TD>
                        <TD><INPUT TYPE="text" NAME="email" MAXLENGTH="128" VALUE="Email"></TD>
                    </TR>
                    <TR VALIGN=TOP ALIGN=LEFT>
                        <TD><B>Phone:</B></TD>
                        <TD><INPUT TYPE="number" NAME="phone" MAXLENGTH="10" VALUE="000000000" onkeypress="return isNumberKey(event)"></TD>
                    </TR>
                </TABLE>
                    <INPUT TYPE="submit" ID="buttonstyle" NAME="aSubmit" VALUE="Register">
                </Fieldset>
            </form>
        </div>
        
        <div id="login">
            <form NAME="LoginForm" ACTION="authentication.jsp" METHOD="post">
                <Fieldset>
                <legend>Login</legend>
                <TABLE>
                    <TR VALIGN=TOP ALIGN=LEFT>
                        <TD><B>Username:</B></TD>
                        <TD><INPUT TYPE="text" NAME="username" VALUE="Username"><BR></TD>
                    </TR>
                    <TR VALIGN=TOP ALIGN=LEFT>
                        <TD><B>Password:</B></TD>
                        <TD><INPUT TYPE="password" NAME="password" VALUE="Password"></TD>
                    </TR>
                </TABLE>
                    <INPUT TYPE="submit" ID="buttonstyle" NAME="bSubmit" VALUE="Login">
                </Fieldset>
            </form>
        </div>
        
        <%@ page import="java.sql.*" %>
        <%
            //Testing for specific attribute (username) in session, if it is a new session or not
            //If it is not a new session, return the user the home page, the user must log out to login under another us
            if(request.getSession(false).getAttribute("username")!= null){
                String encode = response.encodeURL("home.jsp");
                response.sendRedirect(encode);  
            }
        %>
    </div>
</body>
</html>

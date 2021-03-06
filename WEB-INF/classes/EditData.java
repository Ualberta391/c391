/***
    Servlet for editing the meta information associated with the image.
    This servlet is called when the user presses the Edit Photo Information button
    in the display/displayImage.jsp and fills out the appropriate information
***/

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import java.text.*;
import oracle.sql.*;
import oracle.jdbc.*;

public class EditData extends HttpServlet {
    public void doPost(HttpServletRequest request,HttpServletResponse response)
	throws ServletException, IOException {
        // Parameters to connect to the oracle database
        String username = "c391g5";
        String password = "radiohead7";
        String drivername = "oracle.jdbc.driver.OracleDriver";
        String dbstring ="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

        String description = "";
        String place = "";
        String subject = "";
        String groups = "";
        String time = "";
        java.sql.Date sql_date = null;
        String pic_id = "";

        try {
            // Get the new photo information values from the ajax call
            description = request.getParameter("description").toString();
            place = request.getParameter("place").toString();
            subject = request.getParameter("subject").toString();
            groups = request.getParameter("groups").toString();
            time = request.getParameter("time").toString();
            pic_id = request.getParameter("id").toString();

            SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy");
            java.util.Date parsed = format.parse(time);
            sql_date = new java.sql.Date(parsed.getTime());

            // Connect to the database and create a statement
            Class drvClass = Class.forName(drivername);
            DriverManager.registerDriver((Driver) drvClass.newInstance());
            Connection conn = DriverManager.getConnection(dbstring, username, password);
            Statement stmt = conn.createStatement();
            
            // Update the photo information
            stmt.executeQuery("UPDATE images set PLACE='"+place+"', PERMITTED='"+groups+
                              "', DESCRIPTION='"+description+"', TIMING=date'"+sql_date+
                              "', SUBJECT='"+subject+"' WHERE photo_id="+pic_id);
            stmt.executeUpdate("commit");
            conn.close();
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class VisitorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String student_id = request.getParameter("student_id");
        String visitor_name = request.getParameter("visitor_name");
        String relation = request.getParameter("relation");
        String in_time = request.getParameter("in_time");
        String out_time = request.getParameter("out_time");
        String date = request.getParameter("date");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root","");

            if (id == null || id.equals("")) {
                PreparedStatement ps = con.prepareStatement("INSERT INTO visitors (student_id, visitor_name, relation, in_time, out_time, date) VALUES (?, ?, ?, ?, ?, ?)");
                ps.setInt(1, Integer.parseInt(student_id));
                ps.setString(2, visitor_name);
                ps.setString(3, relation);
                ps.setTime(4, java.sql.Time.valueOf(in_time ));
                ps.setTime(5, java.sql.Time.valueOf(out_time ));
                ps.setDate(6, java.sql.Date.valueOf(date));
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Visitor Successfully Added');window.location='visitor_list.jsp';</script>");
            } else {
                PreparedStatement ps = con.prepareStatement( "UPDATE visitors SET student_id=?, visitor_name=?, relation=?, in_time=?, out_time=?, date=? WHERE visitor_id=?");
                ps.setInt(1, Integer.parseInt(student_id));
                ps.setString(2, visitor_name);
                ps.setString(3, relation);
                ps.setTime(4, java.sql.Time.valueOf(in_time ));
                ps.setTime(5, java.sql.Time.valueOf(out_time ));
                ps.setDate(6, java.sql.Date.valueOf(date));
                ps.setInt(7, Integer.parseInt(id));
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Visitor Successfully Updated');window.location='visitor_list.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        if ("delete".equals(action)) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "" );
                PreparedStatement ps = con.prepareStatement("DELETE FROM visitors WHERE visitor_id=?");
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Visitor Successfully Deleted');window.location='visitor_list.jsp';</script>");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

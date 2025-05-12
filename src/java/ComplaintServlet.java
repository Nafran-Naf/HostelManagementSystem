import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class ComplaintServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String student_id = request.getParameter("student_id");
        String date_raised = request.getParameter("date_raised");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");

            if (id == null || id.equals("")) {
                // INSERT
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO complaints(student_id, category, description, status, date_raised) VALUES (?, ?, ?, ?, ?)"
                );
                ps.setInt(1, Integer.parseInt(student_id));
                ps.setString(2, category);
                ps.setString(3, description);
                ps.setString(4, status);
                ps.setDate(5, java.sql.Date.valueOf(date_raised));
                ps.executeUpdate();

                response.getWriter().println("<script>alert('Complaint Successfully Added');window.location='complaint_list.jsp';</script>");
            } else {
                // UPDATE
                PreparedStatement ps = con.prepareStatement("UPDATE complaints SET student_id=?, category=?, description=?, status=?, date_raised=? WHERE complaint_id=?");
                ps.setInt(1, Integer.parseInt(student_id));
                ps.setString(2, category);
                ps.setString(3, description);
                ps.setString(4, status);
                ps.setDate(5, java.sql.Date.valueOf(date_raised));
                ps.setInt(6, Integer.parseInt(id));
                ps.executeUpdate();

                response.getWriter().println("<script>alert('Complaint Successfully Updated');window.location='complaint_list.jsp';</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('An error occurred. Check server logs.');window.location='complaint_list.jsp';</script>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        if ("delete".equals(action)) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");
                PreparedStatement ps = con.prepareStatement("DELETE FROM complaints WHERE complaint_id=?");
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Complaint Successfully Deleted');window.location='complaint_list.jsp';</script>");
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("<script>alert('An error occurred while deleting.');window.location='complaint_list.jsp';</script>");
            }
        }
    }
}

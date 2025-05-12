import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class AttendanceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String student_id = request.getParameter("student_id");
        String date = request.getParameter("date");
        String status = request.getParameter("status");
        String remarks = request.getParameter("remarks");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");

            if (id == null || id.equals("")) {
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO attendance(student_id, date, status, remarks) VALUES(?, ?, ?, ?)"
                );
                ps.setInt(1, Integer.parseInt(student_id));
                ps.setDate(2, java.sql.Date.valueOf(date));
                ps.setString(3, status);
                ps.setString(4, remarks);
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Attendance Successfully Added');window.location='attendance_list.jsp';</script>");
            } else {
                PreparedStatement ps = con.prepareStatement(
                    "UPDATE attendance SET student_id=?, date=?, status=?, remarks=? WHERE attendance_id=?"
                );
                ps.setInt(1, Integer.parseInt(student_id));
                ps.setDate(2, java.sql.Date.valueOf(date));
                ps.setString(3, status);
                ps.setString(4, remarks);
                ps.setInt(5, Integer.parseInt(id));
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Attendance Successfully Updated');window.location='attendance_list.jsp';</script>");
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
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");
                PreparedStatement ps = con.prepareStatement("DELETE FROM attendance WHERE attendance_id=?");
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Attendance Successfully Deleted');window.location='attendance_list.jsp';</script>");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

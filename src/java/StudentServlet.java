import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class StudentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String course = request.getParameter("course");
        String join_date = request.getParameter("join_date");
        String status = request.getParameter("status");
        String room_id = request.getParameter("room_id"); // new for room id

        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");

            if (id == null || id.isEmpty()) {
                // Insert new student
                PreparedStatement ps = con.prepareStatement("INSERT INTO students(name, email, phone, gender, course, join_date, status, room_id) VALUES(?,?,?,?,?,?,?,?)");
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, phone);
                ps.setString(4, gender);
                ps.setString(5, course);
                ps.setString(6, join_date);
                ps.setString(7, status);
                if (room_id == null || room_id.isEmpty()) {
                    ps.setNull(8, Types.INTEGER);
                } else {
                    ps.setInt(8, Integer.parseInt(room_id));
                }
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Successfully Added');window.location='student_list.jsp';</script>");
            } else {
                // Update existing student
                PreparedStatement ps = con.prepareStatement("UPDATE students SET name=?, email=?, phone=?, gender=?, course=?, join_date=?, status=?, room_id=? WHERE student_id=?");
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, phone);
                ps.setString(4, gender);
                ps.setString(5, course);
                ps.setString(6, join_date);
                ps.setString(7, status);
                if (room_id == null || room_id.isEmpty()) {
                    ps.setNull(8, Types.INTEGER);
                } else {
                    ps.setInt(8, Integer.parseInt(room_id));
                }
                ps.setInt(9, Integer.parseInt(id));
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Successfully Updated');window.location='student_list.jsp';</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Error Occurred');window.location='student_list.jsp';</script>");
        } finally {
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        if ("delete".equals(action) && id != null && !id.isEmpty()) {
            Connection con = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");
                PreparedStatement ps = con.prepareStatement("DELETE FROM students WHERE student_id=?");
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Successfully Deleted');window.location='student_list.jsp';</script>");
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("<script>alert('Error Occurred');window.location='student_list.jsp';</script>");
            } finally {
                try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }
}

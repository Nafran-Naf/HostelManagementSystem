import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class StaffServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String role = request.getParameter("role");
        String contact = request.getParameter("contact");
        String shift = request.getParameter("shift");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");

            if(id == null || id.trim().isEmpty()) {
                PreparedStatement ps = con.prepareStatement("INSERT INTO staff(name, role, contact, shift) VALUES(?,?,?,?)");
                ps.setString(1, name);
                ps.setString(2, role);
                ps.setString(3, contact);
                ps.setString(4, shift);
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Staff Successfully Added');window.location='staff_list.jsp';</script>");
            } else {
                PreparedStatement ps = con.prepareStatement("UPDATE staff SET name=?, role=?, contact=?, shift=? WHERE staff_id=?");
                ps.setString(1, name);
                ps.setString(2, role);
                ps.setString(3, contact);
                ps.setString(4, shift);
                ps.setInt(5, Integer.parseInt(id));
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Staff Successfully Updated');window.location='staff_list.jsp';</script>");
            }

            con.close();
        } catch(Exception e){
            e.printStackTrace();
            response.getWriter().println("<script>alert('Operation Failed');window.location='staff_list.jsp';</script>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        if("delete".equals(action) && id != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");
                PreparedStatement ps = con.prepareStatement("DELETE FROM staff WHERE staff_id=?");
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
                con.close();
                response.getWriter().println("<script>alert('Staff Successfully Deleted');window.location='staff_list.jsp';</script>");
            } catch(Exception e){
                e.printStackTrace();
                response.getWriter().println("<script>alert('Delete Failed');window.location='staff_list.jsp';</script>");
            }
        }
    }
}

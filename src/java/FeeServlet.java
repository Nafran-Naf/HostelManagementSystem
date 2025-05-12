import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class FeeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String student_id = request.getParameter("student_id");
        String amount = request.getParameter("amount");
        String due_date = request.getParameter("due_date");
        String payment_date = request.getParameter("payment_date");
        String status = request.getParameter("status");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");

            if (id == null || id.isEmpty()) {
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO fees(student_id, amount, due_date, payment_date, status) VALUES (?, ?, ?, ?, ?)"
                );
                ps.setInt(1, Integer.parseInt(student_id));
                ps.setBigDecimal(2, new java.math.BigDecimal(amount));
                ps.setDate(3, due_date == null || due_date.isEmpty() ? null : java.sql.Date.valueOf(due_date));
                ps.setDate(4, payment_date == null || payment_date.isEmpty() ? null : java.sql.Date.valueOf(payment_date));
                ps.setString(5, status);
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Fee Successfully Added');window.location='fee_list.jsp';</script>");
            } else {
                PreparedStatement ps = con.prepareStatement( "UPDATE fees SET student_id=?, amount=?, due_date=?, payment_date=?, status=? WHERE fee_id=?");
                ps.setInt(1, Integer.parseInt(student_id));
                ps.setBigDecimal(2, new java.math.BigDecimal(amount));
                ps.setDate(3, due_date == null || due_date.isEmpty() ? null : java.sql.Date.valueOf(due_date));
                ps.setDate(4, payment_date == null || payment_date.isEmpty() ? null : java.sql.Date.valueOf(payment_date));
                ps.setString(5, status);
                ps.setInt(6, Integer.parseInt(id));
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Fee Successfully Updated');window.location='fee_list.jsp';</script>");
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
                PreparedStatement ps = con.prepareStatement("DELETE FROM fees WHERE fee_id=?");
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Fee Successfully Deleted');window.location='fee_list.jsp';</script>");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

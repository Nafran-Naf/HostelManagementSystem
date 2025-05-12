import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class RoomServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String room_number = request.getParameter("room_number");
        String block = request.getParameter("block");
        String capacity = request.getParameter("capacity");
        String current_occupancy = request.getParameter("current_occupancy");
        String room_type = request.getParameter("room_type");
        String status = request.getParameter("status");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");

            if(id == null || id.equals("")) {
                PreparedStatement ps = con.prepareStatement("INSERT INTO rooms(room_number, block, capacity, current_occupancy, room_type, status) VALUES(?,?,?,?,?,?)");
                ps.setString(1, room_number);
                ps.setString(2, block);
                ps.setInt(3, Integer.parseInt(capacity));
                ps.setInt(4, Integer.parseInt(current_occupancy));
                ps.setString(5, room_type);
                ps.setString(6, status);
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Room Successfully Added');window.location='room_list.jsp';</script>");
            } else {
                PreparedStatement ps = con.prepareStatement("UPDATE rooms SET room_number=?, block=?, capacity=?, current_occupancy=?, room_type=?, status=? WHERE room_id=?");
                ps.setString(1, room_number);
                ps.setString(2, block);
                ps.setInt(3, Integer.parseInt(capacity));
                ps.setInt(4, Integer.parseInt(current_occupancy));
                ps.setString(5, room_type);
                ps.setString(6, status);
                ps.setInt(7, Integer.parseInt(id));
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Room Successfully Updated');window.location='room_list.jsp';</script>");
            }
        } catch(Exception e){
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        if("delete".equals(action)) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");
                PreparedStatement ps = con.prepareStatement("DELETE FROM rooms WHERE room_id=?");
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
                response.getWriter().println("<script>alert('Room Successfully Deleted');window.location='room_list.jsp';</script>");
            } catch(Exception e){
                e.printStackTrace();
            }
        }
    }
}

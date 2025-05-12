<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    String name = "", email = "", phone = "", gender = "", course = "", join_date = "", status = "active", room_id = "";

    if(id != null){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM students WHERE student_id=?");
            ps.setInt(1, Integer.parseInt(id));
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                name = rs.getString("name");
                email = rs.getString("email");
                phone = rs.getString("phone");
                gender = rs.getString("gender");
                course = rs.getString("course");
                join_date = rs.getString("join_date");
                status = rs.getString("status");
                room_id = rs.getString("room_id");
            }
            rs.close();
            ps.close();
            con.close();
        } catch(Exception e){
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= (id != null ? "Edit" : "Add") %> Student</title>
    <link href="bootstrap-5.3.5-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #ffecd2, #fcb69f);
            font-family: 'Poppins', sans-serif;
        }
        .custom-navbar {
            background: #ffffffcc;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 1rem 2rem;
            border-radius: 0 0 20px 20px;
            margin-bottom: 1rem;
          }
        .main-heading {
            font-size: 2.5rem;
            font-weight: 700;
            color: #212529;
            margin-bottom: 0;
            text-shadow: 1px 1px #ffffff;
        }
        form {
            background: #fff;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 1rem 2rem rgba(0, 0, 0, 0.1);
            max-width: 700px;
            margin: auto;
        }
        .form-control, .form-select {
            border-radius: 12px;
            padding: 0.75rem;
        }
        .btn {
            border-radius: 10px;
            font-weight: 600;
            padding: 0.5rem 1.2rem;
        }
        .form-label {
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="custom-navbar text-center">
        <h2 class="main-heading"><%= (id != null ? "Edit" : "Add ") %>Student</h2>
    </div>
                                                


<form action="StudentServlet" method="post">
    <input type="hidden" name="id" value="<%= id != null ? id : "" %>">

    <div class="mb-3">
        <label class="form-label">Name</label>
        <input type="text" class="form-control" name="name" value="<%= name %>" required>
    </div>

    <div class="mb-3">
        <label class="form-label">Email</label>
        <input type="email" class="form-control" name="email" value="<%= email %>" required>
    </div>

    <div class="mb-3">
        <label class="form-label">Phone</label>
        <input type="text" class="form-control" name="phone" value="<%= phone %>">
    </div>

    <div class="mb-3">
        <label class="form-label">Gender</label>
        <select class="form-select" name="gender" required>
            <option value="">Select Gender</option>
            <option value="Male" <%= "Male".equals(gender) ? "selected" : "" %>>Male</option>
            <option value="Female" <%= "Female".equals(gender) ? "selected" : "" %>>Female</option>
        </select>
    </div>

    <div class="mb-3">
        <label class="form-label">Course</label>
        <input type="text" class="form-control" name="course" value="<%= course %>">
    </div>

    <div class="mb-3">
        <label class="form-label">Join Date</label>
        <input type="date" class="form-control" name="join_date" value="<%= join_date %>">
    </div>

    <div class="mb-3">
        <label class="form-label">Status</label>
        <select class="form-select" name="status">
            <option value="active" <%= "active".equals(status) ? "selected" : "" %>>Active</option>
            <option value="inactive" <%= "inactive".equals(status) ? "selected" : "" %>>Inactive</option>
        </select>
    </div>

    <div class="mb-3">
        <label class="form-label">Room</label>
        <select class="form-select" name="room_id">
            <option value="">-- Select Room --</option>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conRoom = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");
        Statement stmtRoom = conRoom.createStatement();
        ResultSet rsRoom = stmtRoom.executeQuery("SELECT room_id, room_number FROM rooms");
        while(rsRoom.next()){
            String selected = (room_id != null && room_id.equals(String.valueOf(rsRoom.getInt("room_id")))) ? "selected" : "";
%>
            <option value="<%= rsRoom.getInt("room_id") %>" <%= selected %>><%= rsRoom.getString("room_number") %></option>
<%
        }
        rsRoom.close();
        stmtRoom.close();
        conRoom.close();
    } catch(Exception e){ e.printStackTrace(); }
%>
        </select>
    </div>

    <button type="submit" class="btn btn-success">Save</button>
    <a href="student_list.jsp" class="btn btn-secondary">Back</a>
</form>

</body>
</html>

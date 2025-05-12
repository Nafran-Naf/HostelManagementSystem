<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    String name = "", role = "", contact = "", shift = "";

    if(id != null){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM staff WHERE staff_id=?");
            ps.setInt(1, Integer.parseInt(id));
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                name = rs.getString("name");
                role = rs.getString("role");
                contact = rs.getString("contact");
                shift = rs.getString("shift");
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
    <title><%= (id != null ? "Edit" : "Add") %> Staff</title>
    <link href="bootstrap-5.3.5-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
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
<body class="container">
    <div class="custom-navbar text-center">
        <h2 class="main-heading"><%= (id != null ? "Edit" : "Add") %> Staff</h2>
    </div>


<form action="StaffServlet" method="post">
    <input type="hidden" name="id" value="<%= id != null ? id : "" %>">

    <div class="mb-3">
        <label>Name</label>
        <input type="text" class="form-control" name="name" value="<%= name %>" required>
    </div>

    <div class="mb-3">
        <label>Role</label>
        <select class="form-control" name="role" required>
            <option value="">Select Role</option>
            <option value="warden" <%= "warden".equals(role) ? "selected" : "" %>>Warden</option>
            <option value="cleaning" <%= "cleaning".equals(role) ? "selected" : "" %>>Cleaning</option>
            <option value="security" <%= "security".equals(role) ? "selected" : "" %>>Security</option>
            <option value="maintenance" <%= "maintenance".equals(role) ? "selected" : "" %>>Maintenance</option>
        </select>
    </div>

    <div class="mb-3">
        <label>Contact</label>
        <input type="text" class="form-control" name="contact" value="<%= contact %>" required>
    </div>

    <div class="mb-3">
    <label>Shift</label>
    <select class="form-control" name="shift" required>
        <option value="">Select Shift</option>
        <option value="Day" <%= "Day".equalsIgnoreCase(shift) ? "selected" : "" %>>Day</option>
        <option value="Night" <%= "Night".equalsIgnoreCase(shift) ? "selected" : "" %>>Night</option>
        <option value="Full" <%= "Full".equalsIgnoreCase(shift) ? "selected" : "" %>>Full</option>
    </select>
    </div>

    <button type="submit" class="btn btn-success">Save</button>
    <a href="staff_list.jsp" class="btn btn-secondary">Back</a>
</form>

</body>
</html>

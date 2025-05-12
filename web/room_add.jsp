<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    String room_number = "", block = "", room_type = "single", status = "available";
    int capacity = 1, current_occupancy = 0;
    if(id != null){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM rooms WHERE room_id=?");
            ps.setInt(1, Integer.parseInt(id));
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                room_number = rs.getString("room_number");
                block = rs.getString("block");
                capacity = rs.getInt("capacity");
                current_occupancy = rs.getInt("current_occupancy");
                room_type = rs.getString("room_type");
                status = rs.getString("status");
            }
        } catch(Exception e){
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= (id != null ? "Edit" : "Add ") %> Room</title>
   <link href="bootstrap-5.3.5-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
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
<body class="container">
    <div class="custom-navbar text-center">
        <h2><%= (id != null ? "Edit" : "Add") %> Room</h2>
    </div>


<form action="RoomServlet" method="post">
    <input type="hidden" name="id" value="<%= id != null ? id : "" %>">

    <div class="mb-3">
        <label>Room Number</label>
        <input type="text" class="form-control" name="room_number" value="<%= room_number %>" required>
    </div>

    <div class="mb-3">
        <label>Block</label>
        <input type="text" class="form-control" name="block" value="<%= block %>">
    </div>

    <div class="mb-3">
        <label>Capacity</label>
        <input type="number" class="form-control" name="capacity" value="<%= capacity %>" min="1">
    </div>

    <div class="mb-3">
        <label>Current Occupancy</label>
        <input type="number" class="form-control" name="current_occupancy" value="<%= current_occupancy %>" min="0">
    </div>

    <div class="mb-3">
        <label>Room Type</label>
        <select class="form-control" name="room_type">
            <option value="single" <%= "single".equals(room_type) ? "selected" : "" %>>Single</option>
            <option value="shared" <%= "shared".equals(room_type) ? "selected" : "" %>>Shared</option>
        </select>
    </div>

    <div class="mb-3">
        <label>Status</label>
        <select class="form-control" name="status">
            <option value="available" <%= "available".equals(status) ? "selected" : "" %>>Available</option>
            <option value="full" <%= "full".equals(status) ? "selected" : "" %>>Full</option>
        </select>
    </div>

    <button type="submit" class="btn btn-success">Save</button>
    <a href="room_list.jsp" class="btn btn-secondary">Back</a>
</form>

</body>
</html>

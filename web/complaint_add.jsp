<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    String student_id = "", date_raised = "", category = "", description = "", status = "";
    if (id != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM complaints WHERE complaint_id=?");
            ps.setInt(1, Integer.parseInt(id));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                student_id = rs.getString("student_id");
                date_raised = rs.getString("date_raised");
                category = rs.getString("category");
                description = rs.getString("description");
                status = rs.getString("status");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= (id != null ? "Edit" : "Add") %> Complaint</title>
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
        <h2 class="main-heading"><%= (id != null ? "Edit" : "Add")%> Complaint</h2>
    </div>

<form action="ComplaintServlet" method="post">
    <input type="hidden" name="id" value="<%= id != null ? id : "" %>">

    <div class="mb-3">
        <label>Student ID</label>
        <input type="number" class="form-control" name="student_id" value="<%= student_id %>" required>
    </div>

    <div class="mb-3">
        <label>Category</label>
        <select class="form-control" name="category" required>
            <option value="">-- Select Category --</option>
            <option value="Plumbing" <%= "Plumbing".equals(category) ? "selected" : "" %>>Plumbing</option>
            <option value="Electric" <%= "Electric".equals(category) ? "selected" : "" %>>Electric</option>
            <option value="Cleaning" <%= "Cleaning".equals(category) ? "selected" : "" %>>Cleaning</option>
            <option value="Other" <%= "Other".equals(category) ? "selected" : "" %>>Other</option>
        </select>
    </div>

    <div class="mb-3">
        <label>Date Raised</label>
        <input type="date" class="form-control" name="date_raised" value="<%= date_raised %>" required>
    </div>

    <div class="mb-3">
        <label>Description</label>
        <textarea class="form-control" name="description" required><%= description %></textarea>
    </div>

    <div class="mb-3">
        <label>Status</label>
        <select class="form-control" name="status">
            <option value="Pending" <%= "Pending".equalsIgnoreCase(status) ? "selected" : "" %>>Pending</option>
            <option value="Resolved" <%= "Resolved".equalsIgnoreCase(status) ? "selected" : "" %>>Resolved</option>
        </select>
    </div>

    <button type="submit" class="btn btn-success">Save</button>
    <a href="complaint_list.jsp" class="btn btn-secondary">Back</a>
</form>

</body>
</html>

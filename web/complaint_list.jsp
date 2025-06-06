<%@ page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Complaint List</title>
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
        .btn {
            border-radius: 10px;
            font-weight: 600;
            padding: 0.5rem 1.2rem;
        }
        .table {
            background: #fff;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 1rem 2rem rgba(0, 0, 0, 0.1);
        }
        .table thead {
            background-color: #343a40;
            color: #fff;
        }
        .btn-sm {
            border-radius: 10px;
        }
    </style>
</head>
<body class="container">
    <div class="custom-navbar text-center">
        <h2 class="main-heading"> Complaint Management</h2>
    </div>

<a href="complaint_add.jsp" class="btn btn-success mb-3">Add Complaint</a>
<a href="index.jsp" class="btn btn-secondary mb-3 float-end">Back to Dashboard</a>

<table class="table table-bordered">
    <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Student ID</th>
            <th>Category</th>
            <th>Description</th>
            <th>Status</th>
            <th>Date Raised</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
<%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT * FROM complaints");
        while(rs.next()){
%>
        <tr>
            <td><%= rs.getInt("complaint_id") %></td>
            <td><%= rs.getInt("student_id") %></td>
            <td><%= rs.getString("category") %></td>
            <td><%= rs.getString("description") %></td>
            <td><%= rs.getString("status") %></td>
            <td><%= rs.getDate("date_raised") %></td>
            <td>
                <a href="complaint_add.jsp?id=<%= rs.getInt("complaint_id") %>" class="btn btn-warning btn-sm">Edit</a>
                <a href="ComplaintServlet?action=delete&id=<%= rs.getInt("complaint_id") %>" 
                   onclick="return confirm('Are you sure to delete?');" 
                   class="btn btn-danger btn-sm">Delete</a>
            </td>
        </tr>
<%
        }
    } catch(Exception e){
        e.printStackTrace();
    } finally {
        if(rs!=null) rs.close();
        if(stmt!=null) stmt.close();
        if(con!=null) con.close();
    }
%>
    </tbody>
</table>

</body>
</html>

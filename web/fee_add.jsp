<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    String student_id = "", amount = "", due_date = "", payment_date = "", status = "";
    if(id != null){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostel_management", "root", "");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM fees WHERE fee_id=?");
            ps.setInt(1, Integer.parseInt(id));
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                student_id = rs.getString("student_id");
                amount = rs.getString("amount");
                due_date = rs.getString("due_date");
                payment_date = rs.getString("payment_date");
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
    <title><%= (id != null ? "Edit" : "Add") %> Fee</title>
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
        <h2 class="main-heading"><%= (id != null ? "Edit" : "Add") %> Fee</h2>
    </div>


<form action="FeeServlet" method="post">
    <input type="hidden" name="id" value="<%= id != null ? id : "" %>">

    <div class="mb-3">
        <label>Student ID</label>
        <input type="number" class="form-control" name="student_id" value="<%= student_id %>" required>
    </div>

    <div class="mb-3">
        <label>Amount</label>
        <input type="number" step="0.01" class="form-control" name="amount" value="<%= amount %>" required>
    </div>

    <div class="mb-3">
        <label>Due Date</label>
        <input type="date" class="form-control" name="due_date" value="<%= due_date %>" required>
    </div>

    <div class="mb-3">
        <label>Payment Date</label>
        <input type="date" class="form-control" name="payment_date" value="<%= payment_date %>">
    </div>

    <div class="mb-3">
        <label>Status</label>
        <select class="form-control" name="status">
            <option value="Unpaid" <%= "Unpaid".equalsIgnoreCase(status) ? "selected" : "" %>>Unpaid</option>
            <option value="Paid" <%= "Paid".equalsIgnoreCase(status) ? "selected" : "" %>>Paid</option>
        </select>
    </div>

    <button type="submit" class="btn btn-success">Save</button>
    <a href="fee_list.jsp" class="btn btn-secondary">Back</a>
</form>

</body>
</html>

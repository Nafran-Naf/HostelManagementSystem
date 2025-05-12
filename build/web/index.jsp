<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Hostel Management System</title>
  <link href="bootstrap-5.3.5-dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(to right, #ffecd2 0%, #fcb69f 100%);
      font-family: 'Poppins', sans-serif;
      color: #343a40;
      min-height: 100vh;
    }
    .custom-navbar {
      background: #ffffffcc;
      backdrop-filter: blur(10px);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      padding: 1rem 2rem;
      border-radius: 0 0 20px 20px;
      margin-bottom: 2rem;
    }
    .main-heading {
      font-size: 2.5rem;
      font-weight: 700;
      color: #212529;
      margin-bottom: 0;
      text-shadow: 1px 1px #ffffff;
    }
    .dashboard-card {
      border-radius: 1rem;
      box-shadow: 0 1rem 2rem rgba(0, 0, 0, 0.15);
      transition: all 0.3s ease-in-out;
      background: linear-gradient(135deg, #fdfcfb, #e2d1c3);
      color: #2c2c2c;
      height: 180px; /* or any consistent height */
      display: flex;
      flex-direction: column;
      justify-content: center;
    }
    .dashboard-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 1.25rem 2.5rem rgba(0, 0, 0, 0.25);
    }
    .dashboard-icon {
      font-size: 2.8rem;
      margin-bottom: 0.5rem;
    }
    .dashboard-card h5 {
      margin-top: 0.5rem;
      font-weight: 600;
      color: #343a40;
    }
    .container .row {
      margin-top: 1rem;
    }
    a.text-decoration-none {
      color: inherit;
    }
    a.text-decoration-none:hover {
      text-decoration: none;
    }
  </style>
</head>
<body>
  <div class="custom-navbar text-center">
    <h1 class="main-heading">Hostel Management System</h1>
  </div>


  <div class="container">
    <div class="row g-4 justify-content-center">
      <div class="col-lg-3 col-md-4 col-sm-6">
        <a href="room_list.jsp" class="text-decoration-none">
          <div class="card dashboard-card text-center p-4">
            <div class="dashboard-icon text-primary"><i class="bi bi-door-closed"></i></div>
            <h5>Room Management</h5>
          </div>
        </a>
      </div>

      <div class="col-lg-3 col-md-4 col-sm-6">
        <a href="student_list.jsp" class="text-decoration-none">
          <div class="card dashboard-card text-center p-4">
            <div class="dashboard-icon text-success"><i class="bi bi-person-lines-fill"></i></div>
            <h5>Student Management</h5>
          </div>
        </a>
      </div>

      <div class="col-lg-3 col-md-4 col-sm-6">
        <a href="staff_list.jsp" class="text-decoration-none">
          <div class="card dashboard-card text-center p-4">
            <div class="dashboard-icon text-info"><i class="bi bi-people-fill"></i></div>
            <h5>Staff Management</h5>
          </div>
        </a>
      </div>

      <div class="col-lg-3 col-md-4 col-sm-6">
        <a href="fee_list.jsp" class="text-decoration-none">
          <div class="card dashboard-card text-center p-4">
            <div class="dashboard-icon text-warning"><i class="bi bi-currency-rupee"></i></div>
            <h5>Fee Management</h5>
          </div>
        </a>
      </div>

      <div class="col-lg-3 col-md-4 col-sm-6">
        <a href="complaint_list.jsp" class="text-decoration-none">
          <div class="card dashboard-card text-center p-4">
            <div class="dashboard-icon text-danger"><i class="bi bi-exclamation-triangle-fill"></i></div>
            <h5>Complaint Management</h5>
          </div>
        </a>
      </div>

      <div class="col-lg-3 col-md-4 col-sm-6">
        <a href="visitor_list.jsp" class="text-decoration-none">
          <div class="card dashboard-card text-center p-4">
            <div class="dashboard-icon text-secondary"><i class="bi bi-person-check-fill"></i></div>
            <h5>Visitor Management</h5>
          </div>
        </a>
      </div>

      <div class="col-lg-3 col-md-4 col-sm-6">
        <a href="attendance_list.jsp" class="text-decoration-none">
          <div class="card dashboard-card text-center p-4">
            <div class="dashboard-icon text-primary"><i class="bi bi-clipboard-check-fill"></i></div>
            <h5>Attendance Management</h5>
          </div>
        </a>
      </div>
    </div>
  </div>

  <script src="bootstrap-5.3.5-dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
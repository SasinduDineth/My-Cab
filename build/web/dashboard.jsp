<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String username = request.getParameter("username");
    String role = request.getParameter("role");
    String totalBookings = request.getParameter("totalBookings");
    String activeRides = request.getParameter("activeRides");
    String totalCustomers = request.getParameter("totalCustomers");

    if (username == null || role == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { width: 80%; margin: 20px auto; }
        .card { padding: 20px; margin: 10px; border-radius: 10px; background: #f4f4f4; display: inline-block; width: 30%; text-align: center; }
        .logout { float: right; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Admin Dashboard</h2>
        <a class="logout" href="logout.jsp">Logout</a>
        
        <div class="card">
            <h3>Total Bookings</h3>
            <p><%= totalBookings != null ? totalBookings : "0" %></p>
        </div>

        <div class="card">
            <h3>Active Rides</h3>
            <p><%= activeRides != null ? activeRides : "0" %></p>
        </div>

        <div class="card">
            <h3>Total Customers</h3>
            <p><%= totalCustomers != null ? totalCustomers : "0" %></p>
        </div>

        <br>
        <a href="BookingManagement.jsp">Manage Bookings</a>
    </div>
</body>
</html>

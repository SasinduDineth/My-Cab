<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // Connect to database
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "your_user", "your_password");
        
        // Fetch drivers
        String query = "SELECT * FROM drivers";
        ps = conn.prepareStatement(query);
        rs = ps.executeQuery();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Drivers</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { width: 80%; margin: 20px auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .form-container { margin-top: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Manage Drivers</h2>

        <!-- Add Driver Form -->
        <div class="form-container">
            <h3>Add New Driver</h3>
            <form action="AddDriverServlet" method="post">
                <label>Driver Name:</label>
                <input type="text" name="driver_name" required><br><br>

                <label>Vehicle Type:</label>
                <input type="text" name="vehicle_type" required><br><br>

                <label>License Number:</label>
                <input type="text" name="license_number" required><br><br>

                <label>Contact Number:</label>
                <input type="text" name="contact_number" required><br><br>

                <input type="submit" value="Add Driver">
            </form>
        </div>

        <!-- List of Drivers -->
        <h3>Driver List</h3>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Vehicle Type</th>
                <th>License Number</th>
                <th>Contact</th>
                <th>Action</th>
            </tr>
            <% while (rs != null && rs.next()) { %>
            <tr>
                <td><%= rs.getInt("driver_id") %></td>
                <td><%= rs.getString("driver_name") %></td>
                <td><%= rs.getString("vehicle_type") %></td>
                <td><%= rs.getString("license_number") %></td>
                <td><%= rs.getString("contact_number") %></td>
                <td>
                    <a href="DeleteDriverServlet?driver_id=<%= rs.getInt("driver_id") %>">Delete</a>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</body>
</html>

<%
    // Close resources
    if (rs != null) rs.close();
    if (ps != null) ps.close();
    if (conn != null) conn.close();
%>

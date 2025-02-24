<%@page import="com.customer.DatabaseConnection"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.http.HttpSession" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("username") == null) {
        response.sendRedirect("CustomerDashboard.jsp");
        return;
    }

    Integer customerId = (Integer) sessionObj.getAttribute("customerId");
    if (customerId == null) {
        response.sendRedirect("CustomerDashboard.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard</title>
</head>
<body>
    <h2>Welcome, <%= sessionObj.getAttribute("username") %></h2>
    <a href="Booking.jsp">Book a Ride</a>
    <h3>Your Bookings</h3>

    <table border="1">
        <tr>
            <th>Booking ID</th>
            <th>Vehicle</th>
            <th>Pickup</th>
            <th>Drop-off</th>
            <th>Status</th>
        </tr>
        <%
            try {
                conn = DatabaseConnection.getConnection();
                String query = "SELECT booking_id, vehicle_type, pickup_location, dropoff_location, status FROM bookings WHERE customer_id = ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, customerId);
                rs = ps.executeQuery();
                
                while (rs.next()) {
        %>
                <tr>
                    <td><%= rs.getInt("booking_id") %></td>
                    <td><%= rs.getString("vehicle_type") %></td>
                    <td><%= rs.getString("pickup_location") %></td>
                    <td><%= rs.getString("dropoff_location") %></td>
                    <td><%= rs.getString("status") %></td>
                </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
        %>
    </table>
</body>
</html>
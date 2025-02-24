<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.http.HttpSession" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("username") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    Integer customerId = (Integer) sessionObj.getAttribute("customerId");
    if (customerId == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book a Ride</title>
</head>
<body>
    <h2>Book a Ride</h2>
    
    <form action="BookingServlet" method="post">
        <input type="hidden" name="customer_id" value="<%= customerId %>">

        <label for="vehicle_type">Vehicle Type:</label>
        <select name="vehicle_type" required>
            <option value="Car">Car</option>
            <option value="Van">Van</option>
            <option value="Bike">Bike</option>
        </select><br><br>

        <label for="driver_id">Select Driver:</label>
        <select name="driver_id" required>
            <%
                try {
                    conn = DatabaseConnection.getConnection();
                    String driverQuery = "SELECT driver_id, driver_name FROM drivers";
                    ps = conn.prepareStatement(driverQuery);
                    rs = ps.executeQuery();
                    
                    while (rs.next()) {
            %>
                        <option value="<%= rs.getInt("driver_id") %>"><%= rs.getString("driver_name") %></option>
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
        </select><br><br>

        <label for="pickup_location">Pickup Location:</label>
        <input type="text" name="pickup_location" required><br><br>

        <label for="dropoff_location">Drop-off Location:</label>
        <input type="text" name="dropoff_location" required><br><br>

        <input type="submit" value="Book Now">
    </form>
</body>
</html>

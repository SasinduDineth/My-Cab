<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Cab Booking</title>
</head>
<body>
    <h2>Book a Ride</h2>
    <form action="BookingServlet" method="post">
        Customer Name: <input type="text" name="customerName" required><br>
        Pickup Location: <input type="text" name="pickupLocation" required><br>
        Dropoff Location: <input type="text" name="dropoffLocation" required><br>
        Ride Date: <input type="date" name="rideDate" required><br>
        Ride Time: <input type="time" name="rideTime" required><br>
        <input type="submit" value="Book Now">
    </form>

    <% if (request.getParameter("error") != null) { %>
        <p style="color:red;">Booking failed! Please try again.</p>
    <% } %>
</body>
</html>

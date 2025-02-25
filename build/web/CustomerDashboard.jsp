<%@page import="com.customer.DatabaseConnection"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.http.HttpSession" %>

<%
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
    <h2>Welcome, Customer</h2>
    <a href="Booking.jsp">Book a Ride</a>
</body>
</html>

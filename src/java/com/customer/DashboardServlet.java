package com.customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class DashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String role = request.getParameter("role");

        if (username == null || !role.equals("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Fetching total bookings
            String totalBookingsQuery = "SELECT COUNT(*) FROM bookings";
            PreparedStatement ps1 = conn.prepareStatement(totalBookingsQuery);
            ResultSet rs1 = ps1.executeQuery();
            int totalBookings = rs1.next() ? rs1.getInt(1) : 0;

            // Fetching active rides
            String activeRidesQuery = "SELECT COUNT(*) FROM bookings WHERE status = 'Active'";
            PreparedStatement ps2 = conn.prepareStatement(activeRidesQuery);
            ResultSet rs2 = ps2.executeQuery();
            int activeRides = rs2.next() ? rs2.getInt(1) : 0;

            // Fetching total customers
            String totalCustomersQuery = "SELECT COUNT(*) FROM users WHERE role = 'customer'";
            PreparedStatement ps3 = conn.prepareStatement(totalCustomersQuery);
            ResultSet rs3 = ps3.executeQuery();
            int totalCustomers = rs3.next() ? rs3.getInt(1) : 0;

            // Redirecting to dashboard with query parameters
            response.sendRedirect("dashboard.jsp?username=" + username + "&role=" + role 
                + "&totalBookings=" + totalBookings + "&activeRides=" + activeRides 
                + "&totalCustomers=" + totalCustomers);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=database_error");
        }
    }
}

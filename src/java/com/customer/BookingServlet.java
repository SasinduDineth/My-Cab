package com.customer;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// Mapping the servlet to handle booking requests
public class BookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve booking details from the request
        String customerName = request.getParameter("customerName");
        String pickupLocation = request.getParameter("pickupLocation");
        String dropoffLocation = request.getParameter("dropoffLocation");
        String rideDate = request.getParameter("rideDate");
        String rideTime = request.getParameter("rideTime");

        // Get the current session
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        // Ensure the user is logged in
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Validate input fields
        if (customerName == null || pickupLocation == null || dropoffLocation == null || rideDate == null || rideTime == null ||
            customerName.trim().isEmpty() || pickupLocation.trim().isEmpty() || dropoffLocation.trim().isEmpty() || 
            rideDate.trim().isEmpty() || rideTime.trim().isEmpty()) {
            
            response.sendRedirect("booking.jsp?error=missing_fields");
            return;
        }

        // Database connection and SQL insert query
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO bookings (customer_name, pickup_location, dropoff_location, ride_date, ride_time, username) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, customerName);
            ps.setString(2, pickupLocation);
            ps.setString(3, dropoffLocation);
            ps.setString(4, rideDate);
            ps.setString(5, rideTime);
            ps.setString(6, username);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("bookingConfirmation.jsp");
            } else {
                response.sendRedirect("booking.jsp?error=insert_failed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("booking.jsp?error=database_error");
        }
    }
}

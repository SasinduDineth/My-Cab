package com.customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customer_id"));
        int driverId = Integer.parseInt(request.getParameter("driver_id"));
        String vehicleType = request.getParameter("vehicle_type");
        String pickupLocation = request.getParameter("pickup_location");
        String dropoffLocation = request.getParameter("dropoff_location");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO bookings (customer_id, driver_id, vehicle_type, pickup_location, dropoff_location, status) VALUES (?, ?, ?, ?, ?, 'Pending')";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, customerId);
            ps.setInt(2, driverId);
            ps.setString(3, vehicleType);
            ps.setString(4, pickupLocation);
            ps.setString(5, dropoffLocation);
            ps.executeUpdate();

            response.sendRedirect("BookingConfirmation.jsp?success=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Booking.jsp?error=database_error");
        }
    }
}

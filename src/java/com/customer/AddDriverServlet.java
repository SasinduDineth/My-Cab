package com.customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddDriverServlet")
public class AddDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String driverName = request.getParameter("driver_name");
        String vehicleType = request.getParameter("vehicle_type");
        String licenseNumber = request.getParameter("license_number");
        String contactNumber = request.getParameter("contact_number");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "admin");

            String sql = "INSERT INTO drivers (driver_name, vehicle_type, license_number, contact_number) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, driverName);
            ps.setString(2, vehicleType);
            ps.setString(3, licenseNumber);
            ps.setString(4, contactNumber);
            ps.executeUpdate();

            ps.close();
            conn.close();

            response.sendRedirect("ManageDrivers.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ManageDrivers.jsp?error=database_error");
        }
    }
}

package com.customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterCustomerServlet")
public class RegisterCustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contactNumber = request.getParameter("contact_number");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO customers (name, email, password, contact_number) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, contactNumber);

            int result = ps.executeUpdate();
            if (result > 0) {
                response.sendRedirect("CustomerLogin.jsp?success=registered");
            } else {
                response.sendRedirect("RegisterCustomer.jsp?error=registration_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("RegisterCustomer.jsp?error=database_error");
        }
    }
}

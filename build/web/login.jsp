<%-- 
    Document   : login
    Created on : Feb 23, 2025, 1:44:38 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Mega City Cab</title>
    <link rel="stylesheet" href="styles.css"> <!-- Optional CSS -->
</head>
<body>
    <h2>Login</h2>
    <% if (request.getParameter("error") != null) { %>
        <p style="color:red;">Invalid username or password!</p>
    <% } %>
    <form action="AuthServlet" method="post">
    <input type="text" name="username" required>
    <input type="password" name="password" required>
    <button type="submit">Login</button>
    
</form>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Login</title>
</head>
<body>
    <h2>Customer Login</h2>
    <form action="CustomerLoginServlet" method="post">
        Email: <input type="email" name="email" required><br>
        Password: <input type="password" name="password" required><br>
        <input type="submit" value="Login">
    </form>
    <p>Don't have an account? <a href="RegisterCustomer.jsp">Register here</a></p>
    <a href="login.jsp">Login as Admin</a>
</body>
</html>

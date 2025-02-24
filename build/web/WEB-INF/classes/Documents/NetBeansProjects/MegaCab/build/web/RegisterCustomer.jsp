<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Registration</title>
</head>
<body>
    <h2>Register as a Customer</h2>
    <form action="RegisterCustomerServlet" method="post">
        Name: <input type="text" name="name" required><br>
        Email: <input type="email" name="email" required><br>
        Password: <input type="password" name="password" required><br>
        Contact Number: <input type="text" name="contact_number" required><br>
        <input type="submit" value="Register">
    </form>
</body>
</html>

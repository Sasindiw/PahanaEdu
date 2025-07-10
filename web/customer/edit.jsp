<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="com.pahanaedu.dao.CustomerDAO" %>
<%@ page import="com.pahanaedu.dao.CustomerDAOImpl" %>
<%
    String accountNumber = request.getParameter("accountNumber");
    CustomerDAO customerDAO = new CustomerDAOImpl();
    Customer customer = null;
    if (accountNumber != null) {
        for (Customer c : customerDAO.getAllCustomers()) {
            if (accountNumber.equals(c.getAccountNumber())) {
                customer = c;
                break;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Customer - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f1f5f9; }
        .form-container { max-width: 500px; margin: 48px auto; background: #fff; border-radius: 16px; box-shadow: 0 4px 18px rgba(0,0,0,0.08); padding: 32px 28px 24px 28px; }
        .form-title { font-weight: bold; color: #1e293b; margin-bottom: 24px; text-align: center; letter-spacing: 1px; }
        .form-label { color: #334155; font-weight: 500; }
        .btn-primary { background: #3b82f6; border: none; }
        .btn-primary:hover, .btn-primary:focus { background: #60a5fa; }
        .back-link { color: #3b82f6; text-decoration: none; font-size: 0.98rem; }
        .back-link:hover { color: #60a5fa; text-decoration: underline; }
    </style>
</head>
<body>
    <div class="form-container">
        <div class="mb-3 text-center">
            <a href="list.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Back to Customers</a>
        </div>
        <h2 class="form-title">Edit Customer</h2>
        <% if (customer != null) { %>
        <form action="<%=request.getContextPath()%>/customer/update" method="post" autocomplete="off">
            <input type="hidden" name="account_number" value="<%= customer.getAccountNumber() %>">
            <div class="mb-3">
                <label for="name" class="form-label">Name</label>
                <input type="text" class="form-control" id="name" name="name" maxlength="100" value="<%= customer.getName() %>" required>
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <input type="text" class="form-control" id="address" name="address" maxlength="255" value="<%= customer.getAddress() %>" required>
            </div>
            <div class="mb-3">
                <label for="telephone" class="form-label">Telephone</label>
                <input type="text" class="form-control" id="telephone" name="telephone" maxlength="20" value="<%= customer.getTelephone() %>" required>
            </div>
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Update Customer</button>
            </div>
        </form>
        <% } else { %>
            <div class="alert alert-danger">Customer not found.</div>
        <% } %>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 
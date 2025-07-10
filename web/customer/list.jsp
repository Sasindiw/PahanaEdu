<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f1f5f9;
        }
        .container {
            margin-top: 48px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.08);
            padding: 32px 28px 24px 28px;
        }
        h2 {
            color: #1e293b;
            font-weight: bold;
            letter-spacing: 1px;
        }
        .table th {
            background: #3b82f6;
            color: #fff;
        }
        .btn-secondary {
            background: #1e293b;
            border: none;
        }
        .btn-secondary:hover {
            background: #3b82f6;
        }
    </style>
</head>
<body>
    <%
        String success = null;
        if (session.getAttribute("success") != null) {
            success = (String) session.getAttribute("success");
            session.removeAttribute("success");
        }
    %>
    <% if (success != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <%= success %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>
    <div class="container">
        <h2>Customer Accounts</h2>
        <table class="table table-bordered table-striped mt-3">
            <thead>
                <tr>
                    <th>Account Number</th>
                    <th>Name</th>
                    <th>Address</th>
                    <th>Telephone</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                    if (customers != null && !customers.isEmpty()) {
                        for (Customer c : customers) {
                %>
                <tr>
                    <td><%= c.getAccountNumber() %></td>
                    <td><%= c.getName() %></td>
                    <td><%= c.getAddress() %></td>
                    <td><%= c.getTelephone() %></td>
                    <td>
                        <a href="edit.jsp?accountNumber=<%= c.getAccountNumber() %>" class="btn btn-sm btn-warning">Edit</a>
                        <a href="<%=request.getContextPath()%>/customer/delete?accountNumber=<%= c.getAccountNumber() %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this customer?');">Delete</a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="4" class="text-center">No customers found.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <a href="../dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 
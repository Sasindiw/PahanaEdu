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
    <!-- Sidebar -->
    <div class="sidebar" style="position:fixed;top:0;left:0;height:100vh;width:250px;background:#1e293b;color:#fff;z-index:1000;box-shadow:2px 0 10px rgba(0,0,0,.07);">
        <div class="sidebar-header" style="padding:24px 10px 16px 10px;text-align:center;border-bottom:1px solid rgba(255,255,255,0.08);">
            <i class="fas fa-book-reader fa-2x mb-2"></i>
            <h5 style="font-weight:bold;letter-spacing:1px;color:#fff;margin:0;">Pahana Edu</h5>
            <small style="color:#cbd5e1;">Bookshop Management</small>
        </div>
        <nav class="sidebar-menu" style="padding:24px 0;">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" style="color:#fff;padding:14px 28px;font-size:1.08rem;border-radius:30px 0 0 30px;opacity:.85;" href="<%=request.getContextPath()%>/dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" style="color:#fff;padding:14px 28px;font-size:1.08rem;border-radius:30px 0 0 30px;background:#60a5fa;opacity:1;" href="<%=request.getContextPath()%>/customer/list"><i class="fas fa-users"></i> Customers</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" style="color:#fff;padding:14px 28px;font-size:1.08rem;border-radius:30px 0 0 30px;opacity:.85;" href="<%=request.getContextPath()%>/item/list"><i class="fas fa-box"></i> Items</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" style="color:#fff;padding:14px 28px;font-size:1.08rem;border-radius:30px 0 0 30px;opacity:.85;" href="<%=request.getContextPath()%>/help.jsp"><i class="fas fa-question-circle"></i> Help</a>
                </li>
            </ul>
        </nav>
    </div>
    <div class="form-container" style="max-width: 500px; margin: 48px auto; background: #fff; border-radius: 16px; box-shadow: 0 4px 18px rgba(0,0,0,0.08); padding: 32px 28px 24px 28px; margin-left: 290px;">
        <div class="mb-3 text-center">
            <a href="list.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Back to Customers</a>
        </div>
        <h2 class="form-title" style="font-weight:bold;color:#1e293b;margin-bottom:24px;text-align:center;letter-spacing:1px;">Edit Customer</h2>
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
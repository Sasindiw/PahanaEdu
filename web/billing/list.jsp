<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.pahanaedu.model.*" %>
<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    // Get bills from request attributes
    List<Bill> bills = (List<Bill>) request.getAttribute("bills");
    if (bills == null) bills = new ArrayList<>();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill List - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link text-white" href="<%=request.getContextPath()%>/dashboard.jsp">
                                <i class="fas fa-tachometer-alt"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="<%=request.getContextPath()%>/customer/list">
                                <i class="fas fa-users"></i> Customers
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="<%=request.getContextPath()%>/item/list">
                                <i class="fas fa-box"></i> Items
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white active" href="<%=request.getContextPath()%>/billing/list">
                                <i class="fas fa-receipt"></i> Bills
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Main content -->
            <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Bill List</h1>
                    <div>
                        <a href="<%=request.getContextPath()%>/billing/create" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Create New Bill
                        </a>
                        <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Back to Dashboard
                        </a>
                    </div>
                </div>

                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>

                <div class="card">
                    <div class="card-header">
                        <h5><i class="fas fa-list"></i> All Bills</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Bill Number</th>
                                        <th>Customer</th>
                                        <th>Date</th>
                                        <th>Total Amount</th>
                                        <th>Status</th>
                                        <th>Created By</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Bill bill : bills) { %>
                                        <tr>
                                            <td><strong><%= bill.getBillNumber() %></strong></td>
                                            <td>
                                                <%= bill.getCustomerName() != null ? bill.getCustomerName() : bill.getCustomerAccountNumber() %>
                                                <br><small class="text-muted"><%= bill.getCustomerAccountNumber() %></small>
                                            </td>
                                            <td><%= bill.getBillDate() %></td>
                                            <td><strong>$<%= bill.getTotalAmount() %></strong></td>
                                            <td>
                                                <% String statusClass = "secondary";
                                                   if ("completed".equals(bill.getStatus())) statusClass = "success";
                                                   else if ("pending".equals(bill.getStatus())) statusClass = "warning"; %>
                                                <span class="badge bg-<%= statusClass %>">
                                                    <%= bill.getStatus() %>
                                                </span>
                                            </td>
                                            <td><%= bill.getCreatedBy() %></td>
                                            <td>
                                                <a href="<%=request.getContextPath()%>/billing/view?billId=<%= bill.getBillId() %>" 
                                                   class="btn btn-sm btn-info">
                                                    <i class="fas fa-eye"></i> View
                                                </a>
                                                <a href="<%=request.getContextPath()%>/billing/edit?billId=<%= bill.getBillId() %>" 
                                                   class="btn btn-sm btn-warning">
                                                    <i class="fas fa-edit"></i> Edit
                                                </a>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                        
                        <% if (bills.isEmpty()) { %>
                            <div class="text-center py-4">
                                <i class="fas fa-receipt fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">No bills found</h5>
                                <p class="text-muted">Create your first bill to get started.</p>
                                <a href="<%=request.getContextPath()%>/billing/create" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Create First Bill
                                </a>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 
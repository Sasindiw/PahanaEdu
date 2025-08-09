<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.pahanaedu.model.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    // Get bill data from request attributes
    Bill bill = (Bill) request.getAttribute("bill");
    List<BillItem> billItems = (List<BillItem>) request.getAttribute("billItems");
    
    if (bill == null) {
        response.sendRedirect(request.getContextPath() + "/billing/list");
        return;
    }
    
    if (billItems == null) billItems = new ArrayList<>();
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bill - <%= bill.getBillNumber() %> - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @media print {
            .no-print { display: none !important; }
            .print-only { display: block !important; }
            body { margin: 0; padding: 20px; }
            .container-fluid { max-width: none; }
        }
        .print-only { display: none; }
        .bill-header {
            border-bottom: 2px solid #dee2e6;
            padding-bottom: 20px;
            margin-bottom: 30px;
        }
        .bill-details {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 30px;
        }
        .items-table {
            margin-bottom: 30px;
        }
        .total-section {
            background-color: #e9ecef;
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
        }
        .company-logo {
            font-size: 24px;
            font-weight: bold;
            color: #0d6efd;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar (hidden on print) -->
            <div class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse no-print">
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
                <!-- Action buttons (hidden on print) -->
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom no-print">
                    <h1 class="h2">Bill Details</h1>
                    <div>
                        <button onclick="window.print()" class="btn btn-primary">
                            <i class="fas fa-print"></i> Print Bill
                        </button>
                        <a href="<%=request.getContextPath()%>/billing/list" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Back to Bills
                        </a>
                    </div>
                </div>

                <!-- Bill Content -->
                <div class="card">
                    <div class="card-body">
                        <!-- Bill Header -->
                        <div class="bill-header">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="company-logo">
                                        <i class="fas fa-graduation-cap"></i> Pahana Edu Bookshop
                                    </div>
                                    <p class="text-muted mb-0">Educational Excellence</p>
                                    <p class="text-muted mb-0">123 Education Street, Colombo, Sri Lanka</p>
                                    <p class="text-muted mb-0">Phone: +94 11 234 5678 | Email: info@pahanaedu.com</p>
                                </div>
                                <div class="col-md-6 text-end">
                                    <h3 class="text-primary mb-0">INVOICE</h3>
                                    <h4 class="mb-0"><%= bill.getBillNumber() %></h4>
                                    <p class="text-muted mb-0">Date: <%= dateFormat.format(bill.getBillDate()) %></p>
                                    <p class="text-muted mb-0">Status: 
                                        <span class="badge bg-<%= "completed".equals(bill.getStatus()) ? "success" : "warning" %>">
                                            <%= bill.getStatus() %>
                                        </span>
                                    </p>
                                </div>
                            </div>
                        </div>

                        <!-- Bill Details -->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="bill-details">
                                    <h5><i class="fas fa-user"></i> Bill To:</h5>
                                    <p class="mb-1"><strong><%= bill.getCustomerName() != null ? bill.getCustomerName() : "Customer" %></strong></p>
                                    <p class="mb-1">Account: <%= bill.getCustomerAccountNumber() %></p>
                                    <% if (bill.getCustomerAddress() != null) { %>
                                        <p class="mb-0"><%= bill.getCustomerAddress() %></p>
                                    <% } %>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="bill-details">
                                    <h5><i class="fas fa-info-circle"></i> Bill Information:</h5>
                                    <p class="mb-1"><strong>Bill Number:</strong> <%= bill.getBillNumber() %></p>
                                    <p class="mb-1"><strong>Date:</strong> <%= dateFormat.format(bill.getBillDate()) %></p>
                                    <p class="mb-1"><strong>Created By:</strong> <%= bill.getCreatedBy() %></p>
                                    <p class="mb-0"><strong>Status:</strong> 
                                        <span class="badge bg-<%= "completed".equals(bill.getStatus()) ? "success" : "warning" %>">
                                            <%= bill.getStatus() %>
                                        </span>
                                    </p>
                                </div>
                            </div>
                        </div>

                        <!-- Items Table -->
                        <div class="items-table">
                            <h5><i class="fas fa-list"></i> Items:</h5>
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>#</th>
                                            <th>Item Code</th>
                                            <th>Item Name</th>
                                            <th>Description</th>
                                            <th class="text-end">Quantity</th>
                                            <th class="text-end">Unit Price</th>
                                            <th class="text-end">Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% 
                                        int itemNumber = 1;
                                        double subtotal = 0;
                                        for (BillItem item : billItems) { 
                                            subtotal += item.getTotalPrice();
                                        %>
                                            <tr>
                                                <td><%= itemNumber++ %></td>
                                                <td><%= item.getItemCode() %></td>
                                                <td><%= item.getItemName() != null ? item.getItemName() : "N/A" %></td>
                                                <td><%= item.getItemDescription() != null ? item.getItemDescription() : "N/A" %></td>
                                                <td class="text-end"><%= item.getQuantity() %></td>
                                                <td class="text-end">$<%= String.format("%.2f", item.getUnitPrice()) %></td>
                                                <td class="text-end"><strong>$<%= String.format("%.2f", item.getTotalPrice()) %></strong></td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Total Section -->
                        <div class="total-section">
                            <div class="row">
                                <div class="col-md-6 offset-md-6">
                                    <table class="table table-borderless">
                                        <tr>
                                            <td><strong>Subtotal:</strong></td>
                                            <td class="text-end">$<%= String.format("%.2f", subtotal) %></td>
                                        </tr>
                                        <tr>
                                            <td><strong>Tax (0%):</strong></td>
                                            <td class="text-end">$0.00</td>
                                        </tr>
                                        <tr class="border-top">
                                            <td><h5>Total:</h5></td>
                                            <td class="text-end"><h5>$<%= String.format("%.2f", bill.getTotalAmount()) %></h5></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Footer -->
                        <div class="mt-5 pt-4 border-top">
                            <div class="row">
                                <div class="col-md-8">
                                    <h6><i class="fas fa-info-circle"></i> Terms & Conditions:</h6>
                                    <ul class="small text-muted">
                                        <li>Payment is due within 30 days of invoice date</li>
                                        <li>Late payments may incur additional charges</li>
                                        <li>Returns accepted within 7 days with original receipt</li>
                                        <li>All prices are subject to change without notice</li>
                                    </ul>
                                </div>
                                <div class="col-md-4 text-end">
                                    <p class="text-muted small">
                                        Thank you for your business!<br>
                                        Pahana Edu Bookshop<br>
                                        <i class="fas fa-graduation-cap"></i> Educational Excellence
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

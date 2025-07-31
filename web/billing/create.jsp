<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.pahanaedu.model.*" %>
<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    // Get data from request attributes
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
    List<Item> items = (List<Item>) request.getAttribute("items");
    String billNumber = (String) request.getAttribute("billNumber");
    
    if (customers == null) customers = new ArrayList<>();
    if (items == null) items = new ArrayList<>();
    if (billNumber == null) billNumber = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Bill - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --sidebar-bg: #1e293b;
            --sidebar-text: #ffffff;
            --main-bg: #f1f5f9;
            --primary-btn: #3b82f6;
            --primary-btn-hover: #60a5fa;
            --sidebar-width: 250px;
        }
        body {
            background: var(--main-bg);
        }
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: var(--sidebar-width);
            background: var(--sidebar-bg);
            color: var(--sidebar-text);
            z-index: 1000;
            box-shadow: 2px 0 10px rgba(0,0,0,0.07);
        }
        .sidebar-header {
            padding: 24px 10px 16px 10px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.08);
        }
        .sidebar-header h5 {
            font-weight: bold;
            letter-spacing: 1px;
            color: var(--sidebar-text);
        }
        .sidebar-header small {
            color: #cbd5e1;
        }
        .sidebar-menu {
            padding: 24px 0;
        }
        .sidebar-menu .nav-link {
            color: var(--sidebar-text);
            padding: 14px 28px;
            font-size: 1.08rem;
            border-radius: 30px 0 0 30px;
            margin-bottom: 6px;
            transition: all 0.2s;
            opacity: 0.85;
        }
        .sidebar-menu .nav-link i {
            color: var(--sidebar-text);
            margin-right: 8px;
        }
        .sidebar-menu .nav-link:hover,
        .sidebar-menu .nav-link.active {
            color: var(--sidebar-text);
            background: var(--primary-btn-hover);
            opacity: 1;
        }
        .sidebar-menu .nav-link:hover i,
        .sidebar-menu .nav-link.active i {
            color: var(--sidebar-text);
        }
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 32px 24px 24px 24px;
            min-height: 100vh;
            background: var(--main-bg);
        }
        .container-custom {
            width: 100%;
            max-width: 1200px;
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
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            margin-bottom: 24px;
        }
        .card-header {
            background: var(--primary-btn);
            color: #fff;
            border-radius: 12px 12px 0 0;
            font-weight: 500;
            padding: 16px 20px;
        }
        .card-body {
            padding: 24px;
        }
        .btn-primary {
            background: var(--primary-btn);
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
        }
        .btn-primary:hover, .btn-primary:focus {
            background: var(--primary-btn-hover);
        }
        .btn-success {
            background: linear-gradient(90deg, #10b981 0%, #6ee7b7 100%);
            border: none;
            color: #fff;
            border-radius: 8px;
            padding: 12px 24px;
        }
        .btn-success:hover, .btn-success:focus {
            background: #059669;
        }
        .btn-secondary {
            background: #64748b;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
        }
        .btn-secondary:hover {
            background: #475569;
        }
        .form-control, .form-select {
            border-radius: 8px;
            border: 1px solid #e2e8f0;
            padding: 12px 16px;
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-btn);
            box-shadow: 0 0 0 0.2rem rgba(59, 130, 246, 0.25);
        }
        .item-row {
            background: #f8fafc;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 16px;
            border: 1px solid #e2e8f0;
            transition: all 0.2s;
        }
        .item-row:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .remove-item {
            color: #ef4444;
            cursor: pointer;
            font-size: 1.2rem;
            transition: color 0.2s;
        }
        .remove-item:hover {
            color: #dc2626;
        }
        .total-section {
            background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
            border-radius: 12px;
            padding: 24px;
            margin-top: 24px;
            border: 1px solid #cbd5e1;
        }
        .alert {
            border-radius: 12px;
            border: none;
        }
        @media (max-width: 991.98px) {
            .main-content {
                margin-left: 0;
                padding: 16px 6px;
            }
            .sidebar {
                width: 100vw;
                height: auto;
                position: relative;
                box-shadow: none;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <i class="fas fa-book-reader fa-2x mb-2"></i>
            <h5>Pahana Edu</h5>
            <small>Bookshop Management</small>
        </div>
        <nav class="sidebar-menu">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/dashboard.jsp">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/customer/list">
                        <i class="fas fa-users"></i> Customers
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/item/list">
                        <i class="fas fa-box"></i> Items
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="<%=request.getContextPath()%>/billing/create">
                        <i class="fas fa-receipt"></i> Create Bill
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/logout">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </li>
            </ul>
        </nav>
    </div>

    <!-- Main content -->
    <div class="main-content">
        <div class="container-custom">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="fw-bold" style="letter-spacing:1px;">Create New Bill</h2>
                    <p class="text-muted mb-0">Generate a new bill for your customer</p>
                </div>
                <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-triangle"></i> <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="<%=request.getContextPath()%>/billing/create" method="post" id="createBillForm">
                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-user"></i> Customer Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <label for="customer_account_number" class="form-label fw-bold">Customer</label>
                                    <select class="form-select" id="customer_account_number" name="customer_account_number" required>
                                        <option value="">Select a customer...</option>
                                        <% for (Customer customer : customers) { %>
                                            <option value="<%= customer.getAccountNumber() %>">
                                                <%= customer.getAccountNumber() %> - <%= customer.getName() %>
                                            </option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="bill_number" class="form-label fw-bold">Bill Number</label>
                                    <input type="text" class="form-control" id="bill_number" value="<%= billNumber %>" readonly>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-plus"></i> Add Items</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <label for="item_code" class="form-label fw-bold">Item</label>
                                    <select class="form-select" id="item_code">
                                        <option value="">Select an item...</option>
                                        <% for (Item item : items) { %>
                                            <option value="<%= item.getItemCode() %>" data-price="<%= item.getPrice() %>" data-name="<%= item.getName() %>">
                                                <%= item.getItemCode() %> - <%= item.getName() %> ($<%= item.getPrice() %>)
                                            </option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="quantity" class="form-label fw-bold">Quantity</label>
                                    <input type="number" class="form-control" id="quantity" min="1" value="1">
                                </div>
                                <button type="button" class="btn btn-primary" onclick="addItem()">
                                    <i class="fas fa-plus"></i> Add Item
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-list"></i> Bill Items</h5>
                            </div>
                            <div class="card-body">
                                <div id="itemsContainer">
                                    <!-- Items will be added here dynamically -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="total-section">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <h4 class="mb-0 fw-bold">Total Amount: $<span id="totalAmount">0.00</span></h4>
                        </div>
                        <div class="col-md-6 text-end">
                            <button type="submit" class="btn btn-success btn-lg">
                                <i class="fas fa-save"></i> Create Bill
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let itemCounter = 0;
        let totalAmount = 0;

        function addItem() {
            const itemSelect = document.getElementById('item_code');
            const quantity = document.getElementById('quantity').value;
            const selectedOption = itemSelect.options[itemSelect.selectedIndex];

            if (!selectedOption.value) {
                alert('Please select an item');
                return;
            }

            if (!quantity || quantity < 1) {
                alert('Please enter a valid quantity');
                return;
            }

            const itemCode = selectedOption.value;
            const itemName = selectedOption.getAttribute('data-name');
            const unitPrice = parseFloat(selectedOption.getAttribute('data-price'));
            const totalPrice = unitPrice * quantity;

            // Create item row
            const itemRow = document.createElement('div');
            itemRow.className = 'item-row';
            itemRow.innerHTML = `
                <div class="row align-items-center">
                    <div class="col-md-3">
                        <input type="hidden" name="item_code" value="${itemCode}">
                        <strong class="text-primary">${itemCode}</strong>
                        <br><small class="text-muted">${itemName}</small>
                    </div>
                    <div class="col-md-2">
                        <input type="hidden" name="quantity" value="${quantity}">
                        <span class="fw-bold">${quantity}</span>
                    </div>
                    <div class="col-md-2">
                        <span class="text-success fw-bold">$${unitPrice.toFixed(2)}</span>
                    </div>
                    <div class="col-md-3">
                        <span class="item-price fw-bold text-primary">$${totalPrice.toFixed(2)}</span>
                    </div>
                    <div class="col-md-2 text-end">
                        <i class="fas fa-trash remove-item" onclick="removeItem(this)" title="Remove item"></i>
                    </div>
                </div>
            `;

            document.getElementById('itemsContainer').appendChild(itemRow);

            // Clear form
            itemSelect.selectedIndex = 0;
            document.getElementById('quantity').value = '1';

            // Update total
            updateTotal();
        }

        function removeItem(element) {
            element.closest('.item-row').remove();
            updateTotal();
        }

        function updateTotal() {
            const items = document.querySelectorAll('.item-row');
            totalAmount = 0;
            
            items.forEach(item => {
                const priceText = item.querySelector('.item-price').textContent;
                const price = parseFloat(priceText.replace('$', ''));
                totalAmount += price;
            });
            
            document.getElementById('totalAmount').textContent = totalAmount.toFixed(2);
        }
    </script>
</body>
</html> 
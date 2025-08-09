<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Bill - PahanaEdu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --light-bg: #ecf0f1;
            --dark-text: #2c3e50;
            --light-text: #7f8c8d;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--light-bg) 0%, #ffffff 100%);
            min-height: 100vh;
        }

        .navbar {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-weight: bold;
            color: white !important;
        }

        .nav-link {
            color: rgba(255,255,255,0.9) !important;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: white !important;
            transform: translateY(-1px);
        }

        .main-content {
            padding: 2rem 0;
        }

        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .card-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            border-radius: 15px 15px 0 0 !important;
            padding: 1.5rem;
        }

        .btn {
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 0.5rem 1.5rem;
        }

        .btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--secondary-color) 0%, #2980b9 100%);
            border: none;
        }

        .btn-success {
            background: linear-gradient(135deg, var(--success-color) 0%, #229954 100%);
            border: none;
        }

        .btn-warning {
            background: linear-gradient(135deg, var(--warning-color) 0%, #e67e22 100%);
            border: none;
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--accent-color) 0%, #c0392b 100%);
            border: none;
        }

        .form-control, .form-select {
            border-radius: 8px;
            border: 2px solid #e9ecef;
            transition: all 0.3s ease;
            padding: 0.75rem 1rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .alert {
            border-radius: 10px;
            border: none;
            padding: 1rem 1.5rem;
        }

        .item-row {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1rem;
            border: 1px solid #e9ecef;
        }

        .total-section {
            background: linear-gradient(135deg, var(--success-color) 0%, #229954 100%);
            color: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-top: 2rem;
        }

        .print-section {
            background: linear-gradient(135deg, var(--warning-color) 0%, #e67e22 100%);
            color: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-top: 1rem;
        }

        .sidebar {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            padding: 1.5rem;
        }

        .sidebar .nav-link {
            color: var(--dark-text) !important;
            padding: 0.75rem 1rem;
            border-radius: 8px;
            margin-bottom: 0.5rem;
            transition: all 0.3s ease;
        }

        .sidebar .nav-link:hover {
            background: var(--light-bg);
            color: var(--primary-color) !important;
        }

        .sidebar .nav-link.active {
            background: linear-gradient(135deg, var(--secondary-color) 0%, #2980b9 100%);
            color: white !important;
        }

        .calculation-display {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1rem;
            margin-top: 1rem;
            border-left: 4px solid var(--success-color);
        }

        @media print {
            .no-print {
                display: none !important;
            }
            .print-only {
                display: block !important;
            }
        }

        .print-only {
            display: none;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard.jsp">
                <i class="fas fa-graduation-cap"></i> PahanaEdu
            </a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    <i class="fas fa-user"></i> Welcome, ${sessionScope.user.username}
                </span>
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid main-content">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="sidebar">
                    <h5 class="mb-3"><i class="fas fa-bars"></i> Navigation</h5>
                    <nav class="nav flex-column">
                        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard.jsp">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/customer/list">
                            <i class="fas fa-users"></i> Customers
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/item/list">
                            <i class="fas fa-box"></i> Items
                        </a>
                        <a class="nav-link active" href="${pageContext.request.contextPath}/billing/create">
                            <i class="fas fa-receipt"></i> Create Bill
                        </a>
                    </nav>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9">
                <div class="card">
                    <div class="card-header">
                        <h4 class="mb-0">
                            <i class="fas fa-receipt"></i> Create New Bill
                        </h4>
                    </div>
                    <div class="card-body">
                        <!-- Error/Success Messages -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-triangle"></i> ${error}
                            </div>
                        </c:if>
                        <c:if test="${not empty success}">
                            <div class="alert alert-success">
                                <i class="fas fa-check-circle"></i> ${success}
                            </div>
                        </c:if>

                        <form id="billForm" method="post" action="${pageContext.request.contextPath}/billing/create">
                            <!-- Customer Selection -->
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label for="customerAccountNumber" class="form-label">
                                        <i class="fas fa-user"></i> Customer
                                    </label>
                                    <select class="form-select" id="customerAccountNumber" name="customerAccountNumber" required>
                                        <option value="">Select Customer</option>
                                        <c:forEach var="customer" items="${customers}">
                                            <option value="${customer.accountNumber}" 
                                                    ${customer.accountNumber eq customerAccountNumber ? 'selected' : ''}>
                                                ${customer.name} (${customer.accountNumber})
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">
                                        <i class="fas fa-calendar"></i> Bill Date
                                    </label>
                                    <input type="date" class="form-control" id="billDateInput" readonly>
                                </div>
                            </div>

                            <!-- Items Section -->
                            <div class="mb-4">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h5><i class="fas fa-box"></i> Bill Items</h5>
                                    <button type="button" class="btn btn-success" onclick="addItemRow()">
                                        <i class="fas fa-plus"></i> Add Item
                                    </button>
                                </div>
                                
                                <div id="itemsContainer">
                                    <!-- Item rows will be added here dynamically -->
                                </div>
                            </div>

                            <!-- Total Calculation -->
                            <div class="total-section">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h5><i class="fas fa-calculator"></i> Bill Summary</h5>
                                        <div class="calculation-display">
                                            <div class="row">
                                                <div class="col-6">Total Items:</div>
                                                <div class="col-6" id="totalItems">0</div>
                                            </div>
                                            <div class="row">
                                                <div class="col-6">Total Quantity:</div>
                                                <div class="col-6" id="totalQuantity">0</div>
                                            </div>
                                            <div class="row">
                                                <div class="col-6">Total Amount:</div>
                                                <div class="col-6" id="totalAmount">$0.00</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <h5><i class="fas fa-print"></i> Actions</h5>
                                        <div class="d-grid gap-2">
                                            <button type="submit" class="btn btn-light">
                                                <i class="fas fa-save"></i> Calculate & Save Bill
                                            </button>
                                            <button type="button" class="btn btn-light" onclick="printBill()">
                                                <i class="fas fa-print"></i> Print Bill
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Items data from server
        var items = [
            <c:forEach var="item" items="${items}" varStatus="status">
                {
                    itemCode: '${item.itemCode}',
                    name: '${item.name}',
                    price: ${item.price},
                    stock: ${item.stock}
                }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        var itemRowCount = 0;

        // Initialize the form with one item row
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize bill date to today's date (YYYY-MM-DD)
            var dateInput = document.getElementById('billDateInput');
            if (dateInput) {
                dateInput.value = new Date().toISOString().slice(0, 10);
            }

            addItemRow();
            updateTotals();
        });

        function addItemRow() {
            var rowId = 'itemRow_' + itemRowCount;
            var rowHtml = '<div class="item-row" id="' + rowId + '">' +
                '<div class="row align-items-end">' +
                    '<div class="col-md-4">' +
                        '<label class="form-label">Item</label>' +
                        '<select class="form-select item-select" name="itemCode" onchange="updateItemDetails(this, \'' + rowId + '\')" required>' +
                            '<option value="">Select Item</option>';
            
            for (var i = 0; i < items.length; i++) {
                rowHtml += '<option value="' + items[i].itemCode + '" data-price="' + items[i].price + '" data-stock="' + items[i].stock + '">' +
                    items[i].name + ' (' + items[i].itemCode + ')</option>';
            }
            
            rowHtml += '</select>' +
                    '</div>' +
                    '<div class="col-md-2">' +
                        '<label class="form-label">Quantity</label>' +
                        '<input type="number" class="form-control quantity-input" name="quantity" min="1" value="1" onchange="calculateRowTotal(\'' + rowId + '\')" required>' +
                    '</div>' +
                    '<div class="col-md-2">' +
                        '<label class="form-label">Unit Price</label>' +
                        '<input type="number" class="form-control unit-price-input" name="unitPrice" step="0.01" readonly>' +
                    '</div>' +
                    '<div class="col-md-2">' +
                        '<label class="form-label">Total</label>' +
                        '<input type="number" class="form-control total-price-input" name="totalPrice" step="0.01" readonly>' +
                    '</div>' +
                    '<div class="col-md-2">' +
                        '<label class="form-label">&nbsp;</label>' +
                        '<button type="button" class="btn btn-danger d-block" onclick="removeItemRow(\'' + rowId + '\')">' +
                            '<i class="fas fa-trash"></i> Remove' +
                        '</button>' +
                    '</div>' +
                '</div>' +
            '</div>';

            document.getElementById('itemsContainer').insertAdjacentHTML('beforeend', rowHtml);
            itemRowCount++;
        }

        function removeItemRow(rowId) {
            var row = document.getElementById(rowId);
            if (row) {
                row.remove();
                updateTotals();
            }
        }

        function updateItemDetails(selectElement, rowId) {
            var selectedOption = selectElement.options[selectElement.selectedIndex];
            var unitPriceInput = document.querySelector('#' + rowId + ' .unit-price-input');
            var quantityInput = document.querySelector('#' + rowId + ' .quantity-input');
            
            if (selectedOption.value) {
                var price = parseFloat(selectedOption.getAttribute('data-price'));
                var stock = parseInt(selectedOption.getAttribute('data-stock'));
                
                unitPriceInput.value = price.toFixed(2);
                quantityInput.max = stock;
                quantityInput.value = Math.min(quantityInput.value, stock);
                
                calculateRowTotal(rowId);
            } else {
                unitPriceInput.value = '';
                quantityInput.value = '1';
                calculateRowTotal(rowId);
            }
        }

        function calculateRowTotal(rowId) {
            var row = document.getElementById(rowId);
            var quantityInput = row.querySelector('.quantity-input');
            var unitPriceInput = row.querySelector('.unit-price-input');
            var totalPriceInput = row.querySelector('.total-price-input');
            
            var quantity = parseFloat(quantityInput.value) || 0;
            var unitPrice = parseFloat(unitPriceInput.value) || 0;
            var total = quantity * unitPrice;
            
            totalPriceInput.value = total.toFixed(2);
            updateTotals();
        }

        function updateTotals() {
            var rows = document.querySelectorAll('.item-row');
            var totalItems = rows.length;
            var totalQuantity = 0;
            var totalAmount = 0;
            
            for (var i = 0; i < rows.length; i++) {
                var quantityInput = rows[i].querySelector('.quantity-input');
                var totalPriceInput = rows[i].querySelector('.total-price-input');
                
                var quantity = parseFloat(quantityInput.value) || 0;
                var totalPrice = parseFloat(totalPriceInput.value) || 0;
                
                totalQuantity += quantity;
                totalAmount += totalPrice;
            }
            
            document.getElementById('totalItems').textContent = totalItems;
            document.getElementById('totalQuantity').textContent = totalQuantity;
            document.getElementById('totalAmount').textContent = '$' + totalAmount.toFixed(2);
        }

        function printBill() {
            // Create a print-friendly version of the bill
            var printWindow = window.open('', '_blank');
            var billContent = document.getElementById('billForm').innerHTML;
            
            printWindow.document.write(
                '<!DOCTYPE html>' +
                '<html>' +
                '<head>' +
                    '<title>Bill Print</title>' +
                    '<style>' +
                        'body { font-family: Arial, sans-serif; margin: 20px; }' +
                        '.header { text-align: center; margin-bottom: 30px; }' +
                        '.bill-details { margin-bottom: 20px; }' +
                        '.items-table { width: 100%; border-collapse: collapse; margin: 20px 0; }' +
                        '.items-table th, .items-table td { border: 1px solid #ddd; padding: 8px; text-align: left; }' +
                        '.total { font-weight: bold; text-align: right; margin-top: 20px; }' +
                        '@media print { body { margin: 0; } }' +
                    '</style>' +
                '</head>' +
                '<body>' +
                    '<div class="header">' +
                        '<h1>PahanaEdu Bookshop</h1>' +
                        '<h2>Bill</h2>' +
                    '</div>' +
                    '<div class="bill-details">' +
                        '<p><strong>Bill Number:</strong> <span id="billNumber">Generated</span></p>' +
                        '<p><strong>Date:</strong> ' + new Date().toLocaleDateString() + '</p>' +
                        '<p><strong>Customer:</strong> <span id="customerName">Selected Customer</span></p>' +
                    '</div>' +
                    '<table class="items-table">' +
                        '<thead>' +
                            '<tr>' +
                                '<th>Item</th>' +
                                '<th>Quantity</th>' +
                                '<th>Unit Price</th>' +
                                '<th>Total</th>' +
                            '</tr>' +
                        '</thead>' +
                        '<tbody id="printItems">' +
                        '</tbody>' +
                    '</table>' +
                    '<div class="total">' +
                        '<p><strong>Total Amount: </strong><span id="printTotal">$0.00</span></p>' +
                    '</div>' +
                '</body>' +
                '</html>'
            );
            
            // Populate the print content
            var rows = document.querySelectorAll('.item-row');
            var printItemsHtml = '';
            var printTotal = 0;
            
            for (var i = 0; i < rows.length; i++) {
                var itemSelect = rows[i].querySelector('.item-select');
                var quantityInput = rows[i].querySelector('.quantity-input');
                var unitPriceInput = rows[i].querySelector('.unit-price-input');
                var totalPriceInput = rows[i].querySelector('.total-price-input');
                
                if (itemSelect.value) {
                    var itemName = itemSelect.options[itemSelect.selectedIndex].text;
                    var quantity = quantityInput.value;
                    var unitPrice = unitPriceInput.value;
                    var total = totalPriceInput.value;
                    
                    printItemsHtml += '<tr>' +
                        '<td>' + itemName + '</td>' +
                        '<td>' + quantity + '</td>' +
                        '<td>$' + unitPrice + '</td>' +
                        '<td>$' + total + '</td>' +
                        '</tr>';
                    
                    printTotal += parseFloat(total);
                }
            }
            
            printWindow.document.getElementById('printItems').innerHTML = printItemsHtml;
            printWindow.document.getElementById('printTotal').textContent = '$' + printTotal.toFixed(2);
            
            printWindow.document.close();
            printWindow.print();
        }

        // Form validation
        document.getElementById('billForm').addEventListener('submit', function(e) {
            var customerSelect = document.getElementById('customerAccountNumber');
            var itemRows = document.querySelectorAll('.item-row');
            var hasValidItems = false;
            
            for (var i = 0; i < itemRows.length; i++) {
                var itemSelect = itemRows[i].querySelector('.item-select');
                if (itemSelect.value) {
                    hasValidItems = true;
                    break;
                }
            }
            
            if (!customerSelect.value) {
                alert('Please select a customer.');
                e.preventDefault();
                return;
            }
            
            if (!hasValidItems) {
                alert('Please add at least one item to the bill.');
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    java.util.List<com.pahanaedu.model.Customer> customers = (java.util.List<com.pahanaedu.model.Customer>) request.getAttribute("customers");
    java.util.List<com.pahanaedu.model.Item> items = (java.util.List<com.pahanaedu.model.Item>) request.getAttribute("items");
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
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
        :root { --sidebar-bg:#1e293b; --sidebar-text:#fff; --main-bg:#f1f5f9; --primary-btn:#3b82f6; --primary-btn-hover:#60a5fa; --sidebar-width:250px; }
        body { background: var(--main-bg); }
        .sidebar { position:fixed; top:0; left:0; height:100vh; width:var(--sidebar-width); background:var(--sidebar-bg); color:var(--sidebar-text); z-index:1000; box-shadow:2px 0 10px rgba(0,0,0,.07); }
        .sidebar-header { padding:24px 10px 16px 10px; text-align:center; border-bottom:1px solid rgba(255,255,255,.08); }
        .sidebar-header h5 { font-weight:bold; letter-spacing:1px; color:var(--sidebar-text); }
        .sidebar-header small { color:#cbd5e1; }
        .sidebar-menu { padding:24px 0; }
        .sidebar-menu .nav-link { color:var(--sidebar-text); padding:14px 28px; font-size:1.08rem; border-radius:30px 0 0 30px; margin-bottom:6px; transition:all .2s; opacity:.85; }
        .sidebar-menu .nav-link:hover, .sidebar-menu .nav-link.active { color:var(--sidebar-text); background:var(--primary-btn-hover); opacity:1; }
        .main-content { margin-left:var(--sidebar-width); padding:32px 24px 24px 24px; min-height:100vh; background:var(--main-bg); }
        .container-custom { width:100%; max-width:1000px; background:#fff; border-radius:16px; box-shadow:0 4px 18px rgba(0,0,0,.08); padding:32px 28px 24px 28px; }
        .item-row { background:#f8fafc; border-radius:10px; padding:1rem; border:1px solid #e5e7eb; margin-bottom:1rem; }
        .add-btn { background:#10b981; color:#fff; border:none; border-radius:8px; padding:8px 18px; font-size:1rem; transition:background .2s; }
        .add-btn:hover { background:#059669; }
        .btn-danger { background:#ef4444; border:none; }
        .btn-danger:hover { background:#dc2626; }
        @media (max-width: 991.98px) { .main-content{ margin-left:0; padding:16px 6px; } .sidebar{ width:100vw; height:auto; position:relative; box-shadow:none; } }
    </style>
    </head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <i class="fas fa-book-reader fa-2x mb-2"></i>
            <h5>Pahana Edu</h5>
            <small>Bookshop Management</small>
        </div>
        <nav class="sidebar-menu">
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/customer/list"><i class="fas fa-users"></i> Customers</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/item/list"><i class="fas fa-box"></i> Items</a></li>
                <li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/billing/create"><i class="fas fa-receipt"></i> Create Bill</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/help.jsp"><i class="fas fa-question-circle"></i> Help</a></li>
            </ul>
        </nav>
    </div>

    <div class="main-content">
        <div class="container-custom">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2 class="mb-0" style="color:#1e293b; letter-spacing:1px;">Create Bill</h2>
            </div>

            <% if (success != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= success %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>
            <% if (error != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= error %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <form id="billForm" method="post" action="<%=request.getContextPath()%>/billing/create" autocomplete="off">
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Customer</label>
                        <select class="form-select" id="customerAccountNumber" name="customerAccountNumber" required>
                            <option value="">Select Customer</option>
                            <% if (customers != null) {
                                   for (com.pahanaedu.model.Customer c : customers) { %>
                                <option value="<%= c.getAccountNumber() %>"><%= c.getName() %> (<%= c.getAccountNumber() %>)</option>
                            <%   }
                               } %>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Bill Date</label>
                        <input type="date" class="form-control" id="billDate" readonly>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-2">
                    <h5 class="mb-0"><i class="fas fa-box"></i> Bill Items</h5>
                    <button type="button" class="add-btn" onclick="addItemRow()"><i class="fas fa-plus"></i> Add Item</button>
                </div>
                <div id="itemsContainer"></div>

                <div class="row mt-3">
                    <div class="col-md-6">
                        <div class="p-3 bg-light rounded">
                            <div class="d-flex justify-content-between"><span>Total Items:</span><strong id="totalItems">0</strong></div>
                            <div class="d-flex justify-content-between"><span>Total Quantity:</span><strong id="totalQuantity">0</strong></div>
                            <div class="d-flex justify-content-between"><span>Total Amount:</span><strong id="totalAmount">LKR 0.00</strong></div>
                        </div>
                    </div>
                    <div class="col-md-6 d-grid gap-2">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Bill</button>
                        <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Items from server (no JSTL)
        var items = [];
        <% if (items != null) {
               for (com.pahanaedu.model.Item it : items) { %>
            items.push({ itemCode: '<%= it.getItemCode() %>', name: '<%= it.getName().replace("'","\\'") %>', price: <%= it.getPrice() %>, stock: <%= it.getStock() %> });
        <%   }
           } %>

        function setToday() {
            var d = new Date().toISOString().slice(0,10);
            var input = document.getElementById('billDate');
            if (input) input.value = d;
        }

        function addItemRow() {
            var container = document.getElementById('itemsContainer');
            var rowId = 'row_' + Date.now();
            var html = ''+
            '<div class="item-row" id="'+rowId+'">'+
                '<div class="row g-3 align-items-end">'+
                    '<div class="col-md-5">'+
                        '<label class="form-label">Item</label>'+
                        '<select class="form-select item-select" name="itemCode" required onchange="onItemChange(\''+rowId+'\')">'+
                            '<option value="">Select Item</option>'+
                            items.map(function(it){ return '<option value="'+it.itemCode+'" data-price="'+it.price+'" data-stock="'+it.stock+'">'+it.name+' ('+it.itemCode+')</option>'; }).join('')+
                        '</select>'+
                    '</div>'+
                    '<div class="col-md-2">'+
                        '<label class="form-label">Qty</label>'+
                        '<input type="number" class="form-control qty" name="quantity" min="1" value="1" onchange="recalcRow(\''+rowId+'\')" required />'+
                    '</div>'+
                    '<div class="col-md-2">'+
                        '<label class="form-label">Unit Price (LKR)</label>'+
                        '<input type="number" class="form-control unit" name="unitPrice" step="0.01" readonly />'+
                    '</div>'+
                    '<div class="col-md-2">'+
                        '<label class="form-label">Total (LKR)</label>'+
                        '<input type="number" class="form-control total" name="totalPrice" step="0.01" readonly />'+
                    '</div>'+
                    '<div class="col-md-1 d-grid">'+
                        '<button type="button" class="btn btn-danger" onclick="removeRow(\''+rowId+'\')"><i class="fas fa-trash"></i></button>'+
                    '</div>'+
                '</div>'+
            '</div>';
            container.insertAdjacentHTML('beforeend', html);
        }

        function removeRow(id){ var el = document.getElementById(id); if(el){ el.remove(); updateTotals(); } }

        function onItemChange(id){
            var row = document.getElementById(id);
            if(!row) return;
            var select = row.querySelector('.item-select');
            var unit = row.querySelector('.unit');
            var qty = row.querySelector('.qty');
            if(select && unit && qty){
                var opt = select.options[select.selectedIndex];
                var price = parseFloat(opt.getAttribute('data-price')||'0');
                var stock = parseInt(opt.getAttribute('data-stock')||'0');
                unit.value = price.toFixed(2);
                if(stock>0){ qty.max = stock; if(parseInt(qty.value)>stock){ qty.value = stock; } }
                recalcRow(id);
            }
        }

        function recalcRow(id){
            var row = document.getElementById(id);
            if(!row) return;
            var qty = parseFloat(row.querySelector('.qty').value||'0');
            var unit = parseFloat(row.querySelector('.unit').value||'0');
            row.querySelector('.total').value = (qty*unit).toFixed(2);
            updateTotals();
        }

        function updateTotals(){
            var rows = document.querySelectorAll('.item-row');
            var itemsCount = rows.length; var qtySum = 0; var amount = 0;
            rows.forEach(function(r){
                qtySum += parseFloat(r.querySelector('.qty').value||'0');
                amount += parseFloat(r.querySelector('.total').value||'0');
            });
            document.getElementById('totalItems').textContent = itemsCount;
            document.getElementById('totalQuantity').textContent = qtySum;
            document.getElementById('totalAmount').textContent = 'LKR ' + amount.toFixed(2);
        }

        document.addEventListener('DOMContentLoaded', function(){ setToday(); addItemRow(); updateTotals(); });

        document.getElementById('billForm').addEventListener('submit', function(e){
            var customer = document.getElementById('customerAccountNumber').value;
            var rows = document.querySelectorAll('.item-row');
            var hasItem = false; rows.forEach(function(r){ if(r.querySelector('.item-select').value){ hasItem=true; } });
            if(!customer){ alert('Please select a customer.'); e.preventDefault(); return; }
            if(!hasItem){ alert('Please add at least one item.'); e.preventDefault(); return; }
        });
    </script>
</body>
</html>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Item" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Item List</title>
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
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
        }
        .container-custom {
            width: 100%;
            max-width: 900px;
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
        .add-btn {
            background: #10b981;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 8px 18px;
            font-size: 1rem;
            transition: background 0.2s;
            margin-bottom: 16px;
        }
        .add-btn:hover {
            background: #059669;
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
                    <a class="nav-link active" href="<%=request.getContextPath()%>/item/list">
                        <i class="fas fa-box"></i> Items
                    </a>
                </li>
                <li class="nav-item">
                    
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/help.jsp">
                        <i class="fas fa-question-circle"></i> Help
                    </a>
                </li>
            </ul>
        </nav>
    </div>
    <!-- Main Content -->
    <div class="main-content">
        <% String success = null;
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
            <script>
                // Show JavaScript alert as well
                alert('<%= success %>');
            </script>
        <% } %>
        <div class="container-custom">
            <h2>Items</h2>
            <a href="add.jsp" class="add-btn"><i class="fas fa-plus"></i> Add New Item</a>
            <table class="table table-bordered table-striped mt-3">
                <thead>
                    <tr>
                        <th>Item Code</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Category</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<Item> items = (List<Item>) request.getAttribute("items");
                    if (items != null && !items.isEmpty()) {
                        for (Item item : items) {
                %>
                    <tr>
                        <td><%= item.getItemCode() %></td>
                        <td><%= item.getName() %></td>
                        <td><%= item.getDescription() %></td>
                        <td>LKR <%= String.format("%.2f", item.getPrice()) %></td>
                        <td><%= item.getStock() %></td>
                        <td><%= item.getCategory() %></td>
                        <td>
                            <a href="<%=request.getContextPath()%>/item/edit?item_code=<%= item.getItemCode() %>" class="btn btn-sm btn-warning">Edit</a>
                            <a href="<%=request.getContextPath()%>/item/delete?item_code=<%= item.getItemCode() %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this item?');">Delete</a>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="7" class="text-center">No items found.</td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
            <a href="../dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 
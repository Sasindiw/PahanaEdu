<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Item - Pahana Edu Bookshop</title>
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
            min-height: 100vh;
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
        .form-container {
            width: 100%;
            max-width: 500px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.08);
            padding: 32px 28px 24px 28px;
        }
        .form-title {
            font-weight: bold;
            color: var(--sidebar-bg);
            margin-bottom: 24px;
            text-align: center;
            letter-spacing: 1px;
        }
        .form-label {
            color: #334155;
            font-weight: 500;
        }
        .btn-primary {
            background: var(--primary-btn);
            border: none;
        }
        .btn-primary:hover, .btn-primary:focus {
            background: var(--primary-btn-hover);
        }
        .back-link {
            color: var(--primary-btn);
            text-decoration: none;
            font-size: 0.98rem;
        }
        .back-link:hover {
            color: var(--primary-btn-hover);
            text-decoration: underline;
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
        <div class="form-container">
            <div class="mb-3 text-center">
                <a href="../dashboard.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
            </div>
            <h2 class="form-title">Add Item</h2>
            <form action="<%=request.getContextPath()%>/item/add" method="post" autocomplete="off">
                <div class="mb-3">
                    <label for="item_code" class="form-label">Item Code</label>
                    <input type="text" class="form-control" id="item_code" name="item_code" maxlength="50" required>
                </div>
                <div class="mb-3">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" class="form-control" id="name" name="name" maxlength="100" required>
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <input type="text" class="form-control" id="description" name="description" maxlength="255">
                </div>
                <div class="mb-3">
                    <label for="price" class="form-label">Price</label>
                    <div class="input-group">
                        <span class="input-group-text">LKR</span>
                        <input type="text" class="form-control" id="price" name="price" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="stock" class="form-label">Stock</label>
                    <input type="number" class="form-control" id="stock" name="stock" required>
                </div>
                <div class="mb-3">
                    <label for="category" class="form-label">Category</label>
                    <input type="text" class="form-control" id="category" name="category" maxlength="50">
                </div>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-plus"></i> Add Item</button>
                </div>
            </form>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 
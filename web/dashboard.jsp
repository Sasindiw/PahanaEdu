<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Pahana Edu Bookshop</title>
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
        .stats-card {
            background: white;
            border-radius: 16px;
            padding: 24px 18px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.08);
            transition: transform 0.2s;
            border: none;
        }
        .stats-card:hover {
            transform: translateY(-6px) scale(1.03);
        }
        .stats-icon {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 26px;
            color: white;
            margin-bottom: 14px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        .stats-customers { background: linear-gradient(135deg, #3b82f6 0%, #60a5fa 100%); }
        .stats-items { background: linear-gradient(135deg, #fbbf24 0%, #fde68a 100%); color: #1e293b; }
        .stats-sales { background: linear-gradient(135deg, #10b981 0%, #6ee7b7 100%); }
        .stats-revenue { background: linear-gradient(135deg, #a78bfa 0%, #fbc2eb 100%); }
        .card-header {
            background: var(--primary-btn);
            color: #fff;
            border-radius: 12px 12px 0 0;
            font-weight: 500;
        }
        .btn-primary {
            background: var(--primary-btn);
            border: none;
        }
        .btn-primary:hover, .btn-primary:focus {
            background: var(--primary-btn-hover);
        }
        .btn-success {
            background: linear-gradient(90deg, #10b981 0%, #6ee7b7 100%);
            border: none;
            color: #fff;
        }
        .btn-success:hover, .btn-success:focus {
            background: #059669;
        }
        .btn-info {
            background: linear-gradient(90deg, #a78bfa 0%, #fbc2eb 100%);
            border: none;
            color: #fff;
        }
        .btn-info:hover, .btn-info:focus {
            background: #7c3aed;
        }
        .btn-outline-danger {
            border-color: #f3574b;
            color: #f3574b;
        }
        .btn-outline-danger:hover {
            background: #f3574b;
            color: #fff;
        }
        .list-group-item {
            border: none;
            border-bottom: 1px solid #f1f1f1;
        }
        .list-group-item:last-child {
            border-bottom: none;
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
                    <a class="nav-link active" href="dashboard.jsp">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="customer/list">
                        <i class="fas fa-users"></i> Customers
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="item/list">
                        <i class="fas fa-box"></i> Items
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="billing/create">
                        <i class="fas fa-receipt"></i> Create Bill
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="billing/list">
                        <i class="fas fa-list"></i> Bills
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="report/sales">
                        <i class="fas fa-chart-bar"></i> Reports
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="help.jsp">
                        <i class="fas fa-question-circle"></i> Help
                    </a>
                </li>
            </ul>
        </nav>
    </div>
    <!-- Main Content -->
    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold" style="letter-spacing:1px;">Dashboard</h2>
            <a href="logout" class="btn btn-outline-danger">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="stats-card text-center">
                    <div class="stats-icon stats-customers mx-auto">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3 class="fw-bold">150</h3>
                    <p class="text-muted mb-0">Total Customers</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card text-center">
                    <div class="stats-icon stats-items mx-auto">
                        <i class="fas fa-box"></i>
                    </div>
                    <h3 class="fw-bold">75</h3>
                    <p class="text-muted mb-0">Total Items</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card text-center">
                    <div class="stats-icon stats-sales mx-auto">
                        <i class="fas fa-receipt"></i>
                    </div>
                    <h3 class="fw-bold">45</h3>
                    <p class="text-muted mb-0">Total Bills</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card text-center">
                    <div class="stats-icon stats-revenue mx-auto">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <h3 class="fw-bold">Rs. 125,000</h3>
                    <p class="text-muted mb-0">Total Revenue</p>
                </div>
            </div>
        </div>
        <!-- Quick Actions & Recent Activity -->
        <div class="row">
            <div class="col-md-6 mb-3">
                <div class="card h-100">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-bolt"></i> Quick Actions</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <a href="customer/add.jsp" class="btn btn-primary">
                                <i class="fas fa-user-plus"></i> Add Customer
                            </a>
                            <a href="item/add.jsp" class="btn btn-success">
                                <i class="fas fa-plus"></i> Add Item
                            </a>
                            <a href="billing/create" class="btn btn-info">
                                <i class="fas fa-receipt"></i> Create Bill
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-3">
                <div class="card h-100">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-clock"></i> Recent Activity</h5>
                    </div>
                    <div class="card-body">
                        <div class="list-group list-group-flush">
                            <div class="list-group-item">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <strong>New customer registered</strong>
                                        <p class="text-muted mb-0">John Doe - Account #1001</p>
                                    </div>
                                    <small class="text-muted">2 hours ago</small>
                                </div>
                            </div>
                            <div class="list-group-item">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <strong>Bill generated</strong>
                                        <p class="text-muted mb-0">Bill #2024-001 - Rs. 1,250</p>
                                    </div>
                                    <small class="text-muted">4 hours ago</small>
                                </div>
                            </div>
                            <div class="list-group-item">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <strong>Item added</strong>
                                        <p class="text-muted mb-0">"A/L Physics" Book - Stock: 20</p>
                                    </div>
                                    <small class="text-muted">6 hours ago</small>
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
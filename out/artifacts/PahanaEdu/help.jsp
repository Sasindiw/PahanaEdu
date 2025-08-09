<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help & Support - Pahana Edu Bookshop</title>
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
        body { background: var(--main-bg); }
        .sidebar {
            position: fixed; top: 0; left: 0; height: 100vh; width: var(--sidebar-width);
            background: var(--sidebar-bg); color: var(--sidebar-text); z-index: 1000;
            box-shadow: 2px 0 10px rgba(0,0,0,0.07);
        }
        .sidebar-header { padding: 24px 10px 16px 10px; text-align: center; border-bottom: 1px solid rgba(255,255,255,0.08); }
        .sidebar-header h5 { font-weight: bold; letter-spacing: 1px; color: var(--sidebar-text); }
        .sidebar-header small { color: #cbd5e1; }
        .sidebar-menu { padding: 24px 0; }
        .sidebar-menu .nav-link { color: var(--sidebar-text); padding: 14px 28px; font-size: 1.08rem; border-radius: 30px 0 0 30px; margin-bottom: 6px; transition: all 0.2s; opacity: 0.85; }
        .sidebar-menu .nav-link:hover, .sidebar-menu .nav-link.active { color: var(--sidebar-text); background: var(--primary-btn-hover); opacity: 1; }
        .main-content { margin-left: var(--sidebar-width); padding: 32px 24px 24px 24px; min-height: 100vh; background: var(--main-bg); }
        .container-custom { width: 100%; max-width: 1000px; background: #fff; border-radius: 16px; box-shadow: 0 4px 18px rgba(0,0,0,0.08); padding: 32px 28px 24px 28px; }
        .section-title { color: #1e293b; font-weight: 700; letter-spacing: .5px; margin-top: 1rem; }
        .anchor { scroll-margin-top: 90px; }
        .kbd { padding: 2px 6px; border-radius: 4px; background: #e5e7eb; font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace; }
        .card-link { text-decoration: none; }
        .form-help label { font-weight: 500; color: #334155; }
        .faq-item { border-bottom: 1px solid #f1f5f9; padding: .6rem 0; }
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
                    <a class="nav-link" href="<%=request.getContextPath()%>/dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/customer/list"><i class="fas fa-users"></i> Customers</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/item/list"><i class="fas fa-box"></i> Items</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/billing/create"><i class="fas fa-receipt"></i> Create Bill</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="<%=request.getContextPath()%>/help.jsp"><i class="fas fa-question-circle"></i> Help</a>
                </li>
            </ul>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container-custom">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2 class="mb-0" style="color:#1e293b; letter-spacing:1px;">Help & Support</h2>
                <a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn btn-outline-secondary"><i class="fas fa-arrow-left"></i> Back</a>
            </div>

            <!-- Quick Links -->
            <div class="row g-3 mb-4">
                <div class="col-md-4">
                    <a class="card-link" href="#getting-started"><div class="card p-3 h-100"><h5 class="mb-1"><i class="fas fa-play"></i> Getting Started</h5><small class="text-muted">Login and navigation</small></div></a>
                </div>
                <div class="col-md-4">
                    <a class="card-link" href="#common-tasks"><div class="card p-3 h-100"><h5 class="mb-1"><i class="fas fa-list-check"></i> Common Tasks</h5><small class="text-muted">Customers, Items, Bills</small></div></a>
                </div>
                <div class="col-md-4">
                    <a class="card-link" href="#troubleshooting"><div class="card p-3 h-100"><h5 class="mb-1"><i class="fas fa-tools"></i> Troubleshooting</h5><small class="text-muted">Quick fixes</small></div></a>
                </div>
                <div class="col-md-4">
                    <a class="card-link" href="#contact-support"><div class="card p-3 h-100"><h5 class="mb-1"><i class="fas fa-headset"></i> Contact Support</h5><small class="text-muted">Send a support request</small></div></a>
                </div>
            </div>

            <!-- Getting Started -->
            <div id="getting-started" class="anchor">
                <h4 class="section-title"><i class="fas fa-play"></i> Getting Started</h4>
                <ol class="mb-3">
                    <li>Open <span class="kbd">/login</span> and sign in.</li>
                    <li>Use the left sidebar to navigate: Dashboard, Customers, Items, Create Bill, Help.</li>
                    <li>Use Quick Actions on the Dashboard for common flows.</li>
                </ol>
            </div>

            <!-- Common Tasks -->
            <div id="common-tasks" class="anchor mt-4">
                <h4 class="section-title"><i class="fas fa-list-check"></i> Common Tasks</h4>
                <div class="mb-3">
                    <h6 class="fw-bold">Add a Customer</h6>
                    <p class="mb-1">Go to Customers → use Add Customer button, fill the form, and submit.</p>
                </div>
                <div class="mb-3">
                    <h6 class="fw-bold">Add an Item</h6>
                    <p class="mb-1">Go to Items → Add Item, enter item details (code, name, price, stock).</p>
                </div>
                <div class="mb-3">
                    <h6 class="fw-bold">Create a Bill</h6>
                    <p class="mb-1">Go to Create Bill → select customer → add items → review totals → Save.</p>
                </div>
                <div class="mb-3">
                    <h6 class="fw-bold">Print a Bill</h6>
                    <p class="mb-1">After saving a bill you are redirected to Print. Use browser print to paper/PDF.</p>
                </div>
            </div>

            <!-- Troubleshooting -->
            <div id="troubleshooting" class="anchor mt-4">
                <h4 class="section-title"><i class="fas fa-tools"></i> Troubleshooting</h4>
                <ul>
                    <li><strong>Login fails</strong>: Verify username/password. Ensure database is up.</li>
                    <li><strong>Database error</strong>: Check DB credentials and run the SQL setup scripts.</li>
                    <li><strong>JSP error on Create Bill</strong>: Ensure <code>WEB-INF/lib/jstl-1.2.jar</code> is present and clear Tomcat work cache.</li>
                    <li><strong>Changes not visible</strong>: Redeploy and restart Tomcat; clear browser cache if needed.</li>
                </ul>
            </div>

            <!-- Contact Support -->
            <div id="contact-support" class="anchor mt-4">
                <h4 class="section-title"><i class="fas fa-headset"></i> Contact Support</h4>
                <% String supportSuccess = (String) request.getAttribute("supportSuccess");
                   String supportError = (String) request.getAttribute("supportError");
                   if (supportSuccess != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <%= supportSuccess %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>
                <% if (supportError != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <%= supportError %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>
                <form class="form-help" method="post" action="<%=request.getContextPath()%>/support" autocomplete="on">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="name" class="form-label">Your Name</label>
                            <input type="text" id="name" name="name" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" id="email" name="email" class="form-control" required>
                        </div>
                        <div class="col-12">
                            <label for="subject" class="form-label">Subject</label>
                            <input type="text" id="subject" name="subject" class="form-control" required>
                        </div>
                        <div class="col-12">
                            <label for="message" class="form-label">Message</label>
                            <textarea id="message" name="message" rows="5" class="form-control" required></textarea>
                        </div>
                        <div class="col-12 d-grid gap-2 d-md-flex justify-content-md-end">
                            <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane"></i> Send</button>
                            <a href="#getting-started" class="btn btn-light"><i class="fas fa-arrow-up"></i> Top</a>
                        </div>
                    </div>
                </form>
                <div class="mt-3 small text-muted">
                    By sending, basic details are logged for support. No passwords are collected.
                </div>
            </div>

            <!-- Contact / About -->
            <div class="mt-4">
                <h4 class="section-title"><i class="fas fa-info-circle"></i> About</h4>
                <p class="mb-1">Pahana Edu Bookshop Management — educational project for managing customers, items, and billing.</p>
                <p class="mb-0">For support, contact your administrator.</p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // no-op placeholder for any future help interactions
    </script>
</body>
</html>


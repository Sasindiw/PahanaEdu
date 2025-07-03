<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>PahanaEdu Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            margin: 0;
            min-height: 100vh;
            background: linear-gradient(120deg, #e0eafc 0%, #cfdef3 100%);
            font-family: 'Roboto', Arial, sans-serif;
        }
        .navbar {
            background: #2193b0;
            color: #fff;
            padding: 1rem 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 8px rgba(33,147,176,0.08);
        }
        .navbar .logo {
            display: flex;
            align-items: center;
            font-size: 1.3rem;
            font-weight: 700;
            letter-spacing: 1px;
        }
        .navbar .logo i {
            margin-right: 0.7rem;
            font-size: 1.7rem;
        }
        .navbar .user {
            font-size: 1rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .navbar .user i {
            font-size: 1.2rem;
        }
        .dashboard-container {
            max-width: 700px;
            margin: 2.5rem auto 0 auto;
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 4px 24px 0 rgba(31, 38, 135, 0.10);
            padding: 2.5rem 2rem;
            text-align: center;
        }
        .dashboard-title {
            font-size: 2rem;
            font-weight: 700;
            color: #2193b0;
            margin-bottom: 1.2rem;
        }
        .dashboard-welcome {
            font-size: 1.15rem;
            color: #444;
            margin-bottom: 2rem;
        }
        .dashboard-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 1.2rem;
            justify-content: center;
        }
        .dashboard-action {
            background: linear-gradient(90deg, #2193b0, #6dd5ed);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 1.1rem 2.2rem;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(33,147,176,0.09);
            transition: background 0.2s, transform 0.1s;
            display: flex;
            align-items: center;
            gap: 0.7rem;
        }
        .dashboard-action:hover {
            background: linear-gradient(90deg, #6dd5ed, #2193b0);
            transform: translateY(-2px) scale(1.03);
        }
        @media (max-width: 600px) {
            .dashboard-container {
                padding: 1.2rem 0.5rem;
            }
            .dashboard-title {
                font-size: 1.3rem;
            }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo"><i class="fa fa-book-open"></i> PahanaEdu</div>
        <div class="user">
            <i class="fa fa-user-circle"></i>
            <% 
                com.pahanaedu.model.User user = (com.pahanaedu.model.User) session.getAttribute("user");
                if (user != null) {
                    out.print(user.getUsername());
                } else {
                    out.print("Guest");
                }
            %>
        </div>
    </div>
    <div class="dashboard-container">
        <div class="dashboard-title">Welcome to Your Dashboard</div>
        <div class="dashboard-welcome">
            Hello, <b><% if (user != null) { out.print(user.getUsername()); } else { out.print("Guest"); } %></b>!<br>
            This is your main dashboard. You can add your main features and navigation here.
        </div>
        <div class="dashboard-actions">
            <button class="dashboard-action"><i class="fa fa-user"></i> Profile</button>
            <button class="dashboard-action"><i class="fa fa-cog"></i> Settings</button>
            <button class="dashboard-action"><i class="fa fa-sign-out-alt"></i> Logout</button>
        </div>
    </div>
</body>
</html> 
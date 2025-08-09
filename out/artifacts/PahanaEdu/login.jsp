<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>PahanaEdu Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            min-height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(120deg, #e0eafc 0%, #cfdef3 100%);
            font-family: 'Roboto', Arial, sans-serif;
            position: relative;
        }
        body::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: url('https://www.toptal.com/designers/subtlepatterns/patterns/symphony.png');
            opacity: 0.13;
            z-index: 0;
        }
        .login-container {
            position: relative;
            z-index: 1;
            background: #fff;
            padding: 2.5rem 2rem 2rem 2rem;
            border-radius: 18px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.18), 0 1.5px 6px 0 rgba(0,0,0,0.07);
            min-width: 340px;
            max-width: 370px;
            width: 100%;
            text-align: center;
            transition: box-shadow 0.2s;
        }
        .login-container:hover {
            box-shadow: 0 12px 40px 0 rgba(31, 38, 135, 0.22), 0 2px 8px 0 rgba(0,0,0,0.09);
        }
        .login-logo {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, #2193b0 60%, #6dd5ed 100%);
            border-radius: 50%;
            margin: 0 auto 1.1rem auto;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 8px rgba(33,147,176,0.13);
        }
        .login-logo i {
            color: #fff;
            font-size: 2.2rem;
        }
        .login-logo span {
            color: #fff;
            font-size: 2.1rem;
            font-weight: 700;
            letter-spacing: 1px;
            font-family: 'Roboto', Arial, sans-serif;
        }
        .login-title {
            font-size: 1.6rem;
            font-weight: 700;
            color: #2193b0;
            margin-bottom: 1.2rem;
            letter-spacing: 0.5px;
        }
        .login-form {
            position: relative;
        }
        .input-group {
            position: relative;
            margin-bottom: 1.1rem;
        }
        .input-group i {
            position: absolute;
            left: 13px;
            top: 50%;
            transform: translateY(-50%);
            color: #bdbdbd;
            font-size: 1.1rem;
        }
        .input-group .toggle-password {
            position: absolute;
            right: 22px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #bdbdbd;
            font-size: 1.1rem;
            cursor: pointer;
            padding: 0;
            z-index: 2;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100%;
        }
        .input-group input {
            width: 85%;
            max-width: 260px;
            margin: 0 auto;
            padding-right: 2.2rem;
            padding: 0.5rem 0.5rem 0.5rem 2.0rem;
            border: 1.5px solid #e3e3e3;
            border-radius: 7px;
            font-size: 0.95rem;
            background: #f7fafd;
            transition: border 0.2s, box-shadow 0.2s;
        }
        .input-group input:focus {
            border: 1.5px solid #2193b0;
            outline: none;
            box-shadow: 0 0 0 2px #6dd5ed33;
        }
        .password-tooltip {
            position: absolute;
            right: 38px;
            top: 50%;
            transform: translateY(-50%);
            color: #2193b0;
            font-size: 1.1rem;
            cursor: pointer;
        }
        .tooltip-text {
            visibility: hidden;
            width: 180px;
            background-color: #2193b0;
            color: #fff;
            text-align: left;
            border-radius: 6px;
            padding: 0.5rem;
            position: absolute;
            z-index: 2;
            right: 110%;
            top: 50%;
            transform: translateY(-50%);
            font-size: 0.95rem;
            opacity: 0;
            transition: opacity 0.2s;
        }
        .password-tooltip:hover .tooltip-text {
            visibility: visible;
            opacity: 1;
        }
        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.1rem;
        }
        .remember-forgot label {
            font-size: 0.98rem;
            color: #555;
            font-weight: 400;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }
        .remember-forgot a {
            color: #2193b0;
            text-decoration: none;
            font-size: 0.98rem;
            transition: text-decoration 0.2s;
        }
        .remember-forgot a:hover {
            text-decoration: underline;
        }
        .login-form button[type="submit"] {
            width: 100%;
            padding: 0.85rem;
            background: linear-gradient(90deg, #2193b0, #6dd5ed);
            color: #fff;
            border: none;
            border-radius: 7px;
            font-size: 1.13rem;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(33,147,176,0.09);
            transition: background 0.2s, transform 0.1s;
            position: relative;
        }
        .login-form button[type="submit"]:hover {
            background: linear-gradient(90deg, #6dd5ed, #2193b0);
            transform: translateY(-2px) scale(1.03);
        }
        .spinner {
            display: none;
            position: absolute;
            right: 18px;
            top: 50%;
            transform: translateY(-50%);
            width: 22px;
            height: 22px;
            border: 3px solid #fff;
            border-top: 3px solid #2193b0;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            0% { transform: translateY(-50%) rotate(0deg); }
            100% { transform: translateY(-50%) rotate(360deg); }
        }
        .signup-link {
            margin-top: 1.2rem;
            font-size: 1rem;
            color: #555;
        }
        .signup-link a {
            color: #2193b0;
            text-decoration: none;
            font-weight: 500;
            margin-left: 0.3rem;
        }
        .signup-link a:hover {
            text-decoration: underline;
        }
        .error-message {
            color: #e74c3c;
            margin-top: 1rem;
            font-size: 1rem;
            background: #ffeaea;
            border-radius: 5px;
            padding: 0.6rem 0.8rem;
        }
        @media (max-width: 480px) {
            .login-container {
                min-width: 90vw;
                padding: 1.5rem 0.5rem 1.2rem 0.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container" aria-label="Login form">
        <div class="login-logo" aria-hidden="true"><i class="fa fa-book-open"></i></div>
        <div class="login-title">PahanaEdu Login</div>
        <form class="login-form" method="post" action="<%=request.getContextPath()%>/login" autocomplete="on" aria-label="Login form" onsubmit="return showSpinner()">
            <div class="input-group">
                <i class="fa fa-user" aria-hidden="true"></i>
                <label for="username" class="sr-only">Username</label>
                <input type="text" id="username" name="username" required autofocus autocomplete="username" aria-label="Username">
            </div>
            <div class="input-group">
                <i class="fa fa-lock" aria-hidden="true"></i>
                <label for="password" class="sr-only">Password</label>
                <input type="password" id="password" name="password" required autocomplete="current-password" aria-label="Password">
                <button type="button" class="toggle-password" tabindex="0" aria-label="Show or hide password" onclick="togglePassword()">
                    <i class="fa fa-eye" id="togglePasswordIcon"></i>
                </button>
               
            </div>
            <div class="remember-forgot">
                <label><input type="checkbox" name="remember" tabindex="0"> Remember me</label>
                <a href="#" tabindex="0">Forgot password?</a>
            </div>
            <button type="submit" aria-label="Login">
                Login
                <span class="spinner" id="spinner"></span>
            </button>
        </form>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message"><%= request.getAttribute("error") %></div>
        <% } %>
        <div class="signup-link">
            New to PahanaEdu?
            <a href="#" tabindex="0">Sign up</a>
        </div>
    </div>
    <style>
        .sr-only { position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip: rect(0,0,0,0); border: 0; }
    </style>
    <script>
        function togglePassword() {
            const pwd = document.getElementById('password');
            const icon = document.getElementById('togglePasswordIcon');
            if (pwd.type === 'password') {
                pwd.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                pwd.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
        function showSpinner() {
            document.getElementById('spinner').style.display = 'inline-block';
            return true;
        }
    </script>
</body>
</html>
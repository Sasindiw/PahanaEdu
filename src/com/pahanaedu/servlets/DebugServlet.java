package com.pahanaedu.servlets;

import com.pahanaedu.dao.UserDAO;
import com.pahanaedu.dao.UserDAOImpl;
import com.pahanaedu.model.User;
import com.pahanaedu.service.UserService;
import com.pahanaedu.util.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet("/debug")
public class DebugServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<h2>🔍 Authentication Debug Report</h2>");
        
        try {
            // Test 1: Database Connection
            response.getWriter().println("<h3>1. Database Connection Test</h3>");
            Connection conn = DatabaseConnection.getConnection();
            response.getWriter().println("✅ Database connection successful!<br>");
            
            // Test 2: Check if users table exists and has data
            response.getWriter().println("<h3>2. Users Table Check</h3>");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users");
            if (rs.next()) {
                int count = rs.getInt(1);
                response.getWriter().println("✅ Users table exists with " + count + " records<br>");
                
                // Test 3: Check admin user specifically
                response.getWriter().println("<h3>3. Admin User Check</h3>");
                rs = stmt.executeQuery("SELECT * FROM users WHERE username = 'admin'");
                if (rs.next()) {
                    response.getWriter().println("✅ Admin user found in database:<br>");
                    response.getWriter().println("- User ID: " + rs.getInt("user_id") + "<br>");
                    response.getWriter().println("- Username: " + rs.getString("username") + "<br>");
                    response.getWriter().println("- Password Hash: '" + rs.getString("password_hash") + "'<br>");
                    response.getWriter().println("- Full Name: " + rs.getString("full_name") + "<br>");
                    response.getWriter().println("- Email: " + rs.getString("email") + "<br>");
                    response.getWriter().println("- Role: " + rs.getString("role") + "<br>");
                    
                    // Test 4: Test DAO layer
                    response.getWriter().println("<h3>4. DAO Layer Test</h3>");
                    UserDAO userDAO = new UserDAOImpl();
                    User adminUser = userDAO.getUserByUsername("admin");
                    
                    if (adminUser != null) {
                        response.getWriter().println("✅ DAO successfully retrieved user:<br>");
                        response.getWriter().println("- Username: " + adminUser.getUsername() + "<br>");
                        response.getWriter().println("- Password Hash: '" + adminUser.getPasswordHash() + "'<br>");
                        response.getWriter().println("- Full Name: " + adminUser.getFullName() + "<br>");
                        response.getWriter().println("- Role: " + adminUser.getRole() + "<br>");
                        
                        // Test 5: Test Service layer authentication
                        response.getWriter().println("<h3>5. Service Layer Authentication Test</h3>");
                        UserService userService = new UserService();
                        
                        // Test with correct password
                        User authenticatedUser = userService.authenticate("admin", "Admin123");
                        if (authenticatedUser != null) {
                            response.getWriter().println("✅ Authentication successful with 'Admin123'<br>");
                        } else {
                            response.getWriter().println("❌ Authentication failed with 'Admin123'<br>");
                        }
                        
                        // Test with lowercase password
                        authenticatedUser = userService.authenticate("admin", "admin123");
                        if (authenticatedUser != null) {
                            response.getWriter().println("✅ Authentication successful with 'admin123'<br>");
                        } else {
                            response.getWriter().println("❌ Authentication failed with 'admin123'<br>");
                        }
                        
                        // Test password comparison
                        response.getWriter().println("<h3>6. Password Comparison Test</h3>");
                        String storedPassword = adminUser.getPasswordHash();
                        response.getWriter().println("- Stored password: '" + storedPassword + "'<br>");
                        response.getWriter().println("- Expected password: 'Admin123'<br>");
                        response.getWriter().println("- Password length: " + storedPassword.length() + "<br>");
                        response.getWriter().println("- Password equals 'Admin123': " + storedPassword.equals("Admin123") + "<br>");
                        response.getWriter().println("- Password equals 'admin123': " + storedPassword.equals("admin123") + "<br>");
                        
                    } else {
                        response.getWriter().println("❌ DAO failed to retrieve user<br>");
                    }
                    
                } else {
                    response.getWriter().println("❌ Admin user not found in database!<br>");
                }
            } else {
                response.getWriter().println("❌ Users table is empty or doesn't exist<br>");
            }
            
            conn.close();
            
        } catch (Exception e) {
            response.getWriter().println("❌ Error: " + e.getMessage() + "<br>");
            response.getWriter().println("<pre>");
            e.printStackTrace(response.getWriter());
            response.getWriter().println("</pre>");
        }
        
        response.getWriter().println("<br><hr><br>");
        response.getWriter().println("<h3>🔧 Quick Fix Options:</h3>");
        response.getWriter().println("1. <a href='login.jsp'>Try Login Again</a><br>");
        response.getWriter().println("2. <a href='debug'>Refresh Debug Report</a><br>");
        response.getWriter().println("3. Check database and update password if needed<br>");
    }
} 
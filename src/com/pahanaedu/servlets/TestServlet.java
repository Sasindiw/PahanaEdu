package com.pahanaedu.servlets;

import com.pahanaedu.dao.UserDAO;
import com.pahanaedu.dao.UserDAOImpl;
import com.pahanaedu.model.User;
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

@WebServlet("/test")
public class TestServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<h2>Database and Authentication Test</h2>");
        
        try {
            // Test database connection
            response.getWriter().println("<h3>1. Testing Database Connection...</h3>");
            Connection conn = DatabaseConnection.getConnection();
            response.getWriter().println("✅ Database connection successful!<br>");
            
            // Test if admin user exists
            response.getWriter().println("<h3>2. Testing Admin User...</h3>");
            UserDAO userDAO = new UserDAOImpl();
            User adminUser = userDAO.getUserByUsername("admin");
            
            if (adminUser != null) {
                response.getWriter().println("✅ Admin user found:<br>");
                response.getWriter().println("- Username: " + adminUser.getUsername() + "<br>");
                response.getWriter().println("- Password Hash: " + adminUser.getPasswordHash() + "<br>");
                response.getWriter().println("- Full Name: " + adminUser.getFullName() + "<br>");
                response.getWriter().println("- Role: " + adminUser.getRole() + "<br>");
                
                // Test authentication
                response.getWriter().println("<h3>3. Testing Authentication...</h3>");
                if ("Admin123".equals(adminUser.getPasswordHash())) {
                    response.getWriter().println("✅ Password matches! Authentication should work.<br>");
                } else {
                    response.getWriter().println("❌ Password mismatch! Expected: Admin123, Got: " + adminUser.getPasswordHash() + "<br>");
                }
            } else {
                response.getWriter().println("❌ Admin user not found!<br>");
            }
            
            conn.close();
            
        } catch (Exception e) {
            response.getWriter().println("❌ Error: " + e.getMessage() + "<br>");
            e.printStackTrace(response.getWriter());
        }
        
        response.getWriter().println("<br><a href='login.jsp'>Back to Login</a>");
    }
} 
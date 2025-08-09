package com.pahanaedu.dao;

import com.pahanaedu.model.User;
import com.pahanaedu.util.DatabaseConnection;
import java.sql.*;

public class UserDAOImpl implements UserDAO {
    @Override
    public User getUserByUsername(String username) {
        System.out.println("UserDAOImpl.getUserByUsername - Searching for username: " + username);
        User user = null;
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE username = ?")) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPasswordHash(rs.getString("password_hash"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                System.out.println("User found in database: " + user.getUsername() + ", Password: '" + user.getPasswordHash() + "'");
            } else {
                System.out.println("No user found in database for username: " + username);
            }
        } catch (SQLException e) {
            System.out.println("SQL Exception in getUserByUsername: " + e.getMessage());
            e.printStackTrace();
        }
        return user;
    }
}
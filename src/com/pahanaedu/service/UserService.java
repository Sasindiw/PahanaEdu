package com.pahanaedu.service;

import com.pahanaedu.dao.UserDAO;
import com.pahanaedu.dao.UserDAOImpl;
import com.pahanaedu.model.User;

public class UserService {
    private UserDAO userDAO = new UserDAOImpl();

    public User authenticate(String username, String password) {
        System.out.println("UserService.authenticate - Username: " + username + ", Password: " + password);
        
        User user = userDAO.getUserByUsername(username);
        if (user != null) {
            System.out.println("User found: " + user.getUsername() + ", Stored password: '" + user.getPasswordHash() + "'");
            // For production, use hashed password check (e.g., BCrypt)
            if (password.equals(user.getPasswordHash())) {
                System.out.println("Password match successful!");
                return user;
            } else {
                System.out.println("Password mismatch! Expected: '" + password + "', Got: '" + user.getPasswordHash() + "'");
            }
        } else {
            System.out.println("User not found for username: " + username);
        }
        return null;
    }
}
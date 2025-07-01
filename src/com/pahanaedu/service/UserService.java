package com.pahanaedu.service;

import com.pahanaedu.dao.UserDAO;
import com.pahanaedu.dao.UserDAOImpl;
import com.pahanaedu.model.User;

public class UserService {
    private UserDAO userDAO = new UserDAOImpl();

    public User authenticate(String username, String password) {
        User user = userDAO.getUserByUsername(username);
        if (user != null) {
            // For production, use hashed password check (e.g., BCrypt)
            if (password.equals(user.getPasswordHash())) {
                return user;
            }
        }
        return null;
    }
}
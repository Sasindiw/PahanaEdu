package com.pahanaedu.dao;

import com.pahanaedu.model.User;

public interface UserDAO {
    User getUserByUsername(String username);
}
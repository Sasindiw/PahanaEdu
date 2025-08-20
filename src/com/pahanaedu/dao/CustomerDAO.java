package com.pahanaedu.dao;

import com.pahanaedu.model.Customer;
import java.util.List;

public interface CustomerDAO {
    boolean insertCustomer(Customer customer);
    List<Customer> getAllCustomers();
    boolean deleteCustomer(String accountNumber);
    boolean updateCustomer(Customer customer);
    Customer getCustomerByAccountNumber(String accountNumber);
} 
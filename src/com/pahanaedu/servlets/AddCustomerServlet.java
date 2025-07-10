package com.pahanaedu.servlets;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.dao.CustomerDAOImpl;
import com.pahanaedu.model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AddCustomerServlet")
public class AddCustomerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accountNumber = request.getParameter("account_number");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");

        Customer customer = new Customer();
        customer.setAccountNumber(accountNumber);
        customer.setName(name);
        customer.setAddress(address);
        customer.setTelephone(telephone);

        CustomerDAO customerDAO = new CustomerDAOImpl();
        boolean success = customerDAO.insertCustomer(customer);

        if (success) {
            request.setAttribute("success", "Customer added successfully!");
            request.getRequestDispatcher("/customer/add.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Failed to add customer. Please try again.");
            request.getRequestDispatcher("/customer/add.jsp").forward(request, response);
        }
    }
} 
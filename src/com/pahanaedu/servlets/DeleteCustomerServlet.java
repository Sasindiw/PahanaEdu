package com.pahanaedu.servlets;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.dao.CustomerDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/customer/delete")
public class DeleteCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");
        CustomerDAO customerDAO = new CustomerDAOImpl();
        customerDAO.deleteCustomer(accountNumber);
        response.sendRedirect(request.getContextPath() + "/customer/list");
    }
} 
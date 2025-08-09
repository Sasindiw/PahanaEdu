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
        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            request.getSession().setAttribute("error", "Missing account number for deletion.");
            response.sendRedirect(request.getContextPath() + "/customer/list");
            return;
        }
        CustomerDAO customerDAO = new CustomerDAOImpl();
        boolean deleted = customerDAO.deleteCustomer(accountNumber);
        if (!deleted) {
            request.getSession().setAttribute("error", "Cannot delete customer. It may be linked to existing bills.");
        } else {
            request.getSession().setAttribute("success", "Customer deleted successfully.");
        }
        response.sendRedirect(request.getContextPath() + "/customer/list");
    }
} 
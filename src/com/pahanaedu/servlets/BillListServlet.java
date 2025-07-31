package com.pahanaedu.servlets;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.dao.BillDAOImpl;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/billing/list")
public class BillListServlet extends HttpServlet {
    private BillDAO billDAO = new BillDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        try {
            // Get all bills
            List<Bill> bills = billDAO.getAllBills();
            request.setAttribute("bills", bills);
            
            // Forward to bill list page
            request.getRequestDispatcher("/billing/list.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading bills: " + e.getMessage());
            request.getRequestDispatcher("/billing/list.jsp").forward(request, response);
        }
    }
} 
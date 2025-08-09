package com.pahanaedu.servlets;

import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.dao.ItemDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/item/delete")
public class DeleteItemServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String itemCode = request.getParameter("item_code");
        if (itemCode == null || itemCode.trim().isEmpty()) {
            request.getSession().setAttribute("error", "Missing item code for deletion.");
            response.sendRedirect(request.getContextPath() + "/item/list");
            return;
        }
        ItemDAO itemDAO = new ItemDAOImpl();
        boolean deleted = itemDAO.deleteItem(itemCode);
        if (!deleted) {
            request.getSession().setAttribute("error", "Cannot delete item. It may be referenced by bills.");
        } else {
            request.getSession().setAttribute("success", "Item deleted successfully.");
        }
        response.sendRedirect(request.getContextPath() + "/item/list");
    }
} 
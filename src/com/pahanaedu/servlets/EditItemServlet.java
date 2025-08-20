package com.pahanaedu.servlets;

import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.dao.ItemDAOImpl;
import com.pahanaedu.model.Item;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/item/edit")
public class EditItemServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String itemCode = request.getParameter("item_code");
        ItemDAO itemDAO = new ItemDAOImpl();
        List<Item> items = itemDAO.getAllItems();
        Item item = null;
        for (Item i : items) {
            if (i.getItemCode().equals(itemCode)) {
                item = i;
                break;
            }
        }
        if (item != null) {
            request.setAttribute("item_code", item.getItemCode());
            request.setAttribute("name", item.getName());
            request.setAttribute("description", item.getDescription());
            request.setAttribute("price", item.getPrice());
            request.setAttribute("stock", item.getStock());
            request.setAttribute("category", item.getCategory());
        }
        request.getRequestDispatcher("/item/edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String itemCode = request.getParameter("item_code");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String category = request.getParameter("category");

        double price = 0;
        int stock = 0;
        try {
            price = Double.parseDouble(priceStr);
            stock = Integer.parseInt(stockStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid price or stock value.");
            request.getRequestDispatcher("/item/edit.jsp").forward(request, response);
            return;
        }

        Item item = new Item();
        item.setItemCode(itemCode);
        item.setName(name);
        item.setDescription(description);
        item.setPrice(price);
        item.setStock(stock);
        item.setCategory(category);

        ItemDAO itemDAO = new ItemDAOImpl();
        boolean success = itemDAO.updateItem(item);

        if (success) {
            // Set success message in session
            request.getSession().setAttribute("success", "Item updated successfully!");
            response.sendRedirect(request.getContextPath() + "/item/list");
        } else {
            request.setAttribute("error", "Failed to update item. Please try again.");
            request.getRequestDispatcher("/item/edit.jsp").forward(request, response);
        }
    }
} 
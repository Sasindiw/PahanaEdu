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

@WebServlet("/item/list")
public class ItemListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ItemDAO itemDAO = new ItemDAOImpl();
        List<Item> items = itemDAO.getAllItems();
        request.setAttribute("items", items);
        request.getRequestDispatcher("/item/list.jsp").forward(request, response);
    }
} 
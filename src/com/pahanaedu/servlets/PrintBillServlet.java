package com.pahanaedu.servlets;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.dao.BillItemDAO;
import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Item;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/billing/print")
public class PrintBillServlet extends HttpServlet {
    private BillDAO billDAO;
    private BillItemDAO billItemDAO;
    private CustomerDAO customerDAO;
    private ItemDAO itemDAO;

    @Override
    public void init() throws ServletException {
        billDAO = new com.pahanaedu.dao.BillDAOImpl();
        billItemDAO = new com.pahanaedu.dao.BillItemDAOImpl();
        customerDAO = new com.pahanaedu.dao.CustomerDAOImpl();
        itemDAO = new com.pahanaedu.dao.ItemDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String billIdParam = request.getParameter("billId");
        if (billIdParam == null || billIdParam.trim().isEmpty()) {
            request.setAttribute("error", "Bill ID is required");
            response.sendRedirect(request.getContextPath() + "/billing/create");
            return;
        }

        try {
            int billId = Integer.parseInt(billIdParam);
            
            // Get bill details
            Bill bill = billDAO.getBillById(billId);
            if (bill == null) {
                request.setAttribute("error", "Bill not found");
                response.sendRedirect(request.getContextPath() + "/billing/create");
                return;
            }

            // Get customer details
            Customer customer = customerDAO.getCustomerByAccountNumber(bill.getCustomerAccountNumber());
            
            // Get bill items
            List<BillItem> billItems = billItemDAO.getBillItemsByBillId(billId);
            
            // Get item details for each bill item
            for (BillItem billItem : billItems) {
                Item item = itemDAO.getItemByCode(billItem.getItemCode());
                if (item != null) {
                    // You can add item details to the bill item if needed
                    // For now, we'll just use the existing data
                }
            }
            
            // Move any success message from session to request for one-time display
            Object successMessage = session.getAttribute("success");
            if (successMessage != null) {
                request.setAttribute("success", successMessage);
                session.removeAttribute("success");
            }

            request.setAttribute("bill", bill);
            request.setAttribute("customer", customer);
            request.setAttribute("billItems", billItems);
            
            request.getRequestDispatcher("/billing/print.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid bill ID");
            response.sendRedirect(request.getContextPath() + "/billing/create");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading bill: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/billing/create");
        }
    }
}

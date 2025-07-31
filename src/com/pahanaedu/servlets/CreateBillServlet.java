package com.pahanaedu.servlets;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.dao.BillDAOImpl;
import com.pahanaedu.dao.BillItemDAO;
import com.pahanaedu.dao.BillItemDAOImpl;
import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.dao.CustomerDAOImpl;
import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.dao.ItemDAOImpl;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Item;
import com.pahanaedu.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/billing/create")
public class CreateBillServlet extends HttpServlet {
    private BillDAO billDAO = new BillDAOImpl();
    private BillItemDAO billItemDAO = new BillItemDAOImpl();
    private ItemDAO itemDAO = new ItemDAOImpl();
    private CustomerDAO customerDAO = new CustomerDAOImpl();

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
            // Generate new bill number
            String billNumber = billDAO.generateBillNumber();
            request.setAttribute("billNumber", billNumber);
            
            // Load customers for dropdown
            List<Customer> customers = customerDAO.getAllCustomers();
            request.setAttribute("customers", customers);
            
            // Load items for dropdown
            List<Item> items = itemDAO.getAllItems();
            request.setAttribute("items", items);
            
            // Forward to create bill page
            request.getRequestDispatcher("/billing/create.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading data: " + e.getMessage());
            request.getRequestDispatcher("/billing/create.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // Check if user is logged in
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        try {
            // Get form parameters
            String customerAccountNumber = request.getParameter("customer_account_number");
            String[] itemCodes = request.getParameterValues("item_code");
            String[] quantities = request.getParameterValues("quantity");
            
            if (customerAccountNumber == null || itemCodes == null || quantities == null) {
                request.setAttribute("error", "Please fill all required fields");
                // Reload data for form
                doGet(request, response);
                return;
            }
            
            // Create bill
            Bill bill = new Bill();
            bill.setBillNumber(billDAO.generateBillNumber());
            bill.setCustomerAccountNumber(customerAccountNumber);
            bill.setStatus("pending");
            bill.setCreatedBy(user.getUsername());
            
            // Calculate total and add items
            double totalAmount = 0;
            List<BillItem> billItems = new ArrayList<>();
            
            for (int i = 0; i < itemCodes.length; i++) {
                if (itemCodes[i] != null && !itemCodes[i].trim().isEmpty()) {
                    String itemCode = itemCodes[i].trim();
                    int quantity = Integer.parseInt(quantities[i]);
                    
                    // Get item details
                    Item item = itemDAO.getItemByCode(itemCode);
                    if (item != null && item.getStock() >= quantity) {
                        BillItem billItem = new BillItem(itemCode, quantity, item.getPrice());
                        billItems.add(billItem);
                        totalAmount += billItem.getTotalPrice();
                    }
                }
            }
            
            bill.setTotalAmount(totalAmount);
            
            // Save bill to database
            if (billDAO.createBill(bill)) {
                // Save bill items
                for (BillItem billItem : billItems) {
                    billItem.setBillId(bill.getBillId());
                    billItemDAO.addBillItem(billItem);
                }
                
                // Redirect to bill view
                response.sendRedirect(request.getContextPath() + "/billing/view?billId=" + bill.getBillId());
            } else {
                request.setAttribute("error", "Failed to create bill. Please try again.");
                // Reload data for form
                doGet(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while creating the bill: " + e.getMessage());
            // Reload data for form
            doGet(request, response);
        }
    }
} 
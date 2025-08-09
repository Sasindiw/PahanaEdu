package com.pahanaedu.servlets;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.dao.BillItemDAO;
import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.dao.ItemDAO;
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
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@WebServlet("/billing/create")
public class CreateBillServlet extends HttpServlet {
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

        try {
            // Get customers and items for the form
            List<Customer> customers = customerDAO.getAllCustomers();
            List<Item> items = itemDAO.getAllItems();
            
            request.setAttribute("customers", customers);
            request.setAttribute("items", items);
            
            request.getRequestDispatcher("/billing/create.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading bill creation page: " + e.getMessage());
            request.getRequestDispatcher("/billing/create.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        
        // Get form parameters
        String customerAccountNumber = request.getParameter("customerAccountNumber");
        String[] itemCodes = request.getParameterValues("itemCode");
        String[] quantities = request.getParameterValues("quantity");
        String[] unitPrices = request.getParameterValues("unitPrice");
        String[] totalPrices = request.getParameterValues("totalPrice");
        
        try {
            // Validate input
            if (customerAccountNumber == null || customerAccountNumber.trim().isEmpty()) {
                throw new IllegalArgumentException("Customer is required");
            }
            
            if (itemCodes == null || itemCodes.length == 0) {
                throw new IllegalArgumentException("At least one item is required");
            }
            
            // Calculate total amount
            BigDecimal totalAmount = BigDecimal.ZERO;
            for (int i = 0; i < itemCodes.length; i++) {
                if (itemCodes[i] != null && !itemCodes[i].trim().isEmpty() &&
                    quantities[i] != null && !quantities[i].trim().isEmpty() &&
                    totalPrices[i] != null && !totalPrices[i].trim().isEmpty()) {
                    
                    BigDecimal itemTotal = new BigDecimal(totalPrices[i]);
                    totalAmount = totalAmount.add(itemTotal);
                }
            }
            
            // Create bill
            Bill bill = new Bill();
            bill.setBillNumber(billDAO.generateBillNumber());
            bill.setCustomerAccountNumber(customerAccountNumber);
            bill.setBillDate(new Date());
            bill.setBillDate(new Date());
            bill.setTotalAmount(totalAmount);
            bill.setStatus("pending");
            bill.setCreatedBy(user.getUsername());
            bill.setCreatedDate(new Date());
            
            // Save bill to database
            int billId = billDAO.createBill(bill);
            
            if (billId > 0) {
                // Create bill items
                for (int i = 0; i < itemCodes.length; i++) {
                    if (itemCodes[i] != null && !itemCodes[i].trim().isEmpty() &&
                        quantities[i] != null && !quantities[i].trim().isEmpty() &&
                        unitPrices[i] != null && !unitPrices[i].trim().isEmpty() &&
                        totalPrices[i] != null && !totalPrices[i].trim().isEmpty()) {
                        
                        BillItem billItem = new BillItem();
                        billItem.setBillId(billId);
                        billItem.setItemCode(itemCodes[i]);
                        billItem.setQuantity(Integer.parseInt(quantities[i]));
                        billItem.setUnitPrice(new BigDecimal(unitPrices[i]));
                        billItem.setTotalPrice(new BigDecimal(totalPrices[i]));
                        
                        billItemDAO.createBillItem(billItem);
                    }
                }
                
                // Set success message and redirect to print page
                session.setAttribute("success", "Bill created successfully! Bill Number: " + bill.getBillNumber());
                response.sendRedirect(request.getContextPath() + "/billing/print?billId=" + billId);
                
            } else {
                throw new Exception("Failed to create bill");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error creating bill: " + e.getMessage());
            
            // Reload form data
            try {
                List<Customer> customers = customerDAO.getAllCustomers();
                List<Item> items = itemDAO.getAllItems();
                
                request.setAttribute("customers", customers);
                request.setAttribute("items", items);
                
                // Preserve form data
                request.setAttribute("customerAccountNumber", customerAccountNumber);
                request.setAttribute("itemCodes", itemCodes);
                request.setAttribute("quantities", quantities);
                request.setAttribute("unitPrices", unitPrices);
                request.setAttribute("totalPrices", totalPrices);
                
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            request.getRequestDispatcher("/billing/create.jsp").forward(request, response);
        }
    }
}

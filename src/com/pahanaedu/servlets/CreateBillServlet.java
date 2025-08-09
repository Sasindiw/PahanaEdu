package com.pahanaedu.servlets;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.dao.BillItemDAO;
import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.dao.BillDAOImpl;
import com.pahanaedu.dao.BillItemDAOImpl;
import com.pahanaedu.dao.CustomerDAOImpl;
import com.pahanaedu.dao.ItemDAOImpl;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;
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

@WebServlet("/billing/create")
public class CreateBillServlet extends HttpServlet {
    private BillDAO billDAO;
    private BillItemDAO billItemDAO;
    private CustomerDAO customerDAO;
    private ItemDAO itemDAO;

    @Override
    public void init() throws ServletException {
        billDAO = new BillDAOImpl();
        billItemDAO = new BillItemDAOImpl();
        customerDAO = new CustomerDAOImpl();
        itemDAO = new ItemDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        try {
            request.setAttribute("customers", customerDAO.getAllCustomers());
            request.setAttribute("items", itemDAO.getAllItems());
            request.getRequestDispatcher("/billing/create.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading bill page: " + e.getMessage());
            request.getRequestDispatcher("/billing/create.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        String customerAccountNumber = request.getParameter("customerAccountNumber");
        String[] itemCodes = request.getParameterValues("itemCode");
        String[] quantities = request.getParameterValues("quantity");
        String[] unitPrices = request.getParameterValues("unitPrice");
        String[] totalPrices = request.getParameterValues("totalPrice");

        try {
            if (customerAccountNumber == null || customerAccountNumber.trim().isEmpty()) {
                throw new IllegalArgumentException("Customer is required");
            }
            if (itemCodes == null || itemCodes.length == 0) {
                throw new IllegalArgumentException("At least one item is required");
            }

            BigDecimal totalAmount = BigDecimal.ZERO;
            for (int i = 0; i < itemCodes.length; i++) {
                if (isFilled(itemCodes[i]) && isFilled(quantities[i]) && isFilled(totalPrices[i])) {
                    totalAmount = totalAmount.add(new BigDecimal(totalPrices[i]));
                }
            }

            Bill bill = new Bill();
            bill.setBillNumber(billDAO.generateBillNumber());
            bill.setCustomerAccountNumber(customerAccountNumber);
            bill.setBillDate(new Date());
            bill.setTotalAmount(totalAmount);
            bill.setStatus("pending");
            bill.setCreatedBy(user.getUsername());
            bill.setCreatedDate(new Date());

            int billId = billDAO.createBill(bill);
            if (billId <= 0) throw new Exception("Failed to create bill");

            for (int i = 0; i < itemCodes.length; i++) {
                if (isFilled(itemCodes[i]) && isFilled(quantities[i]) && isFilled(unitPrices[i]) && isFilled(totalPrices[i])) {
                    BillItem bi = new BillItem();
                    bi.setBillId(billId);
                    bi.setItemCode(itemCodes[i]);
                    bi.setQuantity(Integer.parseInt(quantities[i]));
                    bi.setUnitPrice(new BigDecimal(unitPrices[i]));
                    bi.setTotalPrice(new BigDecimal(totalPrices[i]));
                    billItemDAO.createBillItem(bi);
                    // TODO: decrement stock here if needed using itemDAO.updateItem(...)
                }
            }

            session.setAttribute("success", "Bill created successfully! Bill Number: " + bill.getBillNumber());
            response.sendRedirect(request.getContextPath() + "/billing/print?billId=" + billId);
        } catch (Exception e) {
            request.setAttribute("error", "Error creating bill: " + e.getMessage());
            try {
                request.setAttribute("customers", customerDAO.getAllCustomers());
                request.setAttribute("items", itemDAO.getAllItems());
            } catch (Exception ignore) { }
            request.setAttribute("customerAccountNumber", customerAccountNumber);
            request.setAttribute("itemCodes", itemCodes);
            request.setAttribute("quantities", quantities);
            request.setAttribute("unitPrices", unitPrices);
            request.setAttribute("totalPrices", totalPrices);
            request.getRequestDispatcher("/billing/create.jsp").forward(request, response);
        }
    }

    private boolean isFilled(String s) { return s != null && !s.trim().isEmpty(); }
}



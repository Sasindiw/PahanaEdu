package com.pahanaedu.dao;

import com.pahanaedu.model.Bill;
import java.util.List;

public interface BillDAO {
    
    /**
     * Create a new bill
     * @param bill The bill to create
     * @return The generated bill ID
     */
    int createBill(Bill bill);
    
    /**
     * Get a bill by its ID
     * @param billId The bill ID
     * @return The bill or null if not found
     */
    Bill getBillById(int billId);
    
    /**
     * Get a bill by its bill number
     * @param billNumber The bill number
     * @return The bill or null if not found
     */
    Bill getBillByNumber(String billNumber);
    
    /**
     * Get all bills
     * @return List of all bills
     */
    List<Bill> getAllBills();
    
    /**
     * Get bills by customer account number
     * @param customerAccountNumber The customer account number
     * @return List of bills for the customer
     */
    List<Bill> getBillsByCustomer(String customerAccountNumber);
    
    /**
     * Update a bill
     * @param bill The bill to update
     * @return true if successful, false otherwise
     */
    boolean updateBill(Bill bill);
    
    /**
     * Delete a bill
     * @param billId The bill ID to delete
     * @return true if successful, false otherwise
     */
    boolean deleteBill(int billId);
    
    /**
     * Generate a unique bill number
     * @return A unique bill number
     */
    String generateBillNumber();
}

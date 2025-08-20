package com.pahanaedu.dao;

import com.pahanaedu.model.BillItem;
import java.util.List;

public interface BillItemDAO {
    
    /**
     * Create a new bill item
     * @param billItem The bill item to create
     * @return The generated bill item ID
     */
    int createBillItem(BillItem billItem);
    
    /**
     * Get a bill item by its ID
     * @param billItemId The bill item ID
     * @return The bill item or null if not found
     */
    BillItem getBillItemById(int billItemId);
    
    /**
     * Get all bill items for a specific bill
     * @param billId The bill ID
     * @return List of bill items for the bill
     */
    List<BillItem> getBillItemsByBillId(int billId);
    
    /**
     * Get all bill items
     * @return List of all bill items
     */
    List<BillItem> getAllBillItems();
    
    /**
     * Update a bill item
     * @param billItem The bill item to update
     * @return true if successful, false otherwise
     */
    boolean updateBillItem(BillItem billItem);
    
    /**
     * Delete a bill item
     * @param billItemId The bill item ID to delete
     * @return true if successful, false otherwise
     */
    boolean deleteBillItem(int billItemId);
    
    /**
     * Delete all bill items for a specific bill
     * @param billId The bill ID
     * @return true if successful, false otherwise
     */
    boolean deleteBillItemsByBillId(int billId);
}

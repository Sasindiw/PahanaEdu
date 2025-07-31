package com.pahanaedu.dao;

import com.pahanaedu.model.Bill;
import java.util.List;

public interface BillDAO {
    boolean createBill(Bill bill);
    Bill getBillById(int billId);
    Bill getBillByNumber(String billNumber);
    List<Bill> getAllBills();
    List<Bill> getBillsByCustomer(String customerAccountNumber);
    boolean updateBill(Bill bill);
    boolean deleteBill(int billId);
    String generateBillNumber();
} 
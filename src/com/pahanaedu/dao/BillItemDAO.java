package com.pahanaedu.dao;

import com.pahanaedu.model.BillItem;
import java.util.List;

public interface BillItemDAO {
    boolean addBillItem(BillItem billItem);
    List<BillItem> getBillItemsByBillId(int billId);
    boolean updateBillItem(BillItem billItem);
    boolean deleteBillItem(int billItemId);
    boolean deleteBillItemsByBillId(int billId);
} 
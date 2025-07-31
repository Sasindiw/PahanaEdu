package com.pahanaedu.model;

import java.util.Date;
import java.util.List;

public class Bill {
    private int billId;
    private String billNumber;
    private String customerAccountNumber;
    private Date billDate;
    private double totalAmount;
    private String status;
    private String createdBy;
    private Date createdDate;
    private List<BillItem> billItems;
    
    // Additional fields for display
    private String customerName;
    private String customerAddress;

    // Constructors
    public Bill() {}

    public Bill(String billNumber, String customerAccountNumber, double totalAmount) {
        this.billNumber = billNumber;
        this.customerAccountNumber = customerAccountNumber;
        this.totalAmount = totalAmount;
        this.billDate = new Date();
        this.status = "pending";
    }

    // Getters and Setters
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }

    public String getBillNumber() { return billNumber; }
    public void setBillNumber(String billNumber) { this.billNumber = billNumber; }

    public String getCustomerAccountNumber() { return customerAccountNumber; }
    public void setCustomerAccountNumber(String customerAccountNumber) { this.customerAccountNumber = customerAccountNumber; }

    public Date getBillDate() { return billDate; }
    public void setBillDate(Date billDate) { this.billDate = billDate; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getCreatedBy() { return createdBy; }
    public void setCreatedBy(String createdBy) { this.createdBy = createdBy; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }

    public List<BillItem> getBillItems() { return billItems; }
    public void setBillItems(List<BillItem> billItems) { this.billItems = billItems; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerAddress() { return customerAddress; }
    public void setCustomerAddress(String customerAddress) { this.customerAddress = customerAddress; }

    // Helper methods
    public void addBillItem(BillItem item) {
        if (billItems != null) {
            billItems.add(item);
            calculateTotal();
        }
    }

    public void calculateTotal() {
        if (billItems != null) {
            totalAmount = billItems.stream()
                    .mapToDouble(BillItem::getTotalPrice)
                    .sum();
        }
    }
} 
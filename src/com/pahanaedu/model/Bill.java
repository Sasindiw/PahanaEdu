package com.pahanaedu.model;

import java.math.BigDecimal;
import java.util.Date;

public class Bill {
    private int billId;
    private String billNumber;
    private String customerAccountNumber;
    private Date billDate;
    private BigDecimal totalAmount;
    private String status;
    private String createdBy;
    private Date createdDate;

    // Default constructor
    public Bill() {
    }

    // Constructor with all fields
    public Bill(int billId, String billNumber, String customerAccountNumber, Date billDate, 
                BigDecimal totalAmount, String status, String createdBy, Date createdDate) {
        this.billId = billId;
        this.billNumber = billNumber;
        this.customerAccountNumber = customerAccountNumber;
        this.billDate = billDate;
        this.totalAmount = totalAmount;
        this.status = status;
        this.createdBy = createdBy;
        this.createdDate = createdDate;
    }

    // Getters and Setters
    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public String getBillNumber() {
        return billNumber;
    }

    public void setBillNumber(String billNumber) {
        this.billNumber = billNumber;
    }

    public String getCustomerAccountNumber() {
        return customerAccountNumber;
    }

    public void setCustomerAccountNumber(String customerAccountNumber) {
        this.customerAccountNumber = customerAccountNumber;
    }

    public Date getBillDate() {
        return billDate;
    }

    public void setBillDate(Date billDate) {
        this.billDate = billDate;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Override
    public String toString() {
        return "Bill{" +
                "billId=" + billId +
                ", billNumber='" + billNumber + '\'' +
                ", customerAccountNumber='" + customerAccountNumber + '\'' +
                ", billDate=" + billDate +
                ", totalAmount=" + totalAmount +
                ", status='" + status + '\'' +
                ", createdBy='" + createdBy + '\'' +
                ", createdDate=" + createdDate +
                '}';
    }
}

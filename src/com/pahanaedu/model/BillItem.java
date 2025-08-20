package com.pahanaedu.model;

import java.math.BigDecimal;

public class BillItem {
    private int billItemId;
    private int billId;
    private String itemCode;
    private int quantity;
    private BigDecimal unitPrice;
    private BigDecimal totalPrice;

    // Default constructor
    public BillItem() {
    }

    // Constructor with all fields
    public BillItem(int billItemId, int billId, String itemCode, int quantity, 
                   BigDecimal unitPrice, BigDecimal totalPrice) {
        this.billItemId = billItemId;
        this.billId = billId;
        this.itemCode = itemCode;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.totalPrice = totalPrice;
    }

    // Getters and Setters
    public int getBillItemId() {
        return billItemId;
    }

    public void setBillItemId(int billItemId) {
        this.billItemId = billItemId;
    }

    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return "BillItem{" +
                "billItemId=" + billItemId +
                ", billId=" + billId +
                ", itemCode='" + itemCode + '\'' +
                ", quantity=" + quantity +
                ", unitPrice=" + unitPrice +
                ", totalPrice=" + totalPrice +
                '}';
    }
}

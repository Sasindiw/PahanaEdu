package com.pahanaedu.dao;

import com.pahanaedu.model.Bill;
import com.pahanaedu.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAOImpl implements BillDAO {

    @Override
    public int createBill(Bill bill) {
        String sql = "INSERT INTO bills (bill_number, customer_account_number, bill_date, total_amount, status, created_by, created_date) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, bill.getBillNumber());
            pstmt.setString(2, bill.getCustomerAccountNumber());
            pstmt.setDate(3, new java.sql.Date(bill.getBillDate().getTime()));
            pstmt.setBigDecimal(4, bill.getTotalAmount());
            pstmt.setString(5, bill.getStatus());
            pstmt.setString(6, bill.getCreatedBy());
            pstmt.setTimestamp(7, new Timestamp(bill.getCreatedDate().getTime()));
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public Bill getBillById(int billId) {
        String sql = "SELECT * FROM bills WHERE bill_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, billId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToBill(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Bill getBillByNumber(String billNumber) {
        String sql = "SELECT * FROM bills WHERE bill_number = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, billNumber);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToBill(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Bill> getAllBills() {
        String sql = "SELECT * FROM bills ORDER BY created_date DESC";
        List<Bill> bills = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                bills.add(mapResultSetToBill(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }

    @Override
    public List<Bill> getBillsByCustomer(String customerAccountNumber) {
        String sql = "SELECT * FROM bills WHERE customer_account_number = ? ORDER BY created_date DESC";
        List<Bill> bills = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, customerAccountNumber);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                bills.add(mapResultSetToBill(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }

    @Override
    public boolean updateBill(Bill bill) {
        String sql = "UPDATE bills SET bill_number = ?, customer_account_number = ?, bill_date = ?, " +
                    "total_amount = ?, status = ?, created_by = ?, created_date = ? WHERE bill_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, bill.getBillNumber());
            pstmt.setString(2, bill.getCustomerAccountNumber());
            pstmt.setDate(3, new java.sql.Date(bill.getBillDate().getTime()));
            pstmt.setBigDecimal(4, bill.getTotalAmount());
            pstmt.setString(5, bill.getStatus());
            pstmt.setString(6, bill.getCreatedBy());
            pstmt.setTimestamp(7, new Timestamp(bill.getCreatedDate().getTime()));
            pstmt.setInt(8, bill.getBillId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteBill(int billId) {
        String sql = "DELETE FROM bills WHERE bill_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, billId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public String generateBillNumber() {
        String sql = "SELECT COUNT(*) FROM bills WHERE bill_date = CURRENT_DATE";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            if (rs.next()) {
                int count = rs.getInt(1);
                String dateStr = new java.sql.Date(System.currentTimeMillis()).toString().replace("-", "");
                return "BILL" + dateStr + String.format("%04d", count + 1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // Fallback if query fails
        String dateStr = new java.sql.Date(System.currentTimeMillis()).toString().replace("-", "");
        return "BILL" + dateStr + "0001";
    }

    private Bill mapResultSetToBill(ResultSet rs) throws SQLException {
        Bill bill = new Bill();
        bill.setBillId(rs.getInt("bill_id"));
        bill.setBillNumber(rs.getString("bill_number"));
        bill.setCustomerAccountNumber(rs.getString("customer_account_number"));
        bill.setBillDate(rs.getDate("bill_date"));
        bill.setTotalAmount(rs.getBigDecimal("total_amount"));
        bill.setStatus(rs.getString("status"));
        bill.setCreatedBy(rs.getString("created_by"));
        bill.setCreatedDate(rs.getTimestamp("created_date"));
        return bill;
    }
}

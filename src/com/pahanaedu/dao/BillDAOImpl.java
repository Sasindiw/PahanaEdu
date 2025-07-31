package com.pahanaedu.dao;

import com.pahanaedu.model.Bill;
import com.pahanaedu.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAOImpl implements BillDAO {
    
    @Override
    public boolean createBill(Bill bill) {
        String sql = "INSERT INTO bills (bill_number, customer_account_number, total_amount, status, created_by) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, bill.getBillNumber());
            stmt.setString(2, bill.getCustomerAccountNumber());
            stmt.setDouble(3, bill.getTotalAmount());
            stmt.setString(4, bill.getStatus());
            stmt.setString(5, bill.getCreatedBy());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    bill.setBillId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public Bill getBillById(int billId) {
        String sql = "SELECT b.*, c.name as customer_name, c.address as customer_address " +
                    "FROM bills b " +
                    "LEFT JOIN customers c ON b.customer_account_number = c.account_number " +
                    "WHERE b.bill_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();
            
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
        String sql = "SELECT b.*, c.name as customer_name, c.address as customer_address " +
                    "FROM bills b " +
                    "LEFT JOIN customers c ON b.customer_account_number = c.account_number " +
                    "WHERE b.bill_number = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, billNumber);
            ResultSet rs = stmt.executeQuery();
            
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
        String sql = "SELECT b.*, c.name as customer_name, c.address as customer_address " +
                    "FROM bills b " +
                    "LEFT JOIN customers c ON b.customer_account_number = c.account_number " +
                    "ORDER BY b.bill_date DESC";
        
        List<Bill> bills = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
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
        String sql = "SELECT b.*, c.name as customer_name, c.address as customer_address " +
                    "FROM bills b " +
                    "LEFT JOIN customers c ON b.customer_account_number = c.account_number " +
                    "WHERE b.customer_account_number = ? " +
                    "ORDER BY b.bill_date DESC";
        
        List<Bill> bills = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, customerAccountNumber);
            ResultSet rs = stmt.executeQuery();
            
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
        String sql = "UPDATE bills SET total_amount = ?, status = ? WHERE bill_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setDouble(1, bill.getTotalAmount());
            stmt.setString(2, bill.getStatus());
            stmt.setInt(3, bill.getBillId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean deleteBill(int billId) {
        String sql = "DELETE FROM bills WHERE bill_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public String generateBillNumber() {
        String sql = "SELECT nextval('bill_number_seq')";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                int nextVal = rs.getInt(1);
                return String.format("BILL-%04d", nextVal);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "BILL-" + System.currentTimeMillis();
    }
    
    private Bill mapResultSetToBill(ResultSet rs) throws SQLException {
        Bill bill = new Bill();
        bill.setBillId(rs.getInt("bill_id"));
        bill.setBillNumber(rs.getString("bill_number"));
        bill.setCustomerAccountNumber(rs.getString("customer_account_number"));
        bill.setBillDate(rs.getDate("bill_date"));
        bill.setTotalAmount(rs.getDouble("total_amount"));
        bill.setStatus(rs.getString("status"));
        bill.setCreatedBy(rs.getString("created_by"));
        bill.setCreatedDate(rs.getTimestamp("created_date"));
        bill.setCustomerName(rs.getString("customer_name"));
        bill.setCustomerAddress(rs.getString("customer_address"));
        return bill;
    }
} 
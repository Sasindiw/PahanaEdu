package com.pahanaedu.dao;

import com.pahanaedu.model.BillItem;
import com.pahanaedu.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillItemDAOImpl implements BillItemDAO {
    
    @Override
    public boolean addBillItem(BillItem billItem) {
        String sql = "INSERT INTO bill_items (bill_id, item_code, quantity, unit_price, total_price) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, billItem.getBillId());
            stmt.setString(2, billItem.getItemCode());
            stmt.setInt(3, billItem.getQuantity());
            stmt.setDouble(4, billItem.getUnitPrice());
            stmt.setDouble(5, billItem.getTotalPrice());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    billItem.setBillItemId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public List<BillItem> getBillItemsByBillId(int billId) {
        String sql = "SELECT bi.*, i.name as item_name, i.description as item_description " +
                    "FROM bill_items bi " +
                    "LEFT JOIN items i ON bi.item_code = i.item_code " +
                    "WHERE bi.bill_id = ?";
        
        List<BillItem> billItems = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                billItems.add(mapResultSetToBillItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return billItems;
    }
    
    @Override
    public boolean updateBillItem(BillItem billItem) {
        String sql = "UPDATE bill_items SET quantity = ?, unit_price = ?, total_price = ? WHERE bill_item_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billItem.getQuantity());
            stmt.setDouble(2, billItem.getUnitPrice());
            stmt.setDouble(3, billItem.getTotalPrice());
            stmt.setInt(4, billItem.getBillItemId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean deleteBillItem(int billItemId) {
        String sql = "DELETE FROM bill_items WHERE bill_item_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billItemId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean deleteBillItemsByBillId(int billId) {
        String sql = "DELETE FROM bill_items WHERE bill_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private BillItem mapResultSetToBillItem(ResultSet rs) throws SQLException {
        BillItem billItem = new BillItem();
        billItem.setBillItemId(rs.getInt("bill_item_id"));
        billItem.setBillId(rs.getInt("bill_id"));
        billItem.setItemCode(rs.getString("item_code"));
        billItem.setQuantity(rs.getInt("quantity"));
        billItem.setUnitPrice(rs.getDouble("unit_price"));
        billItem.setTotalPrice(rs.getDouble("total_price"));
        billItem.setItemName(rs.getString("item_name"));
        billItem.setItemDescription(rs.getString("item_description"));
        return billItem;
    }
} 
package com.pahanaedu.dao;

import com.pahanaedu.model.BillItem;
import com.pahanaedu.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillItemDAOImpl implements BillItemDAO {

    @Override
    public int createBillItem(BillItem billItem) {
        String sql = "INSERT INTO bill_items (bill_id, item_code, quantity, unit_price, total_price) " +
                    "VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, billItem.getBillId());
            pstmt.setString(2, billItem.getItemCode());
            pstmt.setInt(3, billItem.getQuantity());
            pstmt.setBigDecimal(4, billItem.getUnitPrice());
            pstmt.setBigDecimal(5, billItem.getTotalPrice());
            
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
    public BillItem getBillItemById(int billItemId) {
        String sql = "SELECT * FROM bill_items WHERE bill_item_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, billItemId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToBillItem(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<BillItem> getBillItemsByBillId(int billId) {
        String sql = "SELECT * FROM bill_items WHERE bill_id = ? ORDER BY bill_item_id";
        List<BillItem> billItems = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, billId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                billItems.add(mapResultSetToBillItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return billItems;
    }

    @Override
    public List<BillItem> getAllBillItems() {
        String sql = "SELECT * FROM bill_items ORDER BY bill_id, bill_item_id";
        List<BillItem> billItems = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
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
        String sql = "UPDATE bill_items SET bill_id = ?, item_code = ?, quantity = ?, " +
                    "unit_price = ?, total_price = ? WHERE bill_item_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, billItem.getBillId());
            pstmt.setString(2, billItem.getItemCode());
            pstmt.setInt(3, billItem.getQuantity());
            pstmt.setBigDecimal(4, billItem.getUnitPrice());
            pstmt.setBigDecimal(5, billItem.getTotalPrice());
            pstmt.setInt(6, billItem.getBillItemId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteBillItem(int billItemId) {
        String sql = "DELETE FROM bill_items WHERE bill_item_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, billItemId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteBillItemsByBillId(int billId) {
        String sql = "DELETE FROM bill_items WHERE bill_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, billId);
            return pstmt.executeUpdate() > 0;
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
        billItem.setUnitPrice(rs.getBigDecimal("unit_price"));
        billItem.setTotalPrice(rs.getBigDecimal("total_price"));
        return billItem;
    }
}

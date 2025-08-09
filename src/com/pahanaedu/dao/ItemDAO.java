package com.pahanaedu.dao;

import com.pahanaedu.model.Item;
import java.util.List;

public interface ItemDAO {
    List<Item> getAllItems();
    Item getItemByCode(String itemCode);
    boolean insertItem(Item item);
    boolean deleteItem(String itemCode);
    boolean updateItem(Item item);
    /** Decrement stock by quantity (use negative value to increment). Returns true if updated. */
    boolean decrementStock(String itemCode, int quantity);
} 
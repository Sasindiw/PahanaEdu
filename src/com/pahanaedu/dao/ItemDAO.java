package com.pahanaedu.dao;

import com.pahanaedu.model.Item;
import java.util.List;

public interface ItemDAO {
    List<Item> getAllItems();
    boolean insertItem(Item item);
    boolean deleteItem(String itemCode);
    boolean updateItem(Item item);
} 
package dao;



import model.Item;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {
    private final Connection connection;

    public ItemDAO() throws SQLException {
        this.connection = DBConnection.getConnection();
    }

    // Create
    public void addItem(Item item) {
        try {
            String query = "INSERT INTO items (name, category, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, item.getName());
            ps.setString(2, item.getCategory());
            ps.setInt(3, item.getQuantity());
            ps.setDouble(4, item.getPrice());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Read (single item)
    public Item getItemById(int itemID) {
        Item item = new Item();
        try {
            String query = "SELECT * FROM items WHERE itemID=?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, itemID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                item.setItemID(rs.getInt("itemID"));
                item.setName(rs.getString("name"));
                item.setCategory(rs.getString("category"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return item;
    }

    // Read (all items)
//    public List<Item> getAllItems() {
//        List<Item> items = new ArrayList<>();
//        try {
//            Statement statement = connection.createStatement();
//            ResultSet rs = statement.executeQuery("SELECT * FROM items");
//
//            while (rs.next()) {
//                Item item = new Item();
//                item.setItemID(rs.getInt("itemID"));
//                item.setName(rs.getString("name"));
//                item.setCategory(rs.getString("category"));
//                item.setQuantity(rs.getInt("quantity"));
//                item.setPrice(rs.getDouble("price"));
//                items.add(item);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return items;
//    }
    public List<Item> getAllItems() {
        List<Item> items = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();  // Assuming you have a connection utility
             Statement statement = connection.createStatement();
             ResultSet rs = statement.executeQuery("SELECT * FROM items")) {

            while (rs.next()) {
                Item item = new Item();
                item.setItemID(rs.getInt("itemID"));
                item.setName(rs.getString("name"));
                item.setCategory(rs.getString("category"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Consider throwing a custom exception or handling it appropriately
        }
        return items;
    }


    // Update
    public void updateItem(Item item) {
        try {
            String query = "UPDATE items SET name=?, category=?, quantity=?, price=? WHERE itemID=?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, item.getName());
            ps.setString(2, item.getCategory());
            ps.setInt(3, item.getQuantity());
            ps.setDouble(4, item.getPrice());
            ps.setInt(5, item.getItemID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete
    public void deleteItem(int itemID) {
        try {
            String query = "DELETE FROM items WHERE itemID=?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, itemID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
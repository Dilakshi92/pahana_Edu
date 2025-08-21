package dao;


import model.Admin;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDAO {
    // Admin login
    public Admin authenticate(String adminName, String password) throws SQLException {
        String sql = "SELECT * FROM Admin WHERE admin_name = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, adminName);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Admin admin = new Admin();
                    admin.setAdminId(rs.getInt("adminid"));
                    admin.setAdminName(rs.getString("admin_name"));
                    admin.setPassword(rs.getString("password"));
                    return admin;
                }
            }
        }
        return null;
    }

    // Add more admin-related methods as needed
}

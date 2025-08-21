package dao;



import model.User;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    // Create a new user
    public boolean createUser(User user) throws SQLException {
        String sql = "INSERT INTO Users (user_name, role, password, adminid) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUserName());
            stmt.setString(2, user.getRole());
            stmt.setString(3, user.getPassword());
            stmt.setInt(4, user.getAdminId());

            return stmt.executeUpdate() > 0;
        }
    }

    // Get all users for a specific admin
    public List<User> getUsersByAdmin(int adminId) throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE adminid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, adminId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("userid"));
                    user.setUserName(rs.getString("user_name"));
                    user.setRole(rs.getString("role"));
                    user.setPassword(rs.getString("password"));
                    Timestamp timestamp = rs.getTimestamp("login_time");
                    if (timestamp != null) {
                        user.setLoginTime(timestamp.toLocalDateTime());
                    }
                    user.setAdminId(rs.getInt("adminid"));
                    users.add(user);
                }
            }
        }
        return users;
    }

    // Update user login time
    public boolean updateLoginTime(int userId) throws SQLException {
        String sql = "UPDATE Users SET login_time = ? WHERE userid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(2, userId);

            return stmt.executeUpdate() > 0;
        }
    }

    // User authentication
    public User authenticate(String userName, String password) throws SQLException {
        String sql = "SELECT * FROM Users WHERE user_name = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, userName);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("userid"));
                    user.setUserName(rs.getString("user_name"));
                    user.setRole(rs.getString("role"));
                    user.setPassword(rs.getString("password"));
                    Timestamp timestamp = rs.getTimestamp("login_time");
                    if (timestamp != null) {
                        user.setLoginTime(timestamp.toLocalDateTime());
                    }
                    user.setAdminId(rs.getInt("adminid"));
                    return user;
                }
            }
        }
        return null;
    }

    // Delete user
    public boolean deleteUser(int userId) throws SQLException {
        String sql = "DELETE FROM Users WHERE userid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        }
    }
}
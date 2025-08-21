package model;

import java.time.LocalDateTime;

public class User {
    private int userId;
    private String userName;
    private String role;
    private String password;
    private LocalDateTime loginTime;
    private int adminId;

    // Constructors
    public User() {}

    public User(String userName, String role, String password, int adminId) {
        this.userName = userName;
        this.role = role;
        this.password = password;
        this.adminId = adminId;
    }

    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public LocalDateTime getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(LocalDateTime loginTime) {
        this.loginTime = loginTime;
    }

    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }
}
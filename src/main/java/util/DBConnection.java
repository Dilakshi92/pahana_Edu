

        package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
        public class DBConnection {
            private static final String JDBC_URL = "jdbc:mysql://localhost:3306/shop";
            private static final String JDBC_USER = "root";
            private static final String JDBC_PASSWORD = "";

            static {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    System.out.println("MySQL JDBC Driver Registered Successfully!");
                } catch (ClassNotFoundException e) {
                    System.err.println("ERROR: Failed to load JDBC driver");
                    e.printStackTrace();
                    throw new RuntimeException("Failed to load JDBC driver", e);
                }
            }

            public static Connection getConnection() throws SQLException {
                System.out.println("Attempting to connect to database...");
                System.out.println("URL: " + JDBC_URL);
                System.out.println("User: " + JDBC_USER);

                Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                System.out.println("Connection successful!");
                System.out.println("Connection details: " + conn);

                return conn;
            }
        }
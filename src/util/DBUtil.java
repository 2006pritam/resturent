package com.resturent.util;



import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

    private static final String URL = resolveSetting(
        "DB_URL",
        "jdbc:mysql://localhost:3306/resturent?useSSL=false&serverTimezone=UTC");
    private static final String USER = resolveSetting("DB_USER", "root");
    private static final String PASSWORD = resolveSetting("DB_PASSWORD", "admin");

    public static Connection getConnection() throws Exception {

        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Create and return connection
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    private static String resolveSetting(String key, String defaultValue) {
        String value = System.getProperty(key);
        if (value == null || value.trim().isEmpty()) {
            value = System.getenv(key);
        }
        return value == null || value.trim().isEmpty() ? defaultValue : value.trim();
    }
}


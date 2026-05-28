package com.resturent.util;



import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

    private static final String URL =
        getSetting("DB_URL",
            "jdbc:mysql://localhost:3306/resturent?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC");
    private static final String USER = getSetting("DB_USER", "root");
    private static final String PASSWORD = getSetting("DB_PASSWORD", "admin");

    public static Connection getConnection() throws Exception {

        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Create and return connection
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    private static String getSetting(String key, String fallback) {
        String value = System.getProperty(key);
        if (value == null || value.trim().isEmpty()) {
            value = System.getenv(key);
        }
        return (value == null || value.trim().isEmpty()) ? fallback : value.trim();
    }
}


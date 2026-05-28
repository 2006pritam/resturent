package com.resturent.dao;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.resturent.model.User;
import com.resturent.util.DBUtil;

public class UserDAO {

    public static User findByEmail(String email) throws Exception {
        try (Connection con = DBUtil.getConnection()) {
            String idCol = firstExistingColumn(con, "users", "id", "user_id");
            String emailCol = firstExistingColumn(con, "users", "email", "user_email", "username");
            String nameCol = firstExistingColumn(con, "users", "name", "full_name", "username");
            String passwordCol = firstExistingColumn(con, "users", "password", "pass");

            if (emailCol == null || passwordCol == null) {
                throw new SQLException("Missing required identifier/password columns in users table.");
            }

            String idSelect = idCol != null ? idCol : "NULL";
            String nameSelect = nameCol != null ? nameCol : emailCol;
            String sql = "SELECT " + idSelect + " AS uid, "
                    + nameSelect + " AS uname, "
                    + emailCol + " AS uemail, "
                    + passwordCol + " AS upass "
                    + "FROM users WHERE LOWER(" + emailCol + ")=LOWER(?) LIMIT 1";

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, email);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        User u = new User();
                        u.setId(rs.getInt("uid"));
                        u.setName(rs.getString("uname"));
                        u.setEmail(rs.getString("uemail"));
                        u.setPassword(rs.getString("upass"));
                        return u;
                    }
                }
            }
        }
        return null;
    }

    public static boolean authenticate(String email, String password) throws Exception {
        try (Connection con = DBUtil.getConnection()) {
            String emailCol = firstExistingColumn(con, "users", "email", "user_email", "username");
            String passwordCol = firstExistingColumn(con, "users", "password", "pass");

            if (emailCol == null || passwordCol == null) {
                throw new SQLException("Missing required identifier/password columns in users table.");
            }

            String sql = "SELECT 1 FROM users WHERE LOWER(" + emailCol + ")=LOWER(?) "
                    + "AND BINARY " + passwordCol + "=? LIMIT 1";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, email);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    return rs.next();
                }
            }
        }
    }

    public static boolean create(User user) throws Exception {
        String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            return ps.executeUpdate() == 1;
        }
    }

    private static String firstExistingColumn(Connection con, String tableName, String... candidates) throws Exception {
        for (String candidate : candidates) {
            if (hasColumn(con, tableName, candidate)) {
                return candidate;
            }
        }
        return null;
    }

    private static boolean hasColumn(Connection con, String tableName, String columnName) throws Exception {
        DatabaseMetaData metaData = con.getMetaData();
        try (ResultSet rs = metaData.getColumns(null, null, tableName, columnName)) {
            return rs.next();
        }
    }
}

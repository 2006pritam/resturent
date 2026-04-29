package com.resturent.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.resturent.util.DBUtil;

public class SignupServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/signup.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = trimToEmpty(request.getParameter("name"));
        String email = trimToEmpty(request.getParameter("email"));
        String password = trimToEmpty(request.getParameter("password"));

        if (name.isEmpty() || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        try (Connection con = DBUtil.getConnection()) {
            if (userExists(con, email)) {
                request.setAttribute("error", "Email is already registered.");
                request.getRequestDispatcher("/signup.jsp").forward(request, response);
                return;
            }

            createUser(con, name, email, password);
            request.setAttribute("success", "Account created successfully. Please login.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } catch (Exception e) {
            log("Signup failed due to a server error.", e);
            request.setAttribute("error", "Unable to create account right now. Please verify database configuration.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
        }
    }

    private boolean userExists(Connection con, String email) throws Exception {
        String sql = "SELECT 1 FROM users WHERE email = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    private void createUser(Connection con, String name, String email, String password) throws Exception {
        String displayNameColumn = getDisplayNameColumn(con);

        if (displayNameColumn == null) {
            String sql = "INSERT INTO users(email, password) VALUES (?, ?)";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, email);
                ps.setString(2, password);
                ps.executeUpdate();
            }
            return;
        }

        String sql = "INSERT INTO users(" + displayNameColumn + ", email, password) VALUES (?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.executeUpdate();
        }
    }

    private String getDisplayNameColumn(Connection con) throws Exception {
        if (hasColumn(con, "users", "name")) {
            return "name";
        }
        if (hasColumn(con, "users", "full_name")) {
            return "full_name";
        }
        if (hasColumn(con, "users", "username")) {
            return "username";
        }
        return null;
    }

    private boolean hasColumn(Connection con, String tableName, String columnName) throws Exception {
        DatabaseMetaData metaData = con.getMetaData();
        try (ResultSet rs = metaData.getColumns(null, null, tableName, columnName)) {
            return rs.next();
        }
    }

    private String trimToEmpty(String value) {
        return value == null ? "" : value.trim();
    }
}

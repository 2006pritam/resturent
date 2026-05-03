package com.resturent.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.resturent.util.DBUtil;

public class ResetPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userEmail = trimToEmpty(request.getParameter("userEmail"));
        String newPassword = trimToEmpty(request.getParameter("newPassword"));
        String confirmPassword = trimToEmpty(request.getParameter("confirmPassword"));

        if (userEmail.isEmpty()) {
            request.setAttribute("error", "Please enter your email address.");
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
            return;
        }

        try (Connection con = DBUtil.getConnection()) {
            UserRecord user = findUserByEmail(con, userEmail);

            if (user == null) {
                request.setAttribute("error", "No account found for that user ID.");
                request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
                return;
            }

            if (newPassword.isEmpty() && confirmPassword.isEmpty()) {
                request.setAttribute("stage", "new-password");
                request.setAttribute("userEmail", user.email);
                request.setAttribute("info", "User found. Enter a new password to update the account.");
                request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
                return;
            }

            if (newPassword.isEmpty() || confirmPassword.isEmpty()) {
                request.setAttribute("stage", "new-password");
                request.setAttribute("userEmail", user.email);
                request.setAttribute("error", "Please enter and confirm the new password.");
                request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("stage", "new-password");
                request.setAttribute("userEmail", user.email);
                request.setAttribute("error", "Passwords do not match.");
                request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
                return;
            }

            updatePassword(con, user.email, newPassword);
            response.sendRedirect(request.getContextPath() + "/login.jsp?reset=success");
        } catch (Exception e) {
            throw new ServletException("Password reset failed due to server error", e);
        }
    }

    private UserRecord findUserByEmail(Connection con, String email) throws Exception {
        String sql = "SELECT email FROM users WHERE LOWER(email) = LOWER(?) LIMIT 1";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }

                UserRecord user = new UserRecord();
                user.email = rs.getString("email");
                return user;
            }
        }
    }

    private void updatePassword(Connection con, String userEmail, String newPassword) throws Exception {
        String sql = "UPDATE users SET password = ? WHERE LOWER(email) = LOWER(?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, userEmail);
            ps.executeUpdate();
        }
    }

    private String trimToEmpty(String value) {
        return value == null ? "" : value.trim();
    }

    private static class UserRecord {
        String email;
    }
}
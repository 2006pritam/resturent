package com.resturent.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.resturent.dao.UserDAO;
import com.resturent.model.User;
import com.resturent.util.DBUtil;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ctx = request.getContextPath();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        email = email == null ? "" : email.trim();
        password = password == null ? "" : password.trim();

        // Clear any existing auth marker before validating a fresh login attempt.
        HttpSession existingSession = request.getSession(false);
        if (existingSession != null) {
            existingSession.removeAttribute("userEmail");
        }

        if (email.isEmpty() || password.isEmpty()) {
            response.sendRedirect(ctx + "/login.jsp?error=empty");
            return;
        }

        try {
            boolean ok = UserDAO.authenticate(email, password);
            if (ok) {
                User u = UserDAO.findByEmail(email);
                HttpSession session = request.getSession(true);
                session.setAttribute("userEmail", u.getEmail());
                session.setAttribute("userName", u.getName());
                session.setMaxInactiveInterval(30 * 60);
                response.sendRedirect(ctx + "/user/dashboard");
                return;
            }

            response.sendRedirect(ctx + "/login.jsp?error=1");

        } catch (Exception e) {
            log("Login failed due to server error", e);
            response.sendRedirect(ctx + "/login.jsp?error=server");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}

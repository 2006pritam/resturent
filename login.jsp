<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("pageTitle", "Foodu - Login"); %>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="WEB-INF/jspf/head.jspf" %>
</head>
<body>
    <%@ include file="WEB-INF/jspf/header.jspf" %>

    <main class="auth-main">
        <section class="auth-section section-pad">
            <div class="container auth-grid">
                <div class="auth-copy reveal">
                    <p class="kicker">Welcome Back</p>
                    <h1>Login to Your Account</h1>
                    <p>
                        Access your profile, track your orders, and manage your restaurant experience
                        with the same Foodu style.
                    </p>
                    <a class="btn-link" href="<%= ctx %>/signup.jsp">No account? Create Account <i class="fa-solid fa-arrow-right"></i></a>
                </div>
                <div class="auth-card reveal">
                    <h2>Login</h2>
                    <% 
                        String error = request.getParameter("error");
                        String signup = request.getParameter("signup");
                        String reset = request.getParameter("reset");
                        String logout = request.getParameter("logout");
                        if ("success".equals(signup)) {
                    %>
                        <p style="color:#1d7a34; margin-bottom:12px;">✓ Account created successfully. Please login.</p>
                    <% }
                        if ("success".equals(reset)) {
                    %>
                        <p style="color:#1d7a34; margin-bottom:12px;">✓ Password reset successfully. Please login with your new password.</p>
                    <% }
                        if ("1".equals(logout)) {
                    %>
                        <p style="color:#1d7a34; margin-bottom:12px;">✓ You are logged out successfully.</p>
                    <% }
                        if ("empty".equals(error)) { 
                    %>
                        <p style="color:#b00020; margin-bottom:12px;">⚠️ Email and password cannot be empty or contain only spaces.</p>
                    <% } else if ("1".equals(error)) { %>
                        <p style="color:#b00020; margin-bottom:12px;">❌ Invalid email or password. Please check your credentials.</p>
                    <% } else if ("auth".equals(error)) { %>
                        <p style="color:#b00020; margin-bottom:12px;">⚠️ Please login first to access the dashboard.</p>
                    <% } else if ("server".equals(error)) { %>
                        <p style="color:#b00020; margin-bottom:12px;">❌ Unable to connect to database. Check MySQL is running and DB settings are correct.</p>
                    <% } %>
                    <form action="<%= ctx %>/login" method="post" class="auth-form" onsubmit="return validateLoginForm()">
                        <label for="loginEmail">Email Address</label>
                        <input id="loginEmail" name="email" type="email" placeholder="you@example.com" required />

                        <label for="loginPassword">Password</label>
                        <div class="password-field">
                            <input id="loginPassword" name="password" type="password" placeholder="Enter password" required />
                            <button type="button" class="password-toggle" data-toggle-password="loginPassword" aria-label="Show password" title="Show password">
                                <span class="password-eye-icon" aria-hidden="true">&#128065;</span>
                            </button>
                        </div>

                        <a href="<%= ctx %>/forgot-password.jsp" class="forgot-link" style="display: block; text-align: right; margin-bottom: 16px; font-size: 14px; color: #e63946; text-decoration: none;">Forgot Password?</a>

                        <button type="submit" class="btn-primary">Login</button>
                        <a class="btn-link" href="<%= ctx %>/reset-password.jsp">Forgot password? Reset it <i class="fa-solid fa-arrow-right"></i></a>
                        <a class="btn-ghost auth-switch" href="<%= ctx %>/signup.jsp">Create Account</a>
                    </form>
                    
                    <script>
                        function validateLoginForm() {
                            const email = document.getElementById('loginEmail').value.trim();
                            const password = document.getElementById('loginPassword').value.trim();
                            
                            if (!email || !password) {
                                alert('Please enter valid email and password (no empty spaces)');
                                return false;
                            }
                            
                            // Set the trimmed values before submission
                            document.getElementById('loginEmail').value = email;
                            document.getElementById('loginPassword').value = password;
                            
                            return true;
                        }
                    </script>
                </div>
            </div>
        </section>
    </main>

    <%@ include file="WEB-INF/jspf/footer.jspf" %>
</body>
</html>

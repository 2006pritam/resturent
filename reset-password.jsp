<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("pageTitle", "Foodu - Reset Password"); %>
<% String ctx = request.getContextPath(); %>
<%
    String stage = (String) request.getAttribute("stage");
    String userEmailAttr = (String) request.getAttribute("userEmail");
    String error = (String) request.getAttribute("error");
    String info = (String) request.getAttribute("info");
    boolean showResetForm = "new-password".equals(stage) && userEmailAttr != null;
%>
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
                    <p class="kicker">Account Recovery</p>
                    <h1>Reset Your Password</h1>
                    <p>
                        Enter your user ID first. We will verify the account in the database and,
                        once found, let you set a new password for the same account.
                    </p>
                    <a class="btn-link" href="<%= ctx %>/login.jsp">Back to Login <i class="fa-solid fa-arrow-right"></i></a>
                </div>
                <div class="auth-card reveal">
                    <h2>Reset Password</h2>
                    <% if (error != null && !error.trim().isEmpty()) { %>
                        <p style="color:#b00020; margin-bottom:12px;"><%= error %></p>
                    <% } %>
                    <% if (info != null && !info.trim().isEmpty()) { %>
                        <p style="color:#1d7a34; margin-bottom:12px;"><%= info %></p>
                    <% } %>

                    <form action="<%= ctx %>/reset-password" method="post" class="auth-form">
                        <label for="userEmail">Email Address</label>
                        <input
                            id="userEmail"
                            name="userEmail"
                            type="email"
                            placeholder="Enter your email address"
                            required
                            value="<%= userEmailAttr == null ? "" : userEmailAttr %>"
                        />

                        <% if (showResetForm) { %>
                            <div style="padding:0.9rem; border:1px solid var(--line); border-radius:14px; background:rgba(255,255,255,0.5);">
                                <strong style="display:block; margin-bottom:0.35rem; color:var(--secondary);">Account found</strong>
                                <div style="font-size:0.92rem; color:var(--muted); line-height:1.6;">
                                    <div>Email: <%= userEmailAttr == null || userEmailAttr.trim().isEmpty() ? "N/A" : userEmailAttr %></div>
                                </div>
                            </div>

                            <label for="newPassword">New Password</label>
                            <div class="password-field">
                                <input id="newPassword" name="newPassword" type="password" placeholder="Enter new password" required />
                                <button type="button" class="password-toggle" data-toggle-password="newPassword" aria-label="Show password" title="Show password">
                                    <span class="password-eye-icon" aria-hidden="true">&#128065;</span>
                                </button>
                            </div>

                            <label for="confirmPassword">Confirm New Password</label>
                            <div class="password-field">
                                <input id="confirmPassword" name="confirmPassword" type="password" placeholder="Confirm new password" required />
                                <button type="button" class="password-toggle" data-toggle-password="confirmPassword" aria-label="Show password" title="Show password">
                                    <span class="password-eye-icon" aria-hidden="true">&#128065;</span>
                                </button>
                            </div>
                        <% } %>

                        <button type="submit" class="btn-primary"><%= showResetForm ? "Update Password" : "Check Email" %></button>
                        <a class="btn-ghost auth-switch" href="<%= ctx %>/login.jsp">Back to Login</a>
                    </form>
                </div>
            </div>
        </section>
    </main>

    <%@ include file="WEB-INF/jspf/footer.jspf" %>
</body>
</html>
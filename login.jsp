<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("pageTitle", "Foodu - Login"); %>
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
                    <a class="btn-link" href="signup.jsp">No account? Create Account <i class="fa-solid fa-arrow-right"></i></a>
                </div>
                <div class="auth-card reveal">
                    <h2>Login</h2>
                    <form action="#" method="post" class="auth-form">
                        <label for="loginEmail">Email Address</label>
                        <input id="loginEmail" name="email" type="email" placeholder="you@example.com" required />

                        <label for="loginPassword">Password</label>
                        <input id="loginPassword" name="password" type="password" placeholder="Enter password" required />

                        <button type="submit" class="btn-primary">Login</button>
                        <a class="btn-ghost auth-switch" href="signup.jsp">Create Account</a>
                    </form>
                </div>
            </div>
        </section>
    </main>

    <%@ include file="WEB-INF/jspf/footer.jspf" %>
</body>
</html>

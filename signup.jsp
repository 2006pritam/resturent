<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("pageTitle", "Foodu - Sign Up"); %>
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
                    <p class="kicker">Join Foodu</p>
                    <h1>Create New Account</h1>
                    <p>
                        Sign up to start ordering faster, save favorites, and enjoy exclusive
                        restaurant offers with a clean and modern Foodu interface.
                    </p>
                    <a class="btn-link" href="login.jsp">Already have an account? Login <i class="fa-solid fa-arrow-right"></i></a>
                </div>
                <div class="auth-card reveal">
                    <h2>Sign Up</h2>
                    <form action="#" method="post" class="auth-form">
                        <label for="signName">Full Name</label>
                        <input id="signName" name="name" type="text" placeholder="Your full name" required />

                        <label for="signEmail">Email Address</label>
                        <input id="signEmail" name="email" type="email" placeholder="you@example.com" required />

                        <label for="signPassword">Password</label>
                        <input id="signPassword" name="password" type="password" placeholder="Create password" required />

                        <button type="submit" class="btn-primary">Create Account</button>
                    </form>
                </div>
            </div>
        </section>
    </main>

    <%@ include file="WEB-INF/jspf/footer.jspf" %>
</body>
</html>

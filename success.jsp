<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("pageTitle", "Foodu - Login Success");
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
            <div class="container" style="max-width: 720px;">
                <div class="auth-card" style="text-align:center;">
                    <h1>Login Successful</h1>
                    <p>Welcome, <strong><%= userEmail %></strong></p>
                    <p>You are now signed in.</p>
                    <a class="btn-primary" href="index.jsp">Go to Home</a>
                </div>
            </div>
        </section>
    </main>

    <%@ include file="WEB-INF/jspf/footer.jspf" %>
</body>
</html>

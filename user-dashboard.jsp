<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setAttribute("pageTitle", "Foodu - User Dashboard");
    String ctx = request.getContextPath();
    String userEmail = (String) session.getAttribute("userEmail");
    String userName = (String) session.getAttribute("userName");
    String displayName = (userName != null && !userName.trim().isEmpty()) ? userName : "Customer 1";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="WEB-INF/jspf/head.jspf" %>
    <style>
        :root {
            --dash-bg: #e7e1d8;
            --dash-surface: #f4efe7;
            --dash-card: #f1ece4;
            --dash-ink: #2d2822;
            --dash-muted: #7d7165;
            --dash-border: #dfd6ca;
            --dash-pill: #ebe4da;
            --dash-accent: #d8743f;
            --dash-success: #4f8c5c;
            --dash-info: #3b7ab8;
            --dash-danger: #b5523a;
            --dash-radius-lg: 18px;
            --dash-radius-sm: 12px;
        }

        body.userdash-page {
            margin: 0;
            font-family: "Plus Jakarta Sans", sans-serif;
            background: linear-gradient(155deg, #d5cec3 0%, #e9e3da 58%, #ded7cd 100%);
            color: var(--dash-ink);
            min-height: 100vh;
        }

        .userdash-shell {
            max-width: 1260px;
            margin: 12px auto;
            display: grid;
            grid-template-columns: 240px 1fr;
            gap: 14px;
            padding: 0 10px 12px;
        }

        .userdash-sidebar {
            background: var(--dash-surface);
            border: 1px solid var(--dash-border);
            border-radius: var(--dash-radius-lg);
            padding: 18px 12px;
            display: flex;
            flex-direction: column;
            gap: 16px;
            min-height: calc(100vh - 26px);
        }

        .dash-brand {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px;
            border-radius: var(--dash-radius-sm);
            background: #ebe4d9;
            font-weight: 800;
            letter-spacing: 0.03em;
        }

        .dash-brand i {
            width: 32px;
            height: 32px;
            border-radius: 10px;
            display: grid;
            place-items: center;
            background: #d7c8b3;
            color: #6f4d2f;
        }

        .dash-user {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px;
            border-radius: var(--dash-radius-sm);
            background: #f8f3ec;
            border: 1px solid var(--dash-border);
        }

        .dash-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: grid;
            place-items: center;
            background: #e6dac9;
            color: #5a4330;
            font-weight: 800;
        }

        .dash-user p {
            margin: 0;
            font-size: 0.82rem;
            color: var(--dash-muted);
        }

        .dash-user h4 {
            margin: 0;
            font-size: 0.95rem;
            font-weight: 700;
            line-height: 1.2;
        }

        .dash-menu {
            display: grid;
            gap: 8px;
        }

        .dash-menu button,
        .dash-logout {
            width: 100%;
            border: 1px solid transparent;
            background: transparent;
            color: var(--dash-ink);
            padding: 10px 12px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
            text-align: left;
            font-weight: 700;
            cursor: pointer;
            transition: 0.2s ease;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .dash-menu button i,
        .dash-logout i {
            width: 18px;
            text-align: center;
        }

        .dash-menu button:hover,
        .dash-menu button.active,
        .dash-logout:hover {
            background: #e5ddd2;
            border-color: #d8cebf;
        }

        .dash-logout {
            margin-top: auto;
            color: var(--dash-danger);
            background: #f7ece8;
            border-color: #ead0c7;
        }

        .userdash-main {
            background: var(--dash-surface);
            border: 1px solid var(--dash-border);
            border-radius: var(--dash-radius-lg);
            padding: 12px;
            min-height: calc(100vh - 26px);
        }

        .dash-breadcrumb {
            background: var(--dash-pill);
            border: 1px solid var(--dash-border);
            border-radius: var(--dash-radius-sm);
            padding: 10px 14px;
            color: var(--dash-muted);
            font-size: 0.84rem;
            margin-bottom: 10px;
        }

        .dash-head {
            background: var(--dash-pill);
            border: 1px solid var(--dash-border);
            border-radius: var(--dash-radius-sm);
            padding: 12px 14px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .dash-head h1 {
            margin: 0;
            font-size: 1.3rem;
            line-height: 1.1;
            font-family: "Plus Jakarta Sans", sans-serif;
            font-weight: 800;
        }

        .dash-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 12px;
            margin-bottom: 14px;
        }

        .stat-card {
            background: var(--dash-card);
            border: 1px solid var(--dash-border);
            border-radius: 14px;
            padding: 14px;
            display: grid;
            grid-template-columns: auto 1fr auto;
            align-items: center;
            gap: 10px;
        }

        .stat-icon {
            width: 34px;
            height: 34px;
            border-radius: 999px;
            display: grid;
            place-items: center;
            font-size: 0.9rem;
        }

        .stat-card strong {
            display: block;
            font-size: 1.55rem;
            line-height: 1;
        }

        .stat-card span {
            font-size: 0.78rem;
            color: var(--dash-muted);
            font-weight: 600;
            display: block;
        }

        .sparkline {
            width: 42px;
            height: 16px;
            border-radius: 8px;
            position: relative;
            overflow: hidden;
        }

        .sparkline::before {
            content: "";
            position: absolute;
            inset: 0;
            background-size: 100% 100%;
            opacity: 0.85;
        }

        .stat-orders .stat-icon {
            color: #b36b49;
            background: #e8d6cb;
        }

        .stat-orders .sparkline::before {
            background-image: linear-gradient(120deg, transparent 12%, #7f6f60 16%, transparent 24%, #7f6f60 34%, transparent 44%, #7f6f60 54%, transparent 62%, #7f6f60 74%, transparent 80%);
        }

        .stat-delivery .stat-icon {
            color: #d06f1f;
            background: #f4dcc3;
        }

        .stat-delivery .sparkline::before {
            background-image: linear-gradient(120deg, transparent 12%, #d97721 16%, transparent 24%, #d97721 34%, transparent 44%, #d97721 54%, transparent 62%, #d97721 74%, transparent 80%);
        }

        .stat-delivered .stat-icon {
            color: var(--dash-success);
            background: #d8e8dc;
        }

        .stat-delivered .sparkline::before {
            background-image: linear-gradient(120deg, transparent 12%, #4d9556 16%, transparent 24%, #4d9556 34%, transparent 44%, #4d9556 54%, transparent 62%, #4d9556 74%, transparent 80%);
        }

        .stat-week .stat-icon {
            color: var(--dash-info);
            background: #d6e4f2;
        }

        .stat-week .sparkline::before {
            background-image: linear-gradient(120deg, transparent 12%, #337abe 16%, transparent 24%, #337abe 34%, transparent 44%, #337abe 54%, transparent 62%, #337abe 74%, transparent 80%);
        }

        .dash-section {
            display: none;
            background: #f6f0e8;
            border: 1px solid var(--dash-border);
            border-radius: 14px;
            padding: 14px;
        }

        .dash-section.active {
            display: block;
        }

        .section-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            text-align: left;
        }

        .section-head h2 {
            margin: 0;
            font-size: 1.12rem;
            font-family: "Plus Jakarta Sans", sans-serif;
            font-weight: 800;
        }

        .chip {
            display: inline-flex;
            align-items: center;
            border: 1px solid var(--dash-border);
            border-radius: 999px;
            padding: 4px 10px;
            font-size: 0.75rem;
            font-weight: 700;
            color: var(--dash-muted);
            background: #fff;
        }

        .table-wrap {
            width: 100%;
            overflow-x: auto;
            background: #fff;
            border-radius: 12px;
            border: 1px solid var(--dash-border);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 560px;
        }

        th,
        td {
            padding: 10px 12px;
            text-align: left;
            border-bottom: 1px solid #f0e6da;
            font-size: 0.86rem;
        }

        th {
            color: var(--dash-muted);
            font-size: 0.78rem;
            text-transform: uppercase;
            letter-spacing: 0.04em;
        }

        .action-btn {
            border: 1px solid var(--dash-border);
            border-radius: 8px;
            padding: 4px 8px;
            font-size: 0.72rem;
            cursor: pointer;
            background: #fff;
            margin-right: 4px;
        }

        .action-btn.primary {
            border-color: #e9c3a8;
            background: #fdebdc;
            color: #aa5827;
        }

        .action-btn.warn {
            border-color: #e8c7be;
            background: #f9e3dd;
            color: #9f4b39;
        }

        .quick-form {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr auto;
            gap: 10px;
            margin-top: 10px;
        }

        .quick-form input,
        .quick-form select {
            height: 40px;
            border: 1px solid var(--dash-border);
            border-radius: 10px;
            padding: 0 10px;
            background: #fff;
            font-family: inherit;
        }

        .quick-form button {
            border: 1px solid #d9bca2;
            background: #e9d2bc;
            color: #60452e;
            border-radius: 10px;
            height: 40px;
            padding: 0 14px;
            font-weight: 700;
            cursor: pointer;
        }

        .two-col {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }

        .info-card {
            background: #fff;
            border-radius: 12px;
            border: 1px solid var(--dash-border);
            padding: 12px;
        }

        .info-card h3 {
            margin: 0 0 8px;
            font-size: 0.94rem;
        }

        .info-card p {
            margin: 0;
            font-size: 0.84rem;
            color: var(--dash-muted);
            line-height: 1.45;
        }

        .mobile-top {
            display: none;
            margin-bottom: 10px;
        }

        .mobile-menu-btn {
            width: 100%;
            height: 40px;
            border-radius: 10px;
            border: 1px solid var(--dash-border);
            background: #ece4d8;
            font-weight: 700;
            color: #554636;
            cursor: pointer;
        }

        @media (max-width: 1024px) {
            .userdash-shell {
                grid-template-columns: 1fr;
            }

            .userdash-sidebar {
                min-height: auto;
                display: none;
            }

            .userdash-sidebar.open {
                display: flex;
            }

            .mobile-top {
                display: block;
            }

            .userdash-main {
                min-height: auto;
            }

            .dash-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .quick-form {
                grid-template-columns: 1fr;
            }

            .two-col {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 640px) {
            .dash-grid {
                grid-template-columns: 1fr;
            }

            .dash-head {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }

            .dash-head h1 {
                font-size: 1.1rem;
            }
        }
    </style>
</head>
<body class="userdash-page">
    <div class="userdash-shell">
        <aside class="userdash-sidebar" id="userSidebar">
            <div class="dash-brand">
                <i class="fa-solid fa-utensils"></i>
                <span>Foodu User App</span>
            </div>

            <div class="dash-user">
                <div class="dash-avatar"><%= displayName.substring(0, 1).toUpperCase() %></div>
                <div>
                    <h4><%= displayName %></h4>
                    <p><%= userEmail != null ? userEmail : "user@foodu.com" %></p>
                </div>
            </div>

            <div class="dash-menu" id="dashMenu">
                <button type="button" class="active" data-target="section-dashboard"><i class="fa-solid fa-chart-simple"></i> Dashboard</button>
                <button type="button" data-target="section-menu"><i class="fa-solid fa-burger"></i> Menu</button>
                <button type="button" data-target="section-cart"><i class="fa-solid fa-cart-shopping"></i> Add To Cart</button>
                <button type="button" data-target="section-track"><i class="fa-solid fa-location-dot"></i> Track Order</button>
                <button type="button" data-target="section-profile"><i class="fa-solid fa-user"></i> Profile</button>
            </div>

            <a class="dash-logout" href="<%= ctx %>/logout"><i class="fa-solid fa-right-from-bracket"></i> Log Out</a>
        </aside>

        <main class="userdash-main">
            <div class="mobile-top">
                <button id="mobileMenuToggle" class="mobile-menu-btn" type="button">
                    <i class="fa-solid fa-bars"></i> Open Menu
                </button>
            </div>

            <div class="dash-breadcrumb"><i class="fa-solid fa-house" style="margin-right: 6px;"></i> Home / Dashboard</div>

            <div class="dash-head">
                <h1><i class="fa-solid fa-chart-line" style="margin-right: 6px;"></i> Dashboard</h1>
                <div>Welcome, <strong><%= displayName %></strong></div>
            </div>

            <div class="dash-grid">
                <article class="stat-card stat-orders">
                    <span class="stat-icon"><i class="fa-solid fa-clipboard-list"></i></span>
                    <div><strong>0</strong><span>Assigned Orders</span></div>
                    <span class="sparkline"></span>
                </article>
                <article class="stat-card stat-delivery">
                    <span class="stat-icon"><i class="fa-solid fa-truck"></i></span>
                    <div><strong>0</strong><span>Out for Delivery</span></div>
                    <span class="sparkline"></span>
                </article>
                <article class="stat-card stat-delivered">
                    <span class="stat-icon"><i class="fa-solid fa-circle-check"></i></span>
                    <div><strong>0</strong><span>Delivered Today</span></div>
                    <span class="sparkline"></span>
                </article>
                <article class="stat-card stat-week">
                    <span class="stat-icon"><i class="fa-solid fa-chart-column"></i></span>
                    <div><strong>0</strong><span>This Week</span></div>
                    <span class="sparkline"></span>
                </article>
            </div>

            <section id="section-dashboard" class="dash-section active">
                <div class="section-head">
                    <h2>Recent Activity</h2>
                    <span class="chip">SaaS Dashboard</span>
                </div>
                <div class="two-col">
                    <div class="info-card">
                        <h3>Order Queue</h3>
                        <p>No active orders yet. New orders from your cart will appear here with live status updates.</p>
                    </div>
                    <div class="info-card">
                        <h3>Payment Snapshot</h3>
                        <p>Total billing this week: Rs 0.00. Start by adding products to your cart and confirming checkout.</p>
                    </div>
                </div>
            </section>

            <section id="section-menu" class="dash-section">
                <div class="section-head">
                    <h2>Menu Management</h2>
                    <span class="chip">CRUD Table</span>
                </div>
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>Item</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Veg Burger</td>
                                <td>Burger</td>
                                <td>Rs 129</td>
                                <td>Available</td>
                                <td>
                                    <button class="action-btn primary" type="button">Edit</button>
                                    <button class="action-btn warn" type="button">Delete</button>
                                </td>
                            </tr>
                            <tr>
                                <td>Paneer Pizza</td>
                                <td>Pizza</td>
                                <td>Rs 239</td>
                                <td>Available</td>
                                <td>
                                    <button class="action-btn primary" type="button">Edit</button>
                                    <button class="action-btn warn" type="button">Delete</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <form class="quick-form" action="#" method="post" onsubmit="return false;">
                    <input type="text" placeholder="Item Name" />
                    <select>
                        <option>Burger</option>
                        <option>Pizza</option>
                        <option>Drink</option>
                    </select>
                    <input type="text" placeholder="Price (Rs)" />
                    <button type="submit">Add Item</button>
                </form>
            </section>

            <section id="section-cart" class="dash-section">
                <div class="section-head">
                    <h2>Add To Cart</h2>
                    <span class="chip">Cart CRUD</span>
                </div>
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Qty</th>
                                <th>Price</th>
                                <th>Total</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Veg Burger</td>
                                <td>1</td>
                                <td>Rs 129</td>
                                <td>Rs 129</td>
                                <td>
                                    <button class="action-btn primary" type="button">Update</button>
                                    <button class="action-btn warn" type="button">Remove</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <form class="quick-form" action="#" method="post" onsubmit="return false;">
                    <input type="text" placeholder="Product Name" />
                    <input type="text" placeholder="Quantity" />
                    <input type="text" placeholder="Unit Price" />
                    <button type="submit">Add Cart Item</button>
                </form>
            </section>

            <section id="section-track" class="dash-section">
                <div class="section-head">
                    <h2>Track Order</h2>
                    <span class="chip">Live Status</span>
                </div>
                <div class="two-col">
                    <div class="info-card">
                        <h3>Current Delivery</h3>
                        <p>Order #FD-2031 is being prepared. Rider assignment will appear here after dispatch.</p>
                    </div>
                    <div class="info-card">
                        <h3>Timeline</h3>
                        <p>Placed -> Confirmed -> Cooking -> Out For Delivery -> Delivered</p>
                    </div>
                </div>
            </section>

            <section id="section-profile" class="dash-section">
                <div class="section-head">
                    <h2>Profile</h2>
                    <span class="chip">User Settings</span>
                </div>
                <div class="two-col">
                    <div class="info-card">
                        <h3>Name</h3>
                        <p><%= displayName %></p>
                    </div>
                    <div class="info-card">
                        <h3>Email</h3>
                        <p><%= userEmail != null ? userEmail : "Not available" %></p>
                    </div>
                </div>
            </section>
        </main>
    </div>

    <script>
        (function () {
            const menu = document.getElementById("dashMenu");
            const buttons = menu ? menu.querySelectorAll("button[data-target]") : [];
            const sections = document.querySelectorAll(".dash-section");
            const mobileMenuToggle = document.getElementById("mobileMenuToggle");
            const sidebar = document.getElementById("userSidebar");

            buttons.forEach((button) => {
                button.addEventListener("click", () => {
                    const target = button.getAttribute("data-target");

                    buttons.forEach((b) => b.classList.remove("active"));
                    button.classList.add("active");

                    sections.forEach((section) => {
                        section.classList.toggle("active", section.id === target);
                    });
                });
            });

            if (mobileMenuToggle && sidebar) {
                mobileMenuToggle.addEventListener("click", () => {
                    sidebar.classList.toggle("open");
                });
            }
        })();
    </script>
</body>
</html>

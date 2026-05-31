<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.resturent.model.MenuItem" %>
<%@ page import="com.resturent.model.CartItem" %>
<%@ page import="com.resturent.model.OrderRecord" %>
<%!
    private String safe(String v) {
        return v == null ? "" : v;
    }

    private String fmt(double n) {
        return String.format("%.2f", n);
    }
%>
<%
    request.setAttribute("pageTitle", "Foodu - User SaaS Dashboard");
    String ctx = request.getContextPath();
    String activeSection = (String) request.getAttribute("activeSection");
    if (activeSection == null || activeSection.trim().isEmpty()) {
        activeSection = "section-dashboard";
    }

    @SuppressWarnings("unchecked")
    List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
    @SuppressWarnings("unchecked")
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    @SuppressWarnings("unchecked")
    List<OrderRecord> orders = (List<OrderRecord>) request.getAttribute("orders");

    Integer menuCountObj = (Integer) request.getAttribute("menuCount");
    Integer cartCountObj = (Integer) request.getAttribute("cartCount");
    Integer orderCountObj = (Integer) request.getAttribute("orderCount");
    Integer activeOrderCountObj = (Integer) request.getAttribute("activeOrderCount");
    Double cartTotalObj = (Double) request.getAttribute("cartTotal");

    int menuCount = menuCountObj == null ? 0 : menuCountObj.intValue();
    int cartCount = cartCountObj == null ? 0 : cartCountObj.intValue();
    int orderCount = orderCountObj == null ? 0 : orderCountObj.intValue();
    int activeOrderCount = activeOrderCountObj == null ? 0 : activeOrderCountObj.intValue();
    double cartTotal = cartTotalObj == null ? 0.0 : cartTotalObj.doubleValue();

    String userEmail = (String) session.getAttribute("userEmail");
    String userName = (String) session.getAttribute("userName");
    String displayName = (userName != null && !userName.trim().isEmpty()) ? userName.trim() : "Customer";
    String initials = displayName.substring(0, 1).toUpperCase();

    String flashMessage = (String) request.getAttribute("flashMessage");
    String flashType = (String) request.getAttribute("flashType");
    if (flashType == null || flashType.trim().isEmpty()) {
        flashType = "info";
    }

    String userPhone = (String) request.getAttribute("userPhone");
    String userAddress = (String) request.getAttribute("userAddress");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="WEB-INF/jspf/head.jspf" %>
    <style>
        :root {
            --dash-bg: #eef2fb;
            --dash-surface: #ffffff;
            --dash-border: #e8ebf5;
            --dash-ink: #20263c;
            --dash-muted: #67708d;
            --dash-accent: #5f6af2;
            --dash-accent-soft: #eef0ff;
            --dash-success: #2f9a66;
            --dash-danger: #d24b59;
            --dash-warning: #e29730;
            --dash-radius-lg: 20px;
            --dash-radius-md: 14px;
            --dash-radius-sm: 10px;
            --shadow-soft: 0 18px 34px rgba(57, 72, 122, 0.08);
        }

        .site-header {
            display: none;
        }

        body.userdash-page {
            margin: 0;
            font-family: "Plus Jakarta Sans", sans-serif;
            color: var(--dash-ink);
            background:
                radial-gradient(circle at 10% 10%, #dfe5ff 0%, transparent 45%),
                radial-gradient(circle at 88% 16%, #f2f4ff 0%, transparent 40%),
                var(--dash-bg);
            min-height: 100vh;
        }

        .dash-shell {
            max-width: 1240px;
            margin: 14px auto;
            padding: 0 10px 14px;
            display: grid;
            grid-template-columns: 220px 1fr;
            gap: 12px;
        }

        .dash-sidebar {
            background: var(--dash-surface);
            border: 1px solid var(--dash-border);
            border-radius: var(--dash-radius-lg);
            box-shadow: var(--shadow-soft);
            padding: 12px;
            display: flex;
            flex-direction: column;
            min-height: calc(100vh - 28px);
            gap: 14px;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px;
            border-radius: var(--dash-radius-sm);
            border: 1px solid var(--dash-border);
        }

        .brand i {
            width: 30px;
            height: 30px;
            border-radius: 9px;
            display: grid;
            place-items: center;
            background: var(--dash-accent-soft);
            color: var(--dash-accent);
        }

        .brand b {
            font-size: 0.98rem;
        }

        .user-card {
            display: flex;
            gap: 10px;
            align-items: center;
            background: #f8f9ff;
            border: 1px solid var(--dash-border);
            border-radius: var(--dash-radius-sm);
            padding: 10px;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: grid;
            place-items: center;
            background: #dde1ff;
            color: #4a57ec;
            font-weight: 800;
        }

        .user-card h4 {
            margin: 0;
            font-size: 0.93rem;
            line-height: 1.2;
        }

        .user-card p {
            margin: 0;
            font-size: 0.76rem;
            color: var(--dash-muted);
        }

        .dash-nav {
            display: grid;
            gap: 8px;
        }

        .dash-nav a,
        .logout-link {
            text-decoration: none;
            color: var(--dash-ink);
            border: 1px solid transparent;
            border-radius: 10px;
            padding: 10px 12px;
            display: flex;
            gap: 10px;
            align-items: center;
            font-size: 0.88rem;
            font-weight: 700;
            transition: 0.2s ease;
        }

        .dash-nav a:hover,
        .dash-nav a.active {
            border-color: #cfd5ff;
            background: var(--dash-accent-soft);
            color: #3a46d9;
        }

        .logout-link {
            margin-top: auto;
            color: var(--dash-danger);
            background: #fff3f5;
            border-color: #ffd8dd;
        }

        .dash-main {
            background: var(--dash-surface);
            border: 1px solid var(--dash-border);
            border-radius: var(--dash-radius-lg);
            box-shadow: var(--shadow-soft);
            min-height: calc(100vh - 28px);
            padding: 12px;
        }

        .topbar {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 12px;
        }

        .mobile-nav-toggle {
            display: none;
            height: 40px;
            padding: 0 12px;
            border-radius: 10px;
            border: 1px solid var(--dash-border);
            background: #f5f7ff;
            font-weight: 700;
            cursor: pointer;
        }

        .search-wrap {
            flex: 1;
            position: relative;
        }

        .search-wrap i {
            position: absolute;
            left: 12px;
            top: 12px;
            color: var(--dash-muted);
            font-size: 0.86rem;
        }

        .search-wrap input {
            width: 100%;
            height: 40px;
            border-radius: 10px;
            border: 1px solid var(--dash-border);
            padding: 0 12px 0 34px;
            background: #fbfcff;
            font-family: inherit;
        }

        .profile-pill {
            display: inline-flex;
            gap: 8px;
            align-items: center;
            border: 1px solid var(--dash-border);
            border-radius: 10px;
            background: #fbfcff;
            padding: 7px 10px;
            font-size: 0.83rem;
        }

        .welcome-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
            margin-bottom: 12px;
        }

        .welcome-row h1 {
            margin: 0;
            font-size: 1.42rem;
            line-height: 1;
        }

        .breadcrumb {
            color: var(--dash-muted);
            font-size: 0.84rem;
        }

        .flash {
            border-radius: 10px;
            border: 1px solid var(--dash-border);
            padding: 9px 12px;
            margin-bottom: 12px;
            font-size: 0.84rem;
            font-weight: 600;
        }

        .flash.success {
            color: #256f4a;
            background: #ecf9f1;
            border-color: #cbeedb;
        }

        .flash.error {
            color: #912d39;
            background: #fff1f3;
            border-color: #ffd5db;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 10px;
            margin-bottom: 12px;
        }

        .stat-card {
            border: 1px solid var(--dash-border);
            border-radius: 12px;
            background: #fcfdff;
            padding: 12px;
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .stat-card .icon {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            display: grid;
            place-items: center;
            background: var(--dash-accent-soft);
            color: var(--dash-accent);
            font-size: 0.88rem;
        }

        .stat-card strong {
            display: block;
            font-size: 1.2rem;
            line-height: 1;
        }

        .stat-card span {
            font-size: 0.75rem;
            color: var(--dash-muted);
            font-weight: 600;
        }

        .panel {
            display: none;
            border: 1px solid var(--dash-border);
            border-radius: 14px;
            background: #fbfcff;
            padding: 12px;
        }

        .panel.active {
            display: block;
        }

        .panel-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
        }

        .panel-head h2 {
            margin: 0;
            font-size: 1.05rem;
        }

        .chip {
            font-size: 0.74rem;
            font-weight: 700;
            color: var(--dash-muted);
            border: 1px solid var(--dash-border);
            border-radius: 999px;
            padding: 4px 8px;
            background: #fff;
        }

        .two-col {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 10px;
        }

        .mini-card {
            border: 1px solid var(--dash-border);
            border-radius: 12px;
            padding: 12px;
            background: #fff;
        }

        .mini-card h3 {
            margin: 0 0 8px;
            font-size: 0.95rem;
        }

        .mini-card p {
            margin: 0;
            font-size: 0.84rem;
            color: var(--dash-muted);
            line-height: 1.5;
        }

        .table-wrap {
            border: 1px solid var(--dash-border);
            border-radius: 10px;
            overflow-x: auto;
            background: #fff;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 660px;
        }

        th,
        td {
            border-bottom: 1px solid #eff2f8;
            padding: 10px 8px;
            text-align: left;
            font-size: 0.84rem;
            vertical-align: middle;
        }

        th {
            color: var(--dash-muted);
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.04em;
        }

        .inline-input,
        .inline-select,
        .form-control {
            width: 100%;
            height: 34px;
            border: 1px solid var(--dash-border);
            border-radius: 8px;
            padding: 0 8px;
            font-family: inherit;
            font-size: 0.82rem;
            background: #fff;
            box-sizing: border-box;
        }

        .toggle-check {
            width: 18px;
            height: 18px;
            accent-color: var(--dash-accent);
        }

        .actions {
            display: flex;
            gap: 6px;
            flex-wrap: wrap;
        }

        .btn {
            height: 32px;
            border-radius: 8px;
            border: 1px solid transparent;
            background: #f2f5ff;
            color: #3343d0;
            padding: 0 10px;
            font-size: 0.76rem;
            font-weight: 700;
            cursor: pointer;
        }

        .btn:hover {
            filter: brightness(0.97);
        }

        .btn.ghost {
            background: #fff;
            border-color: var(--dash-border);
            color: var(--dash-muted);
        }

        .btn.warn {
            background: #fff1f3;
            color: #a43041;
            border-color: #ffd5db;
        }

        .btn.success {
            background: #eaf8f1;
            color: #24754d;
            border-color: #caedd9;
        }

        .grid-form {
            margin-top: 10px;
            display: grid;
            grid-template-columns: 2fr 1.2fr 1fr auto auto;
            gap: 8px;
            align-items: center;
        }

        .stack-form {
            border: 1px solid var(--dash-border);
            border-radius: 12px;
            background: #fff;
            padding: 10px;
            display: grid;
            gap: 8px;
            max-width: 520px;
        }

        .stack-form label {
            font-size: 0.78rem;
            color: var(--dash-muted);
            font-weight: 700;
        }

        .empty {
            padding: 14px;
            text-align: center;
            color: var(--dash-muted);
            font-size: 0.84rem;
        }

        .status {
            display: inline-block;
            border-radius: 999px;
            padding: 4px 8px;
            font-size: 0.72rem;
            font-weight: 700;
            border: 1px solid var(--dash-border);
        }

        .status.placed {
            background: #fff6e8;
            color: #9c6f29;
            border-color: #ffe0ac;
        }

        .status.progress {
            background: #edf0ff;
            color: #3f49d8;
            border-color: #d5dbff;
        }

        .status.done {
            background: #ecf9f1;
            color: #2d875a;
            border-color: #caedd9;
        }

        @media (max-width: 1024px) {
            .dash-shell {
                grid-template-columns: 1fr;
            }

            .dash-sidebar {
                min-height: 0;
                display: none;
            }

            .dash-sidebar.open {
                display: flex;
            }

            .mobile-nav-toggle {
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .stats-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .grid-form {
                grid-template-columns: 1fr;
            }

            .two-col {
                grid-template-columns: 1fr;
            }

            .welcome-row {
                flex-direction: column;
                align-items: flex-start;
            }
        }

        @media (max-width: 640px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }

            .topbar {
                flex-wrap: wrap;
            }

            .profile-pill {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body class="userdash-page">
    <div class="dash-shell">
        <aside class="dash-sidebar" id="dashSidebar">
            <div class="brand">
                <i class="fa-solid fa-bowl-food"></i>
                <b>Hire Chef</b>
            </div>

            <div class="user-card">
                <div class="avatar"><%= initials %></div>
                <div>
                    <h4><%= displayName %></h4>
                    <p><%= safe(userEmail) %></p>
                </div>
            </div>

            <nav class="dash-nav">
                <a class="<%= "section-dashboard".equals(activeSection) ? "active" : "" %>" href="<%= ctx %>/user/dashboard?s=section-dashboard"><i class="fa-solid fa-chart-pie"></i> Dashboard</a>
                <a class="<%= "section-menu".equals(activeSection) ? "active" : "" %>" href="<%= ctx %>/user/dashboard?s=section-menu"><i class="fa-solid fa-utensils"></i> Menu</a>
                <a class="<%= "section-cart".equals(activeSection) ? "active" : "" %>" href="<%= ctx %>/user/dashboard?s=section-cart"><i class="fa-solid fa-cart-shopping"></i> Add To Cart</a>
                <a class="<%= "section-track".equals(activeSection) ? "active" : "" %>" href="<%= ctx %>/user/dashboard?s=section-track"><i class="fa-solid fa-location-dot"></i> Track Order</a>
                <a class="<%= "section-profile".equals(activeSection) ? "active" : "" %>" href="<%= ctx %>/user/dashboard?s=section-profile"><i class="fa-solid fa-user"></i> Profile</a>
            </nav>

            <a class="logout-link" href="<%= ctx %>/logout"><i class="fa-solid fa-right-from-bracket"></i> Log Out</a>
        </aside>

        <main class="dash-main">
            <div class="topbar">
                <button id="mobileNavToggle" class="mobile-nav-toggle" type="button"><i class="fa-solid fa-bars"></i> Menu</button>
                <div class="search-wrap">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" placeholder="Search" disabled />
                </div>
                <div class="profile-pill"><i class="fa-solid fa-user"></i> <%= displayName %></div>
            </div>

            <div class="welcome-row">
                <div>
                    <h1>Dashboard</h1>
                    <div class="breadcrumb">Home / User Dashboard</div>
                </div>
                <div class="chip">Tablet SaaS Layout</div>
            </div>

            <% if (flashMessage != null && !flashMessage.trim().isEmpty()) { %>
            <div class="flash <%= flashType %>"><%= flashMessage %></div>
            <% } %>

            <section class="stats-grid">
                <article class="stat-card">
                    <div class="icon"><i class="fa-solid fa-indian-rupee-sign"></i></div>
                    <div><strong><%= fmt(cartTotal) %></strong><span>Cart Value</span></div>
                </article>
                <article class="stat-card">
                    <div class="icon"><i class="fa-solid fa-bowl-food"></i></div>
                    <div><strong><%= menuCount %></strong><span>Total Menu</span></div>
                </article>
                <article class="stat-card">
                    <div class="icon"><i class="fa-solid fa-cart-shopping"></i></div>
                    <div><strong><%= cartCount %></strong><span>Cart Items</span></div>
                </article>
                <article class="stat-card">
                    <div class="icon"><i class="fa-solid fa-truck-fast"></i></div>
                    <div><strong><%= activeOrderCount %></strong><span>Active Orders</span></div>
                </article>
            </section>

            <section class="panel <%= "section-dashboard".equals(activeSection) ? "active" : "" %>">
                <div class="panel-head">
                    <h2>Overview</h2>
                    <span class="chip">SaaS Summary</span>
                </div>
                <div class="two-col">
                    <div class="mini-card">
                        <h3>Order Summary</h3>
                        <p>Total Orders: <b><%= orderCount %></b><br/>Active Orders: <b><%= activeOrderCount %></b><br/>Cart Total: <b>Rs <%= fmt(cartTotal) %></b></p>
                    </div>
                    <div class="mini-card">
                        <h3>Workflow</h3>
                        <p>Add menu items, add to cart, place order, and then track each order status from Placed to Delivered.</p>
                    </div>
                </div>
            </section>

            <section class="panel <%= "section-menu".equals(activeSection) ? "active" : "" %>">
                <div class="panel-head">
                    <h2>Menu CRUD</h2>
                    <span class="chip">Create / Update / Delete</span>
                </div>

                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Price (Rs)</th>
                                <th>Available</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (menuItems == null || menuItems.isEmpty()) { %>
                            <tr><td colspan="5" class="empty">No menu item found.</td></tr>
                            <% } else {
                                for (MenuItem item : menuItems) { %>
                            <tr>
                                <td><%= item.getName() %></td>
                                <td><%= item.getCategory() %></td>
                                <td><%= fmt(item.getPrice()) %></td>
                                <td><%= item.isAvailable() ? "Yes" : "No" %></td>
                                <td>
                                    <form action="<%= ctx %>/user/dashboard" method="post">
                                        <input type="hidden" name="action" value="menu-delete" />
                                        <input type="hidden" name="section" value="section-menu" />
                                        <input type="hidden" name="itemId" value="<%= item.getId() %>" />
                                        <button class="btn warn" type="submit">Delete</button>
                                    </form>
                                </td>
                            </tr>
                            <% }
                            } %>
                        </tbody>
                    </table>
                </div>

                <form class="grid-form" action="<%= ctx %>/user/dashboard" method="post">
                    <input type="hidden" name="action" value="menu-update" />
                    <input type="hidden" name="section" value="section-menu" />
                    <select class="form-control" name="itemId" required>
                        <option value="">Select Item To Update</option>
                        <% if (menuItems != null) {
                            for (MenuItem item : menuItems) { %>
                        <option value="<%= item.getId() %>"><%= item.getName() %> (#<%= item.getId() %>)</option>
                        <% }
                           } %>
                    </select>
                    <input class="form-control" name="name" placeholder="Updated Name" required />
                    <input class="form-control" name="category" placeholder="Updated Category" required />
                    <input class="form-control" name="price" type="number" step="0.01" min="0.01" placeholder="Updated Price" required />
                    <label style="display:flex;align-items:center;gap:6px;font-size:0.8rem;"><input class="toggle-check" type="checkbox" name="available" checked /> Available</label>
                    <button class="btn" type="submit">Update Item</button>
                </form>

                <form class="grid-form" action="<%= ctx %>/user/dashboard" method="post">
                    <input type="hidden" name="action" value="menu-add" />
                    <input type="hidden" name="section" value="section-menu" />
                    <input class="form-control" name="name" placeholder="New Item Name" required />
                    <input class="form-control" name="category" placeholder="Category" required />
                    <input class="form-control" name="price" type="number" step="0.01" min="0.01" placeholder="Price" required />
                    <label style="display:flex;align-items:center;gap:6px;font-size:0.8rem;"><input class="toggle-check" type="checkbox" name="available" checked /> Available</label>
                    <button class="btn success" type="submit">Add Item</button>
                </form>
            </section>

            <section class="panel <%= "section-cart".equals(activeSection) ? "active" : "" %>">
                <div class="panel-head">
                    <h2>Add To Cart</h2>
                    <span class="chip">Cart CRUD + Checkout</span>
                </div>

                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Qty</th>
                                <th>Unit Price</th>
                                <th>Total</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (cartItems == null || cartItems.isEmpty()) { %>
                            <tr><td colspan="5" class="empty">Cart is empty.</td></tr>
                            <% } else {
                                for (CartItem item : cartItems) { %>
                            <tr>
                                <td><%= item.getProductName() %></td>
                                <td>
                                    <form action="<%= ctx %>/user/dashboard" method="post" style="display:flex;gap:6px;align-items:center;">
                                        <input type="hidden" name="action" value="cart-update" />
                                        <input type="hidden" name="section" value="section-cart" />
                                        <input type="hidden" name="menuItemId" value="<%= item.getMenuItemId() %>" />
                                        <input class="inline-input" style="max-width:90px;" name="quantity" type="number" min="1" value="<%= item.getQuantity() %>" required />
                                        <button class="btn" type="submit">Update</button>
                                    </form>
                                </td>
                                <td>Rs <%= fmt(item.getUnitPrice()) %></td>
                                <td>Rs <%= fmt(item.getTotal()) %></td>
                                <td>
                                    <form action="<%= ctx %>/user/dashboard" method="post">
                                        <input type="hidden" name="action" value="cart-remove" />
                                        <input type="hidden" name="section" value="section-cart" />
                                        <input type="hidden" name="menuItemId" value="<%= item.getMenuItemId() %>" />
                                        <button class="btn warn" type="submit">Remove</button>
                                    </form>
                                </td>
                            </tr>
                            <% }
                            } %>
                        </tbody>
                    </table>
                </div>

                <form class="grid-form" action="<%= ctx %>/user/dashboard" method="post">
                    <input type="hidden" name="action" value="cart-add" />
                    <input type="hidden" name="section" value="section-cart" />
                    <select class="form-control" name="menuItemId" required>
                        <option value="">Select Menu Item</option>
                        <% if (menuItems != null) {
                            for (MenuItem item : menuItems) {
                                if (!item.isAvailable()) {
                                    continue;
                                }
                        %>
                        <option value="<%= item.getId() %>"><%= item.getName() %> - Rs <%= fmt(item.getPrice()) %></option>
                        <%  }
                           } %>
                    </select>
                    <input class="form-control" name="quantity" type="number" min="1" value="1" required />
                    <div style="font-size:0.82rem;color:var(--dash-muted);display:flex;align-items:center;">Cart Total: Rs <b style="margin-left:4px;"><%= fmt(cartTotal) %></b></div>
                    <button class="btn success" type="submit">Add To Cart</button>
                </form>
                <form action="<%= ctx %>/user/dashboard" method="post" style="margin-top:8px;">
                    <input type="hidden" name="action" value="order-place" />
                    <input type="hidden" name="section" value="section-cart" />
                    <button class="btn" type="submit">Place Order</button>
                </form>
            </section>

            <section class="panel <%= "section-track".equals(activeSection) ? "active" : "" %>">
                <div class="panel-head">
                    <h2>Track Orders</h2>
                    <span class="chip">Placed -> Confirmed -> Cooking -> Out For Delivery -> Delivered</span>
                </div>

                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Items</th>
                                <th>Total</th>
                                <th>Created</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (orders == null || orders.isEmpty()) { %>
                            <tr><td colspan="6" class="empty">No orders yet. Place an order from cart.</td></tr>
                            <% } else {
                                for (OrderRecord order : orders) {
                                    String statusClass = "progress";
                                    if ("Placed".equals(order.getStatus())) {
                                        statusClass = "placed";
                                    } else if ("Delivered".equals(order.getStatus())) {
                                        statusClass = "done";
                                    }
                            %>
                            <tr>
                                <td><%= order.getOrderId() %></td>
                                <td><%= order.getItemCount() %></td>
                                <td>Rs <%= fmt(order.getTotalAmount()) %></td>
                                <td><%= order.getCreatedAt() %></td>
                                <td><span class="status <%= statusClass %>"><%= order.getStatus() %></span></td>
                                <td>
                                    <% if (!"Delivered".equals(order.getStatus())) { %>
                                    <form action="<%= ctx %>/user/dashboard" method="post">
                                        <input type="hidden" name="action" value="order-advance" />
                                        <input type="hidden" name="section" value="section-track" />
                                        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>" />
                                        <button class="btn" type="submit">Next Status</button>
                                    </form>
                                    <% } else { %>
                                    <span style="font-size:0.78rem;color:var(--dash-success);font-weight:700;">Completed</span>
                                    <% } %>
                                </td>
                            </tr>
                            <% }
                            } %>
                        </tbody>
                    </table>
                </div>
            </section>

            <section class="panel <%= "section-profile".equals(activeSection) ? "active" : "" %>">
                <div class="panel-head">
                    <h2>Profile Settings</h2>
                    <span class="chip">User Update</span>
                </div>

                <form class="stack-form" action="<%= ctx %>/user/dashboard" method="post">
                    <input type="hidden" name="action" value="profile-update" />
                    <input type="hidden" name="section" value="section-profile" />

                    <label>Full Name</label>
                    <input class="form-control" name="fullName" value="<%= displayName %>" required />

                    <label>Email (from login)</label>
                    <input class="form-control" value="<%= safe(userEmail) %>" disabled />

                    <label>Phone</label>
                    <input class="form-control" name="phone" value="<%= safe(userPhone) %>" placeholder="Phone number" />

                    <label>Address</label>
                    <input class="form-control" name="address" value="<%= safe(userAddress) %>" placeholder="Address" />

                    <button class="btn success" type="submit">Save Profile</button>
                </form>
            </section>
        </main>
    </div>

    <script>
        (function () {
            var toggle = document.getElementById("mobileNavToggle");
            var sidebar = document.getElementById("dashSidebar");
            if (toggle && sidebar) {
                toggle.addEventListener("click", function () {
                    sidebar.classList.toggle("open");
                });
            }
        })();
    </script>
</body>
</html>

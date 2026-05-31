package com.resturent.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.resturent.model.CartItem;
import com.resturent.model.MenuItem;
import com.resturent.model.OrderRecord;

@WebServlet("/user/dashboard")
public class UserDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String KEY_MENU = "dashboardMenuItems";
    private static final String KEY_CART = "dashboardCartItems";
    private static final String KEY_ORDERS = "dashboardOrders";
    private static final String KEY_FLASH_MESSAGE = "dashboardFlashMessage";
    private static final String KEY_FLASH_TYPE = "dashboardFlashType";
    private static final String KEY_PROFILE_PHONE = "userPhone";
    private static final String KEY_PROFILE_ADDRESS = "userAddress";

    private static final String[] ORDER_STATUSES = {
            "Placed", "Confirmed", "Cooking", "Out For Delivery", "Delivered"
    };

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String ctx = request.getContextPath();

        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(ctx + "/login.jsp?error=auth");
            return;
        }

        @SuppressWarnings("unchecked")
        List<MenuItem> menuItems = (List<MenuItem>) session.getAttribute(KEY_MENU);
        if (menuItems == null) {
            menuItems = defaultMenuItems();
            session.setAttribute(KEY_MENU, menuItems);
        }

        @SuppressWarnings("unchecked")
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute(KEY_CART);
        if (cartItems == null) {
            cartItems = new ArrayList<CartItem>();
            session.setAttribute(KEY_CART, cartItems);
        }

        @SuppressWarnings("unchecked")
        List<OrderRecord> orders = (List<OrderRecord>) session.getAttribute(KEY_ORDERS);
        if (orders == null) {
            orders = new ArrayList<OrderRecord>();
            session.setAttribute(KEY_ORDERS, orders);
        }

        String activeSection = trimToEmpty(request.getParameter("s"));
        if (!isValidSection(activeSection)) {
            activeSection = "section-dashboard";
        }

        request.setAttribute("activeSection", activeSection);
        request.setAttribute("menuItems", menuItems);
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("orders", orders);
        request.setAttribute("menuCount", Integer.valueOf(menuItems.size()));
        request.setAttribute("cartCount", Integer.valueOf(totalCartQuantity(cartItems)));
        request.setAttribute("orderCount", Integer.valueOf(orders.size()));
        request.setAttribute("activeOrderCount", Integer.valueOf(activeOrderCount(orders)));
        request.setAttribute("cartTotal", Double.valueOf(cartTotal(cartItems)));
        request.setAttribute("userPhone", session.getAttribute(KEY_PROFILE_PHONE));
        request.setAttribute("userAddress", session.getAttribute(KEY_PROFILE_ADDRESS));

        Object flashMessage = session.getAttribute(KEY_FLASH_MESSAGE);
        Object flashType = session.getAttribute(KEY_FLASH_TYPE);
        if (flashMessage != null) {
            request.setAttribute("flashMessage", String.valueOf(flashMessage));
            request.setAttribute("flashType", flashType == null ? "info" : String.valueOf(flashType));
            session.removeAttribute(KEY_FLASH_MESSAGE);
            session.removeAttribute(KEY_FLASH_TYPE);
        }

        request.getRequestDispatcher("/user-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String ctx = request.getContextPath();

        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(ctx + "/login.jsp?error=auth");
            return;
        }

        @SuppressWarnings("unchecked")
        List<MenuItem> menuItems = (List<MenuItem>) session.getAttribute(KEY_MENU);
        if (menuItems == null) {
            menuItems = defaultMenuItems();
            session.setAttribute(KEY_MENU, menuItems);
        }

        @SuppressWarnings("unchecked")
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute(KEY_CART);
        if (cartItems == null) {
            cartItems = new ArrayList<CartItem>();
            session.setAttribute(KEY_CART, cartItems);
        }

        @SuppressWarnings("unchecked")
        List<OrderRecord> orders = (List<OrderRecord>) session.getAttribute(KEY_ORDERS);
        if (orders == null) {
            orders = new ArrayList<OrderRecord>();
            session.setAttribute(KEY_ORDERS, orders);
        }

        String action = trimToEmpty(request.getParameter("action"));
        String section = trimToEmpty(request.getParameter("section"));
        if (!isValidSection(section)) {
            section = "section-dashboard";
        }

        try {
            if ("menu-add".equals(action)) {
                handleMenuAdd(request, menuItems);
                setFlash(session, "Menu item added.", "success");
                section = "section-menu";
            } else if ("menu-update".equals(action)) {
                handleMenuUpdate(request, menuItems);
                setFlash(session, "Menu item updated.", "success");
                section = "section-menu";
            } else if ("menu-delete".equals(action)) {
                handleMenuDelete(request, menuItems, cartItems);
                setFlash(session, "Menu item deleted.", "success");
                section = "section-menu";
            } else if ("cart-add".equals(action)) {
                handleCartAdd(request, menuItems, cartItems);
                setFlash(session, "Item added to cart.", "success");
                section = "section-cart";
            } else if ("cart-update".equals(action)) {
                handleCartUpdate(request, cartItems);
                setFlash(session, "Cart item updated.", "success");
                section = "section-cart";
            } else if ("cart-remove".equals(action)) {
                handleCartRemove(request, cartItems);
                setFlash(session, "Cart item removed.", "success");
                section = "section-cart";
            } else if ("order-place".equals(action)) {
                handlePlaceOrder(cartItems, orders);
                setFlash(session, "Order placed successfully.", "success");
                section = "section-track";
            } else if ("order-advance".equals(action)) {
                handleAdvanceOrder(request, orders);
                setFlash(session, "Order status moved to next stage.", "success");
                section = "section-track";
            } else if ("profile-update".equals(action)) {
                handleProfileUpdate(request, session);
                setFlash(session, "Profile updated.", "success");
                section = "section-profile";
            }
        } catch (IllegalArgumentException ex) {
            setFlash(session, ex.getMessage(), "error");
        } catch (Exception ex) {
            log("Dashboard action failed: " + action, ex);
            setFlash(session, "Action failed due to server error.", "error");
        }

        response.sendRedirect(ctx + "/user/dashboard?s=" + section);
    }

    private List<MenuItem> defaultMenuItems() {
        List<MenuItem> items = new ArrayList<MenuItem>();
        items.add(new MenuItem(1, "Veg Burger", "Burger", 129.0, true));
        items.add(new MenuItem(2, "Paneer Pizza", "Pizza", 239.0, true));
        items.add(new MenuItem(3, "French Fries", "Snacks", 99.0, true));
        items.add(new MenuItem(4, "Chocolate Shake", "Drink", 149.0, true));
        return items;
    }

    private void handleMenuAdd(HttpServletRequest request, List<MenuItem> menuItems) {
        String name = trimToEmpty(request.getParameter("name"));
        String category = trimToEmpty(request.getParameter("category"));
        double price = parsePositivePrice(request.getParameter("price"), "Enter valid menu price.");
        boolean available = "on".equalsIgnoreCase(trimToEmpty(request.getParameter("available")));

        if (name.isEmpty() || category.isEmpty()) {
            throw new IllegalArgumentException("Menu name and category are required.");
        }

        int nextId = 1;
        for (MenuItem item : menuItems) {
            if (item.getId() >= nextId) {
                nextId = item.getId() + 1;
            }
        }

        menuItems.add(new MenuItem(nextId, name, category, price, available));
    }

    private void handleMenuUpdate(HttpServletRequest request, List<MenuItem> menuItems) {
        int itemId = parseInt(request.getParameter("itemId"), "Invalid menu item id.");
        String name = trimToEmpty(request.getParameter("name"));
        String category = trimToEmpty(request.getParameter("category"));
        double price = parsePositivePrice(request.getParameter("price"), "Enter valid menu price.");

        if (name.isEmpty() || category.isEmpty()) {
            throw new IllegalArgumentException("Menu name and category are required.");
        }

        MenuItem target = findMenuItem(menuItems, itemId);
        if (target == null) {
            throw new IllegalArgumentException("Menu item not found.");
        }

        target.setName(name);
        target.setCategory(category);
        target.setPrice(price);
        target.setAvailable("on".equalsIgnoreCase(trimToEmpty(request.getParameter("available"))));
    }

    private void handleMenuDelete(HttpServletRequest request, List<MenuItem> menuItems, List<CartItem> cartItems) {
        int itemId = parseInt(request.getParameter("itemId"), "Invalid menu item id.");
        MenuItem target = findMenuItem(menuItems, itemId);
        if (target == null) {
            throw new IllegalArgumentException("Menu item not found.");
        }

        Iterator<MenuItem> menuIterator = menuItems.iterator();
        while (menuIterator.hasNext()) {
            if (menuIterator.next().getId() == itemId) {
                menuIterator.remove();
            }
        }

        Iterator<CartItem> cartIterator = cartItems.iterator();
        while (cartIterator.hasNext()) {
            if (cartIterator.next().getMenuItemId() == itemId) {
                cartIterator.remove();
            }
        }
    }

    private void handleCartAdd(HttpServletRequest request, List<MenuItem> menuItems, List<CartItem> cartItems) {
        int menuItemId = parseIntWithFallback(request.getParameter("menuItemId"), -1);
        int quantity = parsePositiveInt(request.getParameter("quantity"), "Quantity must be greater than 0.");

        MenuItem selected = findMenuItem(menuItems, menuItemId);
        if (selected == null || !selected.isAvailable()) {
            throw new IllegalArgumentException("Choose an available menu item.");
        }

        for (CartItem cartItem : cartItems) {
            if (cartItem.getMenuItemId() == menuItemId) {
                cartItem.setQuantity(cartItem.getQuantity() + quantity);
                return;
            }
        }

        cartItems.add(new CartItem(menuItemId, selected.getName(), quantity, selected.getPrice()));
    }

    private void handleCartUpdate(HttpServletRequest request, List<CartItem> cartItems) {
        int menuItemId = parseInt(request.getParameter("menuItemId"), "Invalid cart item.");
        int quantity = parsePositiveInt(request.getParameter("quantity"), "Quantity must be greater than 0.");

        CartItem target = findCartItem(cartItems, menuItemId);
        if (target == null) {
            throw new IllegalArgumentException("Cart item not found.");
        }

        target.setQuantity(quantity);
    }

    private void handleCartRemove(HttpServletRequest request, List<CartItem> cartItems) {
        int menuItemId = parseInt(request.getParameter("menuItemId"), "Invalid cart item.");
        Iterator<CartItem> iterator = cartItems.iterator();
        while (iterator.hasNext()) {
            if (iterator.next().getMenuItemId() == menuItemId) {
                iterator.remove();
                return;
            }
        }
        throw new IllegalArgumentException("Cart item not found.");
    }

    private void handlePlaceOrder(List<CartItem> cartItems, List<OrderRecord> orders) {
        if (cartItems.isEmpty()) {
            throw new IllegalArgumentException("Cart is empty. Add menu items before placing order.");
        }

        int count = totalCartQuantity(cartItems);
        double total = cartTotal(cartItems);
        String orderId = "FD-" + UUID.randomUUID().toString().substring(0, 6).toUpperCase(Locale.ENGLISH);
        String createdAt = new SimpleDateFormat("dd MMM yyyy, hh:mm a", Locale.ENGLISH).format(new Date());
        orders.add(0, new OrderRecord(orderId, count, total, ORDER_STATUSES[0], createdAt));
        cartItems.clear();
    }

    private void handleAdvanceOrder(HttpServletRequest request, List<OrderRecord> orders) {
        String orderId = trimToEmpty(request.getParameter("orderId"));
        if (orderId.isEmpty()) {
            throw new IllegalArgumentException("Order id is required.");
        }

        for (OrderRecord order : orders) {
            if (!orderId.equals(order.getOrderId())) {
                continue;
            }

            for (int i = 0; i < ORDER_STATUSES.length; i++) {
                if (ORDER_STATUSES[i].equals(order.getStatus())) {
                    if (i + 1 < ORDER_STATUSES.length) {
                        order.setStatus(ORDER_STATUSES[i + 1]);
                        return;
                    }
                    throw new IllegalArgumentException("Order is already delivered.");
                }
            }

            order.setStatus(ORDER_STATUSES[0]);
            return;
        }

        throw new IllegalArgumentException("Order not found.");
    }

    private void handleProfileUpdate(HttpServletRequest request, HttpSession session) {
        String fullName = trimToEmpty(request.getParameter("fullName"));
        String phone = trimToEmpty(request.getParameter("phone"));
        String address = trimToEmpty(request.getParameter("address"));

        if (fullName.isEmpty()) {
            throw new IllegalArgumentException("Full name is required.");
        }

        session.setAttribute("userName", fullName);
        session.setAttribute(KEY_PROFILE_PHONE, phone);
        session.setAttribute(KEY_PROFILE_ADDRESS, address);
    }

    private MenuItem findMenuItem(List<MenuItem> menuItems, int menuItemId) {
        for (MenuItem menuItem : menuItems) {
            if (menuItem.getId() == menuItemId) {
                return menuItem;
            }
        }
        return null;
    }

    private CartItem findCartItem(List<CartItem> cartItems, int menuItemId) {
        for (CartItem cartItem : cartItems) {
            if (cartItem.getMenuItemId() == menuItemId) {
                return cartItem;
            }
        }
        return null;
    }

    private boolean isValidSection(String section) {
        return "section-dashboard".equals(section)
                || "section-menu".equals(section)
                || "section-cart".equals(section)
                || "section-track".equals(section)
                || "section-profile".equals(section);
    }

    private int totalCartQuantity(List<CartItem> cartItems) {
        int count = 0;
        for (CartItem item : cartItems) {
            count += item.getQuantity();
        }
        return count;
    }

    private double cartTotal(List<CartItem> cartItems) {
        double total = 0.0;
        for (CartItem item : cartItems) {
            total += item.getTotal();
        }
        return total;
    }

    private int activeOrderCount(List<OrderRecord> orders) {
        int count = 0;
        for (OrderRecord order : orders) {
            if (!"Delivered".equals(order.getStatus())) {
                count++;
            }
        }
        return count;
    }

    private String trimToEmpty(String value) {
        return value == null ? "" : value.trim();
    }

    private int parseInt(String value, String errorMessage) {
        try {
            return Integer.parseInt(trimToEmpty(value));
        } catch (Exception ex) {
            throw new IllegalArgumentException(errorMessage);
        }
    }

    private int parseIntWithFallback(String value, int fallback) {
        try {
            return Integer.parseInt(trimToEmpty(value));
        } catch (Exception ex) {
            return fallback;
        }
    }

    private int parsePositiveInt(String value, String errorMessage) {
        int parsed = parseInt(value, errorMessage);
        if (parsed <= 0) {
            throw new IllegalArgumentException(errorMessage);
        }
        return parsed;
    }

    private double parsePositivePrice(String value, String errorMessage) {
        try {
            double parsed = Double.parseDouble(trimToEmpty(value));
            if (parsed <= 0) {
                throw new IllegalArgumentException(errorMessage);
            }
            return parsed;
        } catch (NumberFormatException ex) {
            throw new IllegalArgumentException(errorMessage);
        }
    }

    private void setFlash(HttpSession session, String message, String type) {
        session.setAttribute(KEY_FLASH_MESSAGE, message);
        session.setAttribute(KEY_FLASH_TYPE, type);
    }
}

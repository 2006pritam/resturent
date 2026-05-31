package com.resturent.model;

import java.io.Serializable;

public class OrderRecord implements Serializable {

    private static final long serialVersionUID = 1L;

    private String orderId;
    private int itemCount;
    private double totalAmount;
    private String status;
    private String createdAt;

    public OrderRecord() {
    }

    public OrderRecord(String orderId, int itemCount, double totalAmount, String status, String createdAt) {
        this.orderId = orderId;
        this.itemCount = itemCount;
        this.totalAmount = totalAmount;
        this.status = status;
        this.createdAt = createdAt;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public int getItemCount() {
        return itemCount;
    }

    public void setItemCount(int itemCount) {
        this.itemCount = itemCount;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}

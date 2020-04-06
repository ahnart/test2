package com.example.dto;

import java.util.Date;

public class OrderListDTO {
	
	
	private String orderId;
	private String u_Id;
	private String orderRec;
	private String u_Addr1;
	private String u_Addr2;
	private String u_Addr3;
	private int amount;
	private Date orderDate;
	private String delivery;
	
	private int orderDetailsNum;
	private int g_no;
	private int cartStock;
	
	private String g_name;
	private String g_thum;
	private int g_price;
	
	
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getDelivery() {
		return delivery;
	}
	public void setDelivery(String delivery) {
		this.delivery = delivery;
	}
	public String getU_Id() {
		return u_Id;
	}
	public void setU_Id(String u_Id) {
		this.u_Id = u_Id;
	}
	public String getOrderRec() {
		return orderRec;
	}
	public void setOrderRec(String orderRec) {
		this.orderRec = orderRec;
	}
	public String getU_Addr1() {
		return u_Addr1;
	}
	public void setU_Addr1(String u_Addr1) {
		this.u_Addr1 = u_Addr1;
	}
	public String getU_Addr2() {
		return u_Addr2;
	}
	public void setU_Addr2(String u_Addr2) {
		this.u_Addr2 = u_Addr2;
	}
	public String getU_Addr3() {
		return u_Addr3;
	}
	public void setU_Addr3(String u_Addr3) {
		this.u_Addr3 = u_Addr3;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public int getOrderDetailsNum() {
		return orderDetailsNum;
	}
	public void setOrderDetailsNum(int orderDetailsNum) {
		this.orderDetailsNum = orderDetailsNum;
	}
	public int getG_no() {
		return g_no;
	}
	public void setG_no(int g_no) {
		this.g_no = g_no;
	}
	public int getCartStock() {
		return cartStock;
	}
	public void setCartStock(int cartStock) {
		this.cartStock = cartStock;
	}
	public String getG_name() {
		return g_name;
	}
	public void setG_name(String g_name) {
		this.g_name = g_name;
	}
	public String getG_thum() {
		return g_thum;
	}
	public void setG_thum(String g_thum) {
		this.g_thum = g_thum;
	}
	public int getG_price() {
		return g_price;
	}
	public void setG_price(int g_price) {
		this.g_price = g_price;
	}
	
    
   
}

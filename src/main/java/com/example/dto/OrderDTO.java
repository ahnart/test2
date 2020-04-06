package com.example.dto;

import java.util.Date;

public class OrderDTO {
	
	private String orderId;
	private String u_Id;
	private String orderRec;
	private String u_Addr1;
	private String u_Addr2;
	private String u_Addr3;
	private String orderPhon;
	private int amount;
	private Date orderDate;
	private String delivery;
	
	public String getDelivery() {
		return delivery;
	}
	public void setDelivery(String delivery) {
		this.delivery = delivery;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
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
	public String getOrderPhon() {
		return orderPhon;
	}
	public void setOrderPhon(String orderPhon) {
		this.orderPhon = orderPhon;
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
	
	
	
}

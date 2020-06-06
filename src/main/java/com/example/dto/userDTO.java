package com.example.dto;

import java.util.Date;

import lombok.Data;

@Data
public class userDTO {

	private int u_no;
	private String u_id;
	private String u_pw;
	private Date u_date;
	private int level;
	
	
	
//	private String uid;
//	private String upw;
//	private String uname;
//	private Integer upoint;
	
	private String email;
	private String googleid;
	private String naverid;
	private String nickname;
	
//	private String loginip;
//	private Date lastlogin;
	
//	public static void main(String[] args) {
//		userDTO user1 = new userDTO();
//		user1.setU_no(1111111);
//		user1.setU_id("adsfasfsaf1212121");
//		
//		userDTO user2 = new userDTO();
//		user2.setU_no(1111111);
//		user2.setU_id("adsfasfsaf");
//		System.out.println(user1.equals(user2));
//	}
//	
	
	
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public Date getU_date() {
		return u_date;
	}
	public void setU_date(Date u_date) {
		this.u_date = u_date;
	}
	public int getU_no() {
		return u_no;
	}
	public void setU_no(int u_no) {
		this.u_no = u_no;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getU_pw() {
		return u_pw;
	}
	public void setU_pw(String u_pw) {
		this.u_pw = u_pw;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public String getGoogleid() {
		return googleid;
	}



	public void setGoogleid(String googleid) {
		this.googleid = googleid;
	}



	public String getNaverid() {
		return naverid;
	}



	public void setNaverid(String naverid) {
		this.naverid = naverid;
	}



	public String getNickname() {
		return nickname;
	}



	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	
	
	
	
	
	
	

}

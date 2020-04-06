package com.example.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.example.dto.userDTO;

public interface MemberService {

	// 회원조회
	public List<userDTO> selectMember() throws Exception;
	
	//회원조회 view
	public List<userDTO> memberView() throws Exception;
	
	// 회원가입
	public void insert(userDTO userDTO) throws Exception;

	// 회원 삭제
	public void mDelete(userDTO userDTO) throws Exception;

	// 로그인
	public userDTO signin(userDTO userDTO) throws Exception;

	// 로그아웃
	public void signout(HttpSession httpSession) throws Exception;
	
	

//	// 로그인
//	public boolean signin(HttpServletRequest request, userDTO userDTO) throws Exception;
}

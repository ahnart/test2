package com.example.dao;

import java.util.List;

import com.example.dto.userDTO;

public interface MemberDAO {

	// 회원조회
	public List<userDTO> selectMember() throws Exception;

	// 회원조회 view
	public List<userDTO> memberView() throws Exception;

	// 회원가입
	public void insert(userDTO userDTO) throws Exception;

	// 로그인
	public userDTO signin(userDTO userDTO) throws Exception;

	// 회원 삭제
	public void mDelete(userDTO userDTO) throws Exception;

	
}

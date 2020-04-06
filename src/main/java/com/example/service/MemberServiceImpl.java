package com.example.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.MemberDAO;
import com.example.dto.userDTO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO dao;
	
	
	@Override
	public List<userDTO> selectMember() throws Exception {
		// 회원조회
		return dao.selectMember();
	}
	@Override
	public List<userDTO> memberView() throws Exception {
		// 회원조회 view
		return dao.selectMember();
	}
	
	
	@Override
	public void insert(userDTO userDTO) throws Exception {
		//회원가입
		dao.insert(userDTO);
	}

	@Override
	public void mDelete(userDTO userDTO) throws Exception {
		// 회원 삭제
		dao.mDelete(userDTO);
	}

	@Override
	public userDTO signin(userDTO userDTO) throws Exception {
		// 로그인
		return dao.signin(userDTO);
	}

	@Override
	public void signout(HttpSession httpSession) throws Exception {
		// 로그아웃
		httpSession.invalidate();
	}

	

	
	

	

	
	

}

package com.example.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.dto.userDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	
	private static final String Namespace = "memberMapper";
	


	@Override
	public void insert(userDTO userDTO) throws Exception{
		// 회원가입
		sqlSession.insert(Namespace + ".insert", userDTO);
	}
	@Override
	public void mDelete(userDTO userDTO) throws Exception {
		// 회원 삭제
		sqlSession.delete(Namespace + ".mDelete", userDTO);	
	}
	
	@Override
	public userDTO signin(userDTO userDTO) throws Exception {
		// 로그인
		return sqlSession.selectOne(Namespace + ".signin", userDTO);
	}

	
	@Override
	public List<userDTO> memberView() throws Exception {
		// 회우너리스트 view
		return sqlSession.selectList(Namespace + ".selectMember");
	}
	@Override
	public List<userDTO> selectMember() throws Exception {
		//회원리스트 보기
		return sqlSession.selectList(Namespace + ".selectMember");
	}
	

	

	


	
	
	












	

}

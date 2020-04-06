package com.example.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.dto.CartDTO;
import com.example.dto.CartListDTO;
import com.example.dto.OrderDTO;
import com.example.dto.OrderDetailsDTO;
import com.example.dto.OrderListDTO;
import com.example.dto.goodsViewDTO;
import com.example.dto.replyDTO;
import com.example.dto.replyListDTO;


@Repository
public class shopDAOImpl implements shopDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String Namespace = "memberMapper";
	
	@Override
	public void registReply(replyDTO replyDTO) throws Exception {
		// 후기글 작성
		sqlSession.insert(Namespace + ".registReply", replyDTO);
	}

	@Override
	public goodsViewDTO goodsView(int g_no) throws Exception {
		// 상품조회 user
		return sqlSession.selectOne(Namespace + ".view", g_no);
	}
	
	@Override
	public List<replyListDTO> replyList(int g_no) throws Exception {
		// 상품소감 리스트
		return sqlSession.selectList(Namespace + ".replyList", g_no);
	}
	
	@Override
	public void deleteReply(replyDTO replyDTO) throws Exception {
		// 소감글 삭제
		sqlSession.delete(Namespace + ".deleteReply", replyDTO);
	}
	
	@Override
	public String idCheck(int reNum) throws Exception {
		// 소감글 ID 체크
		return sqlSession.selectOne(Namespace + ".replyUserCheck", reNum);
	}

	@Override
	public void modifyReply(replyDTO replyDTO) throws Exception {
		// 소감글 수정
		sqlSession.update(Namespace + ".modifyReply", replyDTO);
		
	}
	
	
	@Override
	public void addCart(CartDTO cartDTO) throws Exception {
		// 카트담기
		sqlSession.insert(Namespace + ".addCart", cartDTO);
	}

	@Override
	public List<CartListDTO> cartList(String u_Id) throws Exception {
		// 카트 리스트
		return sqlSession.selectList(Namespace + ".cartList", u_Id);
	}

	@Override
	public void deleteCart(CartDTO cartDTO) throws Exception {
		// 카트 삭제
		sqlSession.delete(Namespace + ".deleteCart", cartDTO);
	}

	
	
	@Override
	public void orderInfo(OrderDTO order) throws Exception {
		// 주문 정보
		sqlSession.insert(Namespace + ".orderInfo", order);
	}

	@Override
	public void orderInfo_Details(OrderDetailsDTO orderDetails) throws Exception {
		// 주문 정보 상세
		sqlSession.insert(Namespace + ".orderInfo_Details", orderDetails);
	}

	@Override
	public void cartAllDelete(String u_Id) throws Exception {
		// 장바구니 비우기
		sqlSession.delete(Namespace + ".cartAllDelete", u_Id);
	}
	
	@Override
	public List<OrderDTO> orderList(OrderDTO order) throws Exception {
		// 주문 목록
		return sqlSession.selectList(Namespace + ".orderList", order);
	}

	@Override
	public List<OrderListDTO> orderView(OrderDTO order) throws Exception {
		// 주문목록 상세
		return sqlSession.selectList(Namespace + ".orderView", order);
	}
	
	
	
	
	
	
	
	
	
}

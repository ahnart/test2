package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.shopDAO;
import com.example.dto.CartDTO;
import com.example.dto.CartListDTO;
import com.example.dto.OrderDTO;
import com.example.dto.OrderDetailsDTO;
import com.example.dto.OrderListDTO;
import com.example.dto.goodsViewDTO;
import com.example.dto.replyDTO;
import com.example.dto.replyListDTO;

@Service
public class shopServiceImpl implements shopService {
	
	@Autowired
	private shopDAO sDao;
	
	
	@Override
	public void registReply(replyDTO replyDTO) throws Exception {
		// 후기글 작성
		sDao.registReply(replyDTO);
	}

	@Override
	public goodsViewDTO goodsView(int g_no) throws Exception {
		// 상품조회 user
		return sDao.goodsView(g_no);
	}


	@Override
	public List<replyListDTO> replyList(int g_no) throws Exception {
		// 상품소감 리스트
		return sDao.replyList(g_no);
	}
	@Override
	public void addCart(CartDTO cartDTO) throws Exception {
		// 카트담기
		sDao.addCart(cartDTO);
	}
	@Override
	public List<CartListDTO> cartList(String u_Id) throws Exception {
		// 카트 리스트
		return sDao.cartList(u_Id);
	}


	@Override
	public void deleteReply(replyDTO replyDTO) throws Exception {
		// 소감글 삭제
		sDao.deleteReply(replyDTO);
	}
	@Override
	public String idCheck(int reNum) throws Exception {
		// 소감글 ID 체크
		return sDao.idCheck(reNum);
	}
	@Override
	public void modifyReply(replyDTO replyDTO) throws Exception {
		// 소감글 수정
		sDao.modifyReply(replyDTO);
	}
	@Override
	public void deleteCart(CartDTO cartDTO) throws Exception {
		// 카트 삭제
		sDao.deleteCart(cartDTO);
	}
	
	
	
	@Override
	public void orderInfo(OrderDTO order) throws Exception {
		// 주문 정보
		sDao.orderInfo(order);
	}
	@Override
	public void orderInfo_Details(OrderDetailsDTO orderDetails) throws Exception {
		// 주문 정보 상세
		sDao.orderInfo_Details(orderDetails);
	}
	@Override
	public void cartAllDelete(String u_Id) throws Exception {
		// 장바구니 비우기
		sDao.cartAllDelete(u_Id);
	}
	@Override
	public List<OrderDTO> orderList(OrderDTO order) throws Exception {
		// 주문 목록
		return sDao.orderList(order);
	}
	@Override
	public List<OrderListDTO> orderView(OrderDTO order) throws Exception {
		// 주문목록 상세
		return sDao.orderView(order);
	}
	
	
	
}

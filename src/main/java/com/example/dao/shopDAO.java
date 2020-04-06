package com.example.dao;

import java.util.List;

import com.example.dto.CartDTO;
import com.example.dto.CartListDTO;
import com.example.dto.OrderDTO;
import com.example.dto.OrderDetailsDTO;
import com.example.dto.OrderListDTO;
import com.example.dto.goodsViewDTO;
import com.example.dto.replyDTO;
import com.example.dto.replyListDTO;

public interface shopDAO {

	// 소감글 작성
	public void registReply(replyDTO replyDTO) throws Exception;

	// 소감글 삭제
	public void deleteReply(replyDTO replyDTO) throws Exception;

	// 소감글 수정
	public void modifyReply(replyDTO replyDTO) throws Exception;

	// 소감글 ID체크
	public String idCheck(int reNum) throws Exception;

	// 상품조회 user
	public goodsViewDTO goodsView(int g_no) throws Exception;

	// 상품평 리스트 조회
	public List<replyListDTO> replyList(int g_no) throws Exception;
	
	
	
	// 카트 리스트
	public List<CartListDTO> cartList(String u_Id) throws Exception;
	
	// 카트담기
	public void addCart(CartDTO cartDTO) throws Exception;
	
	// 카트 삭제
	public void deleteCart(CartDTO cartDTO) throws Exception;
	
	
	
	
	//주문 정보
	public void orderInfo(OrderDTO order) throws Exception;
	
	//주문 상세정보
	public void orderInfo_Details(OrderDetailsDTO orderDetails) throws Exception;
	
	//장바구니 비우기
	public void cartAllDelete(String u_Id) throws Exception;
	
	//주문목록
	public List<OrderDTO> orderList(OrderDTO order) throws Exception;
	
	//주문목록 상세
	public List<OrderListDTO> orderView(OrderDTO order) throws Exception;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

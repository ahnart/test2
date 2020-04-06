package com.example.service;

import java.util.List;

import com.example.dto.OrderDTO;
import com.example.dto.OrderListDTO;
import com.example.dto.categoryDTO;
import com.example.dto.goodsDTO;
import com.example.dto.replyListDTO;

public interface adminService {

	// 상품등록
	public void register(goodsDTO goodsDTO) throws Exception;

	// 상품리스트 보기
	public List<goodsDTO> goodslist() throws Exception;

	// 게시물 삭제
	public void gDelete(goodsDTO goodsDTO) throws Exception;
	
	// 게시물 상세보기
	public goodsDTO view(int g_no) throws Exception;
	
	// 상품 게시물 수정
	public void gModify(goodsDTO goodsDTO) throws Exception;

	// 상품 게시물 갯수
	public int count() throws Exception;

	// 상품 리스트 페이지
	public List<goodsDTO> listPage(int displayPost, int postNum) throws Exception;

	// 카테고리
	public List<categoryDTO> category() throws Exception;
	
	//주문목록 관리자
	public List<OrderDTO> aorderList() throws Exception;
	
	//주문목록 관리자 상세
	public List<OrderListDTO> aorderView(OrderDTO order) throws Exception;
	
	//주문 상태
	public void delivery(OrderDTO order) throws Exception;
	
	
	//상품 수량 조절
	public void changeStock(goodsDTO goods) throws Exception;
	
	
	//상품 전체 소감댓글 확인
	public List<replyListDTO> allReply() throws Exception;
	
	//상품 전체 댓글 삭제
	public void deleteReply(int reNum) throws Exception;
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
}

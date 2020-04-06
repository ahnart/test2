package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.adminDAO;
import com.example.dto.OrderDTO;
import com.example.dto.OrderListDTO;
import com.example.dto.categoryDTO;
import com.example.dto.goodsDTO;
import com.example.dto.replyListDTO;

@Service
public class adminServiceImpl implements adminService {
	
	@Autowired
	private adminDAO aDao;
	
	@Override
	public void register(goodsDTO goodsDTO) throws Exception {
		// 상품등록
		aDao.register(goodsDTO);
		
	}

	@Override
	public List<goodsDTO> goodslist() throws Exception {
		// 상품리스트 보기
		System.out.println("상품리스트 보기");
		return aDao.goodslist();
	}

	@Override
	public void gDelete(goodsDTO goodsDTO) throws Exception {
		// 상품 게시물 삭제
		aDao.gDelete(goodsDTO);
	}

	@Override
	public goodsDTO view(int g_no) throws Exception {
		// 상품 상세보기
		return aDao.view(g_no);
	}
	
	
	
	@Override
	public void gModify(goodsDTO goodsDTO) throws Exception {
		// 상품 게시물 수정
		aDao.gModify(goodsDTO);
	}

	@Override
	public int count() throws Exception {
		// //상품 게시물 갯수
		return aDao.count();
	}

	@Override
	public List<goodsDTO> listPage(int displayPost, int postNum) throws Exception {
		// 상품리스트 패이징
		return aDao.listPage(displayPost, postNum);
	}

	@Override
	public List<categoryDTO> category() throws Exception {
		// 카테고리
		return aDao.category();
	}

	@Override
	public List<OrderDTO> aorderList() throws Exception {
		// 주문목록 
		return aDao.aorderList();
	}
	
	@Override
	public List<OrderListDTO> aorderView(OrderDTO order) throws Exception {
		// 주문목록 상세
		return aDao.aorderView(order);
	}

	@Override
	public void delivery(OrderDTO order) throws Exception {
		// 주문 상태
		aDao.delivery(order);
	}

	@Override
	public void changeStock(goodsDTO goods) throws Exception {
		// 상품 수량 조절
		aDao.changeStock(goods);
	}

	@Override
	public List<replyListDTO> allReply() throws Exception {
		// 상품 전채 소감 댓글 확인
		return aDao.allReply();
	}

	@Override
	public void deleteReply(int reNum) throws Exception {
		// 상품 소감 댓글 전채 삭제
		aDao.deleteReply(reNum);
	}
	
	
}

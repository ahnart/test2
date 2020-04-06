package com.example.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.dto.OrderDTO;
import com.example.dto.OrderListDTO;
import com.example.dto.categoryDTO;
import com.example.dto.goodsDTO;
import com.example.dto.replyListDTO;

@Repository
public class adminDAOImpl implements adminDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "memberMapper";

	@Override
	public void register(goodsDTO goodsDTO) throws Exception {
		// 상품등록
		sqlSession.insert(Namespace + ".register", goodsDTO);
	}

	@Override
	public List<goodsDTO> goodslist() throws Exception {
		// 상품리스트 보기
		return sqlSession.selectList(Namespace + ".g_list");
	}

	@Override
	public void gDelete(goodsDTO goodsDTO) throws Exception {
		// 상품 게시물 삭제
		sqlSession.delete(Namespace + ".gDelete", goodsDTO);
	}

	@Override
	public void gModify(goodsDTO goodsDTO) throws Exception {
		// 상품 게시물 수정
		sqlSession.update(Namespace + ".gModify", goodsDTO);
	}

	@Override
	public goodsDTO view(int g_no) throws Exception {
		// 상품 상세 보기
		return sqlSession.selectOne(Namespace + ".view", g_no);
	}

	@Override
	public int count() throws Exception {
		// 게시물 갯수
		return sqlSession.selectOne(Namespace + ".count");
	}

	@Override
	public List<goodsDTO> listPage(int displayPost, int postNum) throws Exception {
		// 상품리스트 패이징
		HashMap<String, Integer> data = new HashMap<String, Integer>();
		data.put("displayPost", displayPost);
		data.put("postNum", postNum);

		return sqlSession.selectList(Namespace + ".listPage", data);
	}

	@Override
	public List<categoryDTO> category() throws Exception {
		// 상품 카테고리 조인
		return sqlSession.selectList(Namespace + ".category");
	}

	@Override
	public List<OrderDTO> aorderList() throws Exception {
		// 주문목록
		return sqlSession.selectList(Namespace + ".aorderList");
	}

	@Override
	public List<OrderListDTO> aorderView(OrderDTO order) throws Exception {
		// 주문목록 상세
		return sqlSession.selectList(Namespace + ".aorderView", order);
	}

	@Override
	public void delivery(OrderDTO order) throws Exception {
		// 주문 상태
		sqlSession.update(Namespace + ".delivery", order);
	}

	@Override
	public void changeStock(goodsDTO goods) throws Exception {
		// 상품 수량 조절
		sqlSession.update(Namespace + ".changeStock", goods);
	}

	@Override
	public List<replyListDTO> allReply() throws Exception {
		// 상품 전체 소감 댓글 확인
		return sqlSession.selectList(Namespace + ".allReply");
	}

	@Override
	public void deleteReply(int reNum) throws Exception {
		// 상품 전체 소감 댓글 삭제
		sqlSession.delete(Namespace + ".deleteAllReply", reNum);
		
	}

}

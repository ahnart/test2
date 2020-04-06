package com.example.coco;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dto.OrderDTO;
import com.example.dto.OrderListDTO;
import com.example.dto.goodsDTO;
import com.example.dto.replyDTO;
import com.example.dto.replyListDTO;
import com.example.dto.userDTO;
import com.example.service.adminService;

@Controller
@RequestMapping("/user/admin/*")
public class AdminController {
	
	@Autowired
	private adminService aService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	//주문 목록 관리자
	@RequestMapping(value = "/orderList", method = RequestMethod.GET)
	public void getOrderList(Model model) throws Exception{
		logger.info("get order LIST ----------ADMIN ");
		
		List<OrderDTO> orderList = aService.aorderList();
		
		model.addAttribute("aorderList", orderList);
	}
	
	//주문목록 상세 관리자
	@RequestMapping(value = "/orderView", method = RequestMethod.GET)
	public void getOrderList(@RequestParam("n")String orderId, OrderDTO order, Model model) throws Exception{
		logger.info("get order VIEW ----------ADMIN ");
		
		order.setOrderId(orderId);
		List<OrderListDTO> orderView = aService.aorderView(order);
		
		model.addAttribute("aorderView", orderView);
	}
	
	//주문 상태		 -상태 변경 추가
	@RequestMapping(value = "/orderView", method = RequestMethod.POST)
	public String delivery(OrderDTO order) throws Exception{
		logger.info("get order VIEW ----------ADMIN ");
		
		aService.delivery(order);
		
		List<OrderListDTO> aorderView = aService.aorderView(order);
		goodsDTO goods = new goodsDTO();
		
		for(OrderListDTO i : aorderView) {
			goods.setG_no(i.getG_no());
			goods.setG_amount(i.getCartStock());
			aService.changeStock(goods);
		}
		
		return "redirect:/user/admin/orderView?n=" + order.getOrderId();
	}
	
	
	
	//상품  전채 소감 전체 댓글 출력
	@RequestMapping(value = "/allReply", method = RequestMethod.GET)
	public void getAllReply(Model model) throws Exception{
		logger.info("get All Reply List ----------ADMIN ");
		
		List<replyListDTO> replyAll = aService.allReply();
		
		model.addAttribute("replyAll", replyAll);
	}
	
	
//	@RequestMapping(value = "/allReply", method = RequestMethod.POST)
//	public String postAllReply(replyDTO reply) throws Exception {
//		logger.info("Post All Reply List ----------ADMIN ");
//		
//		aService.deleteReply(reply.getReNum());
//		return "redirect:/user/admin/allReply";
//	}
	
	
	// 상품 게시물 삭제
	@RequestMapping(value = "/deleteReply", method = RequestMethod.GET)
	public String deleteReply(replyDTO reply, int reNum) throws Exception {
			
		aService.deleteReply(reNum);
		return "redirect:/user/admin/allReply";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

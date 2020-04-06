package com.example.coco;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.CartDTO;
import com.example.dto.CartListDTO;
import com.example.dto.OrderDTO;
import com.example.dto.OrderDetailsDTO;
import com.example.dto.OrderListDTO;
import com.example.dto.goodsViewDTO;
import com.example.dto.replyDTO;
import com.example.dto.replyListDTO;
import com.example.dto.userDTO;
import com.example.service.shopService;


@Controller
public class shopController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private shopService sService;
	

	
	// 상품 조회 user
		@RequestMapping(value = "/goods/view", method = RequestMethod.GET)
		public void getGoodsview(@RequestParam("n") int g_no, Model model) throws Exception {
			logger.info("get goods view");
			
			goodsViewDTO view = sService.goodsView(g_no);
			model.addAttribute("view", view);
		}
		
		
		
	// 상품후기 작성
	@ResponseBody
	@RequestMapping(value = "/user/goods/view/registReply", method = RequestMethod.POST)
	public void registReply(replyDTO replyDTO, HttpSession httpSession) throws Exception {
		
		logger.info("=========regist reply");
		
		userDTO userDTO = (userDTO) httpSession.getAttribute("member");
		replyDTO.setU_Id(userDTO.getU_id());
		
		sService.registReply(replyDTO);
		
//		return "redirect:/user/goods/view?n=" + replyDTO.getG_no();
	}
	
	
	// 상품 소감(댓글) 목록
	@ResponseBody
	@RequestMapping(value = "/user/goods/view/replyList", method = RequestMethod.GET)
	public List<replyListDTO> getReplyList(@RequestParam("n") int g_no) throws Exception {
	 logger.info("======== get reply list");
	 
	 List<replyListDTO> reply = sService.replyList(g_no);
	 
	 return reply;
	}
	
	
	
	
	//카트담기
	@ResponseBody
	@RequestMapping(value = "/user/goods/view/addCart", method = RequestMethod.POST)
	public int addCart(CartDTO cartDTO, HttpSession httpSession) throws Exception{
		
		logger.info("========= addCart");
		
		int result = 0;
		
		userDTO userDTO = (userDTO) httpSession.getAttribute("member");
		
		if (userDTO != null) {
			cartDTO.setU_Id(userDTO.getU_id());
			sService.addCart(cartDTO);
			result = 1;
		}
		
		return result;
		
	}
	
	// 카트 목록
	@RequestMapping(value = "/user/goods/cart_list", method = RequestMethod.GET)
	public void getCartList(HttpSession session, Model model) throws Exception{
		logger.info("========= get CartList");
		
		userDTO member = (userDTO)session.getAttribute("member");
		String u_Id = member.getU_id();
		
		List<CartListDTO> cartList = sService.cartList(u_Id);
		
		model.addAttribute("cartList", cartList);
	}
	
	//카트 삭제
	@ResponseBody
	@RequestMapping(value = "/user/goods/cart_list/deleteCart", method = RequestMethod.POST)
	public int deleteCart(HttpSession session, @RequestParam(value ="chbax[]") List<String> chArr, CartDTO cartDTO) throws Exception{
		logger.info("========= go deleteCart");
		
		userDTO member = (userDTO)session.getAttribute("member");
		String u_Id = member.getU_id();
		
		int result = 0;
		int cartNum = 0;
		
		if(member != null) {
			cartDTO.setU_Id(u_Id);
			
			for(String i :chArr) {
				cartNum = Integer.parseInt(i);
				cartDTO.setCartNum(cartNum);
				sService.deleteCart(cartDTO);
			}
			result = 1;
		}
		return result;
	}
	
	
	
	
	
	
	// 상품 후기글 삭제
	@ResponseBody
	@RequestMapping(value = "/user/goods/view/deleteReply", method = RequestMethod.POST)
	public int getReplyList(replyDTO replyDTO, HttpSession session) throws Exception{
		logger.info("========= get delete Reply");
		
		int result = 0;
		
		userDTO member = (userDTO)session.getAttribute("member");
		String u_Id = sService.idCheck(replyDTO.getReNum());
		
		if (member.getU_id().equals(u_Id)) {
			replyDTO.setU_Id(member.getU_id());
			sService.deleteReply(replyDTO);
			
			result = 1;
		}
		
		return result;
		
	}
	
	
	// 상품 후기글 수정
	@ResponseBody
	@RequestMapping(value = "/user/goods/view/modifyReply", method = RequestMethod.POST)
	public int modifyReply(replyDTO replyDTO, HttpSession session) throws Exception{
		logger.info("========= get modify Reply");
		
		int result = 0;
		
		userDTO member = (userDTO)session.getAttribute("member");
		String u_Id = sService.idCheck(replyDTO.getReNum());
		
		if (member.getU_id().equals(u_Id)){
			
			replyDTO.setU_Id(member.getU_id());
			sService.modifyReply(replyDTO);
			result = 1;
		}
		return result;
		
	}
	
	
	
	//주문
	@RequestMapping(value = "/user/goods/cart_list" , method = RequestMethod.POST)
	public String order(HttpSession session, OrderDTO order, OrderDetailsDTO orderDetails) throws Exception{
		logger.info("========= order");
		
		userDTO member = (userDTO) session.getAttribute("member");
		String u_Id = member.getU_id();
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		String subNum = "";
		
		for (int i = 1; i <= 6; i++) {
			subNum += (int)(Math.random() * 10);
		}
		String orderId = ymd + "_" + subNum;
		
		order.setOrderId(orderId);
		order.setU_Id(u_Id);
		
		sService.orderInfo(order);
		orderDetails.setOrderId(orderId);
		sService.orderInfo_Details(orderDetails);
		
		sService.cartAllDelete(u_Id);
		return "redirect:/user/goods/cart_list";
	}
	
	
	
	//주문 목록
	@RequestMapping(value = "/user/goods/orderList", method = RequestMethod.GET)
	public void getOrderList(HttpSession session, OrderDTO order, Model model) throws Exception{
		logger.info("========= Get order LIST");
		
		userDTO member = (userDTO) session.getAttribute("member");
		String u_Id = member.getU_id();
		
		order.setU_Id(u_Id);
		
		List<OrderDTO> orderList = sService.orderList(order);
		model.addAttribute("orderList", orderList);
	}
	
	//주문목록 상세
	@RequestMapping(value = "/user/goods/orderView")
	public void getOrderList(HttpSession session, @RequestParam("n") String orderId, OrderDTO order, Model model) throws Exception{
		logger.info("========= Get order LIST VIEW");
		
		userDTO member = (userDTO) session.getAttribute("member");
		String u_Id = member.getU_id();
		order.setU_Id(u_Id);
		order.setOrderId(orderId);
		
		List<OrderListDTO> orderView = sService.orderView(order);
		model.addAttribute("orderView", orderView);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}	

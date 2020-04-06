package com.example.coco;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.example.dto.userDTO;

@Controller
public class AdminInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object object)
			throws Exception {
		
		HttpSession session = request.getSession();
		userDTO userDTO = (userDTO) session.getAttribute("userDTO");
		
		if(userDTO == null) {
			response.sendRedirect("/user/admin");
			return false;
		}
		
		if (userDTO.getLevel() != 9){
			response.sendRedirect("/user/admin");
			return false;
		}
		
		return true;
		
	}
}

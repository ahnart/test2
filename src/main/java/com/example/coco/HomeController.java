package com.example.coco;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.userDTO;
import com.example.service.MemberService;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Inject
	private MemberService service;



	@Autowired
	private BCryptPasswordEncoder passEncoder;
	
	// 로그인 ================
	@RequestMapping("/")
	public String login() {
		return "index";
	}
	
//	@RequestMapping(value = "/signup", method = RequestMethod.GET)
//	public String signup() {
//		
//		return "signup";
//	}

	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public void signup() {
		logger.info("==== GET 회원가입 =======" );
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String insert(userDTO userDTO) throws Exception {
		
		logger.info("======= 회원가입 =======" + userDTO);
		
//		String inputPass = userDTO.getU_pw();
//		String pass = passEncoder.encode(inputPass);
//		userDTO.setU_pw(pass);
		
		service.insert(userDTO);
		return "redirect:/";
	}
	
	
	
	@RequestMapping(value = "/signin", method = RequestMethod.GET)
	public void getSignin() throws Exception {
		logger.info("======= get LOGIN =======");
	}
	
	@RequestMapping(value = "/signin", method = RequestMethod.POST)
	public String signin(userDTO userDTO, HttpServletRequest request, RedirectAttributes reattr) throws Exception {
		logger.info("======= POST LOGIN =======");
		
		System.out.println("------------vo : " + userDTO);
		
		userDTO signin = service.signin(userDTO);
		HttpSession httpSession = request.getSession();
		System.out.println("-----------signin : " + signin);
		
		if (signin != null ) {
			httpSession.setAttribute("member", signin);
		} else {
			httpSession.setAttribute("member", null);
			reattr.addFlashAttribute("msg", false);
			return "redirect:/";
		}
		return "redirect:/";
	}
	

	
	@RequestMapping(value = "/user/admin", method = RequestMethod.GET)
	public String selectMember(Locale locale, Model model) throws Exception{
		List<userDTO> memberList = service.selectMember();
		model.addAttribute("memberList", memberList);
		return "/user/admin";
	}
	


	@RequestMapping(value = "/signout", method = RequestMethod.GET)
	public String signout(HttpSession httpSession) throws Exception {
		service.signout(httpSession);
		return "redirect:/";
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String memberView(Locale locale, Model model) throws Exception {

		logger.info("========회원목록===========");
		List<userDTO> memberList = service.selectMember();
		model.addAttribute("memberList", memberList);
		return "list";
	}

	@RequestMapping(value = "/user/mDelete", method = RequestMethod.GET)
	public String mDelete(userDTO userDTO) throws Exception {

		service.mDelete(userDTO);
		return "redirect:/user/admin";
	}


}

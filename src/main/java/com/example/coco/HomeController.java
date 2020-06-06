package com.example.coco;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Locale;
import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;

import com.example.auth.SNSLogin;
import com.example.auth.SnsValue;
import com.example.dto.userDTO;
import com.example.service.MemberService;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.auth.oauth2.TokenResponse;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.http.GenericUrl;
import com.google.api.client.http.HttpRequest;
import com.google.api.client.http.HttpRequestFactory;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.util.Date;

import javax.servlet.http.Cookie;

import org.apache.commons.lang.StringUtils;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Inject
	private MemberService service;

//	@Inject
//	private SnsValue naverSns;
//
//	@Inject
//	private SnsValue googleSns;
//	
//	@Inject
//	private GoogleConnectionFactory googleConnectionFactory;

	@Autowired
	private BCryptPasswordEncoder passEncoder;

	// 구글 로그인 최과장 버전 ================

	private String GOOGLE_ID = "392788246663-51jtgvprgdlr25t85008j677kp85k8qn.apps.googleusercontent.com";

	private String GOOGLE_KEY = "eBSsvgCrSo91UTzCIf-qi13P";

	private String GOOGLE_CALLBACK = "http://localhost:8181/auth/google/callback";

	private static final Collection<String> SCOPES = Arrays.asList("email", "profile");
	private static final JsonFactory JSON_FACTORY = new JacksonFactory();
	private static final HttpTransport HTTP_TRANSPORT = new NetHttpTransport();
	private GoogleAuthorizationCodeFlow flow;

	private static final String USERINFO_ENDPOINT = "https://people.googleapis.com/v1/people/me?personFields=emailAddresses";

	@RequestMapping(value = "/googleSignIn")
	public String googleSignIn(HttpServletRequest request, HttpSession session, Model model) {
		String url = "";
		try {
			logger.info("GOOGLE ID :: " + GOOGLE_ID);
			logger.info("GOOGLE KEY :: " + GOOGLE_KEY);

			String state = new BigInteger(130, new SecureRandom()).toString(32); // prevent request forgery
			session.setAttribute("state", state);

			if (request.getAttribute("loginDestination") != null) {
				request.getSession().setAttribute("loginDestination",
						(String) request.getAttribute("loginDestination"));
			} else {
				session.setAttribute("loginDestination", "/");
			}

			flow = new GoogleAuthorizationCodeFlow.Builder(HTTP_TRANSPORT, JSON_FACTORY, GOOGLE_ID, GOOGLE_KEY, SCOPES)
					.build();

			// Callback url should be the one registered in Google Developers Console
			url = flow.newAuthorizationUrl().setRedirectUri(GOOGLE_CALLBACK).setState(state) // Prevent request forgery
					.build();

			logger.info("************ URL :: " + url);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:" + url;
	}

	@RequestMapping(value = "/auth/google/callback")
	public void googleCallback(userDTO userDTO, HttpServletRequest request, HttpServletResponse response, HttpSession session,
			Model model) throws Exception {
		logger.info("***************** [S] GOOGLE CALL BACK **********************");
		try {
			if (session.getAttribute("state") == null
					|| !request.getParameter("state").equals((String) session.getAttribute("state"))) {
				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
				response.sendRedirect("/googleSignIn");
				return;
			}  
			
			
			session.removeAttribute("state"); // Remove one-time use state.

			flow = new GoogleAuthorizationCodeFlow.Builder(HTTP_TRANSPORT, JSON_FACTORY, GOOGLE_ID, GOOGLE_KEY, SCOPES)
					.build();

			final TokenResponse tokenResponse = flow.newTokenRequest(request.getParameter("code"))
					.setRedirectUri(GOOGLE_CALLBACK).execute();

			session.setAttribute("token", tokenResponse.toString()); // Keep track of the token.
			final Credential credential = flow.createAndStoreCredential(tokenResponse, null);
			final HttpRequestFactory requestFactory = HTTP_TRANSPORT.createRequestFactory(credential);

			final GenericUrl url = new GenericUrl(USERINFO_ENDPOINT); // Make an authenticated request.
			final HttpRequest req = requestFactory.buildGetRequest(url);
			req.getHeaders().setContentType("application/json");

			final String jsonIdentity = req.execute().parseAsString();
			
			String email = getGoogleEmail(jsonIdentity);
			logger.info("***********EAMIL :: " + email);
			
			session.setAttribute("ADMIN_ID", email);
			
			////////////////////////////////
			userDTO signin2 = service.signin(userDTO);
			HttpSession session2 = request.getSession();
			String signin = email;
			
			session.setAttribute("member", signin);
			session2.setAttribute("member", signin2);
			if (signin != null) {
				session.setAttribute("member", signin);
				session2.setAttribute("member", signin2);
			} else {
				session.setAttribute("member", null);
			}
			///////////////////////////////
			
			response.sendRedirect("/");
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("***************** [E] GOOGLE CALL BACK **********************");
		return;
	}

	public String getGoogleEmail(String jsonStr) {
		String email = "";
		try {
			JSONParser parser = new JSONParser();
			JSONObject obj = (JSONObject) parser.parse(jsonStr);

			logger.info("******************* [JSON] *********************");
			logger.info(obj.toString());
			logger.info("******************** [emailAddresses] ********************");
			logger.info(obj.get("emailAddresses").toString());
			logger.info("******************** [emailAddresses-0] ********************");
			logger.info(((JSONArray) obj.get("emailAddresses")).get(0).toString());
			JSONArray array = (JSONArray) obj.get("emailAddresses");
			for (int i = 0; i < array.size(); i++) {
				JSONObject data = (JSONObject) array.get(i);
				if ("true".equals(((JSONObject) data.get("metadata")).get("primary").toString())) {
					email = data.get("value").toString();
				}
			}

		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return email;

	}

	// 구글 로그인 ================
//	@RequestMapping(value = "/signin", method = RequestMethod.GET)
//	public void getSignin(Model model) throws Exception {
//		logger.info("======= get LOGIN =======");
//
//		SNSLogin snsLogin = new SNSLogin(naverSns);
//		model.addAttribute("naver_url", snsLogin.getNaverAuthURL());
//
////		SNSLogin googleLogin = new SNSLogin(googleSns);
////		model.addAttribute("google_url", googleLogin.getNaverAuthURL());
//
//		/* 구글code 발행을 위한 URL 생성 */
//		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
//		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
//		model.addAttribute("google_url", url);
//
//	}
//	
//	
//	@RequestMapping(value = "/auth/{snsService}/callback", 
//			method = { RequestMethod.GET, RequestMethod.POST})
//	public String snsLoginCallback(@PathVariable String snsService,
//			Model model, @RequestParam String code, HttpSession session) throws Exception {
//		
//		logger.info("snsLoginCallback: service={}", snsService);
//		SnsValue sns = null;
//		if (StringUtils.equals("naver", snsService))
//			sns = naverSns;
//		else
//			sns = googleSns;
//		
//		// 1. code를 이용해서 access_token 받기
//		// 2. access_token을 이용해서 사용자 profile 정보 가져오기
//		SNSLogin snsLogin = new SNSLogin(sns);
//		
//		User snsUser = snsLogin.getUserProfile(code); // 1,2번 동시
//		System.out.println("Profile>>" + snsUser);
//		
//		// 3. DB 해당 유저가 존재하는 체크 (googleid, naverid 컬럼 추가)
//		User user = service.getBySns(snsUser);
//		if (user == null) {
//			model.addAttribute("result", "존재하지 않는 사용자입니다. 가입해 주세요.");
//			
//			//미존재시 가입페이지로!!
//			
//		} else {
//			model.addAttribute("result", user.getUname() + "님 반갑습니다.");
//			
//			// 4. 존재시 강제로그인
//			session.setAttribute(SessionNames.LOGIN, user);
//		}
//		
//		
//		return "loginResult";
//	}
//	

	@RequestMapping("/")
	public String login() {
		return "index";
	}

	@RequestMapping(value = "/signin", method = RequestMethod.GET)
	public void getSignin(Model model) throws Exception {
		logger.info("======= get LOGIN =======");

	}

//	@RequestMapping(value = "/signup", method = RequestMethod.GET)
//	public String signup() {
//		
//		return "signup";
//	}

	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public void signup() {
		logger.info("==== GET 회원가입 =======");
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

	@RequestMapping(value = "/signin", method = RequestMethod.POST)
	public String signin(userDTO userDTO, HttpServletRequest request, RedirectAttributes reattr) throws Exception {
		logger.info("======= POST LOGIN =======");

		System.out.println("------------vo : " + userDTO);

		userDTO signin = service.signin(userDTO);
		HttpSession httpSession = request.getSession();
		System.out.println("-----------signin : " + signin);

		if (signin != null) {
			httpSession.setAttribute("member", signin);
		} else {
			httpSession.setAttribute("member", null);
			reattr.addFlashAttribute("msg", false);
			return "redirect:/";
		}
		return "redirect:/";
	}

	@RequestMapping(value = "/user/admin", method = RequestMethod.GET)
	public String selectMember(Locale locale, Model model) throws Exception {
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

//	계정 등록 ===========================
	@RequestMapping(value = "/company/userForm", method = RequestMethod.GET)
	public void userForm(Model model) throws Exception {
		logger.info("======= get user Form  =======");
	}

//	기업 등록 ===========================
	@RequestMapping(value = "/company/companyForm", method = RequestMethod.GET)
	public void companyForm(Model model) throws Exception {
		logger.info("======= get company Form  =======");
	}

//	기업 등록 ===========================
	@RequestMapping(value = "/company/companyCommisionList", method = RequestMethod.GET)
	public void companyCommisionList(Model model) throws Exception {
		logger.info("======= get company CommisionList =======");
	}

//	금액 정보 ===========================
	@RequestMapping(value = "/company/companyPointList", method = RequestMethod.GET)
	public void companyPointList(Model model) throws Exception {
		logger.info("======= get company PointList =======");
	}

//	search Media List  ===========================
	@RequestMapping(value = "/company/searchMediaList", method = RequestMethod.GET)
	public void searchMediaList(Model model) throws Exception {
		logger.info("======= get company search Media List =======");
	}

//	buy Detail  ===========================
	@RequestMapping(value = "/buy/buyDetail", method = RequestMethod.GET)
	public void buyDetail(Model model) throws Exception {
		logger.info("======= get buy buy Detail =======");
	}

//	User commCodeList  ===========================
	@RequestMapping(value = "/user/commCodeList", method = RequestMethod.GET)
	public void commCodeList(Model model) throws Exception {
		logger.info("======= get User commCodeList =======");
	}

//	User commCodeDetail  ===========================
	@RequestMapping(value = "/user/commCodeDetail", method = RequestMethod.GET)
	public void commCodeDetail(Model model) throws Exception {
		logger.info("======= get User commCodeDetail =======");
	}

//	User commCodeDetail  ===========================
	@RequestMapping(value = "/user/insertCommCodeForm", method = RequestMethod.GET)
	public void insertCommCodeForm(Model model) throws Exception {
		logger.info("======= get User insertCommCodeForm =======");
	}

//	send campaignList  ===========================
	@RequestMapping(value = "/send/campaignList", method = RequestMethod.GET)
	public void campaignList(Model model) throws Exception {
		logger.info("======= get send campaignList =======");
	}

//	send sendList  ===========================
	@RequestMapping(value = "/send/sendList", method = RequestMethod.GET)
	public void sendList(Model model) throws Exception {
		logger.info("======= get send sendList =======");
	}

//	send sendFailList  ===========================
	@RequestMapping(value = "/send/sendFailList", method = RequestMethod.GET)
	public void sendFailList(Model model) throws Exception {
		logger.info("======= get send sendFailList =======");
	}

//	goods goodsList  ===========================
	@RequestMapping(value = "/goods/goodsList", method = RequestMethod.GET)
	public void goodsList(Model model) throws Exception {
		logger.info("======= get goods goodsList =======");
	}

//	goods goodsDetail  ===========================
	@RequestMapping(value = "/goods/goodsDetail", method = RequestMethod.GET)
	public void goodsDetail(Model model) throws Exception {
		logger.info("======= get goods goodsDetail =======");
	}

//	goods dispGoodsList  ===========================
	@RequestMapping(value = "/goods/dispGoodsList", method = RequestMethod.GET)
	public void dispGoodsList(Model model) throws Exception {
		logger.info("======= get goods dispGoodsList =======");
	}

//	goods dispGoodsList2  ===========================
	@RequestMapping(value = "/goods/dispGoodsList2", method = RequestMethod.GET)
	public void dispGoodsList2(Model model) throws Exception {
		logger.info("======= get goods dispGoodsList =======");
	}

//	disp searchDispPop  ===========================
	@RequestMapping(value = "/disp/searchDispPop", method = RequestMethod.GET)
	public void searchDispList(Model model) throws Exception {
		logger.info("======= get disp searchDispPop =======");
	}

//	send insertCampaignForm  ===========================
	@RequestMapping(value = "/send/insertCampaignForm", method = RequestMethod.GET)
	public void insertCampaignForm(Model model) throws Exception {
		logger.info("======= get send insertCampaignForm =======");
	}

}

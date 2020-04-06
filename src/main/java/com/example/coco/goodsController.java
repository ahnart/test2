package com.example.coco;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.dto.goodsDTO;
import com.example.service.adminService;
import com.example.util.updateFile;
import com.google.gson.JsonObject;

@Controller
public class goodsController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Inject
	private adminService aService;
	
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	
	
	// 상품 등록 ===========================
	@RequestMapping(value = "/user/register", method = RequestMethod.GET)
	public void gRegister(Model model) throws Exception {
		logger.info("======= get goods Register =======");

//		List<categoryDTO> categoryDTO = null;
//		categoryDTO = aService.category();
//		model.addAttribute("category", JSONArray.fromObject(categoryDTO));

	}



	
	// 상품 등록 이미지 추가 ===============
	@RequestMapping(value = "/user/register", method = RequestMethod.POST)
	public String register(goodsDTO goodsDTO, MultipartFile file) throws Exception {
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = updateFile.calcPath(imgUploadPath);
		String fileName = null;

		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			fileName = updateFile.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			goodsDTO.setG_img(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
			goodsDTO.setG_thum(
					File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);

		} else {
			fileName = File.separator + "images" + File.separator + "none.png";
			goodsDTO.setG_img(fileName);
			goodsDTO.setG_thum(fileName);

		}

		aService.register(goodsDTO);

		return "redirect:/user/goods_list?num=1";
	}



	// 상품목록 수정
	@RequestMapping(value = "/user/goods/modify", method = RequestMethod.GET)
	public void postGoodsModify(@RequestParam("g_no") int g_no, Model model) throws Exception {
		goodsDTO goodsDTO = aService.view(g_no);
		model.addAttribute("view", goodsDTO);
	}

	// 게시물 수정
	@RequestMapping(value = "/user/goods/modify", method = RequestMethod.POST)
	public String gModufy(goodsDTO goodsDTO, MultipartFile file, HttpServletRequest request) throws Exception {

		// 새로운 파일이 등록되었는지 확인
		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			// 기존 파일을 삭제
			new File(uploadPath + request.getParameter("g_img")).delete();
			new File(uploadPath + request.getParameter("g_thum")).delete();

			// 새로 첨부한 파일을 등록
			String imgUploadPath = uploadPath + File.separator + "imgUpload";
			String ymdPath = updateFile.calcPath(imgUploadPath);
			String fileName = updateFile.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(),
					ymdPath);

			goodsDTO.setG_img(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
			goodsDTO.setG_thum(
					File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);

		} else { // 새로운 파일이 등록되지 않았다면
			// 기존 이미지를 그대로 사용
			goodsDTO.setG_img(request.getParameter("g_img"));
			goodsDTO.setG_thum(request.getParameter("g_thum"));
		}
		aService.gModify(goodsDTO);

		return "redirect:/user/goods/view?g_no=" + goodsDTO.getG_no();
//		return "redirect:/user/goods_list?num=1";
	}

	// 상품 상세 보기
	@RequestMapping(value = "/user/goods/view", method = RequestMethod.GET)
	public void getView(@RequestParam("g_no") int g_no, Model model) throws Exception {

		goodsDTO goodsDTO = aService.view(g_no);
		model.addAttribute("view", goodsDTO);
		
		
		
		
	}
	
	
	
	
	

//	// 상품 리스트 조회 ===========================
//		@RequestMapping(value = "/user/goods_list", method = RequestMethod.POST)
//		public String goodslist(Model model) throws Exception {
//			logger.info("======= 상품 리스트 ===========");
//			List<goodsDTO> g_list = aService.goodslist();
//			model.addAttribute("g_list", g_list);
//			return "/user/goods_list";
//		}
	
	// 상품 게시물 삭제
	@RequestMapping(value = "/user/goods_list/gDelete", method = RequestMethod.GET)
	public String gDelete(goodsDTO goodsDTO) throws Exception {

		aService.gDelete(goodsDTO);
		return "redirect:/user/goods_list?num=1";
	}

	// 상품 페이지 갯수
	@RequestMapping(value = "/user/goods_list", method = RequestMethod.GET)
	public void getListPage(Model model, @RequestParam("num") int num) throws Exception {

		// 게시물 총 갯수
		int count = aService.count();
		// 한페이지 출력 게시물 수
		int postNum = 5;
		// 하단 페이징 번호 (게시물 갯수 / 한페이지 출력 갯수)
		int pageNum = (int) Math.ceil((double) count / postNum);
		// 출력할 게시물
		int displayPost = (num - 1) * postNum;

		List<goodsDTO> list = null;
		list = aService.listPage(displayPost, postNum);
		model.addAttribute("list", list);
		model.addAttribute("pageNum", pageNum);
	}

	// ck Editor 파일 업로드
	@RequestMapping(value = "/user/goods/ckUpload", method = RequestMethod.POST)
	public void postCKEditorImgUpload(HttpServletRequest request, HttpServletResponse response,
			@RequestParam MultipartFile upload) throws Exception {

		// 렌덤문자생성
		UUID uid = UUID.randomUUID();

		OutputStream out = null;
		PrintWriter printWriter = null;

		// 제이슨
		JsonObject json = new JsonObject();

		// 인코딩
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		try {

			String fileName = upload.getOriginalFilename(); // 파일이름 가져오기
			byte[] bytes = upload.getBytes();

			// 업로드 경로
			String ckUploadPath = uploadPath + File.separator + "ckUpload" + File.separator + uid + "_" + fileName;
			out = new FileOutputStream(new File(ckUploadPath));
			out.write(bytes);
			out.flush(); // out에 저장된 데이터를 전송하고 초기화

			String callback = request.getParameter("CKEditorFuncNum");
			printWriter = response.getWriter();
			String fileUrl = "/ckUpload/" + uid + "_" + fileName; // 작성화면

			// json 데이터로 등록
			// {"uploaded" : 1, "fileName" : "test.jpg", "url" : "/img/test.jpg"}
			// 이런 형태로 리턴이 나가야함.
			json.addProperty("uploaded", 1);
			json.addProperty("fileName", fileName);
			json.addProperty("url", fileUrl);

			printWriter.println(json);

//			// 업로드시 메시지 출력
//			printWriter.println("<script type='text/javascript'>" + "window.parent.CKEDITOR.tools.callFunction("
//					+ callback + ",'" + fileUrl + "','이미지를 업로드하였습니다.')" + "</script>");

			printWriter.flush();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null)
					out.close();
				if (printWriter != null)
					printWriter.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return;
	}

}

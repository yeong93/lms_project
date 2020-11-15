package kr.kosmo.jobkorea.cur.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.common.comnUtils.ComnCodUtil;
import kr.kosmo.jobkorea.cur.service.CourseService;
import kr.kosmo.jobkorea.cur.model.CourseModel;
import kr.kosmo.jobkorea.login.model.UserInfo;

@Controller
@RequestMapping("/cur/")
public class CourseController {
	
	@Autowired
	CourseService courseService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 과정 관리 초기화면
	 */
	@RequestMapping("courseMng.do")
	public String courseMng(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".courseMng");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".courseMng");

		return "cur/courseMng";
	}
	
	
	/**
	 * 과정 목록 조회
	 */
	@RequestMapping("listcourse.do")
	@ResponseBody
	public Map<String, Object> listcourse(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listcourse");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 과정 목록 조회
		List<CourseModel> listCourse = courseService.listCourse(paramMap);
		resultMap.put("listCourse", listCourse);
		
		// 공통 그룹코드 목록 카운트 조회
		int totalCount = courseService.countListCourse(paramMap);
		resultMap.put("totalCount", totalCount);
		
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPageComnGrpCod",currentPage);
		
		logger.info("+ End " + className + ".listcourse");
		

		return resultMap;
	}	

	/**
	 * 학생 목록 조회
	 */
	@RequestMapping("liststudent.do")
	@ResponseBody
	public Map<String, Object> liststudent(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".liststudent");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 학생 목록 조회
		List<UserInfo> liststudent = courseService.liststudent(paramMap);
		resultMap.put("liststudent", liststudent);
		
		// 학생 목록 카운트 조회
		int totalCount = courseService.countListstudent(paramMap);
		resultMap.put("totalCount", totalCount);
		
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPageCourse",currentPage);
		resultMap.put("no", paramMap.get("no"));
		
		logger.info("+ End " + className + ".liststudent");

		return resultMap;
	}		

	/**
	 * 미 수장 학생 목록 조회
	 */
	@RequestMapping("listunstudent.do")
	@ResponseBody
	public Map<String, Object> listunstudent(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listunstudent");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 학생 목록 조회
		List<UserInfo> listunstudent = courseService.listunstudent(paramMap);
		resultMap.put("listunstudent", listunstudent);
		
		// 학생 목록 카운트 조회
		int totalCount = courseService.countListunstudent(paramMap);
		resultMap.put("totalCount", totalCount);
		
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPageCourse",currentPage);
		resultMap.put("no", paramMap.get("no"));
		
		logger.info("+ End " + className + ".listunstudent");

		return resultMap;
	}		
	
	
	/**
	 *  과정 단건 조회
	 */
	@RequestMapping("coursesel.do")
	@ResponseBody
	public Map<String, Object> coursesel (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".coursesel");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 공통 그룹 코드 단건 조회
		CourseModel courseinfo = courseService.selectcourse(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("courseinfo", courseinfo);
		
		logger.info("+ End " + className + ".coursesel");
		
		return resultMap;
	}
	
	
	/**
	 *  과정 저장
	 */
	@RequestMapping("saveCourse.do")
	@ResponseBody
	public Map<String, Object> saveCourse(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveCourse");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		if ("I".equals(action)) {
			// 과정 신규 저장
			courseService.insertCourse(paramMap);
		} else if("U".equals(action)) {
			// 과정 수정 저장
			courseService.updateCourse(paramMap);
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveCourse");
		
		return resultMap;
	}
	
		
	/**
	 *  과정 삭제
	 */
	@RequestMapping("coursedel.do")
	@ResponseBody
	public Map<String, Object> coursedel(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".deleteComnGrpCod");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		// 과정 삭제
		courseService.coursedel(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteComnGrpCod");
		
		return resultMap;
	}
	
	/**
	 *  학생 추가
	 */
	@RequestMapping("addstudent.do")
	@ResponseBody
	public Map<String, Object> addstudent(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".addstudent");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "추가 되었습니다.";
		
		try {
			courseService.addstudent(paramMap);
		} catch (Exception e) {
			result = "FAIL";
			resultMsg = "추가 과정 중 오류가 발행 했습니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".addstudent");
		
		return resultMap;
	}	

	/**
	 *  학생 삭제
	 */
	@RequestMapping("delstudent.do")
	@ResponseBody
	public Map<String, Object> delstudent(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".delstudent");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "수강 취소 되었습니다.";
		
		try {
			courseService.delstudent(paramMap);
		} catch (Exception e) {
			result = "FAIL";
			resultMsg = "수강 취소 과정 중 오류가 발행 했습니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".delstudent");
		
		return resultMap;
	}	
}

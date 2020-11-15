package kr.kosmo.jobkorea.std.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import kr.kosmo.jobkorea.cur.model.CourseModel;
import kr.kosmo.jobkorea.login.model.UserInfo;
import kr.kosmo.jobkorea.std.service.StudentService;

@Controller
@RequestMapping("/std/")
public class stdListController {

	@Autowired
	StudentService studentService;	
	
	private final Logger logger = LogManager.getLogger(this.getClass());

	private final String className = this.getClass().toString();
	
	@RequestMapping("/adviceMgt.do")
	public String adviceMgt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".adviceMgt");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".adviceMgt");

		return "/std/studentList";
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
		List<UserInfo> listStudent = studentService.liststudent(paramMap);
		resultMap.put("listStudent", listStudent);
		
		// 학생 목록 카운트 조회
		int totalCount = studentService.countListstudent(paramMap);
		resultMap.put("totalCount", totalCount);
		
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPageComnGrpCod",currentPage);
		
		logger.info("+ End " + className + ".liststudent");
		
		return resultMap;
	}		

	/**
	 *  학생 단건 조회
	 */
	@RequestMapping("studentsel.do")
	@ResponseBody
	public Map<String, Object> studentsel (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".studentsel");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 공통 그룹 코드 단건 조회
		UserInfo studentinfo = studentService.selectstudent(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("studentinfo", studentinfo);
		
		logger.info("+ End " + className + ".studentsel");
		
		return resultMap;
	}	
	
}

package kr.kosmo.jobkorea.qanda.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.kosmo.jobkorea.login.model.UserInfo;
import kr.kosmo.jobkorea.qanda.model.Qanda;
import kr.kosmo.jobkorea.qanda.model.Qanda_rv;
import kr.kosmo.jobkorea.qanda.service.A_qandaService;

@SessionAttributes({"lgnInfoModel"})
@Controller
@RequestMapping("/qanda")
public class A_qandaController {
	
	@Autowired 
	A_qandaService QnaService;
	
	// qna화면 연결
	@RequestMapping("/a_qanda.do")
	public String selectQnA(Model model){
		return "qanda/a_qanda";
	}
	
	// qna 목록 조회
	@RequestMapping("/exchangeQnaList.do")
	public String QnaList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("loginId", session.getAttribute("loginId"));

		List<Qanda> qnaList = QnaService.selectQna(paramMap);
		model.addAttribute("qnaList", qnaList);
		
		int totalCount = QnaService.countListComnGrpCod(paramMap);
		model.addAttribute("totalCntComnGrpCod", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnGrpCod",currentPage);
		
		
		// 콜백 화면 return 
		return "qanda/a_qandaCallback";
	}
	
	
	// qna 상세 조회
	@RequestMapping("/detailList.do")
	@ResponseBody
	public Map<String, Object> detailList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		// qa_id (클릭한 글 번호)
		int qa_id = Integer.parseInt((String)paramMap.get("qa_id"));
		
		// qna 조회
		Qanda qnaList = QnaService.detailQnaList(qa_id);
		
		System.out.println("qnaList"+ qnaList);
		// 댓글 조회
		List<Qanda_rv> qnaRvList = QnaService.detailQnaRvList(qa_id);
		
		// 상세 조회수 up
		if(qnaList != null){
			int increaseHit = QnaService.increaseHit(qa_id);
		}
		
		// session에서 id가져오기 -> 수정 삭제시 필요
		String login_id = (String) session.getAttribute("loginId");
		//System.out.println("세션id" + login_id);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("qnaList",qnaList);
		resultMap.put("qnaRvList",qnaRvList);
		resultMap.put("result","SUCCESS");
		
		return resultMap;
	}
	
	// qna 글 삭제
	@RequestMapping("/deleteQna.do")
	@ResponseBody
	public Map<String, Object> deleteQna(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		String resultMsg = "";

		int re = QnaService.deleteQna(paramMap);
		
		//System.out.println("글삭제성공" + re);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result","SUCCESS");
		resultMap.put("resultMsg","삭제 성공");
		
		return resultMap;
	}
	
	// qna 댓글 등록
	@RequestMapping("/insertQnaRv.do")
	@ResponseBody
	public Map<String, Object> insertQnaRv(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		
		String login_id = (String) session.getAttribute("loginId");
		paramMap.put("login_id", login_id);
		
		int insertRv = QnaService.insertQnaRr(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result","SUCCESS");
		resultMap.put("resultMsg","댓글 등록 성공");
		
		return resultMap;
	}
	
	// qna 댓글 삭제
	@RequestMapping("/deleteRv.do")
	@ResponseBody
	public Map<String, Object> deleteRv(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		int deleteRs = QnaService.deleteRv(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result","SUCCESS");
		resultMap.put("resultMsg","댓글 삭제 성공");
		
		return resultMap;
	}
	
	// qna 글 등록
	@RequestMapping("/saveQna.do")
	@ResponseBody
	public Map<String, Object> saveQna(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		String login_id = (String) session.getAttribute("loginId");
		paramMap.put("login_id", login_id);
		
		int insertQna = QnaService.insertQna(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result","SUCCESS");
		resultMap.put("resultMsg","글 등록 성공");
		
		return resultMap;
	}
	
	
	// qna 글 수정
	@RequestMapping("/updateQna.do")
	@ResponseBody
	public Map<String, Object> updateQna(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		
		int updateQna = QnaService.updateQna(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result","SUCCESS");
		resultMap.put("resultMsg","글 수정 성공");
		
		return resultMap;
	}
	
	
	
	
}

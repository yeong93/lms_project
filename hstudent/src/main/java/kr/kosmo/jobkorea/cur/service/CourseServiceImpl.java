package kr.kosmo.jobkorea.cur.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.cur.dao.CourseDao;
import kr.kosmo.jobkorea.cur.model.CourseModel;
import kr.kosmo.jobkorea.login.model.UserInfo;

@Service
public class CourseServiceImpl implements CourseService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	CourseDao courseDao;
	
	/** 과정 목록 조회 */
	public List<CourseModel> listCourse(Map<String, Object> paramMap) throws Exception {
		
		List<CourseModel> listCourse = courseDao.listCourse(paramMap);
		
		return listCourse;
	}
	
	/** 과정 목록 카운트 조회 */
	public int countListCourse(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = courseDao.countListCourse(paramMap);
		
		return totalCount;
	}

	/** 학생 목록 조회 */
	public List<UserInfo> liststudent(Map<String, Object> paramMap) throws Exception {
		
		List<UserInfo> listStudent = courseDao.liststudent(paramMap);
		
		return listStudent;
	}
	
	/** 학생 목록 카운트 조회 */
	public int countListstudent(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = courseDao.countListstudent(paramMap);
		
		return totalCount;
	}	

	/** 미수강 학생 목록 조회 */
	public List<UserInfo> listunstudent(Map<String, Object> paramMap) throws Exception {
		
		List<UserInfo> listStudent = courseDao.listunstudent(paramMap);
		
		return listStudent;
	}
	
	/** 미수강 학생 목록 카운트 조회 */
	public int countListunstudent(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = courseDao.countListunstudent(paramMap);
		
		return totalCount;
	}	
	
	/** 과정 단건 조회 */
	public CourseModel selectcourse(Map<String, Object> paramMap) throws Exception {
		return courseDao.selectcourse(paramMap);		
	}	
	
	/** 과정 등록 */
	public void insertCourse(Map<String, Object> paramMap) throws Exception {
		courseDao.insertCourse(paramMap);
		return;
	}	
	
	/** 과정 수정 */
	public void updateCourse(Map<String, Object> paramMap) throws Exception {
		courseDao.updateCourse(paramMap);
		return;
	}	
	
	/** 과정 삭제 */
	public void coursedel(Map<String, Object> paramMap) throws Exception {
		courseDao.coursedel(paramMap);
		return;
	}
	
	/** 학생 추가 */
	public void addstudent(Map<String, Object> paramMap) throws Exception {
		courseDao.addstudent(paramMap);
		return;
	}
	
	/** 수강 취소 */
	public void delstudent(Map<String, Object> paramMap) throws Exception {
		courseDao.delstudent(paramMap);
		return;
	}
}

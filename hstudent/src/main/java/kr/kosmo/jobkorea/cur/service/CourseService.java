package kr.kosmo.jobkorea.cur.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.cur.model.CourseModel;
import kr.kosmo.jobkorea.login.model.UserInfo;

public interface CourseService {

	/** 과정 목록 조회 */
	public List<CourseModel> listCourse(Map<String, Object> paramMap) throws Exception;
	
	/** 과정 목록 카운트 조회 */
	public int countListCourse(Map<String, Object> paramMap) throws Exception;
	
	/** 학생 목록 조회 */
	public List<UserInfo> liststudent(Map<String, Object> paramMap) throws Exception;
	
	/** 학생 목록 카운트 조회 */
	public int countListstudent(Map<String, Object> paramMap) throws Exception;
	
	/** 미 수강 학생 목록 조회 */
	public List<UserInfo> listunstudent(Map<String, Object> paramMap) throws Exception;
	
	/** 미 수강 학생 목록 카운트 조회 */
	public int countListunstudent(Map<String, Object> paramMap) throws Exception;
	
	/** 과정 단건 조회 */
	public CourseModel selectcourse(Map<String, Object> paramMap) throws Exception;
	
	/** 과정 등록 */
	public void insertCourse(Map<String, Object> paramMap) throws Exception;
	
	/** 과정 수정 */
	public void updateCourse(Map<String, Object> paramMap) throws Exception;
	
	/** 과정 삭제 */
	public void coursedel(Map<String, Object> paramMap) throws Exception;
	
	/** 학생 추가 */
	public void addstudent(Map<String, Object> paramMap) throws Exception;
	
	/** 수강 취소 */
	public void delstudent(Map<String, Object> paramMap) throws Exception;
}

package kr.kosmo.jobkorea.std.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.cur.model.CourseModel;
import kr.kosmo.jobkorea.login.model.UserInfo;

public interface StudentDao {

	/** 학생 목록 조회 */
	public List<UserInfo> liststudent(Map<String, Object> paramMap) throws Exception;
	
	/** 학생 목록 카운트 조회 */
	public int countListstudent(Map<String, Object> paramMap) throws Exception;
	
	/** 학생 한건 조회 */
	public UserInfo selectstudent(Map<String, Object> paramMap) throws Exception;
	
}

package kr.kosmo.jobkorea.std.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.std.dao.StudentDao;
import kr.kosmo.jobkorea.login.model.UserInfo;

@Service
public class StudentServiceImpl implements StudentService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	StudentDao studentDao;
	
	/** 학생 목록 조회 */
	public List<UserInfo> liststudent(Map<String, Object> paramMap) throws Exception {
		
		List<UserInfo> listStudent = studentDao.liststudent(paramMap);
		
		return listStudent;
	}
	
	/** 학생 목록 카운트 조회 */
	public int countListstudent(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = studentDao.countListstudent(paramMap);
		
		return totalCount;
	}	
	
	/** 학생 한건 조회 */
	public UserInfo selectstudent(Map<String, Object> paramMap) throws Exception{
		
		UserInfo studentinfo = studentDao.selectstudent(paramMap);
		
		return studentinfo;
	}
	
}

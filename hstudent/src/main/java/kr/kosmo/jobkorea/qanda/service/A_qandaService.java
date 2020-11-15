package kr.kosmo.jobkorea.qanda.service;

import java.util.List;
import java.util.Map;
import kr.kosmo.jobkorea.qanda.model.Qanda;
import kr.kosmo.jobkorea.qanda.model.Qanda_rv;

public interface A_qandaService {

	/* QnA 목록 조회 */
	public List<Qanda> selectQna(Map<String, Object> paramMap) throws Exception;

	public int countListComnGrpCod(Map<String, Object> paramMap)throws Exception;

	public Qanda detailQnaList(int qa_id)throws Exception;

	public List<Qanda_rv> detailQnaRvList(int qa_id)throws Exception;

	public int deleteQna(Map<String, Object> paramMap)throws Exception;

	public int insertQnaRr(Map<String, Object> paramMap)throws Exception;

	public int deleteRv(Map<String, Object> paramMap)throws Exception;

	public int insertQna(Map<String, Object> paramMap)throws Exception;
	
	// qna 상세조회시 조회수 증가
	public int increaseHit(int qa_id)throws Exception;
	
	// qna 글 수정
	public int updateQna(Map<String, Object> paramMap)throws Exception;



	
	
	
	
	
}

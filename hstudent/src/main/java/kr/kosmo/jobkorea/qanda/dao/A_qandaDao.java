package kr.kosmo.jobkorea.qanda.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.qanda.model.Qanda;
import kr.kosmo.jobkorea.qanda.model.Qanda_rv;


public interface A_qandaDao {
	
	/* qna 목록 조회 */
	public List<Qanda> selectQna(Map<String, Object> paramMap);

	public int selectQnaCount(Map<String, Object> paramMap);

	public Qanda detailQnaList(int qa_id);

	public List<Qanda_rv> detailQnaRvList(int qa_id);

	public int deleteQna(Map<String, Object> paramMap);

	public int insertQnaRr(Map<String, Object> paramMap);

	public int deleteRv(Map<String, Object> paramMap);
	
	/* qna 글 등록 */
	public int insertQna(Map<String, Object> paramMap);
	
	/* qna 상세조회시 조회수 증가 */
	public int increaseHit(int qa_id);
	
	/* qna 글 수정*/
	public int updateQna(Map<String, Object> paramMap);
	
	
	
}

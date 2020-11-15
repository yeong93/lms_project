package kr.kosmo.jobkorea.qanda.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.qanda.dao.A_qandaDao;
import kr.kosmo.jobkorea.qanda.model.Qanda;
import kr.kosmo.jobkorea.qanda.model.Qanda_rv;
import kr.kosmo.jobkorea.supportD.dao.NoticeDDao;
import kr.kosmo.jobkorea.supportD.model.NoticeDModel;

@Service
public class A_qandaServiceImpl implements A_qandaService {
	
	@Autowired
	A_qandaDao qnaDao;

	// Qna 목록 조회
	@Override
	public List<Qanda> selectQna(Map<String, Object> paramMap) throws Exception {
		List<Qanda> qnaList = qnaDao.selectQna(paramMap);
		return qnaList;
	}
	
	// qna 목록 카운트
	@Override
	public int countListComnGrpCod(Map<String, Object> paramMap) throws Exception {
		int totalCount = qnaDao.selectQnaCount(paramMap);
		return totalCount;
	}

	// qna 상세 조회
	@Override
	public Qanda detailQnaList(int qa_id) throws Exception{
		Qanda qnaDetailList = qnaDao.detailQnaList(qa_id);
		return qnaDetailList;
	}
	
	// qna 댓글 조회
	@Override
	public List<Qanda_rv> detailQnaRvList(int qa_id) throws Exception {
		List<Qanda_rv> detailQnaRvList = qnaDao.detailQnaRvList(qa_id);
		return detailQnaRvList;
	}
	
	// qna 글 삭제
	@Override
	public int deleteQna(Map<String, Object> paramMap) throws Exception{
		int result = qnaDao.deleteQna(paramMap);
		return result;
	}
	
	// qna 댓글 입력
	@Override
	public int insertQnaRr(Map<String, Object> paramMap) throws Exception {
		int result = qnaDao.insertQnaRr(paramMap);
		return result;
	}

	// qna 댓글 삭제
	@Override
	public int deleteRv(Map<String, Object> paramMap) throws Exception {
		int result = qnaDao.deleteRv(paramMap);
		return result;
	}
	
	// qna 글 등록
	@Override
	public int insertQna(Map<String, Object> paramMap) throws Exception {
		int result = qnaDao.insertQna(paramMap);
		return result;
	}
	
	// qna 상세조회시 조회수 증가
	@Override
	public int increaseHit(int qa_id) throws Exception{
		int result = qnaDao.increaseHit(qa_id);
		return result;
	}
	
	// qna 글 수정
	@Override
	public int updateQna(Map<String, Object> paramMap) throws Exception {
		int result = qnaDao.updateQna(paramMap);
		return result;
	}







}

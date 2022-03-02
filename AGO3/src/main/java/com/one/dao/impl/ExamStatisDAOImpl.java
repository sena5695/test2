package com.one.dao.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.one.command.Criteria;
import com.one.command.ExamCommand;
import com.one.dao.ExamStatisDAO;
import com.one.dto.ExamStastisDetailVO;
import com.one.dto.ExamStatisVO;

public class ExamStatisDAOImpl implements ExamStatisDAO {

	private SqlSession session;

	public void setSession(SqlSession session) {
		this.session = session;
	}


	@Override
	public List<ExamStatisVO> selectExamStatisList(Criteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return session.selectList("Exam-Mapper.selectExamStatisList", cri, rowBounds);
	}
	
	@Override
	public int countExamStatisList() throws SQLException {
		return session.selectOne("Exam-Mapper.countExamStatisList");
	}


	@Override
	public ExamStastisDetailVO selectStatisDetail(int opcl) throws SQLException {
		return session.selectOne("Exam-Mapper.selectStatisDetail",opcl);
	}

	@Override
	public int countClassStudent(int opcl) throws SQLException {
		return session.selectOne("Exam-Mapper.countClassStudent",opcl);
	}

	@Override
	public int countStudentScore(ExamStastisDetailVO examDetail) throws SQLException {
		return session.selectOne("Exam-Mapper.countStudentScore", examDetail);
	}


	@Override
	public List<ExamStatisVO> selectOnlyExamList() throws SQLException {
		return session.selectList("Exam-Mapper.selectExamStatisList");
	}


	@Override
	public String selectMidScoreAvg(int opcl) throws SQLException {
		return session.selectOne("Exam-Mapper.selectMidScoreAvg", opcl);
	}


	@Override
	public String selectFinScoreAvg(int opcl) throws SQLException {
		return session.selectOne("Exam-Mapper.selectFinScoreAvg", opcl);
	}


	@Override
	public void updateFinScoreAvg(ExamStatisVO examInfo) throws SQLException {
		session.update("Exam-Mapper.updateFinScoreAvg", examInfo);
	}


	@Override
	public void updateBothScoreAvg(ExamStatisVO examInfo) throws SQLException {
		session.update("Exam-Mapper.updateBothScoreAvg", examInfo);
		
	}


	
	
}

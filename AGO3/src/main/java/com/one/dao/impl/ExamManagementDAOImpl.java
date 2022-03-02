package com.one.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.one.command.Criteria;
import com.one.command.ExamRegistCommand;
import com.one.dao.ExamManagementDAO;
import com.one.dto.ManageExamVO;
import com.one.dto.ClassVO.TestVO;

public class ExamManagementDAOImpl implements ExamManagementDAO{

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<ManageExamVO> selectManagementExamList(Criteria cri) throws SQLException {
		
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<ManageExamVO> examList = session.selectList("Exam-Mapper.selectManagementExamList", cri, rowBounds);
		return examList;
	}

	@Override
	public int selectManagementExamListCount(Criteria cri) throws SQLException {
		int totalCount = session.selectOne("Exam-Mapper.selectManagementExamListCount", cri);
		return totalCount;
	}

	@Override
	public List<ManageExamVO> selectNoExamClass(Criteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<ManageExamVO> examList = session.selectList("Exam-Mapper.selectNoExamClass", cri, rowBounds);
		return examList;
	}

	@Override
	public int selectNoExamClassCount(Criteria cri) throws SQLException {
		int totalCount = session.selectOne("Exam-Mapper.selectNoExamClassCount", cri);
		return totalCount;
	}

	@Override
	public ManageExamVO selectExamInfo(String clCode) throws SQLException {
		ManageExamVO manageExam = session.selectOne("Exam-Mapper.selectExamInfo", clCode);
		return manageExam;
	}

	@Override
	public void updateExamFileInfo(ExamRegistCommand examCMD) throws SQLException {
		session.update("Exam-Mapper.updateExamInfo", examCMD);
		
	}

	@Override
	public TestVO selectTestInfo(int opcl) throws SQLException {
		TestVO test = session.selectOne("Exam-Mapper.selectTestInfo", opcl);
		return test;
	}

}

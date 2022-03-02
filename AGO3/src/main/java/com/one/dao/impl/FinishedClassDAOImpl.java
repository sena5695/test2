package com.one.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.one.command.ExtReportCommand;
import com.one.command.FinishedClassCommand;
import com.one.command.MemberCriteria;
import com.one.dao.FinishedClassDAO;
import com.one.dto.DebateBoardVO;
import com.one.dto.ExtReportVO;
import com.one.dto.FinishedClassVO;
import com.one.dto.IntReportVO;
import com.one.dto.ClassVO.ClassReviewVO;

public class FinishedClassDAOImpl implements FinishedClassDAO {
	
	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}
	
	@Override
	public List<FinishedClassVO> selectIntFinishedClassList(MemberCriteria mCri) throws SQLException {
		int offset = mCri.getStartRowNum();
		int limit = mCri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		List<FinishedClassVO> intFinishedClassList = session.selectList("ClassFinished-Mapper.selectIntFinishedClassList", mCri, rowBounds);
		
		return intFinishedClassList;
	}
	
	
	@Override
	public List<FinishedClassVO> selectExtFinishedClassList(MemberCriteria mCri) throws SQLException {
		int offset = mCri.getStartRowNum();
		int limit = mCri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		List<FinishedClassVO> extFinishedClassList = session.selectList("ClassFinished-Mapper.selectExtFinishedClassList", mCri, rowBounds);
		
		return extFinishedClassList;
	}

	@Override
	public IntReportVO selectIntReport(int memClNo) throws SQLException {
		return session.selectOne("ClassFinished-Mapper.selectIntReport", memClNo);
	}

	@Override
	public ExtReportVO selectExtReport(int extNo) throws SQLException {
		return session.selectOne("ClassFinished-Mapper.selectExtReport", extNo);
	}

	@Override
	public int countIntClass(String memEmail) throws SQLException {
		return session.selectOne("ClassFinished-Mapper.countIntClass", memEmail);
	}

	@Override
	public int countExtClass(String memEmail) throws SQLException {
		return session.selectOne("ClassFinished-Mapper.countExtClass", memEmail);
	}

	@Override
	public ClassReviewVO selectIntClassReview(ClassReviewVO myReview) throws SQLException {
		return session.selectOne("ClassFinished-Mapper.selectIntClassReview",myReview);
	}

	@Override
	public IntReportVO selectIntReportInsertForm(int memClNo) throws SQLException {
		return session.selectOne("ClassFinished-Mapper.selectIntReportInsertForm",memClNo);
	}

	@Override
	public void insertIntReport(IntReportVO intreport) throws SQLException {
		session.update("ClassFinished-Mapper.insertIntReport",intreport);
	}

	@Override
	public void insertClassReview(ClassReviewVO myReview) throws SQLException {
		session.update("ClassFinished-Mapper.insertClassReview",myReview);
	}

	@Override
	public int insertExtReport(ExtReportVO extReport) throws SQLException {
		return session.update("ClassFinished-Mapper.insertExtReport",extReport);
	}

	@Override
	public void updateExtNo(ExtReportVO extReport) throws SQLException {
		session.update("ClassFinished-Mapper.updateExtNo",extReport);
		
	}

	@Override
	public void updateIntReport(IntReportVO intreport) throws SQLException {
		session.update("ClassFinished-Mapper.updateIntReport",intreport);
	}

	@Override
	public void updateExtReport(ExtReportVO extReport) throws SQLException {
		session.update("ClassFinished-Mapper.updateExtReport",extReport);
	}

	@Override
	public ClassReviewVO selectIntClassReviewForm(int memClNo) throws SQLException {
		return session.selectOne("ClassFinished-Mapper.selectIntClassReviewForm", memClNo);
	}

	@Override
	public void deleteHRDByExtNo(ExtReportCommand ext) throws SQLException {
		session.delete("ClassFinished-Mapper.deleteHRDByExtNo",ext);
		
	}

	@Override
	public void modifyExtReport(ExtReportVO ext) throws SQLException {
		session.update("ClassFinished-Mapper.modifyExtReport",ext);
		
	}

}

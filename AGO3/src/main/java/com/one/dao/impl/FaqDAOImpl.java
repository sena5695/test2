package com.one.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.one.command.Criteria;
import com.one.dao.FaqDAO;
import com.one.dto.FaqVO;

public class FaqDAOImpl implements FaqDAO {

	private SqlSession session;

	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<FaqVO> selectFAQList(Criteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		System.out.println("offset-limit========================="+offset+"-"+limit);
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<FaqVO> faqList = session.selectList("FAQ-Mapper.selectFAQList", cri, rowBounds);
		return faqList;
	}

	@Override
	public List<FaqVO> selectDashboardFAQList(Criteria cri) throws SQLException {
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(0, limit);
		List<FaqVO> faqList = session.selectList("FAQ-Mapper.selectFAQList", cri, rowBounds);
		return faqList;
	}
	
	@Override
	public int selectFAQListCount(Criteria cri) throws SQLException {
		int count = session.selectOne("FAQ-Mapper.selectFAQListCount", cri);
		return count;
	}

	@Override
	public FaqVO selectFAQByFaqNo(int faqNo) throws SQLException {
		FaqVO faq = session.selectOne("FAQ-Mapper.selectFAQByFaqNo", faqNo);
		return faq;
	}

	@Override
	public void updateFAQ(FaqVO faq) throws SQLException {
		session.update("FAQ-Mapper.updateFAQ", faq);

	}

	@Override
	public void deleteFAQ(int faqNo) throws SQLException {
		session.update("FAQ-Mapper.deleteFAQ", faqNo);

	}

	@Override
	public void insertFAQ(FaqVO faq) throws SQLException {
		session.update("FAQ-Mapper.insertFAQ", faq);
	}

	@Override
	public int selectFQASeqNextValue() throws SQLException {
		int FaqNo = session.selectOne("FAQ-Mapper.selectFQASeqNextValue");
		return FaqNo;
	}


}

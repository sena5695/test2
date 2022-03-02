package com.one.dao.impl;

import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.one.command.ClassCommand;
import com.one.command.ClassReviewCommand;
import com.one.command.Criteria;
import com.one.command.MemberClassCommand;
import com.one.dao.UserClassDAO;
import com.one.dto.AskVO;
import com.one.dto.ClassVO.ClassChapterVO;
import com.one.dto.ClassVO.ClassDepartmentVO;
import com.one.dto.ClassVO.ClassEXT;
import com.one.dto.ClassVO.ClassIntr;
import com.one.dto.ClassVO.ClassListVO;
import com.one.dto.ClassVO.ClassReviewVO;

public class UserClassDAOImpl implements UserClassDAO {

	private SqlSession session;

	public void setSession(SqlSession session) {
		this.session = session;
	}
	
	@Override
	public List<ClassCommand> selectClassList(Criteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();

		RowBounds rowBounds = new RowBounds(offset, limit);

		
		List<ClassCommand> classList = session.selectList("Class-Mapper.selectClassList", cri, rowBounds);
		for(int i=0;i<classList.size();i++) {
			if(session.selectOne("Class-Mapper.selectClassAvg",classList.get(i).getOpcl()) !=null) {
				double scope = session.selectOne("Class-Mapper.selectClassAvg",classList.get(i).getOpcl());
				classList.get(i).setScope(scope);
			}
		}
		// System.out.println("class----------------"+classList.get(0));
		/*System.out.println("size-----------------------------------"+classList.size());*/
		return classList;
	}

	@Override
	public int selectClassListCount(Criteria cri) throws SQLException {
		int count = session.selectOne("Class-Mapper.selectClassListCount", cri);
		return count;
	}

	@Override
	public ClassCommand selectClass(int clCode) throws SQLException {
		ClassCommand classVO = session.selectOne("Class-Mapper.selectClass",clCode);
		if(session.selectOne("Class-Mapper.selectClassAvg",classVO.getOpcl()) !=null) {
			double scope = session.selectOne("Class-Mapper.selectClassAvg",classVO.getOpcl());
			classVO.setScope(scope);
		}
		return classVO;
	}

	@Override
	public List<ClassChapterVO> selectClassChapter(int clCode) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectList("Class-Mapper.getClassChapter", clCode);
	}

	@Override
	public List<ClassReviewCommand> selectClassReview(int opcl) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectList("Class-Mapper.selectClassReview", opcl);
	}
	
	@Override
	public List<ClassEXT> selectExtClassList(String memEmail) throws SQLException {
		return session.selectList("Class-Mapper.selectExtClassList", memEmail);
	}
	

	@Override
	public void insertBookmark(ClassIntr intr) throws SQLException {
		session.selectList("Class-Mapper.insertBookmark", intr);
		
	}

	@Override
	public void deleteBookmark(ClassIntr intr) throws SQLException {
		session.selectList("Class-Mapper.deleteBookmark", intr);
		
	}

	@Override
	public void insertMemberClass(MemberClassCommand memberClass) throws SQLException {
		session.selectList("Class-Mapper.insertMemberClass", memberClass);
		
	}

	@Override
	public void insertMemberClassRealTime(MemberClassCommand memberClass) throws SQLException {
		session.selectList("Class-Mapper.insertMemberClassRealTime", memberClass);
		
	}

	@Override
	public List<MemberClassCommand> selectMemberClassList(String memEmail) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectList("Class-Mapper.selectMemberClassList", memEmail);
	}

	@Override
	public List<ClassDepartmentVO> selectDepartmentClass() throws SQLException {
		// TODO Auto-generated method stub
		return session.selectList("Class-Mapper.selectDepartmentClassList");
	}

	@Override
	public List<String> selectMemberInterestClassList(String memEmail) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectList("Class-Mapper.selectMemberInterestClassList", memEmail);
	}

	@Override
	public void insertExtClass(ClassEXT ext) throws SQLException {
		session.selectList("Class-Mapper.insertExtClass", ext);
		
	}

	@Override
	public int selectClassTestState(int opcl) throws SQLException {
		int result = 0;
		if(session.selectOne("Class-Mapper.selectClassTestState", opcl) != null) {
			result = session.selectOne("Class-Mapper.selectClassTestState", opcl);
		}

		return result;
	}

	@Override
	public Date selectClassPostEdate(int opcl) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectOne("Class-Mapper.selectClassPostEdate", opcl);
	}

	@Override
	public int selectStudyEmployeeCount(int opcl) throws SQLException {
		int count = 0;
		if(session.selectOne("Class-Mapper.selectStudyEmployeeCount", opcl) != null) {
			count = session.selectOne("Class-Mapper.selectStudyEmployeeCount", opcl);
		}
		return count;
	}


}

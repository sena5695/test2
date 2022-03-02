package com.one.dao;

import java.sql.SQLException;
import java.util.List;

import com.one.command.ClassCommand;
import com.one.command.ClassReviewCommand;
import com.one.dto.MemberClVO;
import com.one.dto.MemberVO;
import com.one.dto.ClassVO.ClassChapterVO;
import com.one.dto.ClassVO.ClassDocumentVO;
import com.one.dto.ClassVO.ClassListVO;
import com.one.dto.ClassVO.ClassReviewVO;

public interface JMSClassDAO {

	public ClassCommand selectClassAndOpClByOpcl(int opcl) throws SQLException;

	public List<ClassDocumentVO> selectClDocListByOpcl(int opcl) throws SQLException;

	public List<ClassChapterVO> selectClChapterListByOpcl(int opcl) throws SQLException;

	public List<ClassReviewCommand> selectClReviewListByOpcl(int opcl) throws SQLException;

	public MemberVO selectMemberByMemId(String memId) throws SQLException;

	public double selectAvgReviewScoreByOpcl(int opcl) throws SQLException;

	public Boolean checkMemChap(MemberClVO clChap) throws SQLException;

	public MemberClVO getMemChap(MemberClVO memChap) throws SQLException;

	public void deleteStudyingClass(MemberClVO memClVO) throws SQLException;

	public List<MemberClVO> selectAllProgChapByMemClNo(int memClNo) throws SQLException;

	public int selectProgRate(ClassListVO classVO)throws SQLException;

	public List<MemberVO> getMem();

	public void setPwd(MemberVO mem);

}

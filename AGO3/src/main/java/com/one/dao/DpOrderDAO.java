package com.one.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.one.command.ClassReviewCommand;
import com.one.command.Criteria;
import com.one.command.CriteriaDpCommand;
import com.one.command.DepartmentHeadReportCommand;
import com.one.command.DepartmentMemberClassCommand;
import com.one.command.DpFavClassCommand;
import com.one.command.ReportClassCommand;
import com.one.dto.CertificateVO;
import com.one.dto.DpHeadDashVO;
import com.one.dto.DpHeadVO;
import com.one.dto.ExtReportVO;
import com.one.dto.IntReportVO;
import com.one.dto.MemberCertificateVO;
import com.one.dto.OrderClassVO;
import com.one.dto.ClassVO.ClassChapterVO;
import com.one.dto.ClassVO.ClassListVO;

public interface DpOrderDAO {
	public List<DpFavClassCommand> selectDpClassList(CriteriaDpCommand cri) throws SQLException; 
	
	public List<DpFavClassCommand> selectDpClassList(String dpId) throws SQLException; 
	
	//즐겨찾기 목록
	public List<DpFavClassCommand> selectDpFavClassList(String dpId) throws SQLException;
	
	public DpFavClassCommand selectDpClass(int opcl) throws SQLException;

	public List<ClassChapterVO> selectClassChapter(String clCode)throws SQLException;
	
	public List<ClassReviewCommand> selectClassReview(int opcl)throws SQLException;
	
	public int selectDpClassListCount(CriteriaDpCommand cri) throws SQLException;
	
	public int selectDpClassMemberCount(int opcl) throws SQLException;
	
	public int getOdId() throws SQLException;

	public void insertDpHeadOd(DpHeadVO order) throws SQLException;

	public void insertDpOdOpcl(DpHeadVO order) throws SQLException;

	public void insertDpOdMem(DpHeadVO order) throws SQLException;

	public List<ClassListVO> selectDpHeadFav(String dpId) throws SQLException;

	public void insertDpHeadFav(DpHeadVO fav) throws SQLException;

	public void deleteDpHeadFav(DpHeadVO fav) throws SQLException;

	public int favCheck(DpHeadVO fav) throws SQLException;
	
	public String selectAutograph(String dpId) throws SQLException;
	
	public List<DepartmentHeadReportCommand> selectReportList(Criteria cri, String department) throws SQLException;
	
	public List<DepartmentHeadReportCommand> selectDashReportList(Criteria cri, String department) throws SQLException;
	
	public int selectReportCount(Criteria cri, String department) throws SQLException;
	
	public List<OrderClassVO> selectOrderClassList(String department) throws SQLException;
	
	public List<DpHeadDashVO> selectDashMemberClassList(Criteria cri) throws SQLException;
	
	public List<DepartmentMemberClassCommand> selectMemberClassCheckList(String department, int opcl) throws SQLException;
	
	public ExtReportVO selectExtReport(int no) throws SQLException;
	
	public IntReportVO selectIntReport(int no) throws SQLException;
	
	public void updateDpSeal (Map<String, Object> map) throws SQLException;
	
	public ReportClassCommand selectExtReportClass(int no) throws SQLException;
	
	public ReportClassCommand selectIntReportClass(int memClNo) throws SQLException;
	
	public void updateExtReportApproval(int no) throws SQLException;
	
	public void updateIntReportApproval(int no) throws SQLException;
	
	public void updateExtReportReturn(int no) throws SQLException;
	
	public void updateIntReportReturn(int no) throws SQLException;
	
	public CertificateVO selectCertificate() throws SQLException;
	
	public MemberCertificateVO selectCretificateByEmail(String memClNo, String memEmail) throws SQLException;
	
	public int selectClPoint(int opcl) throws SQLException;
	
	public String selectMemEmail(String memClNo)throws SQLException;
	
	public void updateMemCredit(Map<String, Object> map)throws SQLException;
	
	public List<DpHeadVO> selectMemDpOdList(String memEmail) throws SQLException;
}

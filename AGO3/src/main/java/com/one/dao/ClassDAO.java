package com.one.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.one.command.ClassModifyCommand;
import com.one.command.CompletedAvgCommand;
import com.one.command.Criteria;
import com.one.command.RegistClassCommand;
import com.one.command.RegistClassOrderCommand;
import com.one.dto.OpclVO;
import com.one.dto.ClassVO.ClassChapterVO;
import com.one.dto.ClassVO.ClassDocumentVO;
import com.one.dto.ClassVO.ClassEXT;
import com.one.dto.ClassVO.ClassListVO;
import com.one.dto.ClassVO.ClassRegistFormVO;
import com.one.dto.ClassVO.ClassReviewVO;
import com.one.dto.ClassVO.ClassStasticsVO;
import com.one.dto.ClassVO.ClassVO;
import com.one.dto.ClassVO.TestVO;


public interface ClassDAO {
	public List<ClassListVO> getClassList(Criteria cri) throws SQLException;

	public List<ClassListVO> getClassAllList() throws SQLException;

	public ClassListVO getClassByclCode(String clCode) throws SQLException;
	
	public List<ClassChapterVO> getClassChapter(String clCode) throws SQLException;
	
	public List<ClassDocumentVO> getClassDocument(String clCode) throws SQLException;
	
	public List<ClassReviewVO> getClassReview(String clCode) throws SQLException;
	
	public List<ClassRegistFormVO> getClCateList() throws SQLException;
	
	public List<ClassRegistFormVO> getDpIdList() throws SQLException;
	
	public void RegistClassWithoutSubInfo(ClassVO cls) throws SQLException;
	
	public String getclCode() throws SQLException;
	
	public int getTestNo() throws SQLException;
	
	public List<ClassListVO> getClassRoom() throws SQLException;
	
	public void RegistOpcl(OpclVO opcl) throws SQLException;
	
	public int getOpcl() throws SQLException;
	
	public void insertClChapter(List<ClassChapterVO> chapterList) throws Exception;
	
	public int getClassTotalCount(Criteria cri) throws SQLException;
	
	public void modifyClass(ClassVO clModify) throws Exception;
	
	public void ModifyClChapter(List<ClassChapterVO> chapterList,String clCode) throws Exception;
	
	public TestVO getTest(String clCode) throws SQLException;
	
	public void InsertTestNull(ClassModifyCommand cmc) throws SQLException;
	
	public void deleteOpenClass(OpclVO opcl) throws SQLException;
	
	public List<OpclVO> getOpclByclCode(String clCode) throws SQLException;
	
	public int getRoundNo(String clCode) throws SQLException;
	
	public OpclVO getOpclByopenRound(OpclVO opclDetail) throws SQLException;
	
	public int selectCountAllClass() throws SQLException;
	
	public int selectCountIntern() throws SQLException;
	
	public int selectCountNormal() throws SQLException;
	
	public int selectCountHobby() throws SQLException;
	
	//오프라인강의 QRcode생성
	public void updateClQR(OpclVO opcl) throws SQLException;

	public ClassListVO selectClassInfo(int opcl) throws SQLException;
	
	public List<CompletedAvgCommand> getCompletedAvgByOpenClass() throws SQLException;
	
	public List<ClassListVO> selectClassMemListByOpcl(int opcl) throws SQLException;
	
	public void modifyOpenClass(OpclVO opcl) throws SQLException;
	
	public int countOpenClassByclCode(String clCode) throws SQLException;
	
	public void deleteClass(String clCode) throws SQLException;
	
	public List<ClassStasticsVO> getOnlyUseDetailMemListByOpcl(int opclNum, Criteria cri) throws SQLException;
	
	public List<ClassListVO > selectMainEPList() throws SQLException; 
	
	public void registClassOrderByDpid(RegistClassOrderCommand dpList) throws SQLException;
	
	public List<RegistClassOrderCommand> getClassOrderByOpcl(int opcl) throws SQLException;
	
	public List<ClassDocumentVO> getclDocListByOpcl(int opcl) throws SQLException;
	
	public List<ClassListVO> getclassEdate() throws SQLException;
	
	public int getOnlyUseDetailMemListByOpclCount(int opcl) throws SQLException;
}

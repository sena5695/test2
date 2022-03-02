package com.one.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.one.command.MemberClassCommand;
import com.one.dto.DepartmentVO;
import com.one.dto.FinishedClassVO;
import com.one.dto.MemberClVO;
import com.one.dto.MemberRemindSetVO;
import com.one.dto.MemberRemindVO;
import com.one.dto.MemberVO;
import com.one.dto.NewRemindCheckVO;
import com.one.dto.ClassVO.ClassVO;

public interface MemberDAO {

	// 아이디로 멤버
	public MemberVO selectMemberById(String memId) throws SQLException;

	// 이메일로 인적사항 찾기
	public MemberVO selectMemberByEmail(String memEmail) throws SQLException;

	// dpId로 사원 목록
	public List<MemberVO> selectMemberByDpId(String dpId) throws SQLException;

	// opcl로 memberCl view 목록 조회
	public List<MemberClVO> selectMemberClByOpcl(int opcl) throws SQLException;

	// 가입(아이디랑 비밀번호 저장)
	public void insertIdAndPwd(MemberVO member) throws SQLException;

	// 등록
	public void insertMember(MemberVO member) throws SQLException;

	// 엑셀등록
	public void insertMembers(Map<String, Object> paramMap) throws Exception;

	public List<MemberClassCommand> selectMemberClassList(String memEmail) throws SQLException;

	public ClassVO selectMemberClassName(int opcl) throws SQLException;

	public List<DepartmentVO> selectMemberDepartment() throws SQLException;

	public List<DepartmentVO> selectMemberPosition() throws SQLException;

	public List<DepartmentVO> selectMemberAuthority() throws SQLException;

	public void updateMemberAuthority(MemberVO member) throws SQLException;

	public void updateMemberPwd(MemberVO member) throws SQLException;

	public void updatePwdById(MemberVO member) throws SQLException;

	public String memberStatusChk(MemberVO member) throws SQLException;
	
	public MemberRemindSetVO selectMemberRemindSet(String memEmail) throws SQLException;
	
	public List<MemberRemindVO> selectMemberNotReadRemind(String memEmail) throws SQLException;
	
	public List<NewRemindCheckVO> selectMemberIntrClass(String memEmail) throws SQLException;
	
	public List<NewRemindCheckVO> selectMemberRealTimeClass(String memEmail) throws SQLException;
	
	public int countExtReport(String dpId) throws SQLException;
	
	public int countIntReport(String dpId) throws SQLException;
	
	public int insertMemberRemd(MemberRemindVO newRemind) throws SQLException;
	
	// 학습 완료 강의  int
	public List<FinishedClassVO> selectMemberIntCtfClass(String memEmail) throws SQLException;
	// 학습 완료 강의  ext
	public List<FinishedClassVO> selectMemberExtCtfClass(String memEmail) throws SQLException;
}









































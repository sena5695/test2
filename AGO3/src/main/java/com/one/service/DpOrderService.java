package com.one.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.one.command.Criteria;
import com.one.command.CriteriaDpCommand;
import com.one.command.DepartmentMemberClassCommand;
import com.one.command.DpFavClassCommand;
import com.one.command.OrderCommand;
import com.one.dto.DpHeadVO;
import com.one.dto.ClassVO.ClassVO;

public interface DpOrderService {
	
	public Map<String, Object> selectDpClassList(CriteriaDpCommand cri) throws SQLException; 
	
	public Map<String, Object> selectDpClass(int opcl, String clCode)throws SQLException;

	//즐겨찾기목록
	public Map<String,Object> getFavList(CriteriaDpCommand cri) throws SQLException;
	
	public List<Map<String, String>> selectFav(String dpId) throws Exception;

	public void registFav(DpHeadVO fav) throws SQLException;

	public void removeFav(DpHeadVO fav) throws SQLException;

	public void DepartmentOrderOpcl(OrderCommand orderCmd, String dpId) throws SQLException;

	public Boolean favCheck(DpHeadVO fav) throws SQLException;

	public Map<String, Object> selectReportList(Criteria cri, String department) throws SQLException;
	
	public Map<String, Object> selectOrderClassMain(Criteria cri) throws SQLException;
	
	public List<DepartmentMemberClassCommand> selectMemberClassList(String department, int opcl)throws SQLException;
	
	public void updateDpSeal(String dpId, String fileName) throws SQLException;
	
	public String selectAutograph(String dpId)throws SQLException;
	
	public Map<String, Object> selectIntReport(int no) throws SQLException;
	
	public Map<String, Object> selectExtReport(int no) throws SQLException;
	
	public void updateReportApproval (String reType, int no, String memClNo, int opcl, String memEmail) throws SQLException;
	
	public void updateReportReturn (String reType, int no) throws SQLException;

}

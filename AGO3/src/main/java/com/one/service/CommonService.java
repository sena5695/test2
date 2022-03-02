package com.one.service;

import java.sql.SQLException;
import java.util.List;

import com.one.dto.CommonVO;
import com.one.dto.MemberVO;

public interface CommonService {

	public List<CommonVO> getCommonByGroupCode(String groupCode) throws SQLException;

	public String getCodeName1ByCommonCode(String commonCode) throws SQLException;

	public CommonVO getCommonVOByCommonCode(String commonCode) throws SQLException;
	
	public String getPositionByKeyword(String keyword) throws SQLException;
	
	public MemberVO getConvertPositionAndDpBymemInfo(MemberVO member) throws SQLException;
}

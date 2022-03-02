package com.one.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.one.command.Criteria;
import com.one.dto.ClassVO.ClassStasticsVO;

public interface LikeClassService {

	public Map<String, Object> getLikeClassList(String memEmail, Criteria cri, String memDpId)throws SQLException;
	
	public Map<String, Object> getLikeClPoint(String memEmail) throws SQLException;
	
	public void removeLikeCls(Map<String, Object> dataMap)throws SQLException;
	
	//public String exchangeStudyDate()throws SQLException;
}

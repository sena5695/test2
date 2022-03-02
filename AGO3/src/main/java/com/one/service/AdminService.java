package com.one.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.one.command.Criteria;
import com.one.dto.AdminVO;

public interface AdminService {

	AdminVO getAdmin(String loginId) throws SQLException;

	public Map<String, Object> selectMemberList(Criteria cri) throws SQLException;

	public void updateAuthority(String[] memId, boolean check) throws SQLException;

	public List<Map<String, String>> csvPaser(String loginLog, String userLoginFileName) throws IOException;

	public int selectAdminEmailCheck(String adminEmail) throws SQLException;

	public void updateAdminPwd(String adminEmail, String adminPwd) throws SQLException;

	public Map<String, String> selectProperties(String path, String savePathFileName) throws IOException;

}

package com.one.service.impl;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.one.command.Criteria;
import com.one.dao.AdminDAO;
import com.one.dto.AdminVO;
import com.one.service.AdminService;
import com.one.utils.CSVParser;
import com.one.utils.PropertiesParser;

public class AdminServiceImpl implements AdminService {

	private AdminDAO adminDAO;

	public void setAdminDAO(AdminDAO adminDAO) {
		this.adminDAO = adminDAO;
	}

	@Override
	public AdminVO getAdmin(String loginId) throws SQLException {
		AdminVO admin = adminDAO.selectAdminById(loginId);

//		throw new NullPointerException("null 포인트 에러");
		return admin;
	}

	@Override
	public Map<String, Object> selectMemberList(Criteria cri) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();

		dataMap.put("employeeList", adminDAO.selectEmployeeList(cri));
		dataMap.put("managerList", adminDAO.selectManagerList());
		dataMap.put("cri", cri);
		return dataMap;
	}

	@Override
	public void updateAuthority(String[] memId, boolean check) throws SQLException {
		if (check) {
			adminDAO.updateManagerAuthority(memId);
		} else {
			adminDAO.updateMemberAuthority(memId);
		}

	}

	@Override
	public List<Map<String, String>> csvPaser(String LogPath, String FileName) throws IOException {
		File filePath = new File(LogPath, FileName);

		List<Map<String, String>> dataCSV = CSVParser.parse(filePath.getAbsolutePath());

		return dataCSV;
	}

	@Override
	public int selectAdminEmailCheck(String adminEmail) throws SQLException {
		return adminDAO.selectAdminEmailCheck(adminEmail);
	}

	@Override
	public void updateAdminPwd(String adminEmail, String adminPwd) throws SQLException {
		Map<String, String> map = new HashMap<>();

		map.put("adminEmail", adminEmail);
		map.put("adminPwd", adminPwd);

		adminDAO.updateAdminPwd(map);

	}

	@Override
	public Map<String, String> selectProperties(String path, String savePathFileName) throws IOException {
		Map<String, String> dataMap = null;
		dataMap = PropertiesParser.parser(path, savePathFileName);
		return dataMap;
	}

}

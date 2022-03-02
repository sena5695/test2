package com.one.controller.admin;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.one.service.AdminService;
import com.one.service.JMSClassService;

@RestController
@RequestMapping("/admin/log")
public class LogRestController {

	@Resource(name = "loginLog")
	private String loginLog;

	@Resource(name="actionLog")
	private String actionLog;

	@Resource(name="errorLog")
	private String errorLog;

	@Resource(name = "userLoginFileName")
	private String userLoginFileName;

	@Resource(name = "managerLoginFileName")
	private String managerLoginFileName;

	@Resource(name = "adminLoginFileName")
	private String adminLoginFileName;

	@Resource(name = "userClassActionFileName")
	private String userClassActionFileName;

	@Resource(name = "managerActionFileName")
	private String managerActionFileName;

	@Resource(name = "adminActionFileName")
	private String adminActionFileName;

	@Resource(name = "errorFileName")
	private String errorFileName;

	@Autowired
	private AdminService adminService;

	@RequestMapping(value = "/userLog", method = RequestMethod.GET)
	public ResponseEntity<List<Map<String, String>>> userLog() throws Exception {
		ResponseEntity<List<Map<String, String>>> entity = null;

		try {
			List<Map<String, String>> dataCSV = adminService.csvPaser(loginLog, userLoginFileName);
			dataCSV.addAll(adminService.csvPaser(actionLog, userClassActionFileName));
			entity = new ResponseEntity<List<Map<String, String>>>(dataCSV, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<Map<String, String>>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@RequestMapping(value = "/managerLog", method = RequestMethod.GET)
	public ResponseEntity<List<Map<String, String>>> managerLog() throws Exception {
		ResponseEntity<List<Map<String, String>>> entity = null;

		try {
			List<Map<String, String>> dataCSV = adminService.csvPaser(loginLog, managerLoginFileName);
			dataCSV.addAll(adminService.csvPaser(actionLog, managerActionFileName));
			entity = new ResponseEntity<List<Map<String, String>>>(dataCSV, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<Map<String, String>>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@RequestMapping(value = "/adminLog", method = RequestMethod.GET)
	public ResponseEntity<List<Map<String, String>>> adminLog() throws Exception {
		ResponseEntity<List<Map<String, String>>> entity = null;

		try {
			List<Map<String, String>> dataCSV = adminService.csvPaser(loginLog, adminLoginFileName);
			dataCSV.addAll(adminService.csvPaser(actionLog, adminActionFileName));
			entity = new ResponseEntity<List<Map<String, String>>>(dataCSV, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<Map<String, String>>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@RequestMapping(value = "/errorLog", method = RequestMethod.GET)
	public ResponseEntity<List<Map<String, String>>> errorLog() throws Exception {
		ResponseEntity<List<Map<String, String>>> entity = null;

		try {
			List<Map<String, String>> dataCSV = adminService.csvPaser(errorLog, errorFileName);
			entity = new ResponseEntity<List<Map<String, String>>>(dataCSV, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<Map<String, String>>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

}

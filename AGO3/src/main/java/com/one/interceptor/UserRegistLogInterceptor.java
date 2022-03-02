package com.one.interceptor;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.one.dao.ClassDAO;
import com.one.dto.MemberVO;

public class UserRegistLogInterceptor extends HandlerInterceptorAdapter {

	private String savePath;
	private String saveFileName;
	private ClassDAO classDAO;

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}

	public void setClassDAO(ClassDAO classDAO) {
		this.classDAO = classDAO;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		boolean tag = false;
		String action = "";
		String clName = "";
		if (request.getServletPath().indexOf("regist") >= 0) {
			action = "regist";
			if (request.getServletPath().indexOf("hrd") >= 0) {
				clName = request.getParameter("extClName");
			} else {
				int opcl = Integer.parseInt(request.getParameter("opcl"));
				clName = classDAO.selectClassInfo(opcl).getClName();
			}
		}
		if (request.getServletPath().indexOf("drop") >= 0) {
			action ="remove";
			int opcl = Integer.parseInt(request.getParameter("opcl"));
			clName = classDAO.selectClassInfo(opcl).getClName();
		}
		MemberVO loginUser = (MemberVO) request.getSession().getAttribute("loginUser");
		String head = "action,ServletPath,clName,memName,memEmail,remoteAddr,date,memId,memPhone";
		String log = action + "," + request.getServletPath() + "," + clName + "," + loginUser.getMemName() + "," + loginUser.getMemEmail() + "," + request.getRemoteAddr() + "," + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()) +"," + loginUser.getMemId()+"," + loginUser.getMemPhone();
		String NEWLINE = System.lineSeparator();
		File file = new File(savePath);
		if (!file.exists()) {
			file.mkdirs();
		}
		String logFilePath = savePath + File.separator + saveFileName;

		FileOutputStream fos = null;
		OutputStreamWriter osw = null;
		BufferedWriter bfw = null;

		if (!new File(logFilePath).exists()) {
			tag = true;
		}
		try {
			fos = new FileOutputStream(logFilePath, true);
			osw = new OutputStreamWriter(fos, "MS949");
			bfw = new BufferedWriter(osw);
			if (tag) {
				bfw.write(head);
				bfw.write(NEWLINE);
				tag = false;
			}
			bfw.write(log);
			bfw.write(NEWLINE);
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // 닫기
			if (bfw != null) {
				try {
					bfw.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (osw != null) {
				try {
					osw.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (fos != null) {
				try {
					fos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
}

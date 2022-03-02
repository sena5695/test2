package com.one.controller.user.myPage;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.one.command.Criteria;
import com.one.command.MemberCriteria;
import com.one.dto.CertificateVO;
import com.one.dto.MemberCertificateVO;
import com.one.dto.MemberVO;
import com.one.service.impl.CertificateServiceImpl;

@Controller
@RequestMapping("/user/myPage/certificate")
public class CertificateController {
	
	@Autowired
	private CertificateServiceImpl certificateService;
	
	// 수료증 발급 목록
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public ModelAndView list(MemberCriteria mCri, ModelAndView mnv, HttpSession session) throws Exception{
		String url = "/user/myPage/Certificate/list";
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		mCri.setMemEmail(member.getMemEmail());
		
		Map<String, Object> dataMap = certificateService.getCretificateList(mCri);
		
		mnv.setViewName(url);
		mnv.addObject("dataMap", dataMap);
		return mnv;
	}
	
	// 수료증 발급 버튼 눌렀을때
	@RequestMapping(value = "/certificate.pop", method = RequestMethod.GET)
	public ModelAndView certificate(ModelAndView mnv, HttpSession session, String clCode) throws Exception{
//		String url = "/user/myPage/Certificate/printCertificate";
		String url = "/user/myPage/Certificate/certificate";
		Map<String, Object> dataMap = new HashMap<String, Object>();
		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		
		CertificateVO certificate = certificateService.getCertificate();
		MemberCertificateVO memCertificate = certificateService.getMemberCretificate(clCode, member.getMemEmail());
		
		dataMap.put("certificate", certificate);
		dataMap.put("memCertificate", memCertificate);

		mnv.setViewName(url);
		mnv.addObject("dataMap", dataMap);
		return mnv;
	}
	
	 // 문의게시판 상세 페이지 
	@RequestMapping(value = "/detail.do", method = RequestMethod.GET)
	public ModelAndView detail(String askNo, ModelAndView mnv) throws Exception{
		String url = "/user/myPage/Certificate/detail";

		mnv.setViewName(url);
		return mnv;
	}
	
	
		
}

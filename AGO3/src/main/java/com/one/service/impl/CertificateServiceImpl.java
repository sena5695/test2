package com.one.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.one.command.Criteria;
import com.one.command.MemberCriteria;
import com.one.command.PageMaker;
import com.one.dao.CertificateDAO;
import com.one.dto.CertificateListVO;
import com.one.dto.CertificateVO;
import com.one.dto.MemberCertificateVO;
import com.one.service.CertificateService;

public class CertificateServiceImpl implements CertificateService{
	
	private CertificateDAO certificateDAO;
	public void setCertificateDAO(CertificateDAO certificateDAO) {
		this.certificateDAO = certificateDAO;
	}
	
	public CertificateVO getCertificate() throws Exception{
		return certificateDAO.selectCertificate();
	}
	
	public void registCertificate(CertificateVO certificate) throws Exception{
		certificateDAO.insertCertificate(certificate);
	}

	@Override
	public Map<String, Object> getCretificateList(MemberCriteria mCri) throws Exception {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		int totalCount = (int) certificateDAO.countMemberCertificateList(mCri);
		
		List<CertificateListVO> memCertificateList = certificateDAO.selectCretificateListByEmail(mCri);
		
		List<String> certificateYearList = certificateDAO.selectCertificateYear(mCri.getMemEmail());
		System.out.println("@@@@@@@@@@           yearlist  [" + certificateYearList.toString());
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(mCri);
		pageMaker.setTotalCount(totalCount);
		
		dataMap.put("certificateYearList", certificateYearList);
		dataMap.put("memCertificateList", memCertificateList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public MemberCertificateVO getMemberCretificate(String clCode, String memEmail) throws Exception {
		return certificateDAO.selectCretificateByEmail(clCode, memEmail);
	}
	
}

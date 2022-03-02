package com.one.service.impl;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.util.SystemPropertyUtils;

import com.google.zxing.datamatrix.DataMatrixReader;
import com.one.command.Criteria;
import com.one.command.PageMaker;
import com.one.dao.ClassReviewDAO;
import com.one.dao.ClassStasticsDAO;
import com.one.dao.ManagementMemberDAO;
import com.one.dto.DepartmentVO;
import com.one.dto.ClassVO.ClassStasticsVO;
import com.one.service.ClassStasticsService;

public class ClassStasticsServiceImpl implements ClassStasticsService{

	private ClassStasticsDAO classStasticsDAO;
	
	private ManagementMemberDAO managementMemberDAO;
	
	private ClassReviewDAO classReviewDAO;
	
	public void setClassStasticsDAO(ClassStasticsDAO classStasticsDAO) {
		this.classStasticsDAO = classStasticsDAO;
	}

	public void setManagementMemberDAO(ManagementMemberDAO managementMemberDAO) {
		this.managementMemberDAO = managementMemberDAO;
	}
	public void setClassReviewDAO(ClassReviewDAO classReviewDAO) {
		this.classReviewDAO = classReviewDAO;
	}


	@Override
	public List<ClassStasticsVO> selectStasticsClassInfoList() throws SQLException {
		List<ClassStasticsVO> classList = classStasticsDAO.selectselectInfoStasticsClassList();
		
		return classList;
	}

	@Override
	public Map<String, Object> getAgeSpecificPreferenceData() throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<ClassStasticsVO> listOf20s = classStasticsDAO.selectResultValuesByAge(20);
		List<ClassStasticsVO> listOf30s = classStasticsDAO.selectResultValuesByAge(30);
		List<ClassStasticsVO> listOf40s = classStasticsDAO.selectResultValuesByAge(40);
		List<ClassStasticsVO> listOf50s = classStasticsDAO.selectResultValuesByAge(50);
		List<ClassStasticsVO> listOf60s = classStasticsDAO.selectResultValuesByAge(60);
		
		
		dataMap.put("listOf20s", listOf20s);
		dataMap.put("listOf30s", listOf30s);
		dataMap.put("listOf40s", listOf40s);
		dataMap.put("listOf50s", listOf50s);
		dataMap.put("listOf60s", listOf60s);
		
		return dataMap;
	}

	@Override
	public Map<String, Object> getClassGraphInfo() throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		List<ClassStasticsVO> graph20sInfo = classStasticsDAO.selectClassGraphInfo(20);
		List<ClassStasticsVO> graph30sInfo = classStasticsDAO.selectClassGraphInfo(30);
		List<ClassStasticsVO> graph40sInfo = classStasticsDAO.selectClassGraphInfo(40);
		List<ClassStasticsVO> graph50sInfo = classStasticsDAO.selectClassGraphInfo(50);
		List<ClassStasticsVO> graph60sInfo = classStasticsDAO.selectClassGraphInfo(60);
		
		dataMap.put("graph20sInfo", graph20sInfo);
		dataMap.put("graph30sInfo", graph30sInfo);
		dataMap.put("graph40sInfo", graph40sInfo);
		dataMap.put("graph50sInfo", graph50sInfo);
		dataMap.put("graph60sInfo", graph60sInfo);
		
		return dataMap;
	}

	@Override
	public Map<String, Object> getClassGraphInfoByDpId() throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		//그래프 그리기 위한 데이터
		List<ClassStasticsVO> firstClInfo = classStasticsDAO.selectFirstClassByDpId();
		List<ClassStasticsVO> secondClInfo = classStasticsDAO.selectSecondClassByDpId();
		List<ClassStasticsVO> thirdClInfo = classStasticsDAO.selectThirdClassByDpId();
		
		//부서코드 부서명으로 바꿔
		List<DepartmentVO> depList = managementMemberDAO.selectDepartment();
		
		if(firstClInfo != null) {
			for(ClassStasticsVO firstCl : firstClInfo) {
				for(DepartmentVO dep : depList) {
					if(firstCl.getDpId().equals(dep.getCommonCode())) {
						firstCl.setDpId(dep.getCodeName1());
					}
				}
			}
		}
		if(secondClInfo != null) {
			for(ClassStasticsVO secondCl : secondClInfo) {
				for(DepartmentVO dep : depList) {
					if(secondCl.getDpId().equals(dep.getCommonCode())) {
						secondCl.setDpId(dep.getCodeName1());
					}
				}
			}
		}
		if(thirdClInfo != null) {
			for(ClassStasticsVO thirdCl : thirdClInfo) {
				for(DepartmentVO dep : depList) {
					if(thirdCl.getDpId().equals(dep.getCommonCode())) {
						thirdCl.setDpId(dep.getCodeName1());
					}
				}
			}
		}
		
		
		dataMap.put("firstClInfo", firstClInfo);
		System.out.println("      왜 안나와          "+firstClInfo);
		dataMap.put("secondClInfo", secondClInfo);
		dataMap.put("thirdClInfo", thirdClInfo);
		
		return dataMap;
	}

	@Override
	public Map<String, Object> getTotalOpenClass(Criteria cri) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<ClassStasticsVO> totalOpenClList = classStasticsDAO.selectTotalOpenClass(cri);
		
		
		//평균값 계산
		for(ClassStasticsVO clData : totalOpenClList) {
			try {
				String reviewAvg = classStasticsDAO.selectReviewAvgByOpcl(clData.getOpcl());
				if(reviewAvg.length() == 1){
					clData.setReviewScore(reviewAvg+".0");
					clData.setReScrIntPart(Integer.parseInt(reviewAvg));
					clData.setReScrDecimal(0);
				} else{
					
					int reScrIntPart = Integer.parseInt(reviewAvg.substring(0, 1));
					int reScrDecimal = Integer.parseInt(reviewAvg.substring(2, 3));
					
					clData.setReviewScore(reviewAvg);
					clData.setReScrIntPart(reScrIntPart);
					clData.setReScrDecimal(reScrDecimal);
				}
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			Date sDate = clData.getPostSdate();
			Date eDate = clData.getPostEdate();
			
			Date today = new Date();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(sDate != null && eDate != null) {
				if(today.before(sDate) ) {
					clData.setPostStatus("게시 전");
				}else if(sdf.format(today).compareTo(sdf.format(eDate)) >= 0 ) {
					clData.setPostStatus("게시 종료");
				}else if(sdf.format(today).compareTo(sdf.format(sDate)) >= 0 && sdf.format(today).compareTo(sdf.format(eDate)) <= 0){
					clData.setPostStatus("게시 중");
				}
			}
		}
		
	
		int totalCount = classStasticsDAO.selectTotalOpenClassCount(cri);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		dataMap.put("totalOpenClList", totalOpenClList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public ClassStasticsVO getClassDetailByOpcl(int opcl) throws SQLException {
		ClassStasticsVO clDetail = classStasticsDAO.selectClassDetailByOpcl(opcl);
		
		try {
			String reviewAvg = classStasticsDAO.selectReviewAvgByOpcl(clDetail.getOpcl());
			if(reviewAvg.length() == 1){
				clDetail.setReviewScore(reviewAvg+".0");
				clDetail.setReScrIntPart(Integer.parseInt(reviewAvg));
				clDetail.setReScrDecimal(0);
			} else{
				
				int reScrIntPart = Integer.parseInt(reviewAvg.substring(0, 1));
				int reScrDecimal = Integer.parseInt(reviewAvg.substring(2, 3));
				
				clDetail.setReviewScore(reviewAvg);
				clDetail.setReScrIntPart(reScrIntPart);
				clDetail.setReScrDecimal(reScrDecimal);
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		Date sDate = clDetail.getPostSdate();
		Date eDate = clDetail.getPostEdate();
		
		Date today = new Date();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(sDate != null && eDate != null) {
			if(today.before(sDate)) {
				clDetail.setPostStatus("게시 전");
			}else if(sdf.format(today).compareTo(sdf.format(eDate)) >= 0 ) {
				clDetail.setPostStatus("게시 종료");
			}else if(sdf.format(today).compareTo(sdf.format(sDate)) >= 0 && sdf.format(today).compareTo(sdf.format(eDate)) <= 0){
				clDetail.setPostStatus("게시 중");
			}
		}
		
		return clDetail;
	}

	@Override
	public Map<String, Object> getDetailGraphData(int opcl) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		List<ClassStasticsVO> listStudyRatioByDp = classStasticsDAO.selectDataStudyRatioByDpId(opcl);
		List<ClassStasticsVO> listStudyRationByAges = classStasticsDAO.selectDataStudyRationByAges(opcl);
		
		
		dataMap.put("listByDp", listStudyRatioByDp);
		dataMap.put("listByAges", listStudyRationByAges);
		return dataMap;
	}

	@Override
	public List<ClassStasticsVO> getListMainExposure() throws SQLException {
		List<ClassStasticsVO> exposureOpclList = classStasticsDAO.selectMainExposureOpclNotNull();
		System.out.println(exposureOpclList);
		return exposureOpclList;
	}

	@Override
	public void modifyMainExposureStatus(ClassStasticsVO modifyInfo) throws SQLException {
		if(modifyInfo.getMainExposure() != null) {
			classStasticsDAO.updateMainExposureStatus(modifyInfo);
		}else {
			classStasticsDAO.deleteMainExposureStatus(modifyInfo.getOpcl());
		}
	}
	
	

}

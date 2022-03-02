package com.one.service.impl;

import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.one.command.ClassReviewCommand;
import com.one.command.Criteria;
import com.one.dao.ClassReviewDAO;
import com.one.dto.ClassVO.ClassVO;
import com.one.service.ClassReviewService;

public class ClassReviewServiceImpl implements ClassReviewService {

	private ClassReviewDAO classReviewDAO;
	public void setClassReviewDAO(ClassReviewDAO classReviewDAO) {
		this.classReviewDAO = classReviewDAO;
	}
	
	@Override
	public Map<String, Object> getClassReviewList(Criteria cri) throws Exception {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		List<ClassReviewCommand> reviewList = classReviewDAO.selectClassReviewList(cri);
		
		dataMap.put("reviewList", reviewList);
		dataMap.put("cri", cri);
		
		return dataMap;
	}


	@Override
	public Map<String, Object> getClassReviewDetail(int opcl) throws Exception {
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		// 강의 상세
		ClassVO classDetail = classReviewDAO.selectClassDetail(opcl);
		
		// 강의 평점 평균
		double reviewAVG = classReviewDAO.selectReviewAVG(opcl);
		reviewAVG = Math.round(reviewAVG*100)/100.0;
		
		// 점수대별 인원수
		List<Integer> countReviewScoreList = classReviewDAO.countReviewScore(opcl);
		Map<String, Integer> countReviewScoreMap = new HashMap<String, Integer>();
		int totalCount = 0;
		for(int i = 0; i < countReviewScoreList.size(); i++) {
			if(countReviewScoreList.get(i) != 0)
				totalCount += 1;
			countReviewScoreMap.put("num"+i, countReviewScoreList.get(i));
		}
		
		// 점수대별 % 계산
		Map<String, Double> perScoreMap = new HashMap<String, Double>();
		for(int i = 0; i < countReviewScoreList.size(); i++) {
			double percent = (double)countReviewScoreList.get(i) / (double)totalCount * 100.0;
			perScoreMap.put("per"+i, percent);
		}
		
		// 상세의 후기 리스트
		List<ClassReviewCommand> reviewDetail = classReviewDAO.selectDetailReviewList(opcl);
		DateFormat format = new SimpleDateFormat("yyyy년도 MM월 수강생");
		for(int i=0; i<reviewDetail.size(); i++) {
			// Date 값을 가져와서 String으로 변환한다.
			String memId = format.format(reviewDetail.get(i).getReviewRegdate());
			reviewDetail.get(i).setMemId(memId);
		}
		for(int i=0; i<reviewDetail.size(); i++) {
			String icons = "";
			if(reviewDetail.get(i).getScope() != 0.0) {
				for(int j=1; j<=reviewDetail.get(i).getFrontScope(); j++) {
					icons += "<i class=\"fas fa-star text-warning\"></i>";
				}
				if(reviewDetail.get(i).getBackScope() == 5) {
					icons += "<i class=\"fas fa-star-half-alt text-warning\"></i>";
				}
				for(int j=1; j<=reviewDetail.get(i).getRestScope(); j++) {
					icons += "<i class=\"far fa-star text-warning\"></i>";
				}
			}
			reviewDetail.get(i).setIcons(icons);
		}
		
		dataMap.put("classDetail", classDetail);
		dataMap.put("reviewAVG", reviewAVG);
		dataMap.put("countReviewScoreMap", countReviewScoreMap);
		dataMap.put("perScoreMap", perScoreMap);
		dataMap.put("reviewDetail", reviewDetail);
		
		return dataMap;
	}



}

























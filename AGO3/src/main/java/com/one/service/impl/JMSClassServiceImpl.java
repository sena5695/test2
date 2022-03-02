package com.one.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.one.command.ClassCommand;
import com.one.command.ClassReviewCommand;
import com.one.dao.CommonDAO;
import com.one.dao.JMSClassDAO;
import com.one.dao.MyClassDAO;
import com.one.dto.MemberClVO;
import com.one.dto.MemberVO;
import com.one.dto.ClassVO.ClassChapterVO;
import com.one.dto.ClassVO.ClassDocumentVO;
import com.one.dto.ClassVO.ClassListVO;
import com.one.dto.ClassVO.ClassReviewVO;
import com.one.service.JMSClassService;
import com.one.utils.PwdToEncryption;

public class JMSClassServiceImpl implements JMSClassService {
	private JMSClassDAO jmsClassDAO;
	private CommonDAO commonDAO;
	private MyClassDAO myClassDAO;

	public void setJmsClassDAO(JMSClassDAO jmsClassDAO) {
		this.jmsClassDAO = jmsClassDAO;
	}
	public void setCommonDAO(CommonDAO commonDAO) {
		this.commonDAO = commonDAO;
	}
	public void setMyClassDAO(MyClassDAO myClassDAO) {
		this.myClassDAO = myClassDAO;
	}
	@Override
	public void pwd() {
		List<MemberVO> memList = jmsClassDAO.getMem();
		for(MemberVO mem : memList) {
			System.out.println(PwdToEncryption.encry(mem.getMemId(), "qweqwe"));
			mem.setMemPwd(PwdToEncryption.encry(mem.getMemId(), "qweqwe"));
			jmsClassDAO.setPwd(mem);
		}
	}

	@Override
	public Map<String, Object> selectOpcl(int opcl) throws SQLException {
		Map<String, Object> dataMap = null;

		ClassCommand claz = getClassList(opcl);
		claz.setScope(jmsClassDAO.selectAvgReviewScoreByOpcl(opcl));
		dataMap = new HashMap<String, Object>();
		dataMap.put("claz", claz);
		return dataMap;
	}

	@Override
	public ClassListVO selectClass(int opcl) throws SQLException {
		ClassListVO claz = null;
		claz = getClassList(opcl);
		return claz;
	}

	@Override
	public List<ClassChapterVO> selectChapter(int opcl, String memEmail) throws SQLException {
		ClassListVO classInfo = jmsClassDAO.selectClassAndOpClByOpcl(opcl);
		List<ClassChapterVO> chapList = new ArrayList<ClassChapterVO>();
		MemberClVO memClass = null;
		MemberClVO clChap = new MemberClVO();
		clChap.setMemEmail(memEmail);
		clChap.setOpcl(opcl);
		if (classInfo.getClFormat().equals("A602")) {
			chapList = jmsClassDAO.selectClChapterListByOpcl(opcl);

			for (ClassChapterVO chap : chapList) {
				clChap.setClChap(chap.getClChapNum());
				chap.setMemFinishChk(jmsClassDAO.checkMemChap(clChap));
				MemberClVO memChap = jmsClassDAO.getMemChap(clChap);

				memClass = myClassDAO.selectMemCLByOpclAndEmail(clChap);

				if (chap.getClChapName().contentEquals("시험")) {
					if (chapList.size() == chap.getClChapNum()
							&& chapList.get(chapList.size() - 1).getClChapName().contentEquals("시험")) {
						chap.setfTestCheck(true);
						if (memChap != null) {
							if (memChap.getProgChap() == 100) {
								chap.setDofTestCheck(true);
								chap.setfTestCheck(false);
								chap.setfScore(memClass.getFintestScore());
							}
						}
					} else {
						chap.setmTestCheck(true);
						if (memChap != null) {
							if (memChap.getProgChap() == 100) {
								chap.setDomTestCheck(true);
								chap.setmTestCheck(false);
//							memClass = myClassDAO.selectMemCLByOpclAndEmail(clChap);
								chap.setmScore(memClass.getMidtestScore());
							}
						}
					}
				}

				if (memChap != null) {
					chap.setProgChap(memChap.getProgChap());
				}


			}
		}else {
			memClass = myClassDAO.selectMemCLByOpclAndEmail(clChap);
			ClassChapterVO chap = new ClassChapterVO();
			if (memClass.getProgRate() == 100) {
				chap.setMemFinishChk(true);
			}
			chapList.add(chap);
		}

		return chapList;
	}

	@Override
	public List<ClassDocumentVO> selectDocument(int opcl) throws SQLException {
		List<ClassDocumentVO> docList = null;
		docList = jmsClassDAO.selectClDocListByOpcl(opcl);
		return docList;
	}

	@Override
	public List<ClassReviewCommand> selectReview(int opcl) throws SQLException {
		List<ClassReviewCommand> reviewList = null;
		ClassListVO claz = jmsClassDAO.selectClassAndOpClByOpcl(opcl);

		reviewList = jmsClassDAO.selectClReviewListByOpcl(opcl);

		for (ClassReviewVO review : reviewList) {
			review.setClCode(claz.getClCode());
			review.setClName(claz.getClName());

			review.setMemName(jmsClassDAO.selectMemberByMemId(review.getMemId()).getMemName());
		}

		for (int i = 0; i < reviewList.size(); i++) {
			String icons = "";
		 	if(reviewList.get(i).getScope() > 0.0) {
				for(int j=1; j<=reviewList.get(i).getFrontScope(); j++) {
					icons += "<i class=\"fas fa-star text-warning\"></i>";
				}
				if(reviewList.get(i).getBackScope() == 5) {
					icons += "<i class=\"fas fa-star-half-alt text-warning\"></i>";
				}
				for(int j=1; j<=reviewList.get(i).getRestScope(); j++) {
					icons += "<i class=\"far fa-star text-warning\"></i>";
				}
			}
			reviewList.get(i).setIcons(icons);
		}
		return reviewList;
	}

	public ClassCommand getClassList(int opcl) throws SQLException {
		ClassCommand claz = null;
		claz = jmsClassDAO.selectClassAndOpClByOpcl(opcl);

		claz.setClFormat(commonDAO.selectCommonByCommonCode(claz.getClFormat()).getCodeName1());
		claz.setClCate(commonDAO.selectCommonByCommonCode(claz.getClCate()).getCodeName1());
		claz.setStudyDate(commonDAO.selectCommonByCommonCode(claz.getStudyDate()).getCodeName1());
		claz.setClDivision(commonDAO.selectCommonByCommonCode(claz.getClDivision()).getCodeName1());

		if (!claz.getStudyDate().equals("제한없음")) {
			claz.setStudyDate("신청일로부터 " + claz.getStudyDate() + "일");
		}

		return claz;
	}

	@Override
	public MemberClVO getMemChap(MemberClVO memberCL) throws SQLException {
		MemberClVO memChap = jmsClassDAO.getMemChap(memberCL);
		return memChap;
	}

	@Override
	public void dropClass(int opcl, String memEmail) throws SQLException {
		MemberClVO memClVO = new MemberClVO();
		memClVO.setOpcl(opcl);
		memClVO.setMemEmail(memEmail);

		jmsClassDAO.deleteStudyingClass(memClVO);
	}

	@Override
	public int getotallProgChap(int memClNo) throws SQLException {
		List<MemberClVO> AllprogChapList= jmsClassDAO.selectAllProgChapByMemClNo(memClNo);
		int totalProgChap = 0;
		for(MemberClVO progChap : AllprogChapList) {
			totalProgChap += progChap.getProgChap();
		}
		System.out.println("    합계 프로그챕      "+totalProgChap);
		return totalProgChap;
	}

	@Override
	public int gettotalProgChapList(int memClNo, int clChap, int progChap) throws SQLException {
		List<MemberClVO> AllProgChapList = jmsClassDAO.selectAllProgChapByMemClNo(memClNo);
		System.out.println("몇 챕터인데"+clChap);
		AllProgChapList.get(clChap-1).setProgChap(progChap);

		int totalProgChap = 0;
		for(MemberClVO progChapter : AllProgChapList) {
			totalProgChap += progChapter.getProgChap();
		}
		return totalProgChap;
	}

	@Override
	public int gettotalProgChapList2(int memClNo, int clChap, int progChap) throws SQLException {
		List<MemberClVO> AllProgChapList = jmsClassDAO.selectAllProgChapByMemClNo(memClNo);
		int totalProgChap = 0;
		for(MemberClVO progChapter : AllProgChapList) {
			totalProgChap += progChapter.getProgChap();
		}
		totalProgChap += progChap;
		return totalProgChap;
	}

	@Override
	public int getProgRateByOpcl(int opcl, String memEmail) throws SQLException {
		ClassListVO clazVO = new ClassListVO();
		clazVO.setOpcl(opcl);
		clazVO.setMemEmail(memEmail);
		int progRate = jmsClassDAO.selectProgRate(clazVO);
		return progRate;
	}

}

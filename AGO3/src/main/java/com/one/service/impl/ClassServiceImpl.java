package com.one.service.impl;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.one.command.ClassCommand;
import com.one.command.ClassModifyCommand;
import com.one.command.CompletedAvgCommand;
import com.one.command.Criteria;
import com.one.command.DpFavClassCommand;
import com.one.command.PageMaker;
import com.one.command.RegistClassCommand;
import com.one.command.RegistClassOrderCommand;
import com.one.dao.AttachDAO;
import com.one.dao.ClassDAO;
import com.one.dao.CommonDAO;
import com.one.dao.DpOrderDAO;
import com.one.dao.UserClassDAO;
import com.one.dto.AttachVO;
import com.one.dto.ExcelDTO;
import com.one.dto.OpclVO;
import com.one.dto.ClassVO.ClassChapterVO;
import com.one.dto.ClassVO.ClassDocumentVO;
import com.one.dto.ClassVO.ClassListVO;
import com.one.dto.ClassVO.ClassRegistFormVO;
import com.one.dto.ClassVO.ClassReviewVO;
import com.one.dto.ClassVO.ClassStasticsVO;
import com.one.dto.ClassVO.ClassVO;
import com.one.dto.ClassVO.TestVO;
import com.one.service.ClassService;
import com.one.utils.ExcelUtil;
import com.one.utils.JsTreeJsonConversion;

public class ClassServiceImpl implements ClassService{

	private ClassDAO classDAO;

	private AttachDAO attachDAO;

	private CommonDAO commonDAO;
	
	private UserClassDAO userClassDAO;
	
	private DpOrderDAO dpOrderDAO;
	

	public void setUserClassDAO(UserClassDAO userClassDAO) {
		this.userClassDAO = userClassDAO;
	}
	public void setAttachDAO(AttachDAO attachDAO) {
		this.attachDAO = attachDAO;
	}
	public void setClassDAO(ClassDAO classDAO) {
		this.classDAO = classDAO;
	}
	public void setCommonDAO(CommonDAO commonDAO) {
		this.commonDAO = commonDAO;
	}
	public void setDpOrderDAO(DpOrderDAO dpOrderDAO) {
		this.dpOrderDAO = dpOrderDAO;
	}

	@Override
	public String getClCode() throws SQLException {
		String clCode = classDAO.getclCode();
		return clCode;
	}

	@Override
	public Map<String, Object> getClassList(Criteria cri) throws SQLException {
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<ClassListVO> mainList = classDAO.getClassList(cri);
		String firstclCode = null;
		int totalCount = classDAO.getClassTotalCount(cri);
		if(totalCount > 0) {
			firstclCode = mainList.get(0).getClCode();
			
		}

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		dataMap.put("firstclCode", firstclCode);
		dataMap.put("pageMaker", pageMaker);
		dataMap.put("mainList", mainList);
		return dataMap;
	}

	@Override
	public List<Map<String, String>> getClassAllList(String dpId) throws Exception {
		List<Map<String, String>> jsonData = null;
		List<DpFavClassCommand> classList = dpOrderDAO.selectDpClassList(dpId);
		/*List<DpFavClassCommand> dpClassList = new ArrayList<>();
		
		for(ClassListVO clas : classList) {
			if(clas.getClCate().equals("A202")) {
				int opcl = clas.getOpcl();
				//강의 부서 가져오기
				List<RegistClassOrderCommand> classOrderList = classDAO.getClassOrderByOpcl(opcl);
				for(RegistClassOrderCommand dpClassOrder : classOrderList) {
					if(dpClassOrder.getDpId().equals(dpId)) {
						dpClassList.add(clas);
					}
				}
			}
		}*/
		
		jsonData = JsTreeJsonConversion.conversion(classList);

		return jsonData;
	}

	@Override
	public List<Map<String, String>> getClassAllListNoIcon() throws Exception {
		List<Map<String, String>> jsonData = null;
		List<ClassListVO> classList = classDAO.getClassAllList();

		jsonData = JsTreeJsonConversion.NoIconConversion(classList);

		return jsonData;
	}
	

	@Override
	public ClassCommand getReviewAVG(int opcl) throws SQLException {
		//강의평점
		ClassCommand classVO = userClassDAO.selectClass(opcl);
		return classVO;
	}


	@Override
	public Map<String,Object> getClassByclCode(String clCode,String opcl) throws SQLException {

		Map<String,Object> dataMap = new HashMap<String,Object>();
	//강의정보
		ClassListVO detail = classDAO.getClassByclCode(clCode);
		String intro = detail.getClIntro();
		if(detail.getClFormat().equals("A601")) {
			detail.setClFormat("오프라인");
		}else if(detail.getClFormat().equals("A602")) {
			detail.setClFormat("온라인");
		}else {
			detail.setClFormat("실시간");
		}

		if(detail.getClDivision().equals("A501")) {
			detail.setClDivision("필수");
		}else {
			detail.setClDivision("선택");
		}
		
		
		List<ClassChapterVO> chapterList = new ArrayList<>();
	//강의 목차
		if(detail.getClFormat().equals("온라인")){
			chapterList = classDAO.getClassChapter(clCode);			
			System.out.println(chapterList.toString());
		}

		
		
	//강의 자료
		List<ClassDocumentVO> documentList = classDAO.getClassDocument(clCode);
		
		
	//수강 후기
		List<ClassReviewVO> reviewList = classDAO.getClassReview(clCode);

		if(opcl != null) {
			
			TestVO testFile =  classDAO.getTest(opcl);
			if(!(testFile == null)) {
				
				String mtestName = testFile.getMtestFile();
				String ftestName = testFile.getFtestFile();
				if(!(mtestName == null)) {
					mtestName = mtestName.substring(mtestName.lastIndexOf("$")+1);
				}
				if(!(ftestName == null)) {
					ftestName = ftestName.substring(ftestName.lastIndexOf("$")+1);
				}
				testFile.setMtestFile(mtestName);
				testFile.setFtestFile(ftestName);
				
				dataMap.put("testFile", testFile);
			}
		}

		dataMap.put("detail", detail);
		dataMap.put("chapterList", chapterList);
		dataMap.put("documentList", documentList);
		dataMap.put("reviewList", reviewList);
		
		return dataMap;
	}

	@Override
	public Map<String, Object> getClassRegistForm() throws SQLException {
		Map<String,Object> dataMap = new HashMap<String,Object>();

		List<ClassRegistFormVO> CateList = classDAO.getClCateList();
		List<ClassRegistFormVO> clDivisionList = commonDAO.getClDivision();
		List<ClassRegistFormVO> clFormatList = commonDAO.getClFormat();

		dataMap.put("cateList", CateList);
		dataMap.put("divisionList", clDivisionList);
		dataMap.put("formatList", clFormatList);

		return dataMap;
	}

	@Override
	public Map<String, Object> getOpenClassRegistForm() throws SQLException {
		Map<String,Object> dataMap = new HashMap<String,Object>();
		//오픈클래스 필요한것
		List<ClassRegistFormVO> DpIdList = classDAO.getDpIdList();
		System.out.println(DpIdList.toString());
		List<ClassListVO> ClassRoomList = classDAO.getClassRoom();
		List<ClassRegistFormVO> studyDateList = commonDAO.getStudyDate();
//		ClassListVO classList = classDAO.getClassByclCode(clCode);
		dataMap.put("studyDateList", studyDateList);
		dataMap.put("roomList", ClassRoomList);
		dataMap.put("dpidList", DpIdList);
//		dataMap.put("classList", classList);
		return dataMap;
	}
	
	
	@Override
	public String RegistClassWithoutSubInfo(ClassVO cls) throws SQLException {
		String clCode = classDAO.getclCode();
		cls.setClCode(clCode);
		classDAO.RegistClassWithoutSubInfo(cls);
		return clCode;
	}

	@Override
	public void insertClassFileclChapNameAttach(List<AttachVO> clChapNameList) throws Exception {
		AttachVO attach = new AttachVO();
		if(clChapNameList != null) {
			attach.setFileName(clChapNameList.get(0).getFileName());
			attach.setRegDate(clChapNameList.get(0).getRegDate());
		}

		attachDAO.insertClassFileclChapNameAttach(attach);
	}

	@Override
	public void insertClassFileclDocAttach(List<AttachVO> clDocList, String clCode, int opcl) throws Exception {

		System.out.println(clCode);
//		AttachVO attach = new AttachVO();
//			for(int i = 0; i < clDocList.size(); i++) {
//				attach.setClCode(clCode);
//				attach.setFileName(clDocList.get(i).getFileName());
//				attach.setRegDate(clDocList.get(i).getRegDate());
//			}
			for(AttachVO attach1 : clDocList) {
				int docNo = attachDAO.getNextDocNo();
				attach1.setClCode(clCode);
				attach1.setDocNO(docNo);
				attach1.setOpcl(opcl);
				System.out.println("@@@@@@@@@@@@@@ 인써트 클래스파일 씨엘독어테치");
				System.out.println(attach1);
				attachDAO.insertClassFileclDocAttach(attach1);
			}
	}

	@Override
	public void insertClassFileMiddleTestAttach(List<AttachVO> MiddleList, int opcl, int testNo, String testStatus) throws Exception {


		AttachVO attach = new AttachVO();
		try {
			attach.setRegDate(MiddleList.get(0).getRegDate());
			attach.setFileName(MiddleList.get(0).getFileName());
			
		}catch(Exception e) {
			
		}
		
		attach.setOpcl(opcl);
		attach.setTestNo(testNo);	
		attach.setTestStatus(testStatus);	
		
		attachDAO.insertClassFileMiddleTestAttach(attach);
	}

	@Override
	public void insertClassFileFinalTestAttach(List<AttachVO> FinalList, int opcl, int testNo, String testStatus) throws Exception {

		AttachVO attach = new AttachVO();
		try {
			attach.setFileName(FinalList.get(0).getFileName());
			attach.setRegDate(FinalList.get(0).getRegDate());
		}catch(Exception e) {
			
		}
		attach.setTestNo(testNo); //테스트넘버
		attach.setOpcl(opcl);
		attach.setTestStatus(testStatus);
		
		attachDAO.insertClassFileFinalTestAttach(attach);
	}

	@Override
	public int getTestNo() throws SQLException {
		int testNo = classDAO.getTestNo();
		return testNo;
	}

	@Override
	public void RegistOpcl(OpclVO opcl) throws SQLException {
		classDAO.RegistOpcl(opcl);

	}

	@Override
	public int getOpcl() throws SQLException {
		int opcl = classDAO.getOpcl();
		return opcl;
	}

	@Override
	public void RegistChapter(File uploadFile, String clCode) throws IOException, SQLException {

		ExcelDTO excelDTO = new ExcelDTO();

		// 파일경로 추가
		excelDTO.setFilePath(uploadFile.getAbsolutePath());
		// 컬럼명 추가
		excelDTO.setOutputColumns("A", "B", "C", "D");
		// 시작행
		excelDTO.setStartRow(3);

		List<Map<String, String>> excelContent = ExcelUtil.read(excelDTO);
		List<ClassChapterVO> chapterList = new ArrayList<ClassChapterVO>();

		for(Map<String,String> test : excelContent) {
			ClassChapterVO chapter = new ClassChapterVO();
			chapter.setClCode(clCode);
			chapter.setClChapNum(Integer.parseInt(test.get("A")));
			chapter.setClChapName(test.get("B"));
			chapter.setClChapTime(test.get("C"));
			chapter.setClChapVideo(test.get("D"));

			chapterList.add(chapter);
		}

		try {
			classDAO.insertClChapter(chapterList);
		}catch(Exception e) {
			e.printStackTrace();
		}

	}


	//-----------------------------------------------------수정--------------------------------------------------------

	@Override
	public void modifyClass(ClassVO clModify) throws Exception {
		classDAO.modifyClass(clModify);

	}

	@Override
	public void ModifyChapter(File uploadFile, String clCode) throws IOException, SQLException {
		ExcelDTO excelDTO = new ExcelDTO();

		// 파일경로 추가
		excelDTO.setFilePath(uploadFile.getAbsolutePath());
		// 컬럼명 추가
		excelDTO.setOutputColumns("A", "B", "C", "D");
		// 시작행
		excelDTO.setStartRow(3);

		List<Map<String, String>> excelContent = ExcelUtil.read(excelDTO);
		List<ClassChapterVO> chapterList = new ArrayList<ClassChapterVO>();

		for(Map<String,String> test : excelContent) {
			ClassChapterVO chapter = new ClassChapterVO();
			chapter.setClCode(clCode);
			chapter.setClChapNum(Integer.parseInt(test.get("A")));
			chapter.setClChapName(test.get("B"));
			chapter.setClChapTime(test.get("C"));
			chapter.setClChapVideo(test.get("D"));

			chapterList.add(chapter);
		}

		try {
			classDAO.ModifyClChapter(chapterList, clCode);
		}catch(Exception e) {
			e.printStackTrace();
		}

	}



	@Override
	public void ModifyClassFileMiddleTestAttach(List<AttachVO> MiddleList, String opcl, int testNo) throws Exception {
		AttachVO attach = new AttachVO();
		if(MiddleList != null) {
			attach.setOpcl(Integer.parseInt(opcl));
			attach.setTestNo(testNo);
			attach.setFileName(MiddleList.get(0).getFileName());
			attach.setRegDate(MiddleList.get(0).getRegDate());
			
		}
		attachDAO.ModifyClassFileMiddleTestAttach(attach);
	}



	@Override
	public void ModifyClassFileFinalTestAttach(List<AttachVO> FinalList, String opcl, int testNo) throws Exception {

		AttachVO attach = new AttachVO();
		if(FinalList != null) {
			attach.setTestNo(testNo); //테스트넘버
			attach.setOpcl(Integer.parseInt(opcl));
			attach.setFileName(FinalList.get(0).getFileName());
			attach.setRegDate(FinalList.get(0).getRegDate());
			
		}
		attachDAO.ModifyClassFileFinalTestAttach(attach);
	}

	@Override
	public TestVO getTest(String opcl) throws Exception {
		TestVO test = classDAO.getTest(opcl);
		return test;
	}

	@Override
	public void InsertTestNull(ClassModifyCommand cmc) throws Exception {
		classDAO.InsertTestNull(cmc);
	}

	@Override
	public void deleteClass(OpclVO opcl) throws SQLException {
		String clCode = opcl.getClCode();
		int count = classDAO.countOpenClassByclCode(clCode);
		classDAO.deleteOpenClass(opcl);
		if(count == 1) {
			classDAO.deleteClass(clCode);
		}

	}

	@Override
	public List<OpclVO> getOpclByclCode(String clCode) throws SQLException {
		List<OpclVO> opcl = classDAO.getOpclByclCode(clCode);
		System.out.println("@@@@@@@@@@@@" + opcl.toString());
		return opcl;
	}

	@Override
	public int getNextRound(String clCode) throws SQLException {
		int nextRound = classDAO.getRoundNo(clCode);
		return nextRound;
	}

	@Override
	public OpclVO getOpclByopenRound(OpclVO opclDetail) throws SQLException {
		OpclVO opcl = classDAO.getOpclByopenRound(opclDetail);
		return opcl;
	}

	@Override
	public int selectCountAllClass() throws SQLException {
		int count = classDAO.selectCountAllClass();
		return count;
	}

	@Override
	public Map<String, Object> selectAllCateCount() throws SQLException {
		Map<String,Object> dataMap = new HashMap<>();
		
		int intern = classDAO.selectCountIntern();
		int normal = classDAO.selectCountNormal();
		int hobby = classDAO.selectCountHobby();
		
		List<ClassListVO> EdateClassList = classDAO.getclassEdate();		
		
		dataMap.put("EdateList", EdateClassList);
		dataMap.put("intern", intern);
		dataMap.put("normal", normal);
		dataMap.put("hobby", hobby);
		
		return dataMap;
	}

	@Override
	public void registQR(OpclVO opcl) throws SQLException {
		classDAO.updateClQR(opcl);
	}

	@Override
	public ClassListVO getClassInfo(int opcl) throws SQLException {
		ClassListVO classInfo = classDAO.selectClassInfo(opcl);
		return classInfo;
	}

	@Override
	public List<ClassListVO> getClassMemListByOpcl(int opcl) throws SQLException {
		List<ClassListVO> classMemList = classDAO.selectClassMemListByOpcl(opcl);
		return classMemList;
	}

	@Override
	public Map<String, Object> getCompletedAvgByOpenClass() throws SQLException {
		Map<String,Object> avgMap = new HashMap<>();
		List<CompletedAvgCommand> comAvg =  classDAO.getCompletedAvgByOpenClass();
		
		avgMap.put("comAvg", comAvg);
		return avgMap;
	}

	@Override
	public List<ClassChapterVO> getClassChapter(String clCode) throws SQLException {
		List<ClassChapterVO> chapter = classDAO.getClassChapter(clCode);
		return chapter;
	}
	
	@Override
	public void modifyOpenClass(OpclVO opcl) throws SQLException {
		classDAO.modifyOpenClass(opcl);
		
	}

	@Override
	public Map<String,Object> getOnlyUseDetailMemListByOpcl(int opclNum, Criteria cri) throws SQLException {
		Map<String,Object> dataMap3 = new HashMap<>();
		List<ClassStasticsVO> memList = classDAO.getOnlyUseDetailMemListByOpcl(opclNum,cri);
		
		int totalCount = classDAO.getOnlyUseDetailMemListByOpclCount(opclNum);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
			dataMap3.put("pageMaker", pageMaker);
			dataMap3.put("memList", memList);
		return dataMap3;
	}

	@Override
	public void RegistClassOrderByDpid(RegistClassCommand rcc, int opcl) throws SQLException {
		if(rcc.getDpId() != null) {
			for(int i = 0; i < rcc.getDpId().size(); i ++) {
				RegistClassOrderCommand dpList = new RegistClassOrderCommand();
				String dpid = rcc.getDpId().get(i);
				dpList.setDpId(dpid);
				dpList.setOpcl(opcl);
				
				classDAO.registClassOrderByDpid(dpList);
			}
			
		}
		
	}

	@Override
	public List<RegistClassOrderCommand> getClassOrderByOpcl(int opcl) throws SQLException {
			List<RegistClassOrderCommand> dpList = classDAO.getClassOrderByOpcl(opcl);
		return dpList;
	}

	@Override
	public List<ClassDocumentVO> getclDocListByOpcl(int opcl) throws SQLException {
		List<ClassDocumentVO> documentList = classDAO.getclDocListByOpcl(opcl);
		return documentList;
	}


}






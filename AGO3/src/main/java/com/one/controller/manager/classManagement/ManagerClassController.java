package com.one.controller.manager.classManagement;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.one.command.ClassCommand;
import com.one.command.ClassDashLogCommand;
import com.one.command.ClassModifyCommand;
import com.one.command.Criteria;
import com.one.command.RegistClassCommand;
import com.one.command.RegistClassOrderCommand;
import com.one.dto.AttachVO;
import com.one.dto.CommonVO;
import com.one.dto.OpclVO;
import com.one.dto.ClassVO.ClassChapterVO;
import com.one.dto.ClassVO.ClassDocumentVO;
import com.one.dto.ClassVO.ClassListVO;
import com.one.dto.ClassVO.ClassRegistFormVO;
import com.one.dto.ClassVO.ClassStasticsVO;
import com.one.dto.ClassVO.ClassVO;

import com.one.dto.ClassVO.TestVO;
import com.one.service.AdminService;
import com.one.service.ClassService;
import com.one.service.ClassStasticsService;
import com.one.utils.CreateQRUtill;
import com.one.utils.GetAttachesFromMultipartFileAdapter;
import com.one.utils.MakeFileName;
@Controller
@RequestMapping("/manager/classManagement")
public class ManagerClassController {
	
	@Autowired
	private ClassService classService;
	
	@Autowired
	private ClassStasticsService classStasticsService;
	
	@Autowired
	private AdminService adminService;
	

	@Resource(name = "classUploadPath")
	private String picturePath;
	
	@Resource(name = "excelTempPath")
	private String excelTempPath;
	
	@Resource(name = "excelFormPath")
	private String excelFormPath;
	
	@Resource(name="qrCodeimg")
	private String qrCodeimg;
	
	@Resource(name="userClassActionFileName")
	private String logFileName;
	
	@Resource(name="actionLog")
	private String logPath;
	
	
	 // 메인페이지 - 대시보드
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public ModelAndView main(Locale locale, ModelAndView mnv) throws SQLException{
		String url ="/manager/classManagement/classDash";
		int count = classService.selectCountAllClass();
		Map<String,Object> dataMap = classService.selectAllCateCount();
		Map<String,Object> avgMap = classService.getCompletedAvgByOpenClass();
		List<ClassDashLogCommand> logList = new ArrayList<ClassDashLogCommand>();
		
		try {
			List<Map<String, String>> dataCSV = adminService.csvPaser(logPath, logFileName);
			mnv.addObject("dataCSV",dataCSV);
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
		mnv.addObject("avgMap",avgMap);
		mnv.addObject("dataMap",dataMap);
		mnv.addObject("count",count);
		mnv.setViewName(url);
		  return mnv;
	}
	
	 // 강의 리스트
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public ModelAndView list(Criteria cri, ModelAndView mnv, String message) throws SQLException {
		String url = "/manager/classManagement/classManagement";
			cri.setPerPageNum(5);
			System.out.println(cri.getKeyword());
			System.out.println(cri.getStartRowNum());
			System.out.println(cri.getPerPageNum());
			
			Map<String,Object> dataMap = classService.getClassList(cri);

			mnv.addObject("message",message);
			mnv.addObject("dataMap",dataMap);
			mnv.setViewName(url);
		
		  return mnv;
	}
	
	// 강의상세페이지
	@RequestMapping("/detailClass.do")
	@ResponseBody
	public ResponseEntity<Map<String,Object>> detail(String clCode) throws SQLException {
			ResponseEntity<Map<String,Object>> entity = null;
			Map<String,Object> dataMap = new HashMap<String,Object>();
			try {
				dataMap = classService.getClassByclCode(clCode,null);
				List<OpclVO> opcl =  classService.getOpclByclCode(clCode);
				
				
				
				
				if(!(opcl == null)) {
					dataMap.put("opcl", opcl);					
				}
				entity = new ResponseEntity<Map<String,Object>>(dataMap,HttpStatus.OK);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		
		return entity;
	}
	
	@RequestMapping("/detailInfoClass.do")
	public ModelAndView detailInfoClass(String clCode,String openRound, ModelAndView mnv, Criteria cri, String message) throws SQLException {
			String url = "manager/classManagement/detail";
			Map<String,Object> dataMap = new HashMap<String,Object>();
			OpclVO opclDetail = new OpclVO();
			opclDetail.setClCode(clCode);
			System.out.println("@@@@@@@@@@@@@@@@ openRound    [ " + openRound);
			opclDetail.setOpenRound(Integer.parseInt(openRound));
			cri.setPerPageNum(7);
			
			
			try {
				//클래스인포
				dataMap = classService.getClassByclCode(clCode,null);
				//오픈클래스 인포

				OpclVO opcl = classService.getOpclByopenRound(opclDetail);
				int opclNum = opcl.getOpcl();
				
				List<ClassDocumentVO> documentList = classService.getclDocListByOpcl(opclNum);
				dataMap.put("documentList1", documentList);
				
				//강의별점
				ClassCommand classVO = classService.getReviewAVG(opclNum);
				//수강생정보
				Map<String,Object> dataMap3 = classService.getOnlyUseDetailMemListByOpcl(opclNum,cri);
				System.out.println("@@@@@@         datamap 3 [ " + dataMap3.get("memList").toString());
				mnv.addObject("dataMap3",dataMap3);
				dataMap.put("classVO", classVO);
				if(opcl != null) {
					dataMap.put("opcl", opcl);					
				}
			
				List<RegistClassOrderCommand> dplist = classService.getClassOrderByOpcl(opclNum);
				mnv.addObject("dpList",dplist);
			}catch(Exception e) {
				e.printStackTrace();
			}
			mnv.addObject("openRound",openRound);
			mnv.addObject("message",message);
			mnv.addObject("dataMap",dataMap);
			
			mnv.setViewName(url);
		
		return mnv;
	}	
	
	
	
	// 강의수정페이지
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/modifyClass.do", method = RequestMethod.GET)
	public ModelAndView modifyForm(String clCode, String openRound,String opclNo, ModelAndView mnv) throws SQLException{
		String url ="/manager/classManagement/modify";
		
		//강의별점
		ClassCommand classVO = classService.getReviewAVG(Integer.parseInt(opclNo));
		
		
		Map<String,Object> dataMap = classService.getClassByclCode(clCode,opclNo);
		Map<String,Object> dataMap2 = classService.getClassRegistForm();
		Map<String,Object> dataMap3 = classService.getOpenClassRegistForm();
		OpclVO opclDetail = new OpclVO();
		opclDetail.setClCode(clCode);
		opclDetail.setOpenRound(Integer.parseInt(openRound));

		OpclVO opcl = classService.getOpclByopenRound(opclDetail);
		if(opcl.getLecDate() != null) {
			
			Date lecDateDB = opcl.getLecDate();
			//------------------------날짜 재조합----------------------------------------------
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm");
			String lecDate = sdf.format(lecDateDB);
			String lecTime = sdf2.format(lecDateDB);
			try {
				Date convertLecDate = new Date(sdf.parse(lecDate).getTime());
				Date convertLecTime = new Date(sdf2.parse(lecTime).getTime());
				mnv.addObject("lecDate",convertLecDate);
				mnv.addObject("lecTime",convertLecTime);
			} catch (ParseException e) {
				
				e.printStackTrace();
			}
		}
		//---------------------------------------------------------------------------------
		
//		System.out.println("@@@@@@@@@@@ lecDate[" + lecDate);
//		System.out.println("@@@@@@@@@@@ lecTime[" + lecTime);
		
		dataMap.put("opcl", opcl);
		dataMap.put("classVO", classVO);

		mnv.addObject("clCode",clCode);
		mnv.addObject("dataMap",dataMap);
		mnv.addObject("dataMap2",dataMap2);
		mnv.addObject("dataMap3",dataMap3);
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping(value = "/modify.do", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	public String modify(ClassModifyCommand cmc, RedirectAttributes rttr ) throws Exception {
		 String url="redirect:/manager/classManagement/detailInfoClass.do";
		 System.out.println(cmc.getOpcl());
		 OpclVO opcl = cmc.toOpclVO(); 
		 System.out.println(cmc.toString());
		 classService.modifyOpenClass(opcl);
		 
		 try {
			 
			if(cmc.getClFormat().equals("온라인")) {
				// 테이블이 있나 검사
				TestVO test = classService.getTest(cmc.getOpcl());
			// 없으면 테이블 생섬만 (null 값 넣은 상태로) if(테이블 검사) { 없으면 생성}
				int testNo = classService.getTestNo();
				
				if(test == null) {
				classService.InsertTestNull(cmc);
				}
			// 중간, 기말 있으면 각각 따로 update 구현
			
			List<AttachVO> clMtestList = GetAttachesFromMultipartFileAdapter.save(cmc.getMtestFile(),excelTempPath);	
			classService.ModifyClassFileMiddleTestAttach(clMtestList, cmc.getOpcl(), Integer.parseInt(cmc.getTestNo()));
			
			List<AttachVO> clFtestList = GetAttachesFromMultipartFileAdapter.save(cmc.getFtestFile(), excelTempPath);
			classService.ModifyClassFileFinalTestAttach(clFtestList, cmc.getOpcl(), Integer.parseInt(cmc.getTestNo()));				
							
			}
			
			

			
			
			 }catch(Exception e) {
				 e.printStackTrace();
			 }
		 
//		 		catch(IOException e) {
//				e.printStackTrace();
//				entity = new ResponseEntity<String>("데이터 형식이 잘못", HttpStatus.BAD_REQUEST);
//				
//			} catch(SQLException e) {
//				e.printStackTrace();
//				entity = new ResponseEntity<String>("요건 서버", HttpStatus.INTERNAL_SERVER_ERROR);
//			}
//			
		 	rttr.addAttribute("message","수정되었습니다.");
			rttr.addAttribute("clCode",cmc.getClCode());
			rttr.addAttribute("opclNo",cmc.getOpcl());
			rttr.addAttribute("openRound",cmc.getOpenRound());
		return url;
	}
		
	
	
	
	// 강의등록
	@RequestMapping(value = "/registClass.do", method = RequestMethod.GET)
	public ModelAndView registForm(Locale locale, ModelAndView mnv) throws SQLException{
		String url = "/manager/classManagement/regist";
		Map<String,Object> dataMap = classService.getClassRegistForm();

		Map<String,Object> dataMap2 = classService.getOpenClassRegistForm();
		mnv.addObject("dataMap",dataMap);
		mnv.addObject("dataMap2",dataMap2);
		mnv.setViewName(url);
		 return mnv;

	}
	
	@RequestMapping(value = "/registOpenClassForm.do", method = RequestMethod.GET)
	public ModelAndView registOpenForm(String clCode, ModelAndView mnv) throws SQLException{
		String url = "/manager/classManagement/registOpenClass";
		Map<String,Object> dataMap = classService.getOpenClassRegistForm();
		int maxRound = classService.getNextRound(clCode);
		Map<String,Object>dataMap2 = classService.getClassByclCode(clCode,null);
		
		mnv.addObject("maxRound",maxRound);
		mnv.addObject("dataMap2",dataMap2);
		mnv.addObject("dataMap",dataMap);
		mnv.addObject("clCode",clCode);
		mnv.setViewName(url);
		 return mnv;

	}	
	
	
	@RequestMapping("/getClassExcelFileForm.do")
	public String getFile(Model model) throws Exception {
		String url = "downloadFile";

		model.addAttribute("savePath", excelFormPath);
		model.addAttribute("fileName", "강의목차양식.xlsx");

		return url;
	}
	@RequestMapping("/getClassExcelMtestFileForm.do")
	public String getMtestFile(Model model) throws Exception {
		String url = "downloadFile";

		model.addAttribute("savePath", excelFormPath);
		model.addAttribute("fileName", "시험양식(중간평가).xlsx");

		return url;
	}
	@RequestMapping("/getClassExcelFtestFileForm.do")
	public String getFtestFile(Model model) throws Exception {
		String url = "downloadFile";

		model.addAttribute("savePath", excelFormPath);
		model.addAttribute("fileName", "시험양식(최종평가).xlsx");

		return url;
	}

	@RequestMapping("/getClassDocumentFile.do")
	public String getClassDocumentFile(String clDocName, Model model) throws Exception {
		String url = "downloadFile";

		model.addAttribute("savePath", excelTempPath);
		model.addAttribute("fileName", clDocName);

		return url;
	}		
	
	@RequestMapping(value = "/regist.do", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	public String regist(RegistClassCommand rcc, ModelAndView mnv, RedirectAttributes rttr) throws Exception{
		String url = "redirect:/manager/classManagement/list.do";
	
		System.out.println("@@@@@@@@@@@@@        dpid  [" + rcc.getDpId());
		
		System.out.println("@@@@@@@@@@@@lecdate["+rcc.getLecDate()+"]@@@");
		System.out.println("@@@@@@@@@@@@lecdate["+rcc.getLecDateTime()+"]@@@");
		
		//강의 인포 등록
		ClassVO classinfo = rcc.toClassVO();
		String clCode = classService.RegistClassWithoutSubInfo(classinfo);

		//오픈클래스
		
		int opcl = classService.getOpcl();
		
		OpclVO opclList = rcc.toOpclVO(clCode);
		opclList.setOpcl(opcl);	
		classService.RegistOpcl(opclList);

		classService.RegistClassOrderByDpid(rcc,opcl);
		
		if(rcc.getClFormat().equals("A602")){
			System.out.println("@@@@@@@@@@@@@@@@@@챕터 네임 등록 전 ");
			MultipartFile clChapName = rcc.getClChapName();
			
			File uploadFile = new File(excelTempPath,clChapName.getOriginalFilename());
			
			if(!uploadFile.exists()) {
				uploadFile.mkdirs();
			}
			try {
				clChapName.transferTo(uploadFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			classService.RegistChapter(uploadFile,rcc.getClCode());
			System.out.println("@@@@@@@@@@@@@@@@@@챕터 네임 등록 후 ");
			
			int testNo = classService.getTestNo();
			
			String testStatus = rcc.getTestStatus();	
			
			//시험 등록

			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			
			
				if(rcc.getClFormat().equals("A602")) {
					classService.RegistChapter(uploadFile,clCode);			
				
					List<AttachVO> clMtestList = GetAttachesFromMultipartFileAdapter.save(rcc.getMtestFile(),excelTempPath);
					System.out.println("@@@@@@@@@@@@@@@@                 파일있음                           ");				
					
					classService.insertClassFileMiddleTestAttach(clMtestList, opcl, testNo,testStatus);

					List<AttachVO> clFtestList = GetAttachesFromMultipartFileAdapter.save(rcc.getFtestFile(), excelTempPath);
					classService.insertClassFileFinalTestAttach(clFtestList, opcl,testNo,testStatus);				
				}
				

		}
		
		System.out.println("@@@@@@@@@@@@@@@@@@강의자료 등록 전 ");
		//강의 자료 등록
		if(!(rcc.getClDocName() == null)) {
			List<AttachVO> clDocList = GetAttachesFromMultipartFileAdapter.save(rcc.getClDocName(), excelTempPath);
			classService.insertClassFileclDocAttach(clDocList, clCode,opcl);
			System.out.println("@@@@@@@@@@@@@@@@@@강의자료 등록 후 ");
		}

		
			
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ing");
			
			
		
		//----------------------------------------------------------------------------
		
		rttr.addAttribute("message","등록되었습니다.");
		
		 return url;
	
	}
	
	@RequestMapping(value = "/registOpcl.do", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	public ResponseEntity<String> registOpcl(RegistClassCommand rcc) throws Exception{
		ResponseEntity<String> entity = null;
		
		
		try {
			int opcl = classService.getOpcl();
			
			OpclVO opclList = rcc.toNextOpclVO();
			opclList.setOpcl(opcl);	
			classService.RegistOpcl(opclList);
			
			classService.RegistClassOrderByDpid(rcc,opcl);
//			
//			MultipartFile clChapName = rcc.getClChapName();
//			
//			File uploadFile = new File(excelTempPath,clChapName.getOriginalFilename());
//			
//			if(!uploadFile.exists()) {
//				uploadFile.mkdirs();
//			}
//			try {
//				clChapName.transferTo(uploadFile);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			
//			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//			classService.RegistChapter(uploadFile,rcc.getClCode());
//			
			
			//강의 자료 등록
			if(!(rcc.getClDocName() == null)) {
				List<AttachVO> clDocList = GetAttachesFromMultipartFileAdapter.save(rcc.getClDocName(), excelTempPath);
				classService.insertClassFileclDocAttach(clDocList, rcc.getClCode(),opcl);
			}
			
			int testNo = classService.getTestNo();
			
			String testStatus = rcc.getTestStatus();
			//시험 등록

			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			
			
			if(rcc.getClFormat().equals("온라인")) {
				
				
				List<AttachVO> clMtestList = GetAttachesFromMultipartFileAdapter.save(rcc.getMtestFile(),excelTempPath);
				System.out.println("@@@@@@@@@@@@@@@@                 파일있음                           ");				
				
				classService.insertClassFileMiddleTestAttach(clMtestList, opcl, testNo,testStatus);

				List<AttachVO> clFtestList = GetAttachesFromMultipartFileAdapter.save(rcc.getFtestFile(), excelTempPath);
				classService.insertClassFileFinalTestAttach(clFtestList, opcl,testNo,testStatus);				
			}
			
			
			entity = new ResponseEntity<String>("등록되었습니다.", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return entity;
		
		
	}

	
	@RequestMapping(value = "/deleteClass.do", method = RequestMethod.POST, produces = "test/plain;charset=utf-8")
	@ResponseBody
	public ResponseEntity<String> deleteClass(HttpServletRequest request, RedirectAttributes rttr) throws Exception{
		ResponseEntity<String> entity = null;

		String clCode = request.getParameter("clCode");
		String openRound = request.getParameter("openRound");
		
		OpclVO opcl = new OpclVO();
		opcl.setClCode(clCode);
		opcl.setOpenRound(Integer.parseInt(openRound));
		
		try {
			classService.deleteClass(opcl);
			
			entity = new ResponseEntity<String>("삭제되었습니다.", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return entity;

		
	}	

	// 강의통계
	@RequestMapping(value = "/statistics.do", method = RequestMethod.GET)

	public ModelAndView statistics(Locale locale, ModelAndView mnv, Criteria cri) throws SQLException{
		 String url = "/manager/classManagement/stastics/FFclassStatistics";
		 
		 Map<String, Object> dataMap = new HashMap<String,Object>();
		 List<ClassStasticsVO>classList = classStasticsService.selectStasticsClassInfoList();
		 Map<String, Object> agePreferenceMap = classStasticsService.getAgeSpecificPreferenceData();
		 Map<String, Object> agesGraphInfo = classStasticsService.getClassGraphInfo();
		 Map<String, Object> graphInfoByDpId = classStasticsService.getClassGraphInfoByDpId();
		 Map<String, Object> totalOpenClassListMap = classStasticsService.getTotalOpenClass(cri);
		 
		 List<ClassStasticsVO> exposureList = classStasticsService.getListMainExposure();
		 
		 //메인화면 노출 설정 값
		 dataMap.put("exposureList", exposureList);
		 
		 
		 // 강의별 평점 순
		 dataMap.put("classList", classList);
		 dataMap.put("agePreferenceMap", agePreferenceMap);
		 
		 //연령대 그래프 정보만
		 dataMap.put("agesGraphInfo", agesGraphInfo);
		 
		 //부서별 선호 강의 상위 3개
		 dataMap.put("graphInfoByDpId", graphInfoByDpId);
		 
		 //강의전체 목록
		 dataMap.put("totalOpenClassListMap", totalOpenClassListMap);
		 
		 mnv.addObject("dataMap", dataMap);
		 mnv.setViewName(url);
		 
		 return mnv;

	}
	
	//메인노출 설정 변경
	@RequestMapping(value="/modifyMainExposure.do", method = RequestMethod.POST)
	public ResponseEntity<String> modifyMainExposure(HttpServletRequest request, RedirectAttributes rttr) throws SQLException{
		ResponseEntity<String> entity = null;
		ClassStasticsVO modifyInfo= new ClassStasticsVO(); 
		modifyInfo.setMainExposure(request.getParameter("mainExposure"));
		modifyInfo.setOpcl(Integer.parseInt(request.getParameter("opcl")));
		classStasticsService.modifyMainExposureStatus(modifyInfo);
		String result = "pass";
		entity = new ResponseEntity<String>(result, HttpStatus.OK);
		
		return entity;
		
	}
	
	// 강의통계상세페이지
	@RequestMapping(value = "/statisticsDetail.do", method = RequestMethod.GET)
	public ModelAndView statisticsdetail(int opcl, Locale locale, ModelAndView mnv) throws SQLException {
		 String url = "/manager/classManagement/stastics/detailStatistics";
		 //강의 상세 정보
		 ClassStasticsVO clDetail = classStasticsService.getClassDetailByOpcl(opcl);
		 //그래프 정보(부서별)
		 Map<String, Object> dataMap = classStasticsService.getDetailGraphData(opcl); 
		 
		 mnv.addObject("clDetail", clDetail);
		 mnv.addObject("graphDataMap", dataMap);
		 mnv.setViewName(url);
		 
		return mnv;
	}
	
	
	@RequestMapping(value = "/picture", method = RequestMethod.POST, produces = "test/plain;charset=utf-8")
	public ResponseEntity<String> picture(@RequestParam("pictureFile") MultipartFile multi, String oldPicture)
			throws IOException {
		ResponseEntity<String> entity = null;

		String result = savePicture(oldPicture, multi);

		entity = new ResponseEntity<String>(result, HttpStatus.OK);

		return entity;

	}

	@RequestMapping(value = "/getPicture", produces = "text/plain;charset=utf-8")
	public ResponseEntity<byte[]> getPicture(String picture) throws IOException {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		String imgPath = this.picturePath;
		try {

			in = new FileInputStream(new File(imgPath, picture));
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.CREATED);
		} finally {
			in.close();
		}

		return entity;
	}
	
	private String savePicture(String oldPicture, MultipartFile multi) throws IOException {

		String fileName = null;

		// 파일 유무 확인
		if (!(multi == null || multi.isEmpty() || multi.getSize() > 1024 * 1024 * 5)) {

			// 파일 저장 폴더 설정
			String uploadPath = picturePath;
			fileName = MakeFileName.toUUIDFileName(multi.getOriginalFilename(), "$$");
			File storeFile = new File(uploadPath, fileName);

			storeFile.mkdirs();

			// local HDD에 저장
			multi.transferTo(storeFile);

			if (oldPicture != null && !oldPicture.isEmpty()) {
				File oldFile = new File(uploadPath, oldPicture);
				if (oldFile.exists()) {
					oldFile.delete();
				}
			}
		}

		return fileName;
	}
	
	

	@RequestMapping("/getQR.do")
	public ModelAndView detail(String clCode, int opcl,HttpServletRequest request, ModelAndView mnv) throws Exception {
		String url = "/manager/classManagement/getQRCode";
		
		String qrUrl = request.getContextPath()+ "/user/myClass/clsStudying/checkAttd.do?opcl="+opcl+"&";
		String fileName = "";
		
		ClassListVO param = new ClassListVO();
		ClassListVO classInfo = classService.getClassInfo(opcl);
		
		
		System.out.println(classInfo.getClQr() ==null);
		
		if(classInfo.getClQr() !=null) {
			fileName = classInfo.getClQr();
		}else {
			fileName = MakeFileName.toUUIDFileName(clCode+"_"+opcl, "$$");
			CreateQRUtill.createQR(qrUrl, qrCodeimg, fileName);
			
			OpclVO opclVO = new OpclVO();
			opclVO.setClQr(fileName);
			opclVO.setOpcl(opcl);
			classService.registQR(opclVO);
		}
		
		mnv.addObject("classInfo",classInfo);
		mnv.addObject("fileName", fileName+".png");
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping(value = "/getQRImg", produces = "text/plain;charset=utf-8")
	public ResponseEntity<byte[]> getQRImg(String picture) throws IOException {
		InputStream in = null;
		
		ResponseEntity<byte[]> entity = null;
		String imgPath = this.qrCodeimg;
		try {

			in = new FileInputStream(new File(imgPath, picture));
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.CREATED);
		} finally {
			in.close();
		}

		return entity;
	}
	
}

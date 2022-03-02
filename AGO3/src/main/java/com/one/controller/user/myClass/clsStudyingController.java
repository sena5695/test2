package com.one.controller.user.myClass;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.one.command.ClassReviewCommand;
import com.one.command.MemberClassCommand;
import com.one.command.MemberCriteria;
import com.one.command.TestCommand;
import com.one.dto.ExamExcelVO;
import com.one.dto.MemberClVO;
import com.one.dto.MemberVO;
import com.one.dto.ClassVO.ClassChapterVO;
import com.one.dto.ClassVO.ClassDocumentVO;
import com.one.dto.ClassVO.ClassIntr;
import com.one.dto.ClassVO.ClassListVO;
import com.one.dto.ClassVO.ClassReviewVO;
import com.one.dto.ClassVO.TestVO;
import com.one.service.ClassService;
import com.one.service.ExamManagementService;
import com.one.service.JMSClassService;
import com.one.service.MyClassService;
import com.one.service.UserClassService;

@Controller
@RequestMapping("/user/myClass")
public class clsStudyingController {

	@Autowired
	private MyClassService service;
	@Autowired
	private UserClassService userService;
	@Autowired
	private ClassService classService;

	@Autowired
	private JMSClassService jmsClassService;

	@Autowired
	private ExamManagementService examManagementService;

	@Resource(name = "classUploadPath")
	private String picturePath;

	@Resource(name = "excelTempPath")
	private String excelTempPath;
	
	@Resource(name = "actionLog")
	private String savePath;
	
	@Resource(name = "userClassActionFileName")
	private String saveFileName;

	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public ModelAndView main(ModelAndView mnv, HttpSession session) throws SQLException {
		String url = "/user/myClass/myClassDash";

		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		Map<String, Object> dataMap = service.selectMyClassMain(loginUser.getMemEmail());
		dataMap.put("credit", loginUser.getMemCredit());
		System.out.println("size-------------------------------- " + dataMap.get("memberClassSize"));
		mnv.addObject("dataMap", dataMap);
		mnv.setViewName(url);
		return mnv;
	}

	@RequestMapping(value = "/bookmark", method = RequestMethod.POST)
	public ResponseEntity<String> bookmark(int opcl, Boolean markState, HttpSession session) throws Exception {
		ResponseEntity<String> entity = null;
		ClassIntr intr = new ClassIntr();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		/* System.out.println("---------------------"+opcl+","+loginUser.getMemEmail()); */

		intr.setMemEmail(loginUser.getMemEmail());
		intr.setOpcl(opcl);
		String result = "success";
		userService.updateBookmark(intr, markState);

		entity = new ResponseEntity<String>(result, HttpStatus.OK);

		return entity;

	}

	@RequestMapping(value = "/regist", method = RequestMethod.POST)
	public ResponseEntity<String> regist(int opcl, String endDay, String lecDate, HttpSession session) throws Exception {
		ResponseEntity<String> entity = null;
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		MemberClassCommand memberClass = new MemberClassCommand();
		memberClass.setMemEmail(loginUser.getMemEmail());
		memberClass.setOpcl(opcl);

		memberClass.setMemclState("C101");
		SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd");

		
		if(lecDate.isEmpty()|| lecDate.length()<1) {
			System.out.println("lecDate is  null!!");
			if (!endDay.equals("제한없음")) {
				memberClass.setEndDay(Integer.parseInt(endDay));
			}
			userService.insertMemberClass(memberClass);
		}else {
			System.out.println("lecDate is not null!!");
			Date date = new Date(format.parse(lecDate).getTime());
			System.out.println(date);
			memberClass.setStudyEdate(date);
			userService.insertMemberClassRealTime(memberClass);
		}

		String result = "success";
		entity = new ResponseEntity<String>(result, HttpStatus.OK);

		return entity;

	}

	@RequestMapping("/clsStudying/list.do")
	public ModelAndView listForclsStudying(MemberCriteria cri, HttpSession session, ModelAndView mnv) throws Exception {
		String url = "/user/myClass/clsStudying/list";
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		cri.setMemEmail(member.getMemEmail());
		cri.setPerPageNum(5);

		Map<String, Object> dataMap = service.selectListMyStudyingClass(cri);

		mnv.addObject("dataMap", dataMap);
		mnv.setViewName(url);
		return mnv;
	}

	@RequestMapping(value = "/getPicture", produces = "text/plain;charset=utf-8")
	public ResponseEntity<byte[]> getPicture(String picture) throws IOException {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		String imgPath = picturePath;
		try {

			in = new FileInputStream(new File(imgPath, picture));
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.CREATED);
		} finally {
			in.close();
		}

		return entity;
	}

	@RequestMapping(value = "/clsStudying/detail.do", method = RequestMethod.GET)
	public ModelAndView detailForclsStudying(int opcl, HttpSession session, ModelAndView mnv, String from) throws Exception {
		String url = "/user/myClass/clsStudying/detail";

		Map<String, Object> dataMap = jmsClassService.selectOpcl(opcl);

		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		int progRate = jmsClassService.getProgRateByOpcl(opcl, member.getMemEmail());

		mnv.addObject("from",from);
		mnv.addObject("dataMap", dataMap);
		mnv.addObject("progRate", progRate);
		mnv.setViewName(url);
		return mnv;
	}

	@RequestMapping(value = "/clsStudying/dropClass.do")
	public String dropClass(int opcl, HttpSession session) throws SQLException {
		String url = "redirect:/user/myClass/clsStudying/list.do";
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		MemberVO member = loginUser.getClone();
		String memEmail = member.getMemEmail();

		jmsClassService.dropClass(opcl, memEmail);

		return url;
	}

	@ResponseBody
	@RequestMapping(value = "/clsStudying/classInfo.do", method = RequestMethod.GET)
	public ResponseEntity<Object> classInfo(int opcl) throws Exception {
		ResponseEntity<Object> entity = null;

		try {

			ClassListVO claz = jmsClassService.selectClass(opcl);

			entity = new ResponseEntity<Object>(claz, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<Object>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping(value = "/clsStudying/classChap.do", method = RequestMethod.GET)
	public ResponseEntity<List<ClassChapterVO>> classChap(int opcl, HttpSession session) throws Exception {
		ResponseEntity<List<ClassChapterVO>> entity = null;
		try {
			List<ClassChapterVO> chapList = jmsClassService.selectChapter(opcl, ((MemberVO) session.getAttribute("loginUser")).getMemEmail());
			System.out.println("##############################[controller chapList]" +  chapList.toString());
			entity = new ResponseEntity<List<ClassChapterVO>>(chapList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<ClassChapterVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping(value = "/clsStudying/classDoc.do", method = RequestMethod.GET)
	public ResponseEntity<List<ClassDocumentVO>> classDoc(int opcl) throws Exception {
		ResponseEntity<List<ClassDocumentVO>> entity = null;

		try {
			List<ClassDocumentVO> docList = jmsClassService.selectDocument(opcl);

			entity = new ResponseEntity<List<ClassDocumentVO>>(docList, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<ClassDocumentVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@RequestMapping("/clsStudying/downloadDocumentFile.do")
	public String getClassDocumentFile(String clDocName, Model model) throws Exception {
		String url = "downloadFile";

		model.addAttribute("savePath", excelTempPath);
		model.addAttribute("fileName", clDocName);

		return url;
	}

	@ResponseBody
	@RequestMapping(value = "/clsStudying/classReview.do", method = RequestMethod.GET)
	public ResponseEntity<List<ClassReviewCommand>> classReview(int opcl) throws Exception {
		ResponseEntity<List<ClassReviewCommand>> entity = null;

		try {
			List<ClassReviewCommand> reviewList = jmsClassService.selectReview(opcl);
			entity = new ResponseEntity<List<ClassReviewCommand>>(reviewList, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<ClassReviewCommand>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@RequestMapping("/clsStudying/clsPlay.do")
	public ModelAndView clsPlay(String clChapVideo, ModelAndView mnv) throws Exception {
		String url = "user/myClass/clsStudying/clsPlay";

		mnv.addObject("clChapVideo", clChapVideo);
		mnv.setViewName(url);
		return mnv;
	}

	@RequestMapping(value = "/clsStudying/registMemChap.do", method = RequestMethod.POST)
	public ResponseEntity<String> registMemChap(@RequestBody MemberClVO memberCL,HttpServletRequest request, HttpSession session) throws Exception {
		ResponseEntity<String> entity = null;
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		MemberClassCommand command = new MemberClassCommand();
		command.setOpcl(memberCL.getOpcl());
		command.setMemEmail(memberCL.getMemEmail());

		int memClNo = service.getmemClNoByOpcl(command);
		memberCL.setMemClNo(memClNo);

		try {
			MemberClVO chkMemChap = jmsClassService.getMemChap(memberCL); // opcl 챕터 번호 챕터진도율
			double progRate;

			// 전체챕터 수
			int chapterCnt = service.getClChapterCnt(memberCL.getClCode()) * 100;

			int totalProgChap = 0;

			if (chkMemChap != null) {
				// System.out.println("기존 progratechap "+chkMemChap.getProgChap()+" 기존 clChap"+chkMemChap.getClChap()+" 새로운 progchap "+memberCL.getProgChap()+" 새로운 clchap"+memberCL.getClChap());
				if (chkMemChap.getProgChap() >= memberCL.getProgChap()) {
					System.out.println("박");
					totalProgChap = jmsClassService.getotallProgChap(memberCL.getMemClNo());
					progRate = Math.round(((double) totalProgChap / chapterCnt) * 100);
					memberCL.setProgChap(chkMemChap.getProgChap());
				} else {
					totalProgChap = jmsClassService.gettotalProgChapList(memberCL.getMemClNo(), memberCL.getClChap(), memberCL.getProgChap());

					progRate = Math.round(((double) totalProgChap / chapterCnt) * 100);
				}
				memberCL.setProgRate((int) progRate);

				service.modifyMemChap(memberCL);
				service.modifyMemCLProgRate(memberCL);
			} else {
				// 처음 듣는 챕터를 끝까지 들었을 때
				totalProgChap = jmsClassService.gettotalProgChapList2(memberCL.getMemClNo(), memberCL.getClChap(), memberCL.getProgChap());
				progRate = Math.round(((double) totalProgChap / chapterCnt) * 100);
				memberCL.setProgRate((int) progRate);

				service.regisetMemChap(memberCL);
				service.modifyMemCLProgRate(memberCL);
			}

			// 수료율 100% 시 studyCpl 1로 수정
			Boolean last = lastChapChek(memberCL.getOpcl(), memberCL.getMemEmail(), memberCL.getClChap());
			MemberClVO memberClass = service.getMemCLByOpclAndEmail(memberCL);
			if (last) {
				if (memberClass.getProgRate() == 100) {
					memberCL.setStudyCpl(1);
					service.modifyStudyCpl(memberCL);
					Map<String, String> dataMap = new HashMap<String, String>();
					dataMap.put("path", request.getServletPath());
					dataMap.put("addr", request.getRemoteAddr());
					dataMap.put("opcl", memberCL.getOpcl() + "");
					dataMap.put("savePath", savePath);
					dataMap.put("saveFileName", saveFileName);
					
					service.insertLog(loginUser, dataMap);
				}
				MemberClVO lastMemberClass = service.getMemCLByOpclAndEmail(memberCL);
				if(lastMemberClass.getStudyCpl() == 1 && lastMemberClass.getTestCpl() == 1 && lastMemberClass.getProgRate() == 100) {
					memberCL.setMemclState("C102");
					service.modifyMemClState(memberCL);
				}
			}

			entity = new ResponseEntity<String>("success", HttpStatus.OK);

		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return entity;
	}

	@RequestMapping("/clsStudying/QRCheck.do")
	public String qrCheck() throws Exception {
		String url = "user/myClass/clsStudying/QRCheck";

		return url;
	}

	@RequestMapping("/clsStudying/checkAttd.do")
	public String checkAttd(MemberClVO memberCL, RedirectAttributes rttr) throws Exception {
		String url = "redirect:/user/myClass/clsStudying/QRCheck.do";

		List<ClassListVO> classMemList = classService.getClassMemListByOpcl(memberCL.getOpcl());
		for (ClassListVO classList : classMemList) {
			if (classList.getMemId().equals(memberCL.getMemId())) {
				memberCL.setMemEmail(classList.getMemEmail());

				service.modifyMemCLByQrScan(memberCL);

				rttr.addFlashAttribute("chk", "success");
				rttr.addFlashAttribute("message", classList.getMemName() + "님, " + classList.getClName() + "강의 출석완료되었습니다.");
				break;
			} else {
				rttr.addFlashAttribute("chk", "fail");
				rttr.addFlashAttribute("message", classList.getClName() + " 강의를  수강신청해주세요.");
			}
		}

		return url;
	}

	@RequestMapping("/clsStudying/mtestForm.do")
	public ModelAndView mTestForm(int opcl, int clChap, String clCode, ModelAndView mnv) throws SQLException {
		String url = "user/myClass/clsStudying/mTestForm";

		TestVO test = examManagementService.getTestInfo(opcl);

		mnv.addObject("testVO", test);
		mnv.addObject("clChap", clChap);
		mnv.addObject("clCode", clCode);
		mnv.setViewName(url);

		return mnv;
	}

	@RequestMapping("/clsStudying/ftestForm.do")
	public ModelAndView fTestForm(int opcl, int clChap, String clCode, ModelAndView mnv) throws SQLException {
		String url = "user/myClass/clsStudying/fTestForm";

		TestVO test = examManagementService.getTestInfo(opcl);
		mnv.addObject("testVO", test);
		mnv.addObject("clChap", clChap);
		mnv.addObject("clCode", clCode);
		mnv.setViewName(url);

		return mnv;
	}

	@ResponseBody
	@RequestMapping(value = "/clsStudying/getTest.do", method = RequestMethod.POST)
	public ResponseEntity<List<ExamExcelVO>> getTest(String fileName) throws Exception {
		ResponseEntity<List<ExamExcelVO>> entity = null;

		try {
			Map<String, Object> map = service.readExam(fileName);

			List<ExamExcelVO> data = (List<ExamExcelVO>) map.get("examList");

			entity = new ResponseEntity<List<ExamExcelVO>>(data, HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<ExamExcelVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@RequestMapping(value = "/clsStudying/test.do", method = RequestMethod.POST)
	public String testChk(HttpServletRequest request, TestCommand testCMD, HttpSession session, RedirectAttributes rttr) throws Exception {
		String url = "redirect:detail.do?opcl=" + testCMD.getOpcl();

		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		MemberClVO param = new MemberClVO();
		param.setOpcl(testCMD.getOpcl());
		param.setMemEmail(loginUser.getMemEmail());
		MemberClVO memberClass = service.getMemCLByOpclAndEmail(param);
		
		TestVO test = service.getTestByOpcl(testCMD.getOpcl());
		
		String testCode = testCMD.getTestCode();

		int score = service.checkExam(testCMD);

		// 중간인지 기말인지 확인해서 점수 insert
		if (testCode.equals("mTest")) {
			param.setMidtestScore(score);
			service.modifyMidTestSco(param);
			if (score >= 70) { //점수가 70점이상
				param.setTestCpl(1);
				service.modifyTestCpl(param);
			}else {	//70점 이하라면 testCpl이 0
				param.setTestCpl(0);
				service.modifyTestCpl(param);
			}
		}
		if (testCode.equals("fTest")) {
			param.setFintestScore(score);
			service.modifyFinTestSco(param);
			if (score >= 70) {
				if(memberClass.getMidtestScore() >= 70) { //기말평가라면 중간평가 확인 중간평가가 70점이 넘으면 testCpl이 1
					param.setTestCpl(1);
					service.modifyTestCpl(param);
				} else if(test.getMtestFile() == null) { // 중간평가가 없다면 testCpl이 1
					param.setTestCpl(1);
					service.modifyTestCpl(param);
				} else {	
					param.setTestCpl(0);
					service.modifyTestCpl(param);
				}
			}else {	
				param.setTestCpl(0);
				service.modifyTestCpl(param);
			}
		}


		// 챕터 등록
		MemberClassCommand command = new MemberClassCommand();
		command.setOpcl(testCMD.getOpcl());
		command.setMemEmail(loginUser.getMemEmail());
		int memClNo = service.getmemClNoByOpcl(command);
		param.setMemClNo(memClNo);
		param.setProgChap(100);
		param.setClChap(testCMD.getClChap());
		service.regisetMemChap(param);

		// 전체진도율 수정
		double progRate;

		// 전체챕터 수
		int chapterCnt = service.getClChapterCnt(testCMD.getClCode()) * 100;

		int totalProgChap = jmsClassService.gettotalProgChapList(param.getMemClNo(), testCMD.getClChap(), param.getProgChap());
		progRate = Math.round(((double) totalProgChap / chapterCnt) * 100);
		param.setProgRate((int) progRate);
		service.modifyMemCLProgRate(param);

		// 수료율 100% 시 studyCpl 1로 수정
		Boolean last = lastChapChek(testCMD.getOpcl(), loginUser.getMemEmail(), testCMD.getClChap());
		if (last) {
			if (param.getProgRate() == 100) {
				param.setStudyCpl(1);
				service.modifyStudyCpl(param);
				Map<String, String> dataMap = new HashMap<String, String>();
				dataMap.put("path", request.getServletPath());
				dataMap.put("addr", request.getRemoteAddr());
				dataMap.put("opcl", param.getOpcl() + "");
				dataMap.put("savePath", savePath);
				dataMap.put("saveFileName", saveFileName);

				service.insertLog(loginUser, dataMap);
			}
			MemberClVO lastMemberClass = service.getMemCLByOpclAndEmail(param);
			if(lastMemberClass.getStudyCpl() == 1 && lastMemberClass.getTestCpl() == 1) {
				param.setMemclState("C102");
				service.modifyMemClState(param);
			}else if(lastMemberClass.getStudyCpl() == 1 && lastMemberClass.getTestCpl() == 0) {
				param.setMemclState("C103");
				service.modifyMemClState(param);
			}
		}

		rttr.addFlashAttribute("test", "done");

		return url;
	}

	public Boolean lastChapChek(int opcl, String memEmail, int clChap) throws SQLException {
		Boolean last = false;
		List<ClassChapterVO> chapList = jmsClassService.selectChapter(opcl, memEmail);
		for (int i = 0; i < chapList.size(); i++) {
			if (chapList.get(chapList.size() - 1).getClChapNum() == clChap) {
				last = true;
			}
		}
		return last;
	}
}

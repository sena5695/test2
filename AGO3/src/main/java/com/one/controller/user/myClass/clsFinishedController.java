package com.one.controller.user.myClass;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.josephoconnell.html.HTMLInputFilter;
import com.one.command.ExtReportCommand;
import com.one.command.MemberCriteria;
import com.one.dto.AttachVO;
import com.one.dto.CommonVO;
import com.one.dto.ExtReportVO;
import com.one.dto.FinishedClassVO;
import com.one.dto.IntReportVO;
import com.one.dto.MemberVO;
import com.one.dto.ClassVO.ClassReviewVO;
import com.one.service.CommonService;
import com.one.service.FinishedClassService;
import com.one.utils.GetAttachesFromMultipartFileAdapter;

@Controller
@RequestMapping("/user/myClass/clsFinished")
public class clsFinishedController {

	@Autowired
	private FinishedClassService finishedClassService;

	@Autowired
	private CommonService commonService;

	@Resource(name = "extReportCertificate")
	private String fileUploadPath;

	@RequestMapping("/list.do")
	public ModelAndView listForclsFinished(
			@RequestParam(value = "sortType", defaultValue = "", required = false) String sortType, ModelAndView mnv,
			MemberCriteria mCri, HttpSession session) throws Exception {
		String url = "user/myClass/clsFinished/list";
		Map<String, Object> dataMap = new HashMap<String, Object>();

		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		mCri.setMemEmail(loginUser.getMemEmail());

		if (mCri.getSortType().equals("ext") || sortType.equals("ext")) {
			dataMap = finishedClassService.getExtFinishedClassList(mCri, loginUser.getMemId());
		} else {
			dataMap = finishedClassService.getIntFinishedClassList(mCri, loginUser.getMemId());
		}

		mnv.addObject("dataMap", dataMap);
		mnv.setViewName(url);

		return mnv;
	}

	@RequestMapping("/detail.do")
	public String detailForclsFinished() throws Exception {
		String url = "user/myClass/clsFinished/detail";

		return url;
	}

	@RequestMapping("/intReportForm.pop")
	public ModelAndView intReportForm(ModelAndView mnv, HttpSession session, @RequestParam(value="memClNo", defaultValue="0") int memClNo,MemberCriteria mCri,
										String fromList, String memClNum) throws Exception {
		String url = "user/myClass/clsFinished/reportForm";
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if(memClNum != null) {
			memClNo = Integer.parseInt(memClNum);
		}
		IntReportVO report = finishedClassService.getIntReportInsertForm(memClNo);
		report.setMemClNo(memClNo);
		report.setOpcl(report.getOpcl());
		report.setClName(report.getClName());
		report.setCtfDate(report.getCtfDate());
		report.setMemName(loginUser.getMemName());

		String clCateName = commonService.getCodeName1ByCommonCode(report.getClCate());
		String dpName = commonService.getCodeName1ByCommonCode(loginUser.getDpId());
		String positionName = commonService.getCodeName1ByCommonCode(loginUser.getPositionId());

		report.setClCateName(clCateName);
		report.setDpName(dpName);
		report.setPositionName(positionName);
		
		mnv.addObject("fromList",fromList);
		mnv.addObject("report", report);
		mnv.setViewName(url);
		return mnv;
	}

	@RequestMapping(value = "/intReportRegist", method = RequestMethod.POST)
	public String intReportRegist(@RequestParam(value = "from", defaultValue = "", required = false) String from,
			IntReportVO intReport, HttpSession session) throws Exception {
		String url = "user/myClass/clsFinished/regist_success";

		if (from.equals("main"))
			url = "user/myClass/clsFinished/mainDashRegist_success.jsp";

		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		intReport.setDpId(loginUser.getDpId());
		intReport.setPositionId(loginUser.getPositionId());

		finishedClassService.registIntReport(intReport);

		return url;
	}

	@RequestMapping("/extReportForm.pop")
	public ModelAndView extReportForm(ModelAndView mnv, @RequestParam("extCode") String extCode, MemberCriteria mCri,
			HttpSession session) throws Exception {
		String url = "user/myClass/clsFinished/extReportForm"; // 외부교육 수료증도 첨부해야됨...

		ExtReportVO extReport = getExtReport(extCode, mCri, session);

		mnv.addObject("extReport", extReport);
		mnv.setViewName(url);
		return mnv;
	}

	@RequestMapping(value = "/extReportRegist.do", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	public String extReportRegist(ExtReportCommand registReq, RedirectAttributes rttr, HttpSession session)
			throws Exception {
		String url = "user/myClass/clsFinished/regist_success";

		ExtReportVO extReport = registReq.getExtReportVO();

		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		extReport.setMemEmail(loginUser.getMemEmail());

		List<AttachVO> attachList = GetAttachesFromMultipartFileAdapter.save(registReq.getAttachDoc(), fileUploadPath);
		extReport.setAttachDoc(attachList.get(0).getFileName());

		// XSS 적용
		extReport.setEduContent(HTMLInputFilter.htmlSpecialChars(extReport.getEduContent()));
		extReport.setEduReview(HTMLInputFilter.htmlSpecialChars(extReport.getEduReview()));

		finishedClassService.registExtReport(extReport);

		return url;
	}

	@RequestMapping("/registClsReviewForm.pop")
	public ModelAndView registClsReviewForm(ModelAndView mnv, @RequestParam("memClNo") int memClNo) throws Exception {
		String url = "user/myClass/clsFinished/registClsReviewForm";

		ClassReviewVO review = finishedClassService.getIntClassReviewForm(memClNo);

		mnv.addObject("review", review);
		mnv.setViewName(url);

		return mnv;
	}

	@RequestMapping(value = "/registClsReview", method = RequestMethod.POST)
	public String registClsReview(ClassReviewVO classReview, HttpSession session) throws Exception {
		String url = "user/myClass/clsFinished/reviewRegist_success";

		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		classReview.setMemId(loginUser.getMemId());

		finishedClassService.registClassReview(classReview);

		return url;
	}

	@RequestMapping("/printReport.pop")
	public ModelAndView printReport(ModelAndView mnv, MemberCriteria mCri, HttpSession session,
			@RequestParam(value = "memClNo", defaultValue = "0") int memClNo,
			@RequestParam(value = "extCode", defaultValue = "0") String extCode) throws Exception {
		String url = "user/myClass/clsFinished/printReport";

		if (memClNo != 0) {
			IntReportVO report = finishedClassService.getIntReportInsertForm(memClNo);
			CommonVO common = commonService.getCommonVOByCommonCode(report.getDpId());
			mnv.addObject("report", report);
			mnv.addObject("common", common);
		} else {
			ExtReportVO report = getExtReport(extCode, mCri, session);
			CommonVO common = commonService.getCommonVOByCommonCode(report.getDpId());
			mnv.addObject("report", report);
			mnv.addObject("common", common);
		}

		mnv.setViewName(url);

		return mnv;
	}

	private ExtReportVO getExtReport(String extCode, MemberCriteria mCri, HttpSession session) throws Exception {
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		String positionName = commonService.getCodeName1ByCommonCode(loginUser.getPositionId());

		mCri.setMemEmail(loginUser.getMemEmail());
		Map<String, Object> dataMap = finishedClassService.getExtFinishedClassList(mCri, loginUser.getMemId());

		ExtReportVO extReport = new ExtReportVO();
		extReport.setExtCode(extCode);
		List<FinishedClassVO> extClassList = (List<FinishedClassVO>) dataMap.get("extClassList");
		for (FinishedClassVO finished : extClassList) {
			if (finished.getExtCode().equals(extCode)) {
				extReport.setClName(finished.getExtClName());
				extReport.setCtfDate(finished.getCtfDate());
				if (finished.getExtReport() != null) {
					extReport.setExtNo(finished.getExtNo());
					extReport.setEduContent(finished.getExtReport().getEduContent());
					extReport.setEduReview(finished.getExtReport().getEduReview());
				}
			}
		}

		extReport.setMemName(loginUser.getMemName());
		extReport.setDpId(loginUser.getDpId());
		extReport.setDpName(commonService.getCodeName1ByCommonCode(loginUser.getDpId()));
		extReport.setPositionName(positionName);
		extReport.setPositionId(loginUser.getPositionId());
		return extReport;
	}
}

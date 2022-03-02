package com.one.controller.manager.userManagement;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.one.command.Criteria;
import com.one.command.ManagerMemberRegistCommand;
import com.one.dto.CommonVO;
import com.one.dto.MemberVO;
import com.one.service.CommonService;
import com.one.service.ManagementMemberService;
import com.one.service.MemberService;

@Controller
@RequestMapping("/manager/userManagement")
public class ManagerMemberController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private ManagementMemberService managementMemberService;
	@Autowired
	private CommonService commonService;

	@Resource(name = "excelTempPath")
	private String excelTempPath;

	@Resource(name = "excelFormPath")
	private String excelFormPath;

	// 메인페이지
	@RequestMapping("/main.do")
	public String main() {
		return "manager/userManagement/list";

	}

	// 회원 리스트
	@RequestMapping("/list.do")
	public ModelAndView list(Criteria cri, ModelAndView mnv) throws SQLException {
		String url = "manager/userManagement/list";
		Map<String, Object> dataMap = managementMemberService.getMemberList(cri);
		mnv.addObject("dataMap", dataMap);
		mnv.setViewName(url);
		return mnv;

	}

	// 회원상세페이지
	@RequestMapping("/detailUser.pop")
	public ModelAndView userPage(String memEmail, ModelAndView mnv) throws Exception {
		String url = "manager/userManagement/detailUser";

		Map<String, Object> dataMap = memberService.getMemberDetail(memEmail);
		mnv.addObject("dataMap", dataMap);
		mnv.setViewName(url);
		return mnv;
	}

	// 회원엑셀등록
	@RequestMapping("/registExcel.pop")
	public String registExcel() {

		return "manager/userManagement/registExcel";

	}

	@RequestMapping("/getFile.do")
	public String getFile(Model model) throws Exception {
		String url = "downloadFile";

		model.addAttribute("savePath", excelFormPath);
		model.addAttribute("fileName", "인적사항등록양식.xlsx");

		return url;
	}

	@ResponseBody
	@RequestMapping(value = "/uploadExcelFile.do", method = RequestMethod.POST)
	public String excelUpload(MultipartFile excelFile, MultipartHttpServletRequest multiRequest) throws IOException, SQLException {
		String url = "";

		MultipartFile file = multiRequest.getFile("excelFile");
		File uploadFile = new File(excelTempPath, file.getOriginalFilename());
		if (!uploadFile.exists()) {
			uploadFile.mkdirs();
		}
		try {
			excelFile.transferTo(uploadFile);
		} catch (Exception e) {
			e.printStackTrace();
		}

		memberService.registMembersFromExcel(uploadFile);

		// uploadFile.delete();
		// rttr.addFlashAttribute("upload", "success");
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName(url);

		return url;
	}

	// 회원등록
	@RequestMapping("/registUserForm")
	public ModelAndView registUsers(ModelAndView mnv) throws Exception {
		String url = "manager/userManagement/registUser";

		List<CommonVO> dpList = commonService.getCommonByGroupCode("DP1");
		List<CommonVO> psList = commonService.getCommonByGroupCode("PS1");

		mnv.addObject("dpList", dpList);
		mnv.addObject("psList", psList);
		mnv.setViewName(url);

		return mnv;
	}

	@RequestMapping(value = "/regist.do", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	public String registUser(ManagerMemberRegistCommand memberCMD, RedirectAttributes rttr) throws Exception {
		String url = "redirect:/manager/userManagement/list.do";

		MemberVO member = memberCMD.toMemberVO();

		memberService.registMember(member);
		rttr.addFlashAttribute("from", "regist");
		return url;
	}

	@RequestMapping(value = "/updateAuthority", method = RequestMethod.POST)
	public ResponseEntity<String> registAnswer(String authorityId, String memEmail) throws Exception {
		ResponseEntity<String> entity = null;
		String result = "success";
		System.out.println("au : " + authorityId + ", memEmail : " + memEmail);
		MemberVO member = new MemberVO();
		member.setMemEmail(memEmail);
		member.setAuthorityId(authorityId);

		try {
			boolean statusChk = memberService.memberStatusChk(member);

			if (statusChk) {
				memberService.updateMemberAuthority(member);
			} else {
				result = "fail";
			}
			entity = new ResponseEntity<String>(result, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
}

package com.one.controller;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.one.command.MemberCriteria;
import com.one.dto.DepartmentVO;
import com.one.dto.ManagerVO;
import com.one.dto.MemberRemindSetVO;
import com.one.dto.MemberVO;
import com.one.dto.MenuVO;
import com.one.dto.PopUpVO;
import com.one.dto.SiteInfoVO;
import com.one.service.JMSClassService;
import com.one.service.MemberService;
import com.one.service.MenuService;
import com.one.service.MessageService;
import com.one.service.PopUpService;
import com.one.service.impl.ManagementSiteServiceImpl;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private JMSClassService jms;

	@Autowired
	private MenuService menuService;

	@Autowired
	private PopUpService popupService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private MessageService messageService;

	@Autowired
	private ManagementSiteServiceImpl siteService;

	@RequestMapping(value = "/pwd", method = RequestMethod.GET)
	public void pwd() throws SQLException {
		jms.pwd();
	}

	@RequestMapping(value = "/user/main", method = RequestMethod.GET)
	public ModelAndView mainPage(HttpSession session, MemberCriteria cri, ModelAndView mnv) throws SQLException {
		String url = "user/main";

		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		cri.setMemEmail(loginUser.getMemEmail());
		Map<String, Object> dataMap = memberService.getMemberMainInfo(cri);

		mnv.addObject("dataMap", dataMap);
		mnv.setViewName(url);
		return mnv;
	}

	@RequestMapping("/user/loginPage.do")
	public String userLoginPage() throws Exception {
		String url = "user/login/userLogin";
		return url;
	}

	@RequestMapping("user/indexPage.do")
	public String userIndexPage(@RequestParam(defaultValue = "M000000") String mCode, Model model, HttpSession session) throws Exception {
		String url = "user/indexPage";

		try {
			List<MenuVO> menuList = menuService.getMainMenuList(mCode);
			MenuVO menu = menuService.getMenuByMcode(mCode);
			MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
			MemberVO member = loginUser.getClone();
			List<DepartmentVO> departmentList = memberService.selectMemberDepartment();

			for (DepartmentVO department : departmentList) {
				if (member.getDpId().equals(department.getCommonCode())) {
					member.setDpId(department.getCodeName1());
				}
			}

			int unreadMsgCnt = messageService.getUnreadMsgCnt(member.getMemEmail());
			SiteInfoVO siteInfo = siteService.getSiteInfo();

			// 사용자 알림설정 가져오기
			MemberRemindSetVO remindSet = memberService.getMemberRemindSet(loginUser.getMemEmail());

			// 사용자가 읽지않은 이전 알림 가져옴
//			List<MemberRemindVO> noReadRemind = memberService.getMemberNotReadRemind(loginUser.getMemEmail());

			// 사용자에게 새로 보낼 알림을 추가하고 밀린 보고서 결재 갯수를 가져온다
			Map<String, Object> dataMap = memberService.registMemberNewRemind(loginUser, remindSet);

			model.addAttribute("reportCnt", dataMap.get("reportCnt"));
			model.addAttribute("dataMap", dataMap);
			model.addAttribute("remindSet", remindSet);

			model.addAttribute("menuList", menuList);
			model.addAttribute("menu", menu);
			model.addAttribute("member", member);
			model.addAttribute("msgCnt", unreadMsgCnt);
			model.addAttribute("siteInfo", siteInfo);

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}

		return url;
	}

	@RequestMapping("/manager/loginPage.do")
	public String mnLogin() {
		String url = "manager/login/managerLogin";
		return url;
	}

	@RequestMapping(value = "manager/emailCheck.do", method = RequestMethod.POST)
	public ModelAndView mnEmailCheck(HttpServletRequest request, String email, String id, String pwd, ModelAndView mnv) throws SQLException {
		String url = "redirect:/manager/loginPage.do";
		mnv.setViewName(url);
		HttpSession session = request.getSession();
		MemberVO member = memberService.getMemberByEmail(email);
		if (member == null || !member.getAuthorityId().equals("A103")) {
			request.setAttribute("check", false);
			return mnv;
		}
		url = "/manager/login/redirectPage";
		session.setAttribute("manager", member);
		mnv.setViewName(url);
		mnv.addObject("managerId", id);
		mnv.addObject("managerPwd", pwd);

		return mnv;
	}

	@RequestMapping("manager/indexPage.do")
	public String managerIndexPage(@RequestParam(defaultValue = "M010000") String mCode, Model model) throws Exception {
		String url = "manager/indexPage";

		try {
			List<MenuVO> menuList = menuService.getMainMenuList(mCode);
			MenuVO menu = menuService.getMenuByMcode(mCode);
			SiteInfoVO siteInfo = siteService.getSiteInfo();

			model.addAttribute("menuList", menuList);
			model.addAttribute("menu", menu);
			model.addAttribute("siteInfo", siteInfo);
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}
		return url;
	}

	@RequestMapping("/**/loginTimeOut")
	public String loginTimeOut(HttpServletRequest request, Model model) throws Exception {
		String url = "security/sessionOut";

		model.addAttribute("message", "세션이 만료되었습니다.\\n다시 로그인하세요!");
		return url;
	}

	@RequestMapping("/security/accessDenied")
	public ModelAndView accessDenied(HttpServletRequest request, ModelAndView mnv) throws Exception {
		String url = "/security/accessDenied";
		String referer = (String) request.getHeader("REFERER");
//
//		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~ referer : " + referer);
//		if (!(referer.indexOf("loginPage") < 0)) {
//			mnv.addObject("newLogin", "newLogin");
//			System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~여기는 절대 안들어 오는겨??");
//		}
		mnv.setViewName(url);
		return mnv;
	}

	@RequestMapping("/subMenu")
	@ResponseBody
	public ResponseEntity<List<MenuVO>> subMenuToJSON(String mCode) throws Exception {
		ResponseEntity<List<MenuVO>> entity = null;

		List<MenuVO> subMenu = null;

		try {
			subMenu = menuService.getSubMenuList(mCode);

			entity = new ResponseEntity<List<MenuVO>>(subMenu, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<MenuVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}

		return entity;
	}

	@RequestMapping(value = "/getPopUpList", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<List<PopUpVO>> getPopUpList() throws Exception {
		ResponseEntity<List<PopUpVO>> entity = null;
		List<PopUpVO> popupList = null;

		try {
			popupList = popupService.getPopupListByDate();

			entity = new ResponseEntity<List<PopUpVO>>(popupList, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<PopUpVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}

		return entity;
	}
}

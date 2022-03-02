package com.one.controller.user.myPage;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.one.command.Criteria;
import com.one.dto.MemberRemindSetVO;
import com.one.dto.MemberVO;
import com.one.service.MemRemdSetService;
import com.one.service.MemberService;
import com.one.utils.PwdToEncryption;

@Controller
@RequestMapping("/user/myPage/myInfo")
public class MyInfoController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private MemRemdSetService memRemdSetService;

	// 메인페이지
	@RequestMapping(value = "/main.do")
	public ModelAndView main(Criteria cri, ModelAndView mnv, HttpSession session) throws SQLException {
		String url = "/user/myPage/myInfo";
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		MemberRemindSetVO memAlarm = memRemdSetService.getMemRemdSetByMemEmail(member.getMemEmail());

		mnv.addObject("memAlarm", memAlarm);
		mnv.setViewName(url);

		return mnv;
	}

	@RequestMapping(value = "/modifyPassword", method = RequestMethod.POST)
	public ResponseEntity<String> modifyPassword(HttpServletRequest request, RedirectAttributes rttr, HttpSession session) throws SQLException {
		ResponseEntity<String> entity = null;
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		MemberVO member = loginUser.getClone();

		String memPwd = PwdToEncryption.encry(member.getId(), request.getParameter("memPwd"));
		String newPwd = PwdToEncryption.encry(member.getId(), request.getParameter("newPwd"));

		if (!member.getMemPwd().equals(memPwd)) {
			entity = new ResponseEntity<String>("fail", HttpStatus.OK);
		} else {
			member.setMemPwd(newPwd);
			memberService.modifyMemberPwd(member);

			entity = new ResponseEntity<String>("pass", HttpStatus.OK);
		}

		return entity;
	}

	@RequestMapping(value = "/modifyMemberPwdForm.pop", method = RequestMethod.GET)
	public String modifyPwdForm() {
		String url = "user/login/modifyMemberPwd";
		return url;
	}

	@RequestMapping(value = "/reportDlFlag", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> modifyReportDlFlag(MemberRemindSetVO memAlarm) {
		ResponseEntity<String> entity = null;
		try {
			memRemdSetService.modifyReportDlFlag(memAlarm);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);

		}
		return entity;
	}

	@RequestMapping(value = "/dutyClFlag", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> modifyDutyClFlag(MemberRemindSetVO memAlarm) {
		ResponseEntity<String> entity = null;
		try {
			memRemdSetService.modifyDutyClFlag(memAlarm);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@RequestMapping(value = "/intrClFlag", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> modifyIntrClFlag(MemberRemindSetVO memAlarm) {
		ResponseEntity<String> entity = null;
		try {
			memRemdSetService.modifyIntrClFlag(memAlarm);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@RequestMapping(value = "/realtimeClFlag", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> modifyRealtimeClFlag(MemberRemindSetVO memAlarm) {
		ResponseEntity<String> entity = null;
		try {
			memRemdSetService.modifyRealtimeClFlag(memAlarm);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@RequestMapping(value = "/msgFlag", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> modifyMsgFlag(MemberRemindSetVO memAlarm) {
		ResponseEntity<String> entity = null;
		try {
			memRemdSetService.modifyMsgFlag(memAlarm);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@RequestMapping(value = "/reportChkFlag", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> modifyReportChkFlagg(MemberRemindSetVO memAlarm) {
		ResponseEntity<String> entity = null;
		try {
			memRemdSetService.modifyReportChkFlag(memAlarm);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
}

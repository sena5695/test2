package com.one.controller.user.community;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.josephoconnell.html.HTMLInputFilter;
import com.one.command.Criteria;
import com.one.dto.DebateBoardVO;
import com.one.dto.FreeBoardVO;
import com.one.dto.MemberVO;
import com.one.dto.NoticeVO;
import com.one.service.FreeBoardService;
import com.one.service.FreeReplyService;
import com.one.service.NoticeService;

@Controller
@RequestMapping("/user/community/freeBoard")
public class FreeBoardController {

	@Autowired
	private FreeBoardService freeBoardService;
	@Autowired
	private FreeReplyService freeReplyService;
	@Autowired
	private NoticeService noticeService;

	@RequestMapping("/list.do")
	public ModelAndView list(Criteria cri, ModelAndView mnv) throws Exception {
		String url = "user/community/freeBoard/list";
		Map<String, Object> dataMap = new HashMap<String, Object>();
		cri.setPerPageNum(12);
		dataMap = freeBoardService.getFreeBoardList(cri);
		cri.setPerPageNum(3);
		List<NoticeVO> noticeList = noticeService.getImportantNoticeList(cri);
		dataMap.put("importantNoticeList", noticeList);
		mnv.addObject("dataMap", dataMap);
		mnv.setViewName(url);

		return mnv;
	}
	
	@RequestMapping(value="/report.do",method=RequestMethod.POST)
	public ResponseEntity<Integer> repoat(@RequestParam("freeNo")int freeNo) throws Exception {
		ResponseEntity<Integer> entity = null;
		
		try {
			int cnt = freeBoardService.modifyReportCnt(freeNo);
			entity = new ResponseEntity<Integer>(cnt, HttpStatus.OK);

		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}

	@RequestMapping(value = "/detail.do", method = RequestMethod.GET)
	public ModelAndView detail( int freeNo, String from, ModelAndView mnv, HttpSession session) throws Exception {
		String url = "user/community/freeBoard/detailFree";

		FreeBoardVO freeBoardVO = null;

		if (from != null && from.equals("list")) {
			freeBoardVO = freeBoardService.getFreeBoard(freeNo);

			url = "redirect:/user/community/freeBoard/detail.do?freeNo=" + freeNo;
		} else {
			freeBoardVO = freeBoardService.getFreeBoardFromModify(freeNo);
		}
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		mnv.addObject("freeBoard", freeBoardVO);
		mnv.addObject("loginUser", member);
		mnv.setViewName(url);

		return mnv;

	}

	@RequestMapping(value = "/detailNotice.do", method = RequestMethod.GET)
	public ModelAndView detailNotice(int noticeNo, String from, ModelAndView mnv) throws Exception {
		String url = "user/community/freeBoard/detailNotice";

		NoticeVO notice = null;

		notice = noticeService.getNotice(noticeNo);
		
		mnv.addObject("notice", notice);
		mnv.setViewName(url);

		return mnv;

	}
	
	@RequestMapping("/modifyForm.do")
	public ModelAndView modifyForm(int freeNo, ModelAndView mnv) throws Exception {
		String url = "user/community/freeBoard/modify";
		
		FreeBoardVO freeBoard = freeBoardService.getFreeBoard(freeNo);
		
		mnv.addObject("freeBoard", freeBoard);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/modify.do")
	public String modify(FreeBoardVO freeBoard, RedirectAttributes rttr) throws Exception {
		String url = "redirect:/user/community/freeBoard/detail.do";
		
		freeBoard.setFreeTitle(HTMLInputFilter.htmlSpecialChars(freeBoard.getFreeTitle()));
		freeBoardService.modifyFreeBoard(freeBoard);
		
		rttr.addFlashAttribute("from","modify");
		rttr.addAttribute("freeNo",freeBoard.getFreeNo());
		return url;
	}

	@RequestMapping("/registForm.do")
	public ModelAndView registForm(ModelAndView mnv, HttpSession session) throws Exception {
		String url = "user/community/freeBoard/regist";

		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		System.out.println(member);

		mnv.addObject("memId", member.getMemId());
		mnv.setViewName(url);

		return mnv;
	}

	@RequestMapping(value = "/regist.do", method = RequestMethod.POST)
	public String regist(FreeBoardVO freeBoard, RedirectAttributes rttr) throws Exception {
		String url = "redirect:/user/community/freeBoard/list.do";

		freeBoardService.registFreeBoard(freeBoard);

		return url;
	}
	
	@RequestMapping(value = "/delete.do", method = RequestMethod.POST)
	public String remove(int freeNo, Criteria cri) throws Exception {
		String url = "redirect:/user/community/freeBoard/list.do";
		
		freeReplyService.removeAllFreeReply(freeNo);
		
		freeBoardService.removeFreeBoard(freeNo, cri);
		
		return url;
	}
}

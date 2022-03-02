package com.one.controller.manager.boardManagement;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.one.command.Criteria;
import com.one.dto.FreeBoardVO;
import com.one.service.FreeBoardService;
import com.one.service.FreeReplyService;

@Controller
@RequestMapping("/manager/free")
public class ManagerFreeBoardController {

	@Autowired
	private FreeBoardService freeBoardService;
	
	@Autowired
	private FreeReplyService freeReplyService;
	
	// 자유게시판 리스트
	@RequestMapping("/list.do")
	public ModelAndView list(Criteria cri, ModelAndView mnv) throws Exception{
		String url = "manager/boardManagement/freeBoard/list";
		Map<String, Object> dataMap = freeBoardService.getFreeBoardList(cri);
		mnv.addObject("dataMap", dataMap);
		mnv.setViewName(url);
		return mnv;
	}
	
	// 자유게시판 리스트
	@RequestMapping("/sortList.do")
	public ModelAndView sortList(Criteria cri, ModelAndView mnv) throws Exception{
		String url = "manager/boardManagement/freeBoard/list";
		Map<String, Object> dataMap = freeBoardService.getSortFreeBoardList(cri);
		mnv.addObject("dataMap", dataMap);
		mnv.setViewName(url);
		return mnv;
	}
		
	// 자유게시판 상세
	@RequestMapping("/detail.do")
	public ModelAndView detail(int freeNo, ModelAndView mnv) throws Exception{
		String url = "manager/boardManagement/freeBoard/detail";
		
		FreeBoardVO freeBoardVO = null;
		freeBoardVO = freeBoardService.getFreeBoard(freeNo);
		mnv.addObject("freeBoard",freeBoardVO);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	//삭제
	@RequestMapping(value="/remove.do", method=RequestMethod.POST)
	public String remove(int freeNo, Criteria cri) throws Exception{
		String url = "redirect:list.do";
		
		freeReplyService.removeAllFreeReply(freeNo);
		freeBoardService.removeFreeBoard(freeNo, cri);
		
		return url;
	}
	
	@RequestMapping(value = "/removeList.do", method = RequestMethod.GET)
	public String removeDebateBoardList(@RequestParam("freeNo") int[] freeNoArr, Criteria cri) throws Exception{
		String url = "redirect:list.do";
		
		for(int freeNo : freeNoArr) {
			freeReplyService.removeAllFreeReply(freeNo);
			freeBoardService.removeFreeBoard(freeNo, cri);
		}
		return url;
	}
}

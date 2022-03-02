package com.one.controller.manager.management;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.one.command.Criteria;
import com.one.dto.AskVO;
import com.one.dto.NoticeVO;
import com.one.service.AskService;
import com.one.service.NoticeService;

@Controller
@RequestMapping("/manager/management/ask")
public class ManagerASKController {
	
	@Resource(name="askService")
	private AskService service;

	 // 메인페이지
	@RequestMapping(value = "/main.do")
	public ModelAndView main(Criteria cri, ModelAndView mnv) throws SQLException{
		String url = "/manager/management/ask/list";
		System.out.println("keyword : "+cri.getSortType());
		cri.setPerPageNum(15);
		System.out.println(cri.getKeyword());
		Map<String,Object> dataMap = service.getAskList(cri);
/*		List<AskVO> askList = (List<AskVO>) dataMap.get("askList");
		System.out.println("asklistTitle => "+askList.get(0).getQnTitle());*/
		mnv.addObject("dataMap",dataMap);
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/list.do")
	public ModelAndView list(Criteria cri, ModelAndView mnv) throws SQLException{
		String url = "/manager/management/ask/list";
		System.out.println("sort : "+cri.getKeyword());
		cri.setPerPageNum(15);
		System.out.println(cri.getKeyword());
		Map<String,Object> dataMap = service.getAskList(cri);

		mnv.addObject("dataMap",dataMap);
		mnv.setViewName(url);
		return mnv;
	}
	
	 // 문의게시판 상세 페이지 
	@RequestMapping(value = "/detail.do", method = RequestMethod.GET)
	public ModelAndView detail(String askNo, ModelAndView mnv) throws Exception{
		String url = "/manager/management/ask/detail";
		AskVO ask = null;
		ask = service.getAsk(Integer.parseInt(askNo));
		mnv.addObject("ask",ask);
		mnv.setViewName(url);
		return mnv;
	}
	
	// 답변등록
	@RequestMapping(value = "/regist.do", method = RequestMethod.POST)
	public ResponseEntity<String> registAnswer (String qnNo,String qnAnswer ) throws Exception {
		ResponseEntity<String> entity = null;
		
		AskVO ask = new AskVO();


		ask.setQnAnswer(qnAnswer);
		ask.setQnNo(Integer.parseInt(qnNo));
		System.out.println("qnNo :---------- "+ask.getQnNo());
		System.out.println("qnAnswer : -----------------"+qnAnswer);
		service.registAnswer(ask);
		
		
		/*String result = savePicture(oldPicture, multi);*/

		entity = new ResponseEntity<String>(qnAnswer, HttpStatus.OK);

		return entity;

	}
		
}

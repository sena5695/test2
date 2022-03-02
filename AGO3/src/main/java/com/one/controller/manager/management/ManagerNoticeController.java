package com.one.controller.manager.management;


import java.io.File;
import java.sql.SQLException;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.josephoconnell.html.HTMLInputFilter;

import com.one.command.Criteria;
import com.one.command.NoticeModifyCommand;
import com.one.command.NoticeRegistCommand;
import com.one.dto.AttachVO;
import com.one.dto.MessageVO;
import com.one.dto.NoticeVO;
import com.one.service.NoticeService;
import com.one.utils.GetAttachesFromMultipartFileAdapter;



@Controller
@RequestMapping("manager/management/notice")
public class ManagerNoticeController {
	@Resource(name="fileUploadPath")
	private String fileUploadPath;
	
	@Resource(name="noticeService")
	private NoticeService service;
	
	@RequestMapping("/main")
	public void main() throws Exception{}
	
	// 메인화면
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String main(Locale locale, Model model) {
		  return "/manager/management/notice/list";
	}
	
/*	// 공지사항 리스트
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public String list(Locale locale, Model model) {
		  return "/manager/management/notice/list";
	}*/
	@RequestMapping("/list.do")
	public ModelAndView list(Criteria cri, ModelAndView mnv) throws SQLException{
		String url = "/manager/management/notice/list";
		cri.setPerPageNum(14);
		// System.out.println(cri.getKeyword());
		Map<String,Object> dataMap = service.getNoticeList(cri);
		cri.setPerPageNum(6);

		dataMap.put("importantNoticeList", service.getImportantNoticeList(cri));
		dataMap.put("recentNoticeList", service.getNomalNoticeList(cri));
		mnv.addObject("dataMap",dataMap);
		mnv.setViewName(url);
		return mnv;
	}
	
	// 공지사항 상세
	@RequestMapping(value = "/detail.do")
	public ModelAndView detail(String noticeNo, ModelAndView mnv) throws Exception{
		String url = "/manager/management/notice/detail";
		NoticeVO notice = null;

		notice = service.getNotice(Integer.parseInt(noticeNo));
		mnv.addObject("notice",notice);
		mnv.setViewName(url);
		return mnv;
	}
	
	// 공지사항 등록
	@RequestMapping(value = "/registForm.do", method = RequestMethod.GET)
	public String registForm(Locale locale, Model model) {
		  return "/manager/management/notice/regist";
	}
	
	@RequestMapping(value="/regist.do", method = RequestMethod.POST, produces="text/plain;charset=utf-8")
	public String regist(NoticeRegistCommand registReq, RedirectAttributes rttr) throws Exception{
		String url = "redirect:/manager/management/notice/list.do";

		NoticeVO notice = registReq.toNoticeVO();
		System.out.println(registReq.getFileUpload());
		List<AttachVO> attachList = GetAttachesFromMultipartFileAdapter.save(registReq.getFileUpload(), fileUploadPath);

		notice.setNoticeTitle(HTMLInputFilter.htmlSpecialChars(notice.getNoticeTitle()));
		
		service.regist(notice, attachList);

		rttr.addFlashAttribute("from","regist");
		
		return url;
	}
	
	@RequestMapping("/remove.do")
	public String remove(int[] noticeNo, RedirectAttributes rttr) throws Exception{
		String url = "redirect:/manager/management/notice/list.do";
		
/*		List<AttachVO> attachList = service.getNotice(pno).getAttachList();
		if(attachList != null) {
			for (AttachVO attach : attachList) {
				File target = new File(attach.getUploadPath(), attach.getFileName());
				if(target.exists()) {
					target.delete();
				}
			}
		}*/
		service.remove(noticeNo);
		
		rttr.addFlashAttribute("from","remove");
		rttr.addAttribute("noticeNo",noticeNo);
		
		return url;
	}
	
	// 공지사항 수정
	@RequestMapping(value = "/modifyForm.do")
	public ModelAndView modify(String noticeNo, ModelAndView mnv) throws Exception{
		String url = "/manager/management/notice/modify";
		NoticeVO notice = null;
		notice = service.getNotice(Integer.parseInt(noticeNo));
		mnv.addObject("notice",notice);
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/modify.do")
	   public String modifyPOST(NoticeModifyCommand modifyReq,HttpServletRequest request,RedirectAttributes rttr)throws Exception{
	      String url = "redirect:/manager/management/notice/detail.do";
	      // System.out.println(modifyReq.getNoticeNo());
      
	      //파일삭제
	      if(modifyReq.getDeleteFile() != null && modifyReq.getDeleteFile().length>0) {
	         for(String anoStr : modifyReq.getDeleteFile()) {
	            int ano =Integer.parseInt(anoStr);
	            AttachVO attach = service.getAttachByAno(ano);
	            File deleteFile = new File(fileUploadPath, attach.getFileName());
	            if(deleteFile.exists()) {
	               deleteFile.delete(); //File 삭제
	            }
	            service.removeAttachByAno(ano); //DB삭제
	         }
	      }
	      
	      //파일 저장
	     
		    List<AttachVO> attachList = GetAttachesFromMultipartFileAdapter.save(modifyReq.getFileUpload(), fileUploadPath);
		    

	      //noticeVO setting
		  NoticeVO notice = modifyReq.toNoticeVO();
		  notice.setAttachList(attachList);
	      notice.setNoticeTitle(HTMLInputFilter.htmlSpecialChars(notice.getNoticeTitle()));
	      
	      //DB 저장
	      service.modify(notice, attachList);
	      rttr.addAttribute("noticeNo",notice.getNoticeNo());
	      
	      return url;
	   }
	
	@RequestMapping("/getFile.do")
	public String getFile(String fileName, Model model) throws Exception{
		String url = "downloadFile";
		
		model.addAttribute("savePath", fileUploadPath);
		model.addAttribute("fileName", fileName);
		
		return url;
	}
	
	@RequestMapping("/nomal")
	@ResponseBody
	public ResponseEntity<List<NoticeVO>> nomal(String sortType) throws Exception {
		Criteria cri = new Criteria();
		cri.setSortType(sortType);
		cri.setPerPageNum(6);
		ResponseEntity<List<NoticeVO>> entity = null;
		List<NoticeVO> noticeList = service.getNomalNoticeList(cri);
		entity = new ResponseEntity<List<NoticeVO>>(noticeList ,HttpStatus.OK);
		return entity;
	}

}

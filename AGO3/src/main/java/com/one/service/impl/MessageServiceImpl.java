package com.one.service.impl;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.one.command.Criteria;
import com.one.command.MessageComand;
import com.one.command.PageMaker;
import com.one.dao.MessageDAO;
import com.one.dto.MessageVO;
import com.one.service.MessageService;

public class MessageServiceImpl implements MessageService{

	private MessageDAO messageDAO;
	public void setMessageDAO(MessageDAO messageDAO) {
		this.messageDAO = messageDAO;
	}


	@Override
	public Map<String, Object> getMessageList(String memEmail, Criteria cri) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		cri.setKeyword(memEmail);
		List<MessageVO> messageList = messageDAO.selectMessageList(cri);
		int totalCount = messageDAO.selectMessageListCount(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		dataMap.put("messageList", messageList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}


	@Override
	public MessageVO getMessage(MessageComand msgCMD) throws SQLException {
		MessageVO message = messageDAO.selectMessage(msgCMD);
		messageDAO.readMessage(message);
		return message;
	}


	@Override
	public void registMessage(MessageVO message) throws SQLException {
		int msgNo = messageDAO.selectMsgSequenceNextValue();
		message.setMsgNo(msgNo);
		
		String[] mail = message.getMemEmail().split(",");
		
		for(int i = 0; i < mail.length; i++) {
			message.setMemEmail(mail[i].trim());
			messageDAO.insertMemMsg(message);
		}
		messageDAO.insertMessage(message);
	}


	@Override
	public void removeMsg(Map<String, Object> dataMap) throws SQLException {
		messageDAO.deleteMsg(dataMap);
		
	}

	@Override
	public Map<String, Object> getMsgList(Criteria cri) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<MessageVO> msgList = messageDAO.selectMsgList(cri);
		
		int totalCount = messageDAO.countMsg();
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		for(MessageVO message : msgList) {
			List<MessageVO> memMsg = messageDAO.selectMemMsgByNo(message.getMsgNo());
			String memName = "";
			String memEmail = "";
			for(int i = 0; i < memMsg.size(); i++) {
				memName += memMsg.get(i).getMemName() + ",";
				memEmail += memMsg.get(i).getMemEmail() + ",";
			}
			
			if(memName != null || !memName.isEmpty()) {
				memName = memName.substring(0,memName.lastIndexOf(","));
			}
			if(memEmail != null) {
				memEmail = memEmail.substring(0,memEmail.lastIndexOf(","));
			}
			message.setMemName(memName);
			message.setMemEmail(memEmail);
		}
		
		dataMap.put("msgList", msgList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}


	@Override
	public MessageVO getMsg(int msgNo) throws SQLException {
		MessageVO msg = messageDAO.selectMsg(msgNo);
		List<MessageVO> memMsg = messageDAO.selectMemMsgByNo(msgNo);
		String memName = "";
		String memEmail = "";
		for(int i = 0; i < memMsg.size(); i++) {
			memName += memMsg.get(i).getMemName() + ", ";
			memEmail += memMsg.get(i).getMemEmail() + ", ";
		}
		memName = memName.substring(0,memName.lastIndexOf(","));
		memEmail = memEmail.substring(0,memEmail.lastIndexOf(","));
		msg.setMemName(memName);
		msg.setMemEmail(memEmail);
		
		return msg;
	}


	@Override
	public void removeMsgByManager(int msgNo) throws SQLException {
		messageDAO.deleteMsgBymanager(msgNo);
	}


	@Override
	public int getUnreadMsgCnt(String memEmail) throws SQLException {
		int unreadMsgCnt = messageDAO.selectUnreadMsgCount(memEmail);
		return unreadMsgCnt;
	}




}

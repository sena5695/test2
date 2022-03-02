package com.one.command;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DepartmentHeadReportCommand {
	private String reType;
	private int no         ;
	private String clName;
	private String memName   ;
	private Date regdate    ;
	private String state      ;
	private String dpId      ;
	private String positionId;
	
	String pattern = "yyyy.MM.dd";
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
	
	private String reportDate;
	
	private String stateName; // 결재 상태 이름
	
	
	public String getStateName() {
		return stateName;
	}
	public void setStateName(String stateName) {
		this.stateName = stateName;
	}
	public String getReportDate() {
		return reportDate;
	}
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}
	public String getReType() {
		return reType;
	}
	public void setReType(String reType) {
		this.reType = reType;
	}

	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
		setReportDate(simpleDateFormat.format(regdate));
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getDpId() {
		return dpId;
	}
	public void setDpId(String dpId) {
		this.dpId = dpId;
	}
	public String getPositionId() {
		return positionId;
	}
	public void setPositionId(String positionId) {
		this.positionId = positionId;
	}
	public String getClName() {
		return clName;
	}
	public void setClName(String clName) {
		this.clName = clName;
	}

	
	
}

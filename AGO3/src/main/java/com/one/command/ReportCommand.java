package com.one.command;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ReportCommand extends MemberStudyClassCommand{
	private int intNo = 0;
	private int memClNo  ;
	private int opcl       ;
	private String eduContent;
	private String eduReview ;
	private String intState  ;
	private Date intDate   ;
	
	private Date dDate;
	private int dDays;
	
	String pattern = "yyyy-MM-dd";
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
	
	private String cdate = "";
	
	private String classType="int"; // 내부강의인지, HRD인지

	
	public String getClassType() {
		return classType;
	}
	public void setClassType(String classType) {
		this.classType = classType;
	}
	public int getIntNo() {
		return intNo;
	}
	public void setIntNo(int intNo) {
		this.intNo = intNo;
	}
	public int getMemClNo() {
		return memClNo;
	}
	public void setMemClNo(int memClNo) {
		this.memClNo = memClNo;
	}
	public int getOpcl() {
		return opcl;
	}
	public void setOpcl(int opcl) {
		this.opcl = opcl;
	}
	public String getEduContent() {
		return eduContent;
	}
	public void setEduContent(String eduContent) {
		this.eduContent = eduContent;
	}
	public String getEduReview() {
		return eduReview;
	}
	public void setEduReview(String eduReview) {
		this.eduReview = eduReview;
	}

	public String getIntState() {
		return intState;
	}
	public void setIntState(String intState) {
		this.intState = intState;
	}
	public Date getIntDate() {
		return intDate;
	}
	public void setIntDate(Date intDate) {
		this.intDate = intDate;
	}
	
	public void setCtfDate(Date ctfDate) {
		this.ctfDate = ctfDate;
		setCdate(simpleDateFormat.format(ctfDate));
	}
	public String getCdate() {
		return cdate;
	}
	public void setCdate(String cdate) {
		this.cdate = cdate;
	}
	public Date getdDate() {
		return dDate;
	}
	public void setdDate(Date dDate) {
		this.dDate = dDate;
	}
	public int getdDays() {
		return dDays;
	}
	public void setdDays(int dDays) {
		this.dDays = dDays;
	}
	
	
	
}

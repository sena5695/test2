package com.one.command;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.one.dto.ClassVO.ClassListVO;

public class MemberClassCommand extends ClassListVO{

	private int memClNo   ;
	private int opcl      ;
	private String memEmail  ;
	private int testCpl   ;
	private int studyCpl  ;
	private int progRate  ;
	private String memclState;
	protected Date ctfDate   ;
	private Date studySdate;
	private Date studyEdate;
	private String clName;
	private String clCode;
	private String authorityId;
	private int endDay;

	private String intState;
	private Date intDate;

	String pattern = "yyyy.MM.dd";
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);


	
	public String getAuthorityId() {
		return authorityId;
	}
	
	
	public void setAuthorityId(String authorityId) {
		this.authorityId = authorityId;
	}
	public String getClCode() {
		return clCode;
	}
	public void setClCode(String clCode) {
		this.clCode = clCode;
	}
	public String getClName() {
		return clName;
	}
	public void setClName(String clName) {
		this.clName = clName;
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
	public String getMemEmail() {
		return memEmail;
	}
	public void setMemEmail(String memEmail) {
		this.memEmail = memEmail;
	}
	public int getTestCpl() {
		return testCpl;
	}
	public void setTestCpl(int testCpl) {
		this.testCpl = testCpl;
	}
	public int getStudyCpl() {
		return studyCpl;
	}
	public void setStudyCpl(int studyCpl) {
		this.studyCpl = studyCpl;
	}
	public int getProgRate() {
		return progRate;
	}
	public void setProgRate(int progRate) {
		this.progRate = progRate;
	}
	public String getMemclState() {
		return memclState;
	}
	public void setMemclState(String memclState) {
		this.memclState = memclState;
	}
	public Date getCtfDate() {
		return ctfDate;
	}
	public void setCtfDate(Date ctfDate) {
		this.ctfDate = ctfDate;
	}

	public void setStudyEdate(Date studyEdate) {
		this.studyEdate = studyEdate;
	}
	public Date getStudySdate() {
		return studySdate;
	}
	public Date getStudyEdate() {
		return studyEdate;
	}
	public int getEndDay() {
		return endDay;
	}
	public void setEndDay(int endDay) {
		this.endDay = endDay;
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
	@Override
	public String toString() {
		return "MemberClassCommand [memClNo=" + memClNo + ", opcl=" + opcl + ", memEmail=" + memEmail + ", testCpl=" + testCpl + ", studyCpl=" + studyCpl + ", progRate=" + progRate + ", memclState=" + memclState + ", ctfDate=" + ctfDate + ", studySdate=" + studySdate + ", studyEdate=" + studyEdate + ", clName=" + clName + ", clCode=" + clCode + ", authorityId=" + authorityId + ", endDay=" + endDay + ", intState=" + intState + ", intDate=" + intDate + ", pattern=" + pattern + ", simpleDateFormat=" + simpleDateFormat + "]";
	}

	
	
	
}

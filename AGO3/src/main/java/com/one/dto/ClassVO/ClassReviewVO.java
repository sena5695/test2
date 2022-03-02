package com.one.dto.ClassVO;

import java.util.Date;

public class ClassReviewVO {

	private int reviewNo;
	private int opcl;
	private double reviewScore;
	private String reviewContent;
	public Date reviewRegdate;
	private String memId;
	private String clCode;
	private String clName;
	private String memName;
	private String clCate;
	private Date ctfDate;
	
	public Date getCtfDate() {
		return ctfDate;
	}
	public void setCtfDate(Date ctfDate) {
		this.ctfDate = ctfDate;
	}
	public String getClCate() {
		return clCate;
	}
	public void setClCate(String clCate) {
		this.clCate = clCate;
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public int getOpcl() {
		return opcl;
	}
	public void setOpcl(int opcl) {
		this.opcl = opcl;
	}
	public double getReviewScore() {
		return reviewScore;
	}
	public void setReviewScore(double reviewScore) {
		this.reviewScore = reviewScore;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public Date getReviewRegdate() {
		return reviewRegdate;
	}
	public void setReviewRegdate(Date reviewRegdate) {
		this.reviewRegdate = reviewRegdate;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
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
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	@Override
	public String toString() {
		return "ClassReviewVO [reviewNo=" + reviewNo + ", opcl=" + opcl + ", reviewScore=" + reviewScore
				+ ", reviewContent=" + reviewContent + ", reviewRegdate=" + reviewRegdate + ", memId=" + memId
				+ ", clCode=" + clCode + ", clName=" + clName + ", memName=" + memName + "]";
	}
	
	
}

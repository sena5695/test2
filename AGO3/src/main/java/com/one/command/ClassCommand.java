package com.one.command;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.one.dto.ClassVO.ClassListVO;

public class ClassCommand extends ClassListVO{
	private double scope = 0.00;
	private int frontScope;
	private int backScope;
	private int restScope = 5;
	private String studyTime;
	
	String pattern = "yyyy.MM.dd";
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
	
	private String posts = "";
	private String poste = "";
	
	public int getRestScope() {
		return restScope;
	}
	
	public void setRestScope(int restScope) {
		this.restScope = restScope;
	}
	
	public double getScope() {
		return scope;
	}
	
	public void setScope(double scope) {
		this.scope = scope;
		setFrontScope((int)(scope*10)/10);
		setBackScope((int)(scope*10)%10);
		int sum = 0;
		if(backScope >= 5)
			sum = sum+1;
		sum = sum+frontScope;
		setRestScope(5-sum);
		// System.out.println("scop--------------"+frontScope+" | "+backScope+" | "+restScope);
	}
	
	public void setStudyDate(String studyDate) {
		this.studyDate = studyDate;
		if(studyDate.equals("D101"))
			setStudyTime("7");
		if(studyDate.equals("D102"))
			setStudyTime("30");
		if(studyDate.equals("D103"))
			setStudyTime("제한없음");
	//	System.out.println("studyTime==============================="+studyTime);
	}
	
	public int getFrontScope() {
		return frontScope;
	}
	
	public void setFrontScope(int frontScope) {
		this.frontScope = frontScope;
	}
	
	public int getBackScope() {
		return backScope;
	}
	
	public void setBackScope(int backScope) {
		this.backScope = backScope;
	}

	public void setPostSdate(Date postSdate) {
		this.postSdate = postSdate;
		posts = simpleDateFormat.format(postSdate);
	}
	
	public void setPostEdate(Date postEdate) {
		this.postEdate = postEdate;
		poste = simpleDateFormat.format(postEdate);
	}

	public String getPosts() {
		return posts;
	}

	public String getPoste() {
		return poste;
	}

	public String getStudyTime() {
		return studyTime;
	}

	public void setStudyTime(String studyTime) {
		this.studyTime = studyTime;
	}

	
}

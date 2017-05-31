package org.dodo.vo;

import java.util.Date;

//파일
public class UfileVO {
	private String id;
	private int num;   //글 번호
	private String ufname1; //원본 파일명
	private String ufname2; //바뀐 파일명
	private long ufsize; // 파일 크기
	private String ufdate; //파일 올린 날짜 (업로드 일자)
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getUfname1() {
		return ufname1;
	}
	public void setUfname1(String ufname1) {
		this.ufname1 = ufname1;
	}
	public String getUfname2() {
		return ufname2;
	}
	public void setUfname2(String ufname2) {
		this.ufname2 = ufname2;
	}
	public long getUfsize() {
		return ufsize;
	}
	public void setUfsize(long ufsize) {
		this.ufsize = ufsize;
	}
	public String getUfdate() {
		return ufdate;
	}
	public void setUfdate(String ufdate) {
		this.ufdate = ufdate;
	}
	
	
}

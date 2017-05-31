package org.dodo.vo;

import java.util.Date;

//공지사항
public class NoticeVO {
	
	private int anum;//글 번호
	private String atitle; //글 제목
	private String acontents; // 글 내용
	private String adate; // 작성일
	private String gm; // 운영자 아이디 (권한 : gm)
	private int total; // 토탈
	private int page; //페이지
	
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getAnum() {
		return anum;
	}
	public void setAnum(int anum) {
		this.anum = anum;
	}
	public String getAtitle() {
		return atitle;
	}
	public void setAtitle(String atitle) {
		this.atitle = atitle;
	}
	public String getAcontents() {
		return acontents;
	}
	public void setAcontents(String acontents) {
		this.acontents = acontents;
	}
	
	public String getAdate() {
		return adate;
	}
	public void setAdate(String adate) {
		this.adate = adate;
	}
	public String getGm() {
		return gm;
	}
	public void setGm(String gm) {
		this.gm = gm;
	}
	
	
}
